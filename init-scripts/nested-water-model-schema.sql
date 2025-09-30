-- Complex Nested Water Resources Data Model Schema
-- This creates a sophisticated hierarchical data structure for water management

-- Drop existing tables if they exist
DROP TABLE IF EXISTS stratigraphic_layers CASCADE;
DROP TABLE IF EXISTS geological_logs CASCADE;
DROP TABLE IF EXISTS maintenance_activities CASCADE;
DROP TABLE IF EXISTS water_quality_reports CASCADE;
DROP TABLE IF EXISTS construction_details CASCADE;
DROP TABLE IF EXISTS nested_boreholes CASCADE;
DROP TABLE IF EXISTS nested_wells CASCADE;
DROP TABLE IF EXISTS nested_ponds CASCADE;
DROP TABLE IF EXISTS water_management_zones CASCADE;

-- Enable PostGIS extensions
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Water Management Zone (Top-level container)
CREATE TABLE water_management_zones (
    id SERIAL PRIMARY KEY,
    zone_id VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(200) NOT NULL,
    area_sq_km DECIMAL(10,3),
    administrative_region VARCHAR(100),
    established_date DATE,
    management_authority VARCHAR(100),
    population_served INTEGER,
    annual_rainfall_mm DECIMAL(8,2),
    geom GEOMETRY(POLYGON, 4326) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Nested Ponds within Water Management Zones
CREATE TABLE nested_ponds (
    id SERIAL PRIMARY KEY,
    pond_id VARCHAR(50) UNIQUE NOT NULL,
    zone_id VARCHAR(50) REFERENCES water_management_zones(zone_id) ON DELETE CASCADE,
    name VARCHAR(200) NOT NULL,
    surface_area_sqm DECIMAL(12,2),
    current_water_level_m DECIMAL(6,2),
    maximum_depth_m DECIMAL(6,2),
    is_perennial BOOLEAN DEFAULT FALSE,
    construction_year INTEGER,
    primary_use VARCHAR(50), -- irrigation, drinking, fishery, recreation
    capacity_liters BIGINT,
    geom GEOMETRY(POLYGON, 4326) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Nested Wells within Water Management Zones
CREATE TABLE nested_wells (
    id SERIAL PRIMARY KEY,
    well_id VARCHAR(50) UNIQUE NOT NULL,
    zone_id VARCHAR(50) REFERENCES water_management_zones(zone_id) ON DELETE CASCADE,
    owner VARCHAR(200),
    well_type VARCHAR(50), -- open_well, tube_well, artesian
    depth_m DECIMAL(8,2),
    static_water_level_m DECIMAL(8,2),
    dynamic_water_level_m DECIMAL(8,2),
    yield_liters_per_hour DECIMAL(10,2),
    drilling_date DATE,
    status VARCHAR(30) DEFAULT 'active', -- active, abandoned, dry, under_maintenance
    geom GEOMETRY(POINT, 4326) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Nested Boreholes within Water Management Zones
CREATE TABLE nested_boreholes (
    id SERIAL PRIMARY KEY,
    borehole_id VARCHAR(50) UNIQUE NOT NULL,
    zone_id VARCHAR(50) REFERENCES water_management_zones(zone_id) ON DELETE CASCADE,
    drilling_company VARCHAR(200),
    total_depth_m DECIMAL(8,2),
    casing_diameter_mm DECIMAL(6,1),
    screen_depth_from_m DECIMAL(8,2),
    screen_depth_to_m DECIMAL(8,2),
    pump_type VARCHAR(50),
    pump_capacity_lph DECIMAL(10,2),
    drilling_cost DECIMAL(12,2),
    completion_date DATE,
    license_number VARCHAR(100),
    geom GEOMETRY(POINT, 4326) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Construction Details (Nested data for wells)
CREATE TABLE construction_details (
    id SERIAL PRIMARY KEY,
    well_id VARCHAR(50) REFERENCES nested_wells(well_id) ON DELETE CASCADE,
    contractor_name VARCHAR(200),
    construction_method VARCHAR(100),
    casing_material VARCHAR(50),
    casing_diameter_mm DECIMAL(6,1),
    pump_installation_depth_m DECIMAL(8,2),
    construction_cost DECIMAL(12,2),
    quality_certificate_number VARCHAR(100),
    construction_start_date DATE,
    construction_end_date DATE,
    warranty_period_months INTEGER,
    additional_notes TEXT
);

-- 6. Water Quality Reports (Nested for ponds, wells, and boreholes)
CREATE TABLE water_quality_reports (
    id SERIAL PRIMARY KEY,
    report_id VARCHAR(50) UNIQUE NOT NULL,
    feature_type VARCHAR(20) NOT NULL, -- pond, well, borehole
    feature_id VARCHAR(50) NOT NULL,
    test_date DATE NOT NULL,
    ph_level DECIMAL(4,2),
    tds_ppm DECIMAL(8,2),
    hardness_ppm DECIMAL(8,2),
    chloride_ppm DECIMAL(8,2),
    fluoride_ppm DECIMAL(6,3),
    nitrate_ppm DECIMAL(8,2),
    iron_ppm DECIMAL(6,3),
    bacterial_contamination BOOLEAN,
    overall_quality VARCHAR(30), -- excellent, good, acceptable, poor, unsafe
    testing_laboratory VARCHAR(200),
    lab_certificate_number VARCHAR(100),
    recommended_treatment TEXT,
    next_test_due_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 7. Maintenance Activities (Nested for all water features)
CREATE TABLE maintenance_activities (
    id SERIAL PRIMARY KEY,
    activity_id VARCHAR(50) UNIQUE NOT NULL,
    feature_type VARCHAR(20) NOT NULL,
    feature_id VARCHAR(50) NOT NULL,
    activity_type VARCHAR(100), -- cleaning, repair, pump_maintenance, water_treatment
    scheduled_date DATE,
    completed_date DATE,
    maintenance_team VARCHAR(200),
    activity_description TEXT,
    cost DECIMAL(12,2),
    materials_used TEXT,
    activity_status VARCHAR(30) DEFAULT 'scheduled', -- scheduled, in_progress, completed, cancelled
    next_maintenance_date DATE,
    emergency_repair BOOLEAN DEFAULT FALSE,
    effectiveness_rating INTEGER CHECK (effectiveness_rating BETWEEN 1 AND 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. Geological Logs (Complex nested data for boreholes)
CREATE TABLE geological_logs (
    id SERIAL PRIMARY KEY,
    log_id VARCHAR(50) UNIQUE NOT NULL,
    borehole_id VARCHAR(50) REFERENCES nested_boreholes(borehole_id) ON DELETE CASCADE,
    drilling_date DATE,
    geologist_name VARCHAR(200),
    total_depth_logged_m DECIMAL(8,2),
    groundwater_first_encountered_m DECIMAL(8,2),
    final_groundwater_level_m DECIMAL(8,2),
    rock_formation VARCHAR(100),
    overall_aquifer_potential VARCHAR(50), -- high, medium, low, very_low
    log_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 9. Stratigraphic Layers (Highly complex nested data within geological logs)
CREATE TABLE stratigraphic_layers (
    id SERIAL PRIMARY KEY,
    layer_id VARCHAR(50) UNIQUE NOT NULL,
    geological_log_id VARCHAR(50) REFERENCES geological_logs(log_id) ON DELETE CASCADE,
    depth_from_m DECIMAL(8,2),
    depth_to_m DECIMAL(8,2),
    layer_thickness_m DECIMAL(8,2),
    rock_type VARCHAR(100),
    grain_size VARCHAR(50), -- clay, silt, fine_sand, medium_sand, coarse_sand, gravel, boulder
    color VARCHAR(50),
    hardness VARCHAR(30), -- soft, medium, hard, very_hard
    water_bearing BOOLEAN DEFAULT FALSE,
    permeability VARCHAR(30), -- high, medium, low, impermeable
    porosity_percentage DECIMAL(5,2),
    mineral_composition TEXT,
    fossils_present BOOLEAN DEFAULT FALSE,
    weathering_degree VARCHAR(30), -- fresh, slightly_weathered, moderately_weathered, highly_weathered
    fracture_density VARCHAR(30), -- none, low, medium, high
    layer_description TEXT,
    geotechnical_properties JSONB, -- Store complex technical data as JSON
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create spatial indexes for better performance
CREATE INDEX idx_wmz_geom ON water_management_zones USING GIST (geom);
CREATE INDEX idx_ponds_geom ON nested_ponds USING GIST (geom);
CREATE INDEX idx_wells_geom ON nested_wells USING GIST (geom);
CREATE INDEX idx_boreholes_geom ON nested_boreholes USING GIST (geom);

-- Create indexes for foreign key relationships
CREATE INDEX idx_ponds_zone_id ON nested_ponds(zone_id);
CREATE INDEX idx_wells_zone_id ON nested_wells(zone_id);
CREATE INDEX idx_boreholes_zone_id ON nested_boreholes(zone_id);
CREATE INDEX idx_water_quality_feature ON water_quality_reports(feature_type, feature_id);
CREATE INDEX idx_maintenance_feature ON maintenance_activities(feature_type, feature_id);
CREATE INDEX idx_construction_well ON construction_details(well_id);
CREATE INDEX idx_geological_borehole ON geological_logs(borehole_id);
CREATE INDEX idx_strat_geological_log ON stratigraphic_layers(geological_log_id);

-- Create views for complex feature relationships

-- View: Water Management Zones with nested feature counts
CREATE VIEW wmz_with_feature_counts AS
SELECT 
    wmz.*,
    COALESCE(pond_count, 0) as total_ponds,
    COALESCE(well_count, 0) as total_wells,
    COALESCE(borehole_count, 0) as total_boreholes,
    COALESCE(pond_count, 0) + COALESCE(well_count, 0) + COALESCE(borehole_count, 0) as total_water_features
FROM water_management_zones wmz
LEFT JOIN (
    SELECT zone_id, COUNT(*) as pond_count 
    FROM nested_ponds 
    GROUP BY zone_id
) p ON wmz.zone_id = p.zone_id
LEFT JOIN (
    SELECT zone_id, COUNT(*) as well_count 
    FROM nested_wells 
    GROUP BY zone_id
) w ON wmz.zone_id = w.zone_id
LEFT JOIN (
    SELECT zone_id, COUNT(*) as borehole_count 
    FROM nested_boreholes 
    GROUP BY zone_id
) b ON wmz.zone_id = b.zone_id;

-- View: Complete well information with construction details and latest water quality
CREATE VIEW complete_wells AS
SELECT 
    nw.*,
    cd.contractor_name,
    cd.construction_method,
    cd.casing_material,
    cd.construction_cost,
    wqr.test_date as latest_water_test_date,
    wqr.ph_level,
    wqr.tds_ppm,
    wqr.overall_quality
FROM nested_wells nw
LEFT JOIN construction_details cd ON nw.well_id = cd.well_id
LEFT JOIN LATERAL (
    SELECT * FROM water_quality_reports 
    WHERE feature_type = 'well' AND feature_id = nw.well_id 
    ORDER BY test_date DESC 
    LIMIT 1
) wqr ON TRUE;

-- View: Complete borehole information with geological data
CREATE VIEW complete_boreholes AS
SELECT 
    nb.*,
    gl.geologist_name,
    gl.total_depth_logged_m,
    gl.groundwater_first_encountered_m,
    gl.overall_aquifer_potential,
    COUNT(sl.id) as stratigraphic_layers_count
FROM nested_boreholes nb
LEFT JOIN geological_logs gl ON nb.borehole_id = gl.borehole_id
LEFT JOIN stratigraphic_layers sl ON gl.log_id = sl.geological_log_id
GROUP BY nb.id, gl.geologist_name, gl.total_depth_logged_m, 
         gl.groundwater_first_encountered_m, gl.overall_aquifer_potential;

-- View: Water features with latest maintenance status
-- Commented out problematic view for now
-- CREATE VIEW features_with_maintenance AS
--     SELECT 
--         features.feature_type,
--         features.feature_id,
--         latest_maintenance.activity_type as last_maintenance_type,
--         latest_maintenance.completed_date as last_maintenance_date,
--         latest_maintenance.next_maintenance_date,
--         latest_maintenance.activity_status as maintenance_status,
--         CASE 
--             WHEN latest_maintenance.next_maintenance_date < CURRENT_DATE THEN 'OVERDUE'
--             WHEN latest_maintenance.next_maintenance_date <= CURRENT_DATE + INTERVAL '30 days' THEN 'DUE_SOON'
--             ELSE 'SCHEDULED'
--         END as maintenance_urgency
-- FROM (
--     SELECT DISTINCT feature_type, feature_id 
--     FROM maintenance_activities
-- ) features
-- LEFT JOIN LATERAL (
--     SELECT * FROM maintenance_activities ma
--     WHERE ma.feature_type = features.feature_type 
--     AND ma.feature_id = features.feature_id
--     ORDER BY ma.completed_date DESC NULLS LAST, ma.scheduled_date DESC
--     LIMIT 1
-- ) latest_maintenance ON TRUE;-- Grant permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO geouser;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO geouser;

-- Add comments for documentation
COMMENT ON TABLE water_management_zones IS 'Top-level geographic containers for water resources management';
COMMENT ON TABLE nested_ponds IS 'Pond features nested within water management zones';
COMMENT ON TABLE nested_wells IS 'Well features nested within water management zones';
COMMENT ON TABLE nested_boreholes IS 'Borehole features nested within water management zones';
COMMENT ON TABLE stratigraphic_layers IS 'Detailed geological layers found during borehole drilling - highly complex nested data';
COMMENT ON VIEW wmz_with_feature_counts IS 'Water management zones with counts of nested water features';
COMMENT ON VIEW complete_wells IS 'Wells with complete construction and water quality information';
COMMENT ON VIEW complete_boreholes IS 'Boreholes with complete geological information';

COMMIT;