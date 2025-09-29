-- Sample Data for Complex Water Resources Management Model
-- This script populates the database with realistic test data

-- 1. Insert Water Management Zones (Top-level containers)
INSERT INTO water_management_zones (zone_id, name, area_sq_km, administrative_region, geom) VALUES
('WMZ_Bengaluru_North', 'Vrishabhavathi Watershed', 45.2, 'Bengaluru Urban', 
    ST_GeomFromText('POLYGON((77.5 13.0, 77.6 13.0, 77.6 13.1, 77.5 13.1, 77.5 13.0))', 4326)),
('WMZ_Mysore_East', 'Kaveri Sub-basin Zone', 62.8, 'Mysore District', 
    ST_GeomFromText('POLYGON((76.6 12.25, 76.75 12.25, 76.75 12.4, 76.6 12.4, 76.6 12.25))', 4326)),
('WMZ_Hassan_Rural', 'Hemavathi Catchment', 38.5, 'Hassan District', 
    ST_GeomFromText('POLYGON((76.0 13.0, 76.15 13.0, 76.15 13.15, 76.0 13.15, 76.0 13.0))', 4326)),
('WMZ_Chad_Ndjamena', 'Chari River Basin', 125.4, 'N\'Djamena Region', 
    ST_GeomFromText('POLYGON((15.0 12.0, 15.3 12.0, 15.3 12.3, 15.0 12.3, 15.0 12.0))', 4326)),
('WMZ_Chad_Sahel', 'Northern Sahel Aquifer Zone', 89.7, 'Borkou Region', 
    ST_GeomFromText('POLYGON((18.0 17.0, 18.5 17.0, 18.5 17.5, 18.0 17.5, 18.0 17.0))', 4326));

-- 2. Insert Ponds (Nested features with polygon geometry)
INSERT INTO ponds (pond_id, zone_id, name, surface_area, current_water_level, is_perennial, geom) VALUES
('POND_VW_001', 'WMZ_Bengaluru_North', 'Lalbagh Lake', 25000.0, 2.8, true, 
    ST_GeomFromText('POLYGON((77.52 13.02, 77.525 13.02, 77.525 13.025, 77.52 13.025, 77.52 13.02))', 4326)),
('POND_VW_002', 'WMZ_Bengaluru_North', 'Cubbon Park Pond', 8500.0, 1.5, true, 
    ST_GeomFromText('POLYGON((77.54 13.04, 77.543 13.04, 77.543 13.043, 77.54 13.043, 77.54 13.04))', 4326)),
('POND_KSB_001', 'WMZ_Mysore_East', 'Karanji Lake', 45000.0, 3.2, true, 
    ST_GeomFromText('POLYGON((76.65 12.3, 76.66 12.3, 76.66 12.31, 76.65 12.31, 76.65 12.3))', 4326)),
('POND_HC_001', 'WMZ_Hassan_Rural', 'Village Tank Hasanamba', 12000.0, 1.8, false, 
    ST_GeomFromText('POLYGON((76.05 13.05, 76.055 13.05, 76.055 13.055, 76.05 13.055, 76.05 13.05))', 4326)),
('POND_CRB_001', 'WMZ_Chad_Ndjamena', 'Lac Fitri Seasonal', 180000.0, 2.1, false, 
    ST_GeomFromText('POLYGON((15.1 12.1, 15.2 12.1, 15.2 12.2, 15.1 12.2, 15.1 12.1))', 4326)),
('POND_NSA_001', 'WMZ_Chad_Sahel', 'Oasis Pool Bardai', 3500.0, 0.8, true, 
    ST_GeomFromText('POLYGON((18.2 17.2, 18.205 17.2, 18.205 17.205, 18.2 17.205, 18.2 17.2))', 4326));

-- 3. Insert Wells (Nested features with point geometry)
INSERT INTO wells (well_id, zone_id, owner, depth_m, static_water_level, geom) VALUES
('WELL_VW_001', 'WMZ_Bengaluru_North', 'Bangalore Water Supply Board', 45.0, 12.5, 
    ST_GeomFromText('POINT(77.53 13.03)', 4326)),
('WELL_VW_002', 'WMZ_Bengaluru_North', 'Private Residential Complex', 35.0, 8.2, 
    ST_GeomFromText('POINT(77.55 13.05)', 4326)),
('WELL_VW_003', 'WMZ_Bengaluru_North', 'Agricultural Cooperative', 25.0, 15.8, 
    ST_GeomFromText('POINT(77.52 13.08)', 4326)),
('WELL_KSB_001', 'WMZ_Mysore_East', 'Mysore City Corporation', 55.0, 18.3, 
    ST_GeomFromText('POINT(76.67 12.32)', 4326)),
('WELL_KSB_002', 'WMZ_Mysore_East', 'Farmer Cooperative Mandya', 28.0, 22.1, 
    ST_GeomFromText('POINT(76.68 12.35)', 4326)),
('WELL_HC_001', 'WMZ_Hassan_Rural', 'Village Panchayat Hassan', 32.0, 19.5, 
    ST_GeomFromText('POINT(76.08 13.08)', 4326)),
('WELL_CRB_001', 'WMZ_Chad_Ndjamena', 'Community Well Association', 42.0, 25.8, 
    ST_GeomFromText('POINT(15.15 12.15)', 4326)),
('WELL_CRB_002', 'WMZ_Chad_Ndjamena', 'Municipal Water Authority', 38.0, 28.2, 
    ST_GeomFromText('POINT(15.18 12.18)', 4326)),
('WELL_NSA_001', 'WMZ_Chad_Sahel', 'Desert Community Collective', 65.0, 45.3, 
    ST_GeomFromText('POINT(18.25 17.25)', 4326)),
('WELL_NSA_002', 'WMZ_Chad_Sahel', 'Nomadic Herders Association', 72.0, 52.1, 
    ST_GeomFromText('POINT(18.3 17.3)', 4326));

-- 4. Insert Boreholes (Nested features with point geometry)
INSERT INTO boreholes (borehole_id, zone_id, drilling_company, total_depth_m, casing_diameter_mm, geom) VALUES
('BH_VW_001', 'WMZ_Bengaluru_North', 'Karnataka Drilling Services Pvt Ltd', 85.0, 150.0, 
    ST_GeomFromText('POINT(77.54 13.01)', 4326)),
('BH_VW_002', 'WMZ_Bengaluru_North', 'Aqua Tech Drilling Solutions', 95.0, 200.0, 
    ST_GeomFromText('POINT(77.56 13.06)', 4326)),
('BH_KSB_001', 'WMZ_Mysore_East', 'South India Borewell Company', 120.0, 175.0, 
    ST_GeomFromText('POINT(76.69 12.33)', 4326)),
('BH_HC_001', 'WMZ_Hassan_Rural', 'Rural Water Development Corp', 78.0, 125.0, 
    ST_GeomFromText('POINT(76.09 13.09)', 4326)),
('BH_CRB_001', 'WMZ_Chad_Ndjamena', 'Sahara Water Drilling Ltd', 145.0, 250.0, 
    ST_GeomFromText('POINT(15.2 12.2)', 4326)),
('BH_NSA_001', 'WMZ_Chad_Sahel', 'Desert Aquifer Specialists', 185.0, 300.0, 
    ST_GeomFromText('POINT(18.35 17.35)', 4326));

-- 5. Insert Construction Data (Nested details for wells)
INSERT INTO construction_data (well_id, construction_date, construction_method, lining_material, pump_type, installation_cost, contractor_name, construction_notes) VALUES
('WELL_VW_001', '2022-03-15', 'machine_drilled', 'concrete_rings', 'electric_pump', 125000.00, 'Bangalore Water Infrastructure Ltd', 'Standard municipal well with automated pumping system'),
('WELL_VW_002', '2021-11-20', 'machine_drilled', 'steel_casing', 'solar_pump', 95000.00, 'Green Energy Wells Pvt Ltd', 'Solar-powered system for residential complex'),
('WELL_VW_003', '2020-08-10', 'hand_dug', 'brick', 'hand_pump', 45000.00, 'Rural Development Cooperative', 'Traditional hand-dug well with brick lining'),
('WELL_KSB_001', '2023-01-12', 'machine_drilled', 'concrete_rings', 'electric_pump', 180000.00, 'Mysore Municipal Works', 'High-capacity municipal supply well'),
('WELL_KSB_002', '2022-07-05', 'bore_well', 'steel_casing', 'solar_pump', 85000.00, 'Agricultural Development Agency', 'Farmer cooperative irrigation well'),
('WELL_HC_001', '2021-09-18', 'hand_dug', 'concrete_rings', 'hand_pump', 55000.00, 'Village Development Committee', 'Community well for village water supply'),
('WELL_CRB_001', '2023-02-28', 'machine_drilled', 'steel_casing', 'electric_pump', 165000.00, 'Chad Water Development Corp', 'Deep community well with electric pumping'),
('WELL_CRB_002', '2022-12-14', 'machine_drilled', 'concrete_rings', 'solar_pump', 142000.00, 'Renewable Energy Water Solutions', 'Municipal well with solar backup'),
('WELL_NSA_001', '2023-04-20', 'machine_drilled', 'steel_casing', 'solar_pump', 225000.00, 'Sahara Deep Drilling Inc', 'Deep desert well with reinforced casing'),
('WELL_NSA_002', '2022-10-08', 'machine_drilled', 'steel_casing', 'hand_pump', 185000.00, 'Desert Water Access Project', 'Manual pump for nomadic community access');

-- 6. Insert Water Quality Reports (Complex nested data for multiple feature types)
INSERT INTO water_quality_reports (feature_type, feature_id, test_date, ph_level, tds_ppm, hardness_ppm, nitrate_ppm, fluoride_ppm, iron_ppm, bacterial_contamination, potability_rating, tested_by, lab_certification, report_notes) VALUES
-- Well water quality reports
('well', 'WELL_VW_001', '2024-09-15', 7.2, 450, 180, 12, 0.8, 0.1, false, 'good', 'Karnataka State Pollution Control Board', 'NABL-2024-001', 'Within acceptable limits for municipal supply'),
('well', 'WELL_VW_001', '2024-06-15', 7.4, 420, 175, 10, 0.7, 0.1, false, 'good', 'Karnataka State Pollution Control Board', 'NABL-2024-002', 'Consistent quality over time'),
('well', 'WELL_VW_002', '2024-09-10', 6.8, 680, 220, 18, 1.2, 0.3, false, 'fair', 'Private Testing Lab Bangalore', 'ISO-2024-045', 'Slightly elevated TDS and hardness'),
('well', 'WELL_KSB_001', '2024-08-25', 7.6, 320, 145, 8, 0.5, 0.05, false, 'excellent', 'Mysore Water Quality Lab', 'NABL-2024-003', 'Excellent quality for municipal distribution'),
('well', 'WELL_CRB_001', '2024-09-01', 7.1, 580, 195, 15, 0.9, 0.2, false, 'good', 'Chad National Water Laboratory', 'CHAD-LAB-2024-012', 'Good quality, regular monitoring recommended'),
('well', 'WELL_NSA_001', '2024-08-18', 7.8, 850, 310, 22, 1.8, 0.4, false, 'fair', 'Sahara Research Institute', 'SRI-2024-008', 'High mineralization typical of deep aquifers'),

-- Pond water quality reports
('pond', 'POND_VW_001', '2024-09-12', 8.1, 320, 125, 5, 0.3, 0.8, true, 'poor', 'Environmental Monitoring Agency', 'EMA-2024-089', 'Bacterial contamination detected, treatment required'),
('pond', 'POND_KSB_001', '2024-08-30', 7.9, 280, 110, 4, 0.2, 1.2, false, 'fair', 'Lake Conservation Trust', 'LCT-2024-156', 'Elevated iron content, suitable for irrigation'),
('pond', 'POND_CRB_001', '2024-09-05', 7.5, 420, 160, 8, 0.6, 0.9, false, 'fair', 'Chad Environmental Agency', 'CEA-2024-034', 'Seasonal variations in quality observed'),

-- Borehole water quality reports
('borehole', 'BH_VW_001', '2024-09-20', 7.3, 385, 155, 9, 0.6, 0.08, false, 'good', 'Groundwater Research Institute', 'GRI-2024-234', 'Deep aquifer water with good mineral balance'),
('borehole', 'BH_CRB_001', '2024-09-08', 7.0, 495, 185, 12, 1.1, 0.15, false, 'good', 'Chad Hydrogeological Survey', 'CHS-2024-067', 'Confined aquifer with stable quality'),
('borehole', 'BH_NSA_001', '2024-08-28', 7.7, 720, 285, 19, 2.1, 0.25, false, 'fair', 'Desert Hydrology Lab', 'DHL-2024-045', 'High fluoride content, treatment may be needed');

-- 7. Insert Maintenance Activities (Nested data for ponds)
INSERT INTO maintenance_activities (pond_id, activity_type, scheduled_date, completed_date, activity_status, cost_estimate, actual_cost, contractor_name, activity_description, completion_notes) VALUES
('POND_VW_001', 'desilting', '2024-10-15', NULL, 'planned', 125000.00, NULL, 'Lake Restoration Services Ltd', 'Complete desilting to restore water holding capacity', NULL),
('POND_VW_001', 'water_treatment', '2024-09-01', '2024-09-05', 'completed', 35000.00, 38500.00, 'AquaClean Environmental Solutions', 'Bacterial contamination treatment using UV disinfection', 'Treatment successful, water quality improved significantly'),
('POND_VW_002', 'embankment_repair', '2024-08-10', '2024-08-18', 'completed', 45000.00, 42000.00, 'Park Maintenance Division', 'Repair of eastern embankment erosion damage', 'Repairs completed ahead of monsoon season'),
('POND_KSB_001', 'vegetation_control', '2024-07-20', '2024-07-25', 'completed', 15000.00, 16200.00, 'Aquatic Weed Management Co', 'Removal of invasive water hyacinth', 'Successful removal, follow-up treatment scheduled'),
('POND_HC_001', 'desilting', '2024-11-01', NULL, 'planned', 28000.00, NULL, 'Rural Infrastructure Development', 'Pre-monsoon desilting for increased storage', NULL),
('POND_CRB_001', 'embankment_repair', '2024-12-01', NULL, 'planned', 85000.00, NULL, 'Chad Infrastructure Corp', 'Reinforcement of embankments before flood season', NULL);

-- 8. Insert Stratigraphic Layers (Highly complex nested data for boreholes)
-- Borehole BH_VW_001 geological profile
INSERT INTO stratigraphic_layers (borehole_id, layer_sequence, depth_from_m, depth_to_m, lithology, color, grain_size, water_bearing, permeability_rating, sample_recovery_percentage, geological_age, formation_name, layer_notes) VALUES
('BH_VW_001', 1, 0.0, 3.5, 'clay', 'reddish_brown', 'fine', false, 'very_low', 95.0, 'Quaternary', 'Recent Alluvium', 'Surface lateritic clay with iron concretions'),
('BH_VW_001', 2, 3.5, 12.0, 'sand', 'yellow_brown', 'medium', true, 'high', 88.0, 'Quaternary', 'Alluvial Deposits', 'Clean quartz sand with good water yield'),
('BH_VW_001', 3, 12.0, 25.0, 'clay', 'grey', 'fine', false, 'low', 92.0, 'Quaternary', 'Older Alluvium', 'Plastic clay acting as aquitard'),
('BH_VW_001', 4, 25.0, 45.0, 'sand', 'white_grey', 'coarse', true, 'very_high', 85.0, 'Quaternary', 'Buried Channel Deposits', 'Coarse sand and gravel, main aquifer'),
('BH_VW_001', 5, 45.0, 65.0, 'clay', 'dark_grey', 'fine', false, 'very_low', 90.0, 'Tertiary', 'Peninsular Gneiss Weathering', 'Weathered gneiss clay'),
('BH_VW_001', 6, 65.0, 85.0, 'rock', 'grey_pink', 'crystalline', true, 'medium', 75.0, 'Archaean', 'Peninsular Gneiss', 'Fractured gneiss bedrock');

-- Borehole BH_CRB_001 geological profile
INSERT INTO stratigraphic_layers (borehole_id, layer_sequence, depth_from_m, depth_to_m, lithology, color, grain_size, water_bearing, permeability_rating, sample_recovery_percentage, geological_age, formation_name, layer_notes) VALUES
('BH_CRB_001', 1, 0.0, 8.0, 'sand', 'light_brown', 'fine', false, 'medium', 90.0, 'Quaternary', 'Aeolian Deposits', 'Wind-blown sand with low water content'),
('BH_CRB_001', 2, 8.0, 25.0, 'clay', 'dark_brown', 'fine', false, 'very_low', 95.0, 'Quaternary', 'Lacustrine Deposits', 'Lake-deposited clay with organic matter'),
('BH_CRB_001', 3, 25.0, 58.0, 'sandstone', 'light_grey', 'medium', true, 'high', 82.0, 'Cretaceous', 'Continental Terminal', 'Porous sandstone, primary aquifer'),
('BH_CRB_001', 4, 58.0, 95.0, 'clay', 'red_brown', 'fine', false, 'low', 88.0, 'Cretaceous', 'Continental Terminal', 'Claystone with iron oxide staining'),
('BH_CRB_001', 5, 95.0, 130.0, 'limestone', 'white_grey', 'fine', true, 'very_high', 70.0, 'Cretaceous', 'Limestone Formation', 'Karstified limestone with cavities'),
('BH_CRB_001', 6, 130.0, 145.0, 'sandstone', 'grey', 'coarse', true, 'high', 78.0, 'Jurassic', 'Basement Complex', 'Fractured quartzite bedrock');

-- Borehole BH_NSA_001 geological profile (Deep Sahara aquifer)
INSERT INTO stratigraphic_layers (borehole_id, layer_sequence, depth_from_m, depth_to_m, lithology, color, grain_size, water_bearing, permeability_rating, sample_recovery_percentage, geological_age, formation_name, layer_notes) VALUES
('BH_NSA_001', 1, 0.0, 15.0, 'sand', 'yellow', 'fine', false, 'medium', 85.0, 'Quaternary', 'Desert Sand', 'Mobile dune sand with minimal water'),
('BH_NSA_001', 2, 15.0, 45.0, 'sandstone', 'red_brown', 'medium', false, 'low', 88.0, 'Tertiary', 'Continental Deposits', 'Cemented sandstone, mostly dry'),
('BH_NSA_001', 3, 45.0, 85.0, 'clay', 'grey_green', 'fine', false, 'very_low', 92.0, 'Cretaceous', 'Marine Shale', 'Impermeable shale barrier'),
('BH_NSA_001', 4, 85.0, 125.0, 'sandstone', 'white', 'coarse', true, 'very_high', 80.0, 'Cretaceous', 'Nubian Sandstone', 'Primary fossil water aquifer'),
('BH_NSA_001', 5, 125.0, 165.0, 'sandstone', 'light_grey', 'medium', true, 'high', 75.0, 'Cretaceous', 'Nubian Sandstone', 'Lower productive zone'),
('BH_NSA_001', 6, 165.0, 185.0, 'rock', 'black', 'crystalline', false, 'very_low', 65.0, 'Precambrian', 'Basement Complex', 'Impermeable crystalline basement');

-- Additional boreholes with simplified profiles
INSERT INTO stratigraphic_layers (borehole_id, layer_sequence, depth_from_m, depth_to_m, lithology, color, grain_size, water_bearing, permeability_rating, sample_recovery_percentage, geological_age, formation_name, layer_notes) VALUES
('BH_VW_002', 1, 0.0, 5.0, 'clay', 'red', 'fine', false, 'low', 90.0, 'Quaternary', 'Laterite', 'Lateritic clay cap'),
('BH_VW_002', 2, 5.0, 35.0, 'sand', 'yellow', 'medium', true, 'high', 85.0, 'Quaternary', 'Alluvium', 'Main water-bearing sand'),
('BH_VW_002', 3, 35.0, 95.0, 'rock', 'grey', 'crystalline', true, 'medium', 70.0, 'Archaean', 'Gneiss', 'Fractured basement rock'),

('BH_KSB_001', 1, 0.0, 8.0, 'clay', 'brown', 'fine', false, 'low', 92.0, 'Quaternary', 'Surface Clay', 'Recent clay deposits'),
('BH_KSB_001', 2, 8.0, 45.0, 'sand', 'grey', 'coarse', true, 'very_high', 88.0, 'Quaternary', 'River Terrace', 'High-yield aquifer sand'),
('BH_KSB_001', 3, 45.0, 120.0, 'rock', 'pink', 'crystalline', true, 'medium', 75.0, 'Archaean', 'Granitic Gneiss', 'Weathered and fractured bedrock'),

('BH_HC_001', 1, 0.0, 12.0, 'clay', 'red_brown', 'fine', false, 'low', 95.0, 'Quaternary', 'Laterite', 'Thick lateritic profile'),
('BH_HC_001', 2, 12.0, 48.0, 'sand', 'white', 'medium', true, 'high', 85.0, 'Quaternary', 'Weathered Zone', 'Saprolite with good permeability'),
('BH_HC_001', 3, 48.0, 78.0, 'rock', 'green_grey', 'crystalline', true, 'low', 70.0, 'Archaean', 'Schist', 'Metamorphic bedrock with limited fractures');

-- Create some additional historical water quality data for trend analysis
INSERT INTO water_quality_reports (feature_type, feature_id, test_date, ph_level, tds_ppm, hardness_ppm, nitrate_ppm, fluoride_ppm, iron_ppm, bacterial_contamination, potability_rating, tested_by, lab_certification, report_notes) VALUES
('well', 'WELL_VW_001', '2024-03-15', 7.1, 465, 185, 14, 0.9, 0.12, false, 'good', 'Karnataka State Pollution Control Board', 'NABL-2024-003', 'Quarterly monitoring - slight increase in TDS'),
('well', 'WELL_VW_001', '2023-12-15', 7.3, 440, 178, 11, 0.8, 0.09, false, 'good', 'Karnataka State Pollution Control Board', 'NABL-2023-234', 'Annual comprehensive testing'),
('well', 'WELL_VW_001', '2023-09-15', 7.2, 430, 172, 10, 0.7, 0.08, false, 'good', 'Karnataka State Pollution Control Board', 'NABL-2023-189', 'Post-monsoon quality assessment'),

('borehole', 'BH_NSA_001', '2024-06-28', 7.8, 695, 275, 17, 2.0, 0.22, false, 'fair', 'Desert Hydrology Lab', 'DHL-2024-023', 'Mid-year monitoring of deep aquifer'),
('borehole', 'BH_NSA_001', '2024-03-28', 7.9, 710, 290, 18, 2.2, 0.28, false, 'fair', 'Desert Hydrology Lab', 'DHL-2024-008', 'Consistent high mineralization in fossil aquifer'),

('pond', 'POND_VW_001', '2024-06-12', 8.3, 340, 135, 6, 0.4, 0.9, true, 'poor', 'Environmental Monitoring Agency', 'EMA-2024-045', 'Pre-treatment bacterial contamination'),
('pond', 'POND_VW_001', '2024-03-12', 7.8, 310, 120, 4, 0.3, 1.1, true, 'poor', 'Environmental Monitoring Agency', 'EMA-2024-012', 'Persistent bacterial issues require intervention');