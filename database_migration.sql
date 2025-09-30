-- Migration Script: Remove "nested_" prefix from table names
-- This script renames tables to make wells, ponds, and boreholes regular entities
-- The "nested" concept will be determined by spatial relationship with water management zones

BEGIN;

-- ============================================
-- STEP 1: Rename base tables (remove nested_ prefix)
-- ============================================

-- Rename nested_wells to wells
ALTER TABLE nested_wells RENAME TO wells;

-- Rename nested_ponds to ponds  
ALTER TABLE nested_ponds RENAME TO ponds;

-- Rename nested_boreholes to boreholes
ALTER TABLE nested_boreholes RENAME TO boreholes;

-- ============================================
-- STEP 2: Update sequence names
-- ============================================

-- Update well sequence name
ALTER SEQUENCE nested_wells_id_seq RENAME TO wells_id_seq;
ALTER TABLE wells ALTER COLUMN id SET DEFAULT nextval('wells_id_seq'::regclass);

-- Update pond sequence name  
ALTER SEQUENCE nested_ponds_id_seq RENAME TO ponds_id_seq;
ALTER TABLE ponds ALTER COLUMN id SET DEFAULT nextval('ponds_id_seq'::regclass);

-- Update borehole sequence name
ALTER SEQUENCE nested_boreholes_id_seq RENAME TO boreholes_id_seq;
ALTER TABLE boreholes ALTER COLUMN id SET DEFAULT nextval('boreholes_id_seq'::regclass);

-- ============================================
-- STEP 3: Update constraint names
-- ============================================

-- Wells constraints
ALTER TABLE wells RENAME CONSTRAINT nested_wells_pkey TO wells_pkey;
ALTER TABLE wells RENAME CONSTRAINT nested_wells_well_id_key TO wells_well_id_key;
ALTER TABLE wells RENAME CONSTRAINT nested_wells_zone_id_fkey TO wells_zone_id_fkey;

-- Ponds constraints  
ALTER TABLE ponds RENAME CONSTRAINT nested_ponds_pkey TO ponds_pkey;
ALTER TABLE ponds RENAME CONSTRAINT nested_ponds_pond_id_key TO ponds_pond_id_key;
ALTER TABLE ponds RENAME CONSTRAINT nested_ponds_zone_id_fkey TO ponds_zone_id_fkey;

-- Boreholes constraints
ALTER TABLE boreholes RENAME CONSTRAINT nested_boreholes_pkey TO boreholes_pkey;
ALTER TABLE boreholes RENAME CONSTRAINT nested_boreholes_borehole_id_key TO boreholes_borehole_id_key;
ALTER TABLE boreholes RENAME CONSTRAINT nested_boreholes_zone_id_fkey TO boreholes_zone_id_fkey;

-- ============================================
-- STEP 4: Update index names
-- ============================================

-- Wells indexes
ALTER INDEX idx_wells_geom RENAME TO idx_wells_geometry;
ALTER INDEX idx_wells_zone_id RENAME TO idx_wells_zone_id_new;

-- Ponds indexes
ALTER INDEX idx_ponds_geom RENAME TO idx_ponds_geometry;
ALTER INDEX idx_ponds_zone_id RENAME TO idx_ponds_zone_id_new;

-- Boreholes indexes
ALTER INDEX idx_boreholes_geom RENAME TO idx_boreholes_geometry;
ALTER INDEX idx_boreholes_zone_id RENAME TO idx_boreholes_zone_id_new;

-- ============================================
-- STEP 5: Update foreign key references
-- ============================================

-- Update construction_details table foreign key
ALTER TABLE construction_details DROP CONSTRAINT IF EXISTS construction_details_well_id_fkey;
ALTER TABLE construction_details ADD CONSTRAINT construction_details_well_id_fkey 
    FOREIGN KEY (well_id) REFERENCES wells(well_id) ON DELETE CASCADE;

-- Update geological_logs table foreign key
ALTER TABLE geological_logs DROP CONSTRAINT IF EXISTS geological_logs_borehole_id_fkey;
ALTER TABLE geological_logs ADD CONSTRAINT geological_logs_borehole_id_fkey 
    FOREIGN KEY (borehole_id) REFERENCES boreholes(borehole_id) ON DELETE CASCADE;

-- ============================================
-- STEP 6: Recreate views with updated table names
-- ============================================

-- Drop existing complete views
DROP VIEW IF EXISTS complete_wells CASCADE;
DROP VIEW IF EXISTS complete_boreholes CASCADE;
DROP VIEW IF EXISTS complete_ponds CASCADE;

-- Recreate complete_wells view
CREATE VIEW complete_wells AS
SELECT 
    w.*,
    cd.contractor_name,
    cd.construction_method,
    cd.casing_material,
    cd.construction_cost,
    wq.test_date as latest_water_test_date,
    wq.ph_level,
    wq.tds_ppm,
    wq.overall_quality
FROM wells w
LEFT JOIN construction_details cd ON w.well_id = cd.well_id
LEFT JOIN (
    SELECT DISTINCT ON (feature_id) 
        feature_id, test_date, ph_level, tds_ppm, overall_quality
    FROM water_quality_reports 
    WHERE feature_type = 'well'
    ORDER BY feature_id, test_date DESC
) wq ON w.well_id = wq.feature_id;

-- Recreate complete_boreholes view
CREATE VIEW complete_boreholes AS
SELECT 
    b.*,
    gl.geologist_name,
    gl.rock_formation,
    gl.overall_aquifer_potential,
    wq.test_date as latest_water_test_date,
    wq.ph_level,
    wq.tds_ppm,
    wq.overall_quality
FROM boreholes b
LEFT JOIN geological_logs gl ON b.borehole_id = gl.borehole_id
LEFT JOIN (
    SELECT DISTINCT ON (feature_id) 
        feature_id, test_date, ph_level, tds_ppm, overall_quality
    FROM water_quality_reports 
    WHERE feature_type = 'borehole'
    ORDER BY feature_id, test_date DESC
) wq ON b.borehole_id = wq.feature_id;

-- Recreate complete_ponds view (new view)
CREATE VIEW complete_ponds AS
SELECT 
    p.*,
    wq.test_date as latest_water_test_date,
    wq.ph_level,
    wq.tds_ppm,
    wq.overall_quality,
    ma.activity_type as latest_maintenance_type,
    ma.completed_date as latest_maintenance_date,
    ma.activity_status as maintenance_status
FROM ponds p
LEFT JOIN (
    SELECT DISTINCT ON (feature_id) 
        feature_id, test_date, ph_level, tds_ppm, overall_quality
    FROM water_quality_reports 
    WHERE feature_type = 'pond'
    ORDER BY feature_id, test_date DESC
) wq ON p.pond_id = wq.feature_id
LEFT JOIN (
    SELECT DISTINCT ON (feature_id) 
        feature_id, activity_type, completed_date, activity_status
    FROM maintenance_activities 
    WHERE feature_type = 'pond'
    ORDER BY feature_id, completed_date DESC NULLS LAST
) ma ON p.pond_id = ma.feature_id;

-- ============================================
-- STEP 7: Update comprehensive infrastructure view
-- ============================================

-- Drop and recreate the comprehensive infrastructure view
DROP VIEW IF EXISTS v_water_infrastructure_comprehensive CASCADE;

CREATE VIEW v_water_infrastructure_comprehensive AS
-- Wells
SELECT 
    'well' as feature_type,
    well_id as feature_id,
    well_id as name,
    owner,
    status,
    depth_m as depth,
    yield_liters_per_hour as capacity,
    zone_id,
    geom,
    created_at,
    CASE 
        WHEN zone_id IS NOT NULL THEN 'nested'
        ELSE 'standalone'
    END as nesting_status
FROM wells

UNION ALL

-- Ponds
SELECT 
    'pond' as feature_type,
    pond_id as feature_id,
    name,
    'Public/Community' as owner,
    CASE 
        WHEN is_perennial THEN 'active'
        ELSE 'seasonal'
    END as status,
    maximum_depth_m as depth,
    capacity_liters as capacity,
    zone_id,
    ST_Centroid(geom) as geom,
    created_at,
    CASE 
        WHEN zone_id IS NOT NULL THEN 'nested'
        ELSE 'standalone'
    END as nesting_status
FROM ponds

UNION ALL

-- Boreholes
SELECT 
    'borehole' as feature_type,
    borehole_id as feature_id,
    borehole_id as name,
    drilling_company as owner,
    'active' as status,
    total_depth_m as depth,
    pump_capacity_lph as capacity,
    zone_id,
    geom,
    created_at,
    CASE 
        WHEN zone_id IS NOT NULL THEN 'nested'
        ELSE 'standalone'
    END as nesting_status
FROM boreholes;

-- ============================================
-- STEP 8: Create detailed nested views for GeoServer
-- ============================================

-- NOTE: Nested views disabled to simplify layer management
-- These were causing JavaScript layer errors in the webapp
-- 
-- -- Nested Wells Detailed (only wells within zones)
-- CREATE VIEW nested_wells_detailed AS
-- SELECT 
--     w.*,
--     wmz.name as zone_name,
--     wmz.administrative_region,
--     cd.contractor_name,
--     cd.construction_method,
--     cd.casing_material,
--     cd.construction_cost,
--     wq.test_date as latest_water_test_date,
--     wq.ph_level,
--     wq.tds_ppm,
--     wq.overall_quality
-- FROM wells w
-- INNER JOIN water_management_zones wmz ON w.zone_id = wmz.zone_id
-- LEFT JOIN construction_details cd ON w.well_id = cd.well_id
-- LEFT JOIN (
--     SELECT DISTINCT ON (feature_id) 
--         feature_id, test_date, ph_level, tds_ppm, overall_quality
--     FROM water_quality_reports 
--     WHERE feature_type = 'well'
--     ORDER BY feature_id, test_date DESC
-- ) wq ON w.well_id = wq.feature_id;

-- -- Nested Ponds Detailed (only ponds within zones)
-- CREATE VIEW nested_ponds_detailed AS
-- SELECT 
--     p.*,
--     wmz.name as zone_name,
--     wmz.administrative_region,
--     wq.test_date as latest_water_test_date,
--     wq.ph_level,
--     wq.tds_ppm,
--     wq.overall_quality
-- FROM ponds p
-- INNER JOIN water_management_zones wmz ON p.zone_id = wmz.zone_id
-- LEFT JOIN (
--     SELECT DISTINCT ON (feature_id) 
--         feature_id, test_date, ph_level, tds_ppm, overall_quality
--     FROM water_quality_reports 
--     WHERE feature_type = 'pond'
--     ORDER BY feature_id, test_date DESC
-- ) wq ON p.pond_id = wq.feature_id;

-- -- Nested Boreholes Detailed (only boreholes within zones)  
-- CREATE VIEW nested_boreholes_detailed AS
-- SELECT 
--     b.*,
--     wmz.name as zone_name,
--     wmz.administrative_region,
--     gl.geologist_name,
--     gl.rock_formation,
--     gl.overall_aquifer_potential,
--     wq.test_date as latest_water_test_date,
--     wq.ph_level,
--     wq.tds_ppm,
--     wq.overall_quality
-- FROM boreholes b
-- INNER JOIN water_management_zones wmz ON b.zone_id = wmz.zone_id
-- LEFT JOIN geological_logs gl ON b.borehole_id = gl.borehole_id
-- LEFT JOIN (
--     SELECT DISTINCT ON (feature_id) 
--         feature_id, test_date, ph_level, tds_ppm, overall_quality
--     FROM water_quality_reports 
--     WHERE feature_type = 'borehole'
--     ORDER BY feature_id, test_date DESC
-- ) wq ON b.borehole_id = wq.feature_id;

-- ============================================
-- STEP 9: Update water management zones view
-- ============================================

-- Update the zones view to include correct counts
DROP VIEW IF EXISTS v_water_management_zones_detailed CASCADE;

CREATE VIEW v_water_management_zones_detailed AS
SELECT 
    wmz.*,
    COALESCE(well_counts.well_count, 0) as total_wells,
    COALESCE(pond_counts.pond_count, 0) as total_ponds,
    COALESCE(borehole_counts.borehole_count, 0) as total_boreholes,
    COALESCE(well_counts.active_wells, 0) as active_wells,
    COALESCE(pond_counts.perennial_ponds, 0) as perennial_ponds,
    CASE 
        WHEN COALESCE(well_counts.well_count, 0) + COALESCE(pond_counts.pond_count, 0) + COALESCE(borehole_counts.borehole_count, 0) > 10 THEN 'high'
        WHEN COALESCE(well_counts.well_count, 0) + COALESCE(pond_counts.pond_count, 0) + COALESCE(borehole_counts.borehole_count, 0) > 5 THEN 'medium'
        ELSE 'low'
    END as infrastructure_density
FROM water_management_zones wmz
LEFT JOIN (
    SELECT zone_id, 
           COUNT(*) as well_count,
           COUNT(CASE WHEN status = 'active' THEN 1 END) as active_wells
    FROM wells 
    WHERE zone_id IS NOT NULL
    GROUP BY zone_id
) well_counts ON wmz.zone_id = well_counts.zone_id
LEFT JOIN (
    SELECT zone_id, 
           COUNT(*) as pond_count,
           COUNT(CASE WHEN is_perennial THEN 1 END) as perennial_ponds
    FROM ponds 
    WHERE zone_id IS NOT NULL
    GROUP BY zone_id
) pond_counts ON wmz.zone_id = pond_counts.zone_id
LEFT JOIN (
    SELECT zone_id, COUNT(*) as borehole_count
    FROM boreholes 
    WHERE zone_id IS NOT NULL
    GROUP BY zone_id
) borehole_counts ON wmz.zone_id = borehole_counts.zone_id;

-- ============================================
-- STEP 10: Grant permissions
-- ============================================

-- Grant permissions on new tables and views
GRANT SELECT ON wells TO geouser;
GRANT SELECT ON ponds TO geouser;
GRANT SELECT ON boreholes TO geouser;
GRANT SELECT ON complete_wells TO geouser;
GRANT SELECT ON complete_ponds TO geouser;
GRANT SELECT ON complete_boreholes TO geouser;
-- GRANT SELECT ON nested_wells_detailed TO geouser;
-- GRANT SELECT ON nested_ponds_detailed TO geouser;
-- GRANT SELECT ON nested_boreholes_detailed TO geouser;
GRANT SELECT ON v_water_infrastructure_comprehensive TO geouser;
GRANT SELECT ON v_water_management_zones_detailed TO geouser;

COMMIT;

-- Verification queries
SELECT 'Wells table renamed successfully' as status, COUNT(*) as record_count FROM wells;
SELECT 'Ponds table renamed successfully' as status, COUNT(*) as record_count FROM ponds;
SELECT 'Boreholes table renamed successfully' as status, COUNT(*) as record_count FROM boreholes;
-- SELECT 'Nested wells view created' as status, COUNT(*) as record_count FROM nested_wells_detailed;
-- SELECT 'Nested ponds view created' as status, COUNT(*) as record_count FROM nested_ponds_detailed;
-- SELECT 'Nested boreholes view created' as status, COUNT(*) as record_count FROM nested_boreholes_detailed;