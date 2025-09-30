<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

// Database connection parameters
$host = 'postgres';
$dbname = 'gis_db';
$username = 'gis_user';
$password = 'gis_password';

try {
    $pdo = new PDO("pgsql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection failed: ' . $e->getMessage()]);
    exit;
}

$action = $_GET['action'] ?? '';
$feature_id = $_GET['feature_id'] ?? '';

if (empty($action) || empty($feature_id)) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing action or feature_id parameter']);
    exit;
}

switch ($action) {
    case 'construction_details':
        getConstructionDetails($pdo, $feature_id);
        break;
    
    case 'water_quality':
        getWaterQualityReports($pdo, $feature_id);
        break;
    
    case 'maintenance':
        getMaintenanceActivities($pdo, $feature_id);
        break;
    
    default:
        http_response_code(400);
        echo json_encode(['error' => 'Invalid action parameter']);
        exit;
}

function getConstructionDetails($pdo, $feature_id) {
    try {
        $stmt = $pdo->prepare("
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
            WHERE feature_id = ?
        ");
        
        $stmt->execute([$feature_id]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($result) {
            // Convert PostgreSQL arrays to PHP arrays
            $result['materials_used'] = parsePostgreSQLArray($result['materials_used']);
            $result['equipment_used'] = parsePostgreSQLArray($result['equipment_used']);
            
            echo json_encode($result);
        } else {
            http_response_code(404);
            echo json_encode(['error' => 'No construction details found for this feature']);
        }
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Database query failed: ' . $e->getMessage()]);
    }
}

function getWaterQualityReports($pdo, $feature_id) {
    try {
        $stmt = $pdo->prepare("
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
            WHERE feature_id = ?
            ORDER BY test_date DESC
        ");
        
        $stmt->execute([$feature_id]);
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        if ($results) {
            echo json_encode($results);
        } else {
            http_response_code(404);
            echo json_encode(['error' => 'No water quality reports found for this feature']);
        }
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Database query failed: ' . $e->getMessage()]);
    }
}

function getMaintenanceActivities($pdo, $feature_id) {
    try {
        $stmt = $pdo->prepare("
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
            WHERE feature_id = ?
            ORDER BY activity_date DESC
        ");
        
        $stmt->execute([$feature_id]);
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        if ($results) {
            // Convert PostgreSQL arrays to PHP arrays for each result
            foreach ($results as &$result) {
                $result['parts_replaced'] = parsePostgreSQLArray($result['parts_replaced']);
                $result['equipment_used'] = parsePostgreSQLArray($result['equipment_used']);
            }
            
            echo json_encode($results);
        } else {
            http_response_code(404);
            echo json_encode(['error' => 'No maintenance activities found for this feature']);
        }
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Database query failed: ' . $e->getMessage()]);
    }
}

function parsePostgreSQLArray($pgArray) {
    if (empty($pgArray) || $pgArray === '{}') {
        return [];
    }
    
    // Remove outer braces and split by comma
    $array = trim($pgArray, '{}');
    if (empty($array)) {
        return [];
    }
    
    // Split by comma and clean up quotes
    $items = explode(',', $array);
    return array_map(function($item) {
        return trim($item, '"');
    }, $items);
}
?>