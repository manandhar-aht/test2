#!/usr/bin/env python3
"""
GeoServer Publishing Script for Complex Nested Water Resources Model
Publishes hierarchical water management data with complex feature types
"""

import requests
import json
import time
from requests.auth import HTTPBasicAuth
import xml.etree.ElementTree as ET

# Configuration
GEOSERVER_URL = "http://localhost:8080/geoserver"
USERNAME = "admin"
PASSWORD = "geoserver"
WORKSPACE = "sahel"
DATASTORE = "PostGIS"

# Database connection parameters
DB_CONFIG = {
    "host": "postgres",
    "port": "5432",
    "database": "geodb",
    "user": "geouser",
    "passwd": "geopass"
}

def wait_for_geoserver():
    """Wait for GeoServer to be ready"""
    max_attempts = 30
    for attempt in range(max_attempts):
        try:
            response = requests.get(f"{GEOSERVER_URL}/rest/about/version", 
                                  auth=HTTPBasicAuth(USERNAME, PASSWORD), timeout=10)
            if response.status_code == 200:
                print("✅ GeoServer is ready")
                return True
        except requests.exceptions.RequestException:
            pass
        
        print(f"⏳ Waiting for GeoServer... (attempt {attempt + 1}/{max_attempts})")
        time.sleep(5)
    
    print("❌ GeoServer not responding after maximum attempts")
    return False

def create_workspace(workspace_name):
    """Create workspace if it doesn't exist"""
    url = f"{GEOSERVER_URL}/rest/workspaces"
    
    # Check if workspace exists
    response = requests.get(f"{url}/{workspace_name}", auth=HTTPBasicAuth(USERNAME, PASSWORD))
    if response.status_code == 200:
        print(f"✅ Workspace '{workspace_name}' already exists")
        return True
    
    # Create workspace
    workspace_xml = f"""
    <workspace>
        <name>{workspace_name}</name>
    </workspace>
    """
    
    response = requests.post(url, 
                           data=workspace_xml,
                           headers={'Content-Type': 'application/xml'},
                           auth=HTTPBasicAuth(USERNAME, PASSWORD))
    
    if response.status_code == 201:
        print(f"✅ Created workspace: {workspace_name}")
        return True
    else:
        print(f"❌ Failed to create workspace: {response.status_code} - {response.text}")
        return False

def create_datastore(workspace_name, datastore_name):
    """Create PostGIS datastore if it doesn't exist"""
    url = f"{GEOSERVER_URL}/rest/workspaces/{workspace_name}/datastores"
    
    # Check if datastore exists
    response = requests.get(f"{url}/{datastore_name}", auth=HTTPBasicAuth(USERNAME, PASSWORD))
    if response.status_code == 200:
        print(f"✅ Datastore '{datastore_name}' already exists")
        return True
    
    # Create datastore
    datastore_xml = f"""
    <dataStore>
        <name>{datastore_name}</name>
        <type>PostGIS</type>
        <enabled>true</enabled>
        <workspace>
            <name>{workspace_name}</name>
        </workspace>
        <connectionParameters>
            <host>{DB_CONFIG['host']}</host>
            <port>{DB_CONFIG['port']}</port>
            <database>{DB_CONFIG['database']}</database>
            <user>{DB_CONFIG['user']}</user>
            <passwd>{DB_CONFIG['passwd']}</passwd>
            <dbtype>postgis</dbtype>
        </connectionParameters>
    </dataStore>
    """
    
    response = requests.post(url,
                           data=datastore_xml,
                           headers={'Content-Type': 'application/xml'},
                           auth=HTTPBasicAuth(USERNAME, PASSWORD))
    
    if response.status_code == 201:
        print(f"✅ Created datastore: {datastore_name}")
        return True
    else:
        print(f"❌ Failed to create datastore: {response.status_code} - {response.text}")
        return False

def publish_feature_type(workspace_name, datastore_name, layer_name, table_name, title, srs="EPSG:4326"):
    """Publish a feature type from PostGIS table"""
    
    # Check if feature type already exists
    url = f"{GEOSERVER_URL}/rest/workspaces/{workspace_name}/datastores/{datastore_name}/featuretypes/{layer_name}"
    response = requests.get(url, auth=HTTPBasicAuth(USERNAME, PASSWORD))
    
    if response.status_code == 200:
        print(f"✅ Feature type '{layer_name}' already exists")
        return True
    
    # Create feature type
    url = f"{GEOSERVER_URL}/rest/workspaces/{workspace_name}/datastores/{datastore_name}/featuretypes"
    
    feature_type_xml = f"""
    <featureType>
        <name>{layer_name}</name>
        <nativeName>{table_name}</nativeName>
        <title>{title}</title>
        <srs>{srs}</srs>
        <enabled>true</enabled>
        <store class="dataStore">
            <name>{datastore_name}</name>
        </store>
    </featureType>
    """
    
    response = requests.post(url,
                           data=feature_type_xml,
                           headers={'Content-Type': 'application/xml'},
                           auth=HTTPBasicAuth(USERNAME, PASSWORD))
    
    if response.status_code == 201:
        print(f"✅ Published feature type: {layer_name}")
        return True
    else:
        print(f"❌ Failed to publish feature type {layer_name}: {response.status_code} - {response.text}")
        return False

def create_complex_feature_view(view_name, view_definition):
    """Create a database view for complex features"""
    import subprocess
    
    create_view_sql = f"""
    DROP VIEW IF EXISTS {view_name};
    CREATE VIEW {view_name} AS
    {view_definition};
    """
    
    try:
        result = subprocess.run([
            'docker', 'exec', '-i', 'postgres', 
            'psql', '-U', 'geouser', '-d', 'geodb', '-c', create_view_sql
        ], capture_output=True, text=True)
        
        if result.returncode == 0:
            print(f"✅ Created database view: {view_name}")
            return True
        else:
            print(f"❌ Failed to create view {view_name}: {result.stderr}")
            return False
    except Exception as e:
        print(f"❌ Error creating view {view_name}: {e}")
        return False

def main():
    """Main execution function"""
    print("🚀 Publishing Complex Nested Water Resources Model to GeoServer")
    print("=" * 70)
    
    # Wait for GeoServer
    if not wait_for_geoserver():
        return False
    
    # Create workspace
    if not create_workspace(WORKSPACE):
        return False
    
    # Create datastore
    if not create_datastore(WORKSPACE, DATASTORE):
        return False
    
    # Define complex feature views for hierarchical relationships
    complex_views = [
        {
            "view_name": "v_water_management_zones_detailed",
            "view_definition": """
                SELECT 
                    wmz.*,
                    COALESCE(pond_stats.pond_count, 0) as total_ponds,
                    COALESCE(well_stats.well_count, 0) as total_wells,
                    COALESCE(borehole_stats.borehole_count, 0) as total_boreholes,
                    COALESCE(pond_stats.total_pond_capacity, 0) as total_pond_capacity_liters,
                    COALESCE(well_stats.avg_well_depth, 0) as avg_well_depth_m,
                    COALESCE(borehole_stats.avg_borehole_depth, 0) as avg_borehole_depth_m,
                    CASE 
                        WHEN COALESCE(pond_stats.pond_count, 0) + COALESCE(well_stats.well_count, 0) + COALESCE(borehole_stats.borehole_count, 0) > 10 
                        THEN 'high_density'
                        WHEN COALESCE(pond_stats.pond_count, 0) + COALESCE(well_stats.well_count, 0) + COALESCE(borehole_stats.borehole_count, 0) > 5 
                        THEN 'medium_density'
                        ELSE 'low_density'
                    END as infrastructure_density
                FROM water_management_zones wmz
                LEFT JOIN (
                    SELECT zone_id, 
                           COUNT(*) as pond_count,
                           SUM(capacity_liters) as total_pond_capacity
                    FROM nested_ponds 
                    GROUP BY zone_id
                ) pond_stats ON wmz.zone_id = pond_stats.zone_id
                LEFT JOIN (
                    SELECT zone_id, 
                           COUNT(*) as well_count,
                           AVG(depth_m) as avg_well_depth
                    FROM nested_wells 
                    GROUP BY zone_id
                ) well_stats ON wmz.zone_id = well_stats.zone_id
                LEFT JOIN (
                    SELECT zone_id, 
                           COUNT(*) as borehole_count,
                           AVG(total_depth_m) as avg_borehole_depth
                    FROM nested_boreholes 
                    GROUP BY zone_id
                ) borehole_stats ON wmz.zone_id = borehole_stats.zone_id
            """
        },
        {
            "view_name": "v_water_infrastructure_comprehensive",
            "view_definition": """
                SELECT 
                    'pond' as feature_type,
                    np.pond_id as feature_id,
                    np.name as feature_name,
                    np.zone_id,
                    wmz.name as zone_name,
                    ST_Centroid(np.geom) as geom,
                    np.surface_area_sqm as size_metric,
                    np.current_water_level_m as water_level,
                    np.primary_use as usage_type,
                    CASE WHEN np.is_perennial THEN 'Perennial' ELSE 'Seasonal' END as water_availability,
                    np.capacity_liters as capacity,
                    wqr.overall_quality as water_quality,
                    ma.activity_status as maintenance_status
                FROM nested_ponds np
                JOIN water_management_zones wmz ON np.zone_id = wmz.zone_id
                LEFT JOIN water_quality_reports wqr ON wqr.feature_type = 'pond' AND wqr.feature_id = np.pond_id
                LEFT JOIN maintenance_activities ma ON ma.feature_type = 'pond' AND ma.feature_id = np.pond_id
                
                UNION ALL
                
                SELECT 
                    'well' as feature_type,
                    nw.well_id as feature_id,
                    COALESCE(nw.owner, 'Unknown Owner') as feature_name,
                    nw.zone_id,
                    wmz.name as zone_name,
                    nw.geom,
                    nw.depth_m as size_metric,
                    nw.static_water_level_m as water_level,
                    nw.well_type as usage_type,
                    nw.status as water_availability,
                    nw.yield_liters_per_hour as capacity,
                    wqr.overall_quality as water_quality,
                    ma.activity_status as maintenance_status
                FROM nested_wells nw
                JOIN water_management_zones wmz ON nw.zone_id = wmz.zone_id
                LEFT JOIN water_quality_reports wqr ON wqr.feature_type = 'well' AND wqr.feature_id = nw.well_id
                LEFT JOIN maintenance_activities ma ON ma.feature_type = 'well' AND ma.feature_id = nw.well_id
                
                UNION ALL
                
                SELECT 
                    'borehole' as feature_type,
                    nb.borehole_id as feature_id,
                    nb.drilling_company as feature_name,
                    nb.zone_id,
                    wmz.name as zone_name,
                    nb.geom,
                    nb.total_depth_m as size_metric,
                    gl.final_groundwater_level_m as water_level,
                    nb.pump_type as usage_type,
                    'Active' as water_availability,
                    nb.pump_capacity_lph as capacity,
                    wqr.overall_quality as water_quality,
                    ma.activity_status as maintenance_status
                FROM nested_boreholes nb
                JOIN water_management_zones wmz ON nb.zone_id = wmz.zone_id
                LEFT JOIN geological_logs gl ON nb.borehole_id = gl.borehole_id
                LEFT JOIN water_quality_reports wqr ON wqr.feature_type = 'borehole' AND wqr.feature_id = nb.borehole_id
                LEFT JOIN maintenance_activities ma ON ma.feature_type = 'borehole' AND ma.feature_id = nb.borehole_id
            """
        },
        {
            "view_name": "v_geological_features",
            "view_definition": """
                SELECT 
                    ROW_NUMBER() OVER (ORDER BY gl.log_id, sl.depth_from_m) as gid,
                    gl.log_id,
                    nb.borehole_id,
                    nb.zone_id,
                    nb.geom,
                    sl.depth_from_m,
                    sl.depth_to_m,
                    sl.layer_thickness_m,
                    sl.rock_type,
                    sl.water_bearing,
                    sl.permeability,
                    sl.porosity_percentage,
                    gl.rock_formation,
                    gl.overall_aquifer_potential,
                    sl.geotechnical_properties::text as geotechnical_data
                FROM geological_logs gl
                JOIN nested_boreholes nb ON gl.borehole_id = nb.borehole_id
                JOIN stratigraphic_layers sl ON gl.log_id = sl.geological_log_id
                WHERE sl.water_bearing = true
            """
        }
    ]
    
    # Create complex views
    print("\n📊 Creating Complex Feature Views")
    print("-" * 40)
    for view_config in complex_views:
        create_complex_feature_view(view_config["view_name"], view_config["view_definition"])
    
    # Define layers to publish
    layers_to_publish = [
        {
            "layer_name": "water_management_zones_detailed",
            "table_name": "v_water_management_zones_detailed", 
            "title": "Water Management Zones (Detailed Statistics)"
        },
        {
            "layer_name": "water_infrastructure_comprehensive",
            "table_name": "v_water_infrastructure_comprehensive",
            "title": "Comprehensive Water Infrastructure (All Types)"
        },
        {
            "layer_name": "geological_water_bearing_layers",
            "table_name": "v_geological_features",
            "title": "Geological Water-Bearing Layers"
        },
        {
            "layer_name": "nested_ponds_detailed",
            "table_name": "nested_ponds",
            "title": "Nested Ponds (Detailed Attributes)"
        },
        {
            "layer_name": "nested_wells_detailed", 
            "table_name": "nested_wells",
            "title": "Nested Wells (Detailed Attributes)"
        },
        {
            "layer_name": "nested_boreholes_detailed",
            "table_name": "nested_boreholes",
            "title": "Nested Boreholes (Detailed Attributes)"
        },
        {
            "layer_name": "water_quality_reports",
            "table_name": "water_quality_reports",
            "title": "Water Quality Test Reports"
        },
        {
            "layer_name": "maintenance_activities",
            "table_name": "maintenance_activities", 
            "title": "Infrastructure Maintenance Activities"
        }
    ]
    
    # Publish layers
    print("\n🗺️  Publishing Complex Feature Types")
    print("-" * 40)
    success_count = 0
    for layer in layers_to_publish:
        if publish_feature_type(WORKSPACE, DATASTORE, 
                              layer["layer_name"], 
                              layer["table_name"], 
                              layer["title"]):
            success_count += 1
        time.sleep(2)  # Brief pause between operations
    
    # Summary
    print("\n" + "=" * 70)
    print(f"📈 PUBLISHING SUMMARY")
    print(f"✅ Successfully published: {success_count}/{len(layers_to_publish)} layers")
    print(f"🌐 Workspace: {WORKSPACE}")
    print(f"💾 Datastore: {DATASTORE}")
    
    if success_count == len(layers_to_publish):
        print("\n🎉 All complex nested water resources layers published successfully!")
        print("\n🔗 Access your layers at:")
        for layer in layers_to_publish:
            wms_url = f"{GEOSERVER_URL}/{WORKSPACE}/wms?service=WMS&version=1.1.0&request=GetMap&layers={WORKSPACE}:{layer['layer_name']}&bbox=-180,-90,180,90&width=768&height=384&srs=EPSG:4326&format=image/png"
            print(f"   • {layer['title']}: {wms_url}")
        
        print(f"\n📋 WFS GetCapabilities: {GEOSERVER_URL}/{WORKSPACE}/ows?service=wfs&version=1.0.0&request=GetCapabilities")
        print(f"📋 WMS GetCapabilities: {GEOSERVER_URL}/{WORKSPACE}/ows?service=wms&version=1.1.1&request=GetCapabilities")
        
        return True
    else:
        print(f"\n⚠️  Some layers failed to publish. Check the logs above.")
        return False

if __name__ == "__main__":
    success = main()
    exit(0 if success else 1)