-- Restore original simple water infrastructure tables
-- These tables match what the webapp and GeoServer expect

-- Wells table (POINT geometry)
CREATE TABLE IF NOT EXISTS wells (
    id SERIAL PRIMARY KEY,
    well_id VARCHAR(50) UNIQUE NOT NULL,
    owner VARCHAR(200),
    well_type VARCHAR(50), -- open_well, tube_well, artesian, community, traditional
    depth_m DECIMAL(8,2),
    static_water_level_m DECIMAL(8,2),
    yield_liters_per_hour DECIMAL(10,2),
    status VARCHAR(30) DEFAULT 'active', -- active, abandoned, dry, under_maintenance
    name VARCHAR(200),
    description TEXT,
    feature_type VARCHAR(20) DEFAULT 'well',
    geom GEOMETRY(POINT, 4326) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Ponds table (POINT geometry - representing pond center)
CREATE TABLE IF NOT EXISTS ponds (
    id SERIAL PRIMARY KEY,
    pond_id VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(200) NOT NULL,
    surface_area_sqm DECIMAL(12,2),
    maximum_depth_m DECIMAL(6,2),
    is_perennial BOOLEAN DEFAULT FALSE,
    primary_use VARCHAR(50), -- irrigation, drinking, fishery, recreation
    capacity_liters BIGINT,
    status VARCHAR(30) DEFAULT 'active',
    description TEXT,
    feature_type VARCHAR(20) DEFAULT 'pond',
    geom GEOMETRY(POINT, 4326) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Boreholes table (POINT geometry)
CREATE TABLE IF NOT EXISTS boreholes (
    id SERIAL PRIMARY KEY,
    borehole_id VARCHAR(50) UNIQUE NOT NULL,
    drilling_company VARCHAR(200),
    total_depth_m DECIMAL(8,2),
    pump_capacity_lph DECIMAL(10,2),
    drilling_cost DECIMAL(12,2),
    completion_date DATE,
    status VARCHAR(30) DEFAULT 'active',
    name VARCHAR(200),
    description TEXT,
    feature_type VARCHAR(20) DEFAULT 'borehole',
    geom GEOMETRY(POINT, 4326) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create spatial indexes
CREATE INDEX IF NOT EXISTS idx_wells_geom ON wells USING GIST (geom);
CREATE INDEX IF NOT EXISTS idx_ponds_geom ON ponds USING GIST (geom);
CREATE INDEX IF NOT EXISTS idx_boreholes_geom ON boreholes USING GIST (geom);

-- Create unified view for all water infrastructure
CREATE OR REPLACE VIEW v_water_infrastructure_comprehensive AS
SELECT 
    well_id as id,
    name,
    'well' as type,
    feature_type,
    well_type as subtype,
    depth_m,
    owner,
    status,
    description,
    geom
FROM wells
UNION ALL
SELECT 
    pond_id as id,
    name,
    'pond' as type,
    feature_type,
    primary_use as subtype,
    maximum_depth_m as depth_m,
    'Community' as owner,
    status,
    description,
    geom
FROM ponds
UNION ALL
SELECT 
    borehole_id as id,
    name,
    'borehole' as type,
    feature_type,
    'drilled' as subtype,
    total_depth_m as depth_m,
    drilling_company as owner,
    status,
    description,
    geom
FROM boreholes;

COMMIT;