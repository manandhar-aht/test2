-- Advanced Water Resources Management Data Model
-- This schema implements a complex nested feature model for water resources

-- Enable PostGIS extension
CREATE EXTENSION IF NOT EXISTS postgis;

-- Drop existing tables if they exist (for clean setup)
DROP TABLE IF EXISTS stratigraphic_layers CASCADE;
DROP TABLE IF EXISTS water_quality_reports CASCADE;
DROP TABLE IF EXISTS maintenance_activities CASCADE;
DROP TABLE IF EXISTS construction_data CASCADE;
DROP TABLE IF EXISTS boreholes CASCADE;
DROP TABLE IF EXISTS wells CASCADE;
DROP TABLE IF EXISTS ponds CASCADE;
DROP TABLE IF EXISTS water_management_zones CASCADE;

-- 1. Top-Level Feature: Water Management Zone
CREATE TABLE water_management_zones (
    zone_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    area_sq_km DOUBLE PRECISION,
    administrative_region VARCHAR(100),
    geom GEOMETRY(POLYGON, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Nested Feature: Pond
CREATE TABLE ponds (
    pond_id VARCHAR(50) PRIMARY KEY,
    zone_id VARCHAR(50) REFERENCES water_management_zones(zone_id) ON DELETE CASCADE,
    name VARCHAR(200),
    surface_area DOUBLE PRECISION, -- in square meters
    current_water_level DOUBLE PRECISION, -- in meters
    is_perennial BOOLEAN DEFAULT FALSE,
    geom GEOMETRY(POLYGON, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Nested Feature: Well
CREATE TABLE wells (
    well_id VARCHAR(50) PRIMARY KEY,
    zone_id VARCHAR(50) REFERENCES water_management_zones(zone_id) ON DELETE CASCADE,
    owner VARCHAR(200),
    depth_m DOUBLE PRECISION,
    static_water_level DOUBLE PRECISION,
    geom GEOMETRY(POINT, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Nested Feature: Borehole
CREATE TABLE boreholes (
    borehole_id VARCHAR(50) PRIMARY KEY,
    zone_id VARCHAR(50) REFERENCES water_management_zones(zone_id) ON DELETE CASCADE,
    drilling_company VARCHAR(200),
    total_depth_m DOUBLE PRECISION,
    casing_diameter_mm DOUBLE PRECISION,
    geom GEOMETRY(POINT, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Nested Data Object: Construction Details for Wells
CREATE TABLE construction_data (
    construction_id SERIAL PRIMARY KEY,
    well_id VARCHAR(50) REFERENCES wells(well_id) ON DELETE CASCADE,
    construction_date DATE,
    construction_method VARCHAR(100), -- 'hand_dug', 'machine_drilled', 'bore_well'
    lining_material VARCHAR(100), -- 'concrete_rings', 'brick', 'steel_casing'
    pump_type VARCHAR(100), -- 'hand_pump', 'electric_pump', 'solar_pump'
    installation_cost DECIMAL(10,2),
    contractor_name VARCHAR(200),
    construction_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. Nested Data Object: Water Quality Reports (for both wells and ponds)
CREATE TABLE water_quality_reports (
    report_id SERIAL PRIMARY KEY,
    feature_type VARCHAR(20) CHECK (feature_type IN ('well', 'pond', 'borehole')),
    feature_id VARCHAR(50), -- References well_id, pond_id, or borehole_id
    test_date DATE,
    ph_level DOUBLE PRECISION,
    tds_ppm DOUBLE PRECISION, -- Total Dissolved Solids in parts per million
    hardness_ppm DOUBLE PRECISION,
    nitrate_ppm DOUBLE PRECISION,
    fluoride_ppm DOUBLE PRECISION,
    iron_ppm DOUBLE PRECISION,
    bacterial_contamination BOOLEAN,
    potability_rating VARCHAR(20) CHECK (potability_rating IN ('excellent', 'good', 'fair', 'poor', 'unsafe')),
    tested_by VARCHAR(200),
    lab_certification VARCHAR(100),
    report_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Create composite foreign key constraints
    CONSTRAINT fk_water_quality_well FOREIGN KEY (feature_id) 
        REFERENCES wells(well_id) ON DELETE CASCADE
        DEFERRABLE INITIALLY DEFERRED,
    CONSTRAINT fk_water_quality_pond FOREIGN KEY (feature_id) 
        REFERENCES ponds(pond_id) ON DELETE CASCADE
        DEFERRABLE INITIALLY DEFERRED,
    CONSTRAINT fk_water_quality_borehole FOREIGN KEY (feature_id) 
        REFERENCES boreholes(borehole_id) ON DELETE CASCADE
        DEFERRABLE INITIALLY DEFERRED
);

-- 7. Nested Data Object: Maintenance Activities (for ponds)
CREATE TABLE maintenance_activities (
    activity_id SERIAL PRIMARY KEY,
    pond_id VARCHAR(50) REFERENCES ponds(pond_id) ON DELETE CASCADE,
    activity_type VARCHAR(100), -- 'desilting', 'embankment_repair', 'water_treatment', 'vegetation_control'
    scheduled_date DATE,
    completed_date DATE,
    activity_status VARCHAR(20) CHECK (activity_status IN ('planned', 'in_progress', 'completed', 'cancelled')),
    cost_estimate DECIMAL(10,2),
    actual_cost DECIMAL(10,2),
    contractor_name VARCHAR(200),
    activity_description TEXT,
    completion_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. Highly Complex Nested Data: Stratigraphic Layers (for boreholes)
CREATE TABLE stratigraphic_layers (
    layer_id SERIAL PRIMARY KEY,
    borehole_id VARCHAR(50) REFERENCES boreholes(borehole_id) ON DELETE CASCADE,
    layer_sequence INTEGER, -- Order of layers from top to bottom
    depth_from_m DOUBLE PRECISION,
    depth_to_m DOUBLE PRECISION,
    thickness_m DOUBLE PRECISION GENERATED ALWAYS AS (depth_to_m - depth_from_m) STORED,
    lithology VARCHAR(100), -- 'clay', 'sand', 'gravel', 'rock', 'silt', 'limestone'
    color VARCHAR(50),
    grain_size VARCHAR(50), -- 'fine', 'medium', 'coarse'
    water_bearing BOOLEAN,
    permeability_rating VARCHAR(20) CHECK (permeability_rating IN ('very_low', 'low', 'medium', 'high', 'very_high')),
    sample_recovery_percentage DOUBLE PRECISION,
    geological_age VARCHAR(100),
    formation_name VARCHAR(100),
    layer_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Ensure logical depth ordering
    CHECK (depth_from_m < depth_to_m),
    CHECK (depth_from_m >= 0),
    
    -- Unique constraint to prevent overlapping layers in same borehole
    UNIQUE (borehole_id, layer_sequence)
);

-- Create spatial indexes for performance
CREATE INDEX idx_wmz_geom ON water_management_zones USING GIST (geom);
CREATE INDEX idx_ponds_geom ON ponds USING GIST (geom);
CREATE INDEX idx_wells_geom ON wells USING GIST (geom);
CREATE INDEX idx_boreholes_geom ON boreholes USING GIST (geom);

-- Create regular indexes for foreign keys and common queries
CREATE INDEX idx_ponds_zone_id ON ponds(zone_id);
CREATE INDEX idx_wells_zone_id ON wells(zone_id);
CREATE INDEX idx_boreholes_zone_id ON boreholes(zone_id);
CREATE INDEX idx_water_quality_feature ON water_quality_reports(feature_type, feature_id);
CREATE INDEX idx_water_quality_date ON water_quality_reports(test_date);
CREATE INDEX idx_maintenance_pond ON maintenance_activities(pond_id);
CREATE INDEX idx_maintenance_date ON maintenance_activities(scheduled_date);
CREATE INDEX idx_stratigraphic_borehole ON stratigraphic_layers(borehole_id);
CREATE INDEX idx_stratigraphic_sequence ON stratigraphic_layers(borehole_id, layer_sequence);

-- Create a view for complex water management zone summary
CREATE OR REPLACE VIEW water_management_zone_summary AS
SELECT 
    wmz.zone_id,
    wmz.name as zone_name,
    wmz.area_sq_km,
    wmz.administrative_region,
    COUNT(DISTINCT p.pond_id) as total_ponds,
    COUNT(DISTINCT w.well_id) as total_wells,
    COUNT(DISTINCT b.borehole_id) as total_boreholes,
    COALESCE(SUM(p.surface_area), 0) as total_pond_area_m2,
    COALESCE(AVG(w.depth_m), 0) as avg_well_depth,
    COALESCE(AVG(w.static_water_level), 0) as avg_static_water_level,
    COALESCE(AVG(b.total_depth_m), 0) as avg_borehole_depth,
    ST_Area(wmz.geom::geography) as actual_area_m2,
    ST_Centroid(wmz.geom) as center_point
FROM water_management_zones wmz
LEFT JOIN ponds p ON wmz.zone_id = p.zone_id
LEFT JOIN wells w ON wmz.zone_id = w.zone_id  
LEFT JOIN boreholes b ON wmz.zone_id = b.zone_id
GROUP BY wmz.zone_id, wmz.name, wmz.area_sq_km, wmz.administrative_region, wmz.geom;

-- Create a function to get water quality trends
CREATE OR REPLACE FUNCTION get_water_quality_trend(
    p_feature_type VARCHAR,
    p_feature_id VARCHAR,
    p_months_back INTEGER DEFAULT 12
)
RETURNS TABLE (
    test_month DATE,
    avg_ph DOUBLE PRECISION,
    avg_tds DOUBLE PRECISION,
    avg_hardness DOUBLE PRECISION,
    quality_trend VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        DATE_TRUNC('month', wqr.test_date)::DATE as test_month,
        AVG(wqr.ph_level) as avg_ph,
        AVG(wqr.tds_ppm) as avg_tds,
        AVG(wqr.hardness_ppm) as avg_hardness,
        CASE 
            WHEN AVG(wqr.ph_level) BETWEEN 6.5 AND 8.5 
                 AND AVG(wqr.tds_ppm) < 1000 
                 AND AVG(wqr.hardness_ppm) < 300 THEN 'improving'
            WHEN AVG(wqr.ph_level) NOT BETWEEN 6.5 AND 8.5 
                 OR AVG(wqr.tds_ppm) > 1500 
                 OR AVG(wqr.hardness_ppm) > 500 THEN 'deteriorating'
            ELSE 'stable'
        END as quality_trend
    FROM water_quality_reports wqr
    WHERE wqr.feature_type = p_feature_type 
          AND wqr.feature_id = p_feature_id
          AND wqr.test_date >= CURRENT_DATE - INTERVAL '1 month' * p_months_back
    GROUP BY DATE_TRUNC('month', wqr.test_date)
    ORDER BY test_month;
END;
$$ LANGUAGE plpgsql;

-- Create a function to analyze geological profile
CREATE OR REPLACE FUNCTION get_geological_profile(p_borehole_id VARCHAR)
RETURNS TABLE (
    layer_sequence INTEGER,
    depth_range VARCHAR,
    lithology VARCHAR,
    water_bearing BOOLEAN,
    permeability_rating VARCHAR,
    thickness_m DOUBLE PRECISION
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        sl.layer_sequence,
        CONCAT(sl.depth_from_m, ' - ', sl.depth_to_m, ' m') as depth_range,
        sl.lithology,
        sl.water_bearing,
        sl.permeability_rating,
        sl.thickness_m
    FROM stratigraphic_layers sl
    WHERE sl.borehole_id = p_borehole_id
    ORDER BY sl.layer_sequence;
END;
$$ LANGUAGE plpgsql;