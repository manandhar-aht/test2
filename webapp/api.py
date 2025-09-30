#!/usr/bin/env python3
import json
import urllib.parse
import os
import sys
import psycopg2
from psycopg2.extras import RealDictCursor

# Database connection parameters
DB_HOST = 'postgres'
DB_NAME = 'geodb'
DB_USER = 'geouser'
DB_PASS = 'geopass'

def connect_db():
    """Connect to PostgreSQL database"""
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASS
        )
        return conn
    except Exception as e:
        return None

def get_construction_details(feature_id):
    """Get construction details for a feature"""
    conn = connect_db()
    if not conn:
        return {"error": "Database connection failed"}
    
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute("""
                SELECT 
                    contractor_name,
                    construction_method,
                    construction_start_date,
                    construction_end_date,
                    construction_duration_days,
                    construction_cost,
                    depth_m,
                    diameter_m,
                    length_m,
                    width_m,
                    lining_material,
                    materials_used,
                    equipment_used,
                    warranty_period_months,
                    quality_certificate_number,
                    environmental_compliance,
                    project_status,
                    quality_rating,
                    final_inspection_date,
                    additional_notes,
                    feature_type
                FROM feature_construction_details 
                WHERE feature_id = %s
            """, (feature_id,))
            
            result = cur.fetchone()
            if result:
                # Convert result to dict and handle date serialization
                data = dict(result)
                for key, value in data.items():
                    if hasattr(value, 'isoformat'):  # Date/datetime objects
                        data[key] = value.isoformat()
                return data
            else:
                return {"error": "No construction details found for this feature"}
                
    except Exception as e:
        return {"error": f"Database query failed: {str(e)}"}
    finally:
        conn.close()

def get_water_quality_reports(feature_id):
    """Get water quality reports for a feature"""
    conn = connect_db()
    if not conn:
        return {"error": "Database connection failed"}
    
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute("""
                SELECT 
                    test_date,
                    ph_level,
                    tds_ppm,
                    conductivity,
                    turbidity,
                    temperature,
                    ecoli_count,
                    coliform_count,
                    overall_quality,
                    testing_laboratory,
                    next_test_due_date,
                    recommended_treatment,
                    notes
                FROM feature_water_quality_reports 
                WHERE feature_id = %s
                ORDER BY test_date DESC
            """, (feature_id,))
            
            results = cur.fetchall()
            data = []
            for result in results:
                row = dict(result)
                for key, value in row.items():
                    if hasattr(value, 'isoformat'):  # Date/datetime objects
                        row[key] = value.isoformat()
                data.append(row)
            return data
                
    except Exception as e:
        return {"error": f"Database query failed: {str(e)}"}
    finally:
        conn.close()

def get_maintenance_activities(feature_id):
    """Get maintenance activities for a feature"""
    conn = connect_db()
    if not conn:
        return {"error": "Database connection failed"}
    
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute("""
                SELECT 
                    activity_date,
                    activity_type,
                    activity_status,
                    priority,
                    cost,
                    duration_hours,
                    technician,
                    description,
                    parts_replaced,
                    equipment_used,
                    effectiveness_rating,
                    next_maintenance_date,
                    notes
                FROM feature_maintenance_activities 
                WHERE feature_id = %s
                ORDER BY activity_date DESC
            """, (feature_id,))
            
            results = cur.fetchall()
            data = []
            for result in results:
                row = dict(result)
                for key, value in row.items():
                    if hasattr(value, 'isoformat'):  # Date/datetime objects
                        row[key] = value.isoformat()
                data.append(row)
            return data
                
    except Exception as e:
        return {"error": f"Database query failed: {str(e)}"}
    finally:
        conn.close()

def main():
    """Main CGI handler"""
    # Set content type
    print("Content-Type: application/json")
    print("Access-Control-Allow-Origin: *")
    print("Access-Control-Allow-Methods: GET, POST, OPTIONS")
    print("Access-Control-Allow-Headers: Content-Type")
    print()  # Empty line required after headers
    
    # Parse query string
    query_string = os.environ.get('QUERY_STRING', '')
    params = urllib.parse.parse_qs(query_string)
    
    action = params.get('action', [''])[0]
    feature_id = params.get('feature_id', [''])[0]
    
    if not action or not feature_id:
        print(json.dumps({"error": "Missing action or feature_id parameter"}))
        return
    
    if action == 'construction_details':
        result = get_construction_details(feature_id)
    elif action == 'water_quality':
        result = get_water_quality_reports(feature_id)
    elif action == 'maintenance':
        result = get_maintenance_activities(feature_id)
    else:
        result = {"error": "Invalid action parameter"}
    
    print(json.dumps(result))

if __name__ == "__main__":
    main()