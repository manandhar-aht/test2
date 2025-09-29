-- Sample Data for Complex Nested Water Resources Model
-- This populates the database with realistic nested hierarchical data

-- Insert Water Management Zones (Top-level containers)
INSERT INTO water_management_zones (
    zone_id, name, area_sq_km, administrative_region, established_date, 
    management_authority, population_served, annual_rainfall_mm, geom
) VALUES 
(
    'WMZ_BENGALURU_NORTH', 'Vrishabhavathi Watershed North', 45.7, 'Bengaluru Urban District',
    '2018-04-15', 'Karnataka Water Resources Department', 125000, 850.5,
    ST_GeomFromText('POLYGON((77.580 13.020, 77.620 13.020, 77.620 13.060, 77.580 13.060, 77.580 13.020))', 4326)
),
(
    'WMZ_MYSORE_EAST', 'Kaveri Sub-Basin East Mysore', 78.3, 'Mysore District',
    '2019-08-10', 'Mysore District Water Authority', 89000, 1200.8,
    ST_GeomFromText('POLYGON((76.650 12.280, 76.720 12.280, 76.720 12.340, 76.650 12.340, 76.650 12.280))', 4326)
),
(
    'WMZ_CHAD_NDJAMENA', 'N''Djamena Urban Water Zone', 156.2, 'N''Djamena Prefecture',
    '2020-03-22', 'Chad Ministry of Water Resources', 245000, 450.2,
    ST_GeomFromText('POLYGON((15.020 12.080, 15.080 12.080, 15.080 12.140, 15.020 12.140, 15.020 12.080))', 4326)
),
(
    'WMZ_SAHEL_AGADEZ', 'Agadez Regional Water Management', 89.4, 'Agadez Region',
    '2021-01-18', 'Niger Water Resources Ministry', 67000, 120.5,
    ST_GeomFromText('POLYGON((7.980 17.880, 8.040 17.880, 8.040 17.940, 7.980 17.940, 7.980 17.880))', 4326)
);

-- Insert Nested Ponds within Water Management Zones
INSERT INTO nested_ponds (
    pond_id, zone_id, name, surface_area_sqm, current_water_level_m, maximum_depth_m,
    is_perennial, construction_year, primary_use, capacity_liters, geom
) VALUES
(
    'POND_LALBAGH', 'WMZ_BENGALURU_NORTH', 'Lalbagh Lake', 15000.5, 2.8, 4.2,
    true, 1760, 'recreation', 63000000,
    ST_GeomFromText('POLYGON((77.584 13.024, 77.588 13.024, 77.588 13.028, 77.584 13.028, 77.584 13.024))', 4326)
),
(
    'POND_VRISH_01', 'WMZ_BENGALURU_NORTH', 'Vrishabhavathi Community Pond', 8500.2, 1.9, 3.1,
    false, 1995, 'irrigation', 26350000,
    ST_GeomFromText('POLYGON((77.590 13.035, 77.594 13.035, 77.594 13.039, 77.590 13.039, 77.590 13.035))', 4326)
),
(
    'POND_MYSORE_CENTRAL', 'WMZ_MYSORE_EAST', 'Central Mysore Tank', 12800.7, 3.4, 5.6,
    true, 1650, 'drinking', 71680000,
    ST_GeomFromText('POLYGON((76.670 12.300, 76.675 12.300, 76.675 12.305, 76.670 12.305, 76.670 12.300))', 4326)
),
(
    'POND_NDJAMENA_01', 'WMZ_CHAD_NDJAMENA', 'N''Djamena Municipal Reservoir', 22000.0, 4.1, 7.2,
    true, 1982, 'drinking', 158400000,
    ST_GeomFromText('POLYGON((15.040 12.100, 15.048 12.100, 15.048 12.108, 15.040 12.108, 15.040 12.100))', 4326)
),
(
    'POND_AGADEZ_SEASONAL', 'WMZ_SAHEL_AGADEZ', 'Agadez Seasonal Collection Basin', 5600.3, 0.8, 2.1,
    false, 2010, 'irrigation', 11760000,
    ST_GeomFromText('POLYGON((8.000 17.900, 8.005 17.900, 8.005 17.905, 8.000 17.905, 8.000 17.900))', 4326)
);

-- Insert Nested Wells within Water Management Zones
INSERT INTO nested_wells (
    well_id, zone_id, owner, well_type, depth_m, static_water_level_m, 
    dynamic_water_level_m, yield_liters_per_hour, drilling_date, status, geom
) VALUES
(
    'WELL_BNG_001', 'WMZ_BENGALURU_NORTH', 'Rajesh Kumar', 'tube_well', 85.4, 12.6, 
    15.8, 2500.0, '2019-03-15', 'active',
    ST_GeomFromText('POINT(77.592 13.042)', 4326)
),
(
    'WELL_BNG_002', 'WMZ_BENGALURU_NORTH', 'Community Trust', 'open_well', 25.2, 8.9, 
    11.2, 800.0, '2020-07-22', 'active',
    ST_GeomFromText('POINT(77.598 13.028)', 4326)
),
(
    'WELL_BNG_003', 'WMZ_BENGALURU_NORTH', 'Priya Sharma', 'tube_well', 45.7, 18.3, 
    22.1, 1200.0, '2021-11-08', 'under_maintenance',
    ST_GeomFromText('POINT(77.586 13.055)', 4326)
),
(
    'WELL_MYS_001', 'WMZ_MYSORE_EAST', 'Kaveri Farmers Cooperative', 'artesian', 35.8, 5.2, 
    6.8, 3200.0, '2018-05-14', 'active',
    ST_GeomFromText('POINT(76.685 12.315)', 4326)
),
(
    'WELL_MYS_002', 'WMZ_MYSORE_EAST', 'Gowda Family', 'open_well', 18.5, 12.4, 
    14.7, 600.0, '2019-09-30', 'active',
    ST_GeomFromText('POINT(76.695 12.295)', 4326)
),
(
    'WELL_CHAD_001', 'WMZ_CHAD_NDJAMENA', 'N''Djamena Municipality', 'tube_well', 65.3, 22.7, 
    28.4, 4500.0, '2020-02-18', 'active',
    ST_GeomFromText('POINT(15.055 12.125)', 4326)
),
(
    'WELL_AGADEZ_001', 'WMZ_SAHEL_AGADEZ', 'Agadez Village Council', 'tube_well', 125.8, 45.6, 
    52.3, 1800.0, '2021-06-12', 'active',
    ST_GeomFromText('POINT(8.015 17.915)', 4326)
);

-- Insert Nested Boreholes within Water Management Zones
INSERT INTO nested_boreholes (
    borehole_id, zone_id, drilling_company, total_depth_m, casing_diameter_mm,
    screen_depth_from_m, screen_depth_to_m, pump_type, pump_capacity_lph,
    drilling_cost, completion_date, license_number, geom
) VALUES
(
    'BH_BNG_001', 'WMZ_BENGALURU_NORTH', 'Karnataka Drilling Solutions Pvt Ltd', 145.6, 152.4,
    85.0, 140.0, 'submersible', 5000.0, 185000.50, '2021-04-20', 'KA-WR-2021-0847',
    ST_GeomFromText('POINT(77.605 13.045)', 4326)
),
(
    'BH_BNG_002', 'WMZ_BENGALURU_NORTH', 'Aqua Bore Technologies', 98.3, 127.0,
    45.0, 92.0, 'submersible', 3500.0, 142000.75, '2021-08-15', 'KA-WR-2021-1203',
    ST_GeomFromText('POINT(77.595 13.032)', 4326)
),
(
    'BH_MYS_001', 'WMZ_MYSORE_EAST', 'Mysore Deep Well Contractors', 76.8, 203.2,
    35.0, 72.0, 'hand_pump', 1200.0, 95000.00, '2020-12-10', 'KA-MYS-2020-0654',
    ST_GeomFromText('POINT(76.678 12.308)', 4326)
),
(
    'BH_CHAD_001', 'WMZ_CHAD_NDJAMENA', 'Chad Water Infrastructure Corp', 185.4, 254.0,
    125.0, 180.0, 'solar_pump', 8000.0, 425000.00, '2021-11-30', 'TD-WR-2021-0089',
    ST_GeomFromText('POINT(15.062 12.118)', 4326)
),
(
    'BH_AGADEZ_001', 'WMZ_SAHEL_AGADEZ', 'Sahel Drilling Consortium', 245.7, 177.8,
    180.0, 240.0, 'solar_pump', 6500.0, 380000.00, '2022-01-25', 'NE-AG-2022-0012',
    ST_GeomFromText('POINT(8.025 17.925)', 4326)
);

-- Insert Construction Details for Wells
INSERT INTO construction_details (
    well_id, contractor_name, construction_method, casing_material, casing_diameter_mm,
    pump_installation_depth_m, construction_cost, quality_certificate_number,
    construction_start_date, construction_end_date, warranty_period_months, additional_notes
) VALUES
(
    'WELL_BNG_001', 'Karnataka Well Construction Ltd', 'rotary_drilling', 'PVC', 110.0,
    80.0, 125000.00, 'QC-KA-2019-0234', '2019-03-01', '2019-03-15', 24,
    'High-yield well with excellent water quality. Requires monthly maintenance.'
),
(
    'WELL_BNG_002', 'Community Development Trust', 'manual_excavation', 'concrete_rings', 1200.0,
    22.0, 45000.00, 'QC-COM-2020-0567', '2020-07-10', '2020-07-22', 12,
    'Community-built open well with traditional construction methods.'
),
(
    'WELL_MYS_001', 'Kaveri Well Specialists', 'artesian_development', 'steel', 150.0,
    30.0, 85000.00, 'QC-MYS-2018-0891', '2018-05-01', '2018-05-14', 36,
    'Natural artesian flow requires minimal pumping. Excellent water quality.'
),
(
    'WELL_CHAD_001', 'Chad Municipal Engineering', 'rotary_drilling', 'steel', 200.0,
    60.0, 285000.00, 'QC-TD-2020-0156', '2020-02-01', '2020-02-18', 24,
    'Municipal supply well with high capacity. Regular monitoring required.'
);

-- Insert Water Quality Reports
INSERT INTO water_quality_reports (
    report_id, feature_type, feature_id, test_date, ph_level, tds_ppm, hardness_ppm,
    chloride_ppm, fluoride_ppm, nitrate_ppm, iron_ppm, bacterial_contamination,
    overall_quality, testing_laboratory, lab_certificate_number, recommended_treatment, next_test_due_date
) VALUES
-- Well water quality reports
(
    'WQR_WELL_BNG_001_2023_Q1', 'well', 'WELL_BNG_001', '2023-03-15', 7.2, 245.8, 180.5,
    35.2, 0.4, 12.8, 0.15, false, 'good', 'Karnataka State Water Testing Lab',
    'KSWL-2023-0892', 'Minor iron filtration recommended', '2023-09-15'
),
(
    'WQR_WELL_BNG_002_2023_Q2', 'well', 'WELL_BNG_002', '2023-06-10', 6.8, 420.3, 285.7,
    68.9, 0.8, 25.4, 0.35, true, 'acceptable', 'Bengaluru Municipal Lab',
    'BML-2023-1547', 'Bacterial treatment and regular chlorination required', '2023-12-10'
),
(
    'WQR_WELL_CHAD_001_2023_Q1', 'well', 'WELL_CHAD_001', '2023-02-28', 7.8, 180.2, 95.4,
    28.7, 0.2, 8.9, 0.08, false, 'excellent', 'Chad National Water Laboratory',
    'CNWL-2023-0234', 'No treatment required', '2023-08-28'
),
-- Pond water quality reports
(
    'WQR_POND_LALBAGH_2023_Q2', 'pond', 'POND_LALBAGH', '2023-06-20', 8.1, 320.5, 145.8,
    45.6, 0.3, 18.7, 0.22, false, 'good', 'Karnataka Environmental Lab',
    'KEL-2023-0789', 'Suitable for recreation, regular algae monitoring', '2023-12-20'
),
(
    'WQR_POND_NDJAMENA_01_2023_Q1', 'pond', 'POND_NDJAMENA_01', '2023-03-08', 7.5, 198.7, 125.3,
    32.1, 0.5, 15.2, 0.18, false, 'good', 'Chad Municipal Water Lab',
    'CMWL-2023-0445', 'Standard municipal treatment applied', '2023-09-08'
),
-- Borehole water quality reports
(
    'WQR_BH_BNG_001_2023_Q2', 'borehole', 'BH_BNG_001', '2023-05-25', 7.4, 165.9, 98.7,
    22.4, 0.1, 6.8, 0.05, false, 'excellent', 'Bengaluru Groundwater Institute',
    'BGI-2023-0567', 'No treatment required - excellent quality', '2023-11-25'
),
(
    'WQR_BH_CHAD_001_2023_Q1', 'borehole', 'BH_CHAD_001', '2023-04-12', 7.9, 142.3, 78.5,
    19.8, 0.3, 4.5, 0.03, false, 'excellent', 'Chad Geological Survey Lab',
    'CGSL-2023-0189', 'Premium quality groundwater', '2023-10-12'
);

-- Insert Maintenance Activities
INSERT INTO maintenance_activities (
    activity_id, feature_type, feature_id, activity_type, scheduled_date, completed_date,
    maintenance_team, activity_description, cost, materials_used, activity_status,
    next_maintenance_date, emergency_repair, effectiveness_rating
) VALUES
(
    'MAINT_WELL_BNG_001_2023_03', 'well', 'WELL_BNG_001', 'pump_maintenance', '2023-03-20', '2023-03-22',
    'Karnataka Well Services', 'Complete pump overhaul and performance optimization', 8500.00,
    'New impeller, gaskets, electrical components', 'completed', '2023-09-20', false, 5
),
(
    'MAINT_POND_LALBAGH_2023_04', 'pond', 'POND_LALBAGH', 'cleaning', '2023-04-15', '2023-04-18',
    'Bengaluru Parks Department', 'Comprehensive pond cleaning and algae removal', 15000.00,
    'Bio-remediation agents, mechanical cleaning equipment', 'completed', '2023-10-15', false, 4
),
(
    'MAINT_BH_BNG_001_2023_06', 'borehole', 'BH_BNG_001', 'water_treatment', '2023-06-10', '2023-06-12',
    'Aqua Systems Maintenance', 'Water treatment system calibration and filter replacement', 12500.00,
    'New filtration cartridges, UV lamp replacement', 'completed', '2023-12-10', false, 5
),
(
    'MAINT_WELL_BNG_003_2023_07', 'well', 'WELL_BNG_003', 'repair', '2023-07-05', NULL,
    'Emergency Well Repair Team', 'Emergency repair of damaged pump system', 18500.00,
    'New submersible pump, electrical rewiring', 'in_progress', '2023-08-05', true, NULL
),
(
    'MAINT_POND_AGADEZ_2023_05', 'pond', 'POND_AGADEZ_SEASONAL', 'cleaning', '2023-05-20', '2023-05-23',
    'Agadez Municipal Team', 'Seasonal pond preparation and sediment removal', 5500.00,
    'Manual labor, basic cleaning tools', 'completed', '2024-05-20', false, 3
);

-- Insert Geological Logs for Boreholes
INSERT INTO geological_logs (
    log_id, borehole_id, drilling_date, geologist_name, total_depth_logged_m,
    groundwater_first_encountered_m, final_groundwater_level_m, rock_formation,
    overall_aquifer_potential, log_notes
) VALUES
(
    'GEOLOG_BH_BNG_001', 'BH_BNG_001', '2021-04-18', 'Dr. Ramesh Geological Consultancy', 145.6,
    42.5, 38.2, 'Deccan Trap Basalt with Alluvial Overburden', 'high',
    'Excellent aquifer potential with multiple water-bearing fractured zones. High yield expected.'
),
(
    'GEOLOG_BH_BNG_002', 'BH_BNG_002', '2021-08-12', 'Karnataka Geological Survey', 98.3,
    28.7, 25.4, 'Granitic Gneiss with Laterite Cap', 'medium',
    'Moderate aquifer in weathered granite. Seasonal water level fluctuations expected.'
),
(
    'GEOLOG_BH_MYS_001', 'BH_MYS_001', '2020-12-08', 'Mysore Institute of Geology', 76.8,
    18.5, 16.2, 'Alluvial Deposits over Granitic Basement', 'high',
    'Rich alluvial aquifer with excellent recharge potential from nearby Kaveri River.'
),
(
    'GEOLOG_BH_CHAD_001', 'BH_CHAD_001', '2021-11-28', 'Chad National Geological Institute', 185.4,
    78.3, 72.1, 'Cretaceous Sandstone with Clay Interbeds', 'medium',
    'Deep confined aquifer in Cretaceous formations. Good quality water at depth.'
),
(
    'GEOLOG_BH_AGADEZ_001', 'BH_AGADEZ_001', '2022-01-23', 'Sahel Groundwater Consultants', 245.7,
    125.8, 118.6, 'Jurassic Sandstone Aquifer', 'low',
    'Deep fossil water aquifer. Limited recharge potential in arid conditions.'
);

-- Insert Detailed Stratigraphic Layers (Complex nested data)
INSERT INTO stratigraphic_layers (
    layer_id, geological_log_id, depth_from_m, depth_to_m, layer_thickness_m,
    rock_type, grain_size, color, hardness, water_bearing, permeability,
    porosity_percentage, mineral_composition, fossils_present, weathering_degree,
    fracture_density, layer_description, geotechnical_properties
) VALUES
-- Layers for BH_BNG_001
(
    'LAYER_BNG_001_01', 'GEOLOG_BH_BNG_001', 0.0, 8.5, 8.5,
    'Lateritic Soil', 'clay', 'reddish_brown', 'medium', false, 'low',
    35.2, 'Iron oxides, kaolinite, quartz', false, 'highly_weathered', 'none',
    'Typical lateritic soil horizon with high iron content',
    '{"plasticity_index": 25, "liquid_limit": 45, "bearing_capacity_kpa": 150}'
),
(
    'LAYER_BNG_001_02', 'GEOLOG_BH_BNG_001', 8.5, 25.3, 16.8,
    'Weathered Granite', 'medium_sand', 'grayish_white', 'soft', true, 'medium',
    28.7, 'Quartz, feldspar, mica', false, 'moderately_weathered', 'low',
    'Decomposed granite with good porosity',
    '{"permeability_m_per_day": 2.5, "specific_yield": 0.12, "transmissivity": 45.8}'
),
(
    'LAYER_BNG_001_03', 'GEOLOG_BH_BNG_001', 25.3, 42.5, 17.2,
    'Fractured Granite', 'coarse_sand', 'pink_gray', 'hard', true, 'high',
    15.4, 'Quartz, orthoclase, biotite', false, 'slightly_weathered', 'medium',
    'Fresh granite with fracture-controlled permeability',
    '{"fracture_spacing_cm": 15, "fracture_aperture_mm": 2.8, "hydraulic_conductivity": 8.7}'
),
(
    'LAYER_BNG_001_04', 'GEOLOG_BH_BNG_001', 42.5, 85.6, 43.1,
    'Basalt Flow', 'fine_sand', 'dark_gray', 'very_hard', true, 'high',
    12.8, 'Plagioclase, pyroxene, olivine', false, 'fresh', 'high',
    'Vesicular basalt with excellent water storage in vesicles',
    '{"vesicularity_percent": 35, "basalt_flow_number": 3, "joint_density_per_meter": 4.2}'
),
-- Layers for BH_CHAD_001
(
    'LAYER_CHAD_001_01', 'GEOLOG_BH_CHAD_001', 0.0, 15.2, 15.2,
    'Alluvial Clay', 'clay', 'brown', 'soft', false, 'impermeable',
    45.8, 'Montmorillonite, illite, organic matter', false, 'fresh', 'none',
    'Recent alluvial deposits with high clay content',
    '{"swelling_potential": "high", "organic_content_percent": 8.5, "cation_exchange_capacity": 85}'
),
(
    'LAYER_CHAD_001_02', 'GEOLOG_BH_CHAD_001', 15.2, 78.3, 63.1,
    'Sandstone', 'medium_sand', 'light_brown', 'medium', false, 'low',
    18.5, 'Quartz, feldspar, clay matrix', false, 'slightly_weathered', 'low',
    'Continental Cretaceous sandstone with clay matrix',
    '{"cement_type": "clay", "grain_roundness": "sub_angular", "sorting": "moderate"}'
),
(
    'LAYER_CHAD_001_03', 'GEOLOG_BH_CHAD_001', 78.3, 145.7, 67.4,
    'Confined Aquifer Sandstone', 'coarse_sand', 'white_gray', 'medium', true, 'high',
    25.6, 'Quartz, minimal clay matrix', true, 'fresh', 'low',
    'Clean quartz sandstone - main productive aquifer',
    '{"grain_size_mm": 0.8, "porosity_lab_percent": 26.8, "permeability_darcy": 1.25, "fossils": "marine_shells"}'
),
(
    'LAYER_CHAD_001_04', 'GEOLOG_BH_CHAD_001', 145.7, 185.4, 39.7,
    'Shale Aquitard', 'silt', 'dark_gray', 'hard', false, 'impermeable',
    8.2, 'Illite, chlorite, organic carbon', true, 'fresh', 'none',
    'Impermeable shale layer acting as aquitard',
    '{"organic_carbon_percent": 2.8, "compressive_strength_mpa": 45, "fossils": "foraminifera"}'
),
-- Layers for BH_AGADEZ_001 (Deep Sahel borehole)
(
    'LAYER_AGADEZ_001_01', 'GEOLOG_BH_AGADEZ_001', 0.0, 35.8, 35.8,
    'Aeolian Sand', 'fine_sand', 'yellow', 'soft', false, 'high',
    38.5, 'Quartz, minimal feldspar', false, 'fresh', 'none',
    'Wind-blown sand deposits typical of Sahel region',
    '{"grain_sorting": "well_sorted", "wind_direction_indicator": "NE", "dune_type": "barchan"}'
),
(
    'LAYER_AGADEZ_001_02', 'GEOLOG_BH_AGADEZ_001', 35.8, 125.8, 90.0,
    'Continental Sandstone', 'medium_sand', 'red_brown', 'medium', false, 'medium',
    22.3, 'Quartz, iron oxide cement', false, 'slightly_weathered', 'low',
    'Continental Jurassic sandstone with iron cement',
    '{"iron_oxide_percent": 12, "cementation_degree": "moderate", "depositional_environment": "fluvial"}'
),
(
    'LAYER_AGADEZ_001_03', 'GEOLOG_BH_AGADEZ_001', 125.8, 215.4, 89.6,
    'Fossil Water Aquifer', 'coarse_sand', 'light_gray', 'medium', true, 'high',
    28.9, 'Quartz, carbonate cement', true, 'fresh', 'medium',
    'Deep fossil water aquifer - main water source',
    '{"age_million_years": 150, "water_age_years": 25000, "carbonate_cement_percent": 8, "fossils": "dinosaur_bones"}'
),
(
    'LAYER_AGADEZ_001_04', 'GEOLOG_BH_AGADEZ_001', 215.4, 245.7, 30.3,
    'Basement Granite', 'boulder', 'pink', 'very_hard', false, 'low',
    5.2, 'Quartz, orthoclase, biotite', false, 'fresh', 'low',
    'Precambrian basement granite',
    '{"age_million_years": 600, "metamorphic_grade": "none", "intrusion_type": "plutonic"}'
);

-- Update timestamps for realistic data
UPDATE water_management_zones SET updated_at = CURRENT_TIMESTAMP;

COMMIT;