-- Comprehensive Sample Data for Construction Details, Water Quality Reports, and Maintenance Activities
-- For all wells, boreholes, and ponds in the Chad Water Infrastructure System

-- First, get all feature names and create standardized feature IDs
-- Construction Details for Wells
INSERT INTO feature_construction_details (
    feature_id, feature_type, contractor_name, contractor_license, contractor_contact,
    construction_method, construction_start_date, construction_end_date, construction_duration_days,
    construction_cost, depth_m, diameter_m, lining_material, materials_used, equipment_used,
    warranty_period_months, quality_certificate_number, environmental_compliance,
    project_status, quality_rating, final_inspection_date, additional_notes
) VALUES
-- Abeche Community Well
('abeche_community_well', 'well', 'Sahel Infrastructure Ltd', 'SIL-2023-089', '+235 99 12 34 56',
 'Manual Drilling with Hand Pump', '2023-01-15', '2023-02-28', 44,
 12500.00, 38.5, 0.15, 'PVC Schedule 40', 
 ARRAY['PVC Casing 6" diameter', 'Bentonite Clay', 'Gravel Pack', 'Hand Pump System'],
 ARRAY['Manual Drilling Rig', 'Hand Tools', 'Water Testing Kit'],
 18, 'WQ-CD-2023-089', 'Compliant with Chad Water Ministry Standards',
 'Completed', 4, '2023-03-05', 'Community well serving 180 households. Manual pump requires regular maintenance.'),

-- Abeche Deep Well
('abeche_deep_well', 'well', 'Desert Water Solutions', 'DWS-2022-156', '+235 99 87 65 43',
 'Rotary Drilling with Submersible Pump', '2022-09-10', '2022-11-22', 73,
 28750.00, 85.2, 0.25, 'Steel Casing with PVC Liner',
 ARRAY['Steel Casing 10" diameter', 'PVC Liner 8" diameter', 'Submersible Pump', 'Control Panel'],
 ARRAY['Rotary Drilling Rig', 'Crane', 'Electrical Installation Equipment', 'Generator'],
 36, 'WQ-CD-2022-156', 'Environmental Impact Assessment Approved',
 'Completed', 5, '2022-11-28', 'Deep aquifer access. High yield well with automated pumping system.'),

-- Adre Border Well
('adre_border_well', 'well', 'Chad-Sudan Water Co.', 'CSWC-2023-234', '+235 99 55 44 33',
 'Percussion Drilling with Solar Pump', '2023-04-01', '2023-05-20', 49,
 19800.00, 52.0, 0.20, 'PVC Schedule 80',
 ARRAY['PVC Casing 8" diameter', 'Solar Panel System', 'Battery Storage', 'Distribution Network'],
 ARRAY['Percussion Drilling Rig', 'Solar Installation Kit', 'Electrical Components'],
 24, 'WQ-CD-2023-234', 'Cross-border Environmental Compliance',
 'Completed', 4, '2023-05-25', 'Solar-powered well serving border communities. Sustainable energy solution.'),

-- Adre Area Test Well
('adre_area_test_well', 'well', 'Exploration Water Services', 'EWS-2023-078', '+235 99 22 11 88',
 'Test Drilling with Temporary Pump', '2023-06-15', '2023-07-10', 25,
 8500.00, 28.5, 0.12, 'Temporary PVC Casing',
 ARRAY['PVC Casing 5" diameter', 'Temporary Pump', 'Flow Meter', 'Water Samples'],
 ARRAY['Portable Drilling Rig', 'Testing Equipment', 'Sample Collection Kit'],
 6, 'WQ-CD-2023-078', 'Exploratory Drilling Permit',
 'Completed', 3, '2023-07-12', 'Exploratory well for aquifer assessment. Limited production capacity.'),

-- Doba Community Well
('doba_community_well', 'well', 'Southern Chad Contractors', 'SCC-2022-345', '+235 99 77 66 55',
 'Rotary Drilling with Community Hand Pump', '2022-11-01', '2022-12-20', 49,
 14750.00, 42.8, 0.18, 'PVC Schedule 40',
 ARRAY['PVC Casing 7" diameter', 'Community Hand Pump', 'Concrete Platform', 'Drainage System'],
 ARRAY['Rotary Drilling Rig', 'Concrete Mixer', 'Hand Tools', 'Water Quality Kit'],
 24, 'WQ-CD-2022-345', 'Community Development Approval',
 'Completed', 4, '2022-12-28', 'Community-managed well with training provided for local maintenance.'),

-- Guereda Village Well
('guereda_village_well', 'well', 'Guereda Water Cooperative', 'GWC-2023-123', '+235 99 33 22 77',
 'Hand Drilling with Rope Pump', '2023-03-01', '2023-04-15', 45,
 6800.00, 22.0, 0.10, 'PVC Schedule 20',
 ARRAY['PVC Casing 4" diameter', 'Rope Pump System', 'Well Head Protection', 'Manual Tools'],
 ARRAY['Hand Drilling Tools', 'Rope Pump Kit', 'Basic Construction Tools'],
 12, 'WQ-CD-2023-123', 'Village Council Approval',
 'Completed', 3, '2023-04-18', 'Village-built well using local labor and training. Cost-effective solution.'),

-- Moundou Community Well
('moundou_community_well', 'well', 'Southwest Water Development', 'SWD-2023-567', '+235 99 88 99 00',
 'Rotary Drilling with Electric Pump', '2023-02-10', '2023-04-05', 54,
 22400.00, 48.5, 0.22, 'Steel Casing with Concrete Lining',
 ARRAY['Steel Casing 9" diameter', 'Electric Pump', 'Power Connection', 'Water Tank'],
 ARRAY['Rotary Drilling Rig', 'Electrical Installation', 'Concrete Equipment', 'Lifting Equipment'],
 30, 'WQ-CD-2023-567', 'Municipal Development Approval',
 'Completed', 5, '2023-04-10', 'Municipal well with electric pump and storage tank. Serves multiple neighborhoods.'),

-- NDjamena Community Well 1
('ndjamena_community_well_1', 'well', 'Capital City Water Works', 'CCWW-2022-890', '+235 99 11 22 33',
 'Advanced Rotary Drilling with Automated System', '2022-08-15', '2022-10-30', 76,
 45200.00, 95.5, 0.30, 'Steel Casing with Stainless Steel Screen',
 ARRAY['Steel Casing 12" diameter', 'Stainless Steel Screen', 'Variable Speed Pump', 'SCADA System'],
 ARRAY['Advanced Drilling Rig', 'SCADA Installation', 'Electrical Systems', 'Control Room Equipment'],
 60, 'WQ-CD-2022-890', 'Capital City Development Standards',
 'Completed', 5, '2022-11-05', 'Advanced municipal well with automated monitoring and control systems.'),

-- Northern Chad Test Well
('northern_chad_test_well', 'well', 'Desert Exploration Co.', 'DEC-2023-456', '+235 99 44 55 66',
 'Exploration Drilling with Monitoring Equipment', '2023-05-01', '2023-06-15', 45,
 18900.00, 68.0, 0.15, 'PVC with Monitoring Equipment',
 ARRAY['PVC Casing 6" diameter', 'Data Loggers', 'Pressure Sensors', 'Sampling Equipment'],
 ARRAY['Exploration Drilling Rig', 'Monitoring Equipment', 'Data Collection Systems'],
 18, 'WQ-CD-2023-456', 'Research and Development Permit',
 'Completed', 4, '2023-06-18', 'Research well for aquifer studies. Equipped with continuous monitoring systems.'),

-- Sarh Traditional Well
('sarh_traditional_well', 'well', 'Traditional Wells Restoration', 'TWR-2023-789', '+235 99 66 77 88',
 'Traditional Restoration with Modern Safety', '2023-01-20', '2023-03-10', 49,
 9200.00, 18.5, 0.25, 'Stone and Mortar with Safety Features',
 ARRAY['Natural Stone', 'Cement Mortar', 'Safety Rails', 'Pulley System'],
 ARRAY['Traditional Tools', 'Safety Equipment', 'Stone Working Tools', 'Pulley Installation'],
 12, 'WQ-CD-2023-789', 'Cultural Heritage Compliance',
 'Completed', 3, '2023-03-15', 'Restored traditional well with modern safety features. Cultural heritage preservation.');

-- Construction Details for Boreholes
INSERT INTO feature_construction_details (
    feature_id, feature_type, contractor_name, contractor_license, contractor_contact,
    construction_method, construction_start_date, construction_end_date, construction_duration_days,
    construction_cost, depth_m, diameter_m, lining_material, materials_used, equipment_used,
    warranty_period_months, quality_certificate_number, environmental_compliance,
    project_status, quality_rating, final_inspection_date, additional_notes
) VALUES
-- Abeche Deep Borehole
('abeche_deep_borehole', 'borehole', 'Deep Aquifer Specialists', 'DAS-2022-678', '+235 99 12 34 56',
 'Deep Rotary Drilling with Advanced Logging', '2022-10-01', '2023-01-15', 106,
 85600.00, 180.5, 0.35, 'Steel Casing with Gravel Pack',
 ARRAY['Steel Casing 14" diameter', 'Gravel Pack', 'Bentonite Seal', 'Submersible Pump System'],
 ARRAY['Heavy Duty Drilling Rig', 'Geological Logging Equipment', 'Pump Installation Rig'],
 60, 'WQ-CD-2022-678', 'Deep Aquifer Exploitation Permit',
 'Completed', 5, '2023-01-20', 'Deep borehole accessing confined aquifer. High yield with excellent water quality.'),

-- Central Chad Borehole 1
('central_chad_borehole_1', 'borehole', 'Chad Drilling Consortium', 'CDC-2023-345', '+235 99 87 65 43',
 'Rotary Drilling with Multi-Zone Completion', '2023-02-15', '2023-05-30', 104,
 72400.00, 125.0, 0.30, 'Multi-Zone Steel Casing',
 ARRAY['Steel Casing 12" diameter', 'Zone Isolation Packers', 'Multi-Level Pump', 'Control Valves'],
 ARRAY['Rotary Drilling Rig', 'Zone Completion Equipment', 'Multi-Pump System'],
 48, 'WQ-CD-2023-345', 'Multi-Zone Aquifer Development',
 'Completed', 5, '2023-06-05', 'Advanced borehole with multiple aquifer zones. Optimized water production.'),

-- Eastern Chad Borehole
('eastern_chad_borehole', 'borehole', 'Eastern Development Corp', 'EDC-2022-890', '+235 99 55 44 33',
 'Percussion Drilling with Solar Pumping', '2022-12-01', '2023-03-20', 109,
 54800.00, 95.8, 0.25, 'PVC Casing with Solar Integration',
 ARRAY['PVC Casing 10" diameter', 'Solar Panel Array', 'Battery Bank', 'Inverter System'],
 ARRAY['Percussion Drilling Rig', 'Solar Installation Equipment', 'Electrical Components'],
 36, 'WQ-CD-2022-890', 'Renewable Energy Integration Approval',
 'Completed', 4, '2023-03-25', 'Solar-powered borehole system. Sustainable and environmentally friendly.'),

-- Guereda Agricultural Borehole
('guereda_agricultural_borehole', 'borehole', 'Agricultural Water Solutions', 'AWS-2023-567', '+235 99 22 11 88',
 'Agricultural Drilling with Irrigation System', '2023-04-01', '2023-07-15', 105,
 68200.00, 110.0, 0.28, 'Agricultural Grade Steel Casing',
 ARRAY['Steel Casing 11" diameter', 'Irrigation Pump', 'Distribution Network', 'Control Systems'],
 ARRAY['Agricultural Drilling Rig', 'Irrigation Equipment', 'Network Installation Tools'],
 42, 'WQ-CD-2023-567', 'Agricultural Development Permit',
 'Completed', 4, '2023-07-20', 'Agricultural borehole with irrigation system. Supports local farming operations.'),

-- Northern Chad Borehole
('northern_chad_borehole', 'borehole', 'Northern Development Agency', 'NDA-2023-234', '+235 99 77 66 55',
 'Desert Drilling with Wind Power', '2023-01-10', '2023-04-25', 105,
 62100.00, 88.5, 0.22, 'Corrosion-Resistant Steel',
 ARRAY['Stainless Steel Casing 9" diameter', 'Wind Turbine', 'Pump Controller', 'Storage Tank'],
 ARRAY['Desert Drilling Rig', 'Wind Power Installation', 'Storage Equipment'],
 36, 'WQ-CD-2023-234', 'Desert Environment Compliance',
 'Completed', 4, '2023-04-30', 'Wind-powered borehole for desert communities. Adapted for harsh conditions.'),

-- Northern Chad Test Borehole
('northern_chad_test_borehole', 'borehole', 'Geological Survey Chad', 'GSC-2023-456', '+235 99 33 22 77',
 'Research Drilling with Monitoring', '2023-03-15', '2023-06-30', 107,
 45600.00, 150.0, 0.20, 'Research Grade Equipment',
 ARRAY['Monitoring Casing 8" diameter', 'Data Collection Equipment', 'Sample Ports', 'Logging Instruments'],
 ARRAY['Research Drilling Rig', 'Geological Logging Equipment', 'Monitoring Installation'],
 24, 'WQ-CD-2023-456', 'Geological Research Permit',
 'Completed', 5, '2023-07-05', 'Research borehole for geological and hydrological studies. Scientific monitoring.');

-- Construction Details for Ponds
INSERT INTO feature_construction_details (
    feature_id, feature_type, contractor_name, contractor_license, contractor_contact,
    construction_method, construction_start_date, construction_end_date, construction_duration_days,
    construction_cost, depth_m, length_m, width_m, lining_material, materials_used, equipment_used,
    warranty_period_months, quality_certificate_number, environmental_compliance,
    project_status, quality_rating, final_inspection_date, additional_notes
) VALUES
-- Abeche Seasonal Pond
('abeche_seasonal_pond', 'pond', 'Pond Construction Specialists', 'PCS-2022-123', '+235 99 88 99 00',
 'Excavation with Clay Lining', '2022-11-01', '2023-01-20', 80,
 28500.00, 3.5, 45.0, 30.0, 'Compacted Clay with Bentonite',
 ARRAY['Bentonite Clay', 'Gravel Base', 'Overflow Pipe', 'Access Ramp'],
 ARRAY['Excavator', 'Compaction Equipment', 'Survey Equipment', 'Pipe Installation'],
 24, 'WQ-CD-2022-123', 'Seasonal Water Storage Permit',
 'Completed', 4, '2023-01-25', 'Seasonal pond for rainwater harvesting. Clay lining prevents seepage.'),

-- Adre Water Reserve
('adre_water_reserve', 'pond', 'Water Storage Solutions', 'WSS-2023-789', '+235 99 11 22 33',
 'Engineered Excavation with Synthetic Liner', '2023-02-01', '2023-04-30', 88,
 45200.00, 4.2, 60.0, 40.0, 'HDPE Geomembrane Liner',
 ARRAY['HDPE Liner 2mm', 'Geotextile Protection', 'Inlet Structure', 'Outlet Control'],
 ARRAY['Large Excavator', 'Liner Installation Equipment', 'Welding Equipment'],
 36, 'WQ-CD-2023-789', 'Water Reserve Development Permit',
 'Completed', 5, '2023-05-05', 'Large water reserve with synthetic liner. Long-term water storage capacity.'),

-- Adre Area Test Pond
('adre_area_test_pond', 'pond', 'Experimental Water Systems', 'EWS-2023-456', '+235 99 44 55 66',
 'Test Excavation with Monitoring', '2023-05-15', '2023-07-10', 56,
 18200.00, 2.0, 25.0, 15.0, 'Natural Clay with Monitoring',
 ARRAY['Natural Clay Lining', 'Water Level Sensors', 'Quality Monitors', 'Sampling Points'],
 ARRAY['Mini Excavator', 'Monitoring Equipment', 'Installation Tools'],
 12, 'WQ-CD-2023-456', 'Experimental Water Project',
 'Completed', 3, '2023-07-15', 'Test pond for water storage experiments. Equipped with monitoring systems.'),

-- Central Chad Test Pond
('central_chad_test_pond', 'pond', 'Central Development Works', 'CDW-2023-234', '+235 99 66 77 88',
 'Standard Excavation with Concrete Lining', '2023-03-01', '2023-05-15', 75,
 32400.00, 3.0, 35.0, 25.0, 'Reinforced Concrete',
 ARRAY['Concrete Mix', 'Steel Reinforcement', 'Waterproofing', 'Control Structures'],
 ARRAY['Excavator', 'Concrete Mixer', 'Reinforcement Tools', 'Finishing Equipment'],
 48, 'WQ-CD-2023-234', 'Municipal Water Storage',
 'Completed', 4, '2023-05-20', 'Concrete-lined pond for municipal water storage. Durable construction.'),

-- Chari River Pond
('chari_river_pond', 'pond', 'River Management Authority', 'RMA-2022-567', '+235 99 12 34 56',
 'River-Fed Excavation with Natural Lining', '2022-09-15', '2022-12-10', 86,
 22800.00, 2.8, 50.0, 35.0, 'Natural River Sediment',
 ARRAY['River Sediment', 'Rock Armoring', 'Inlet Channel', 'Fish Ladder'],
 ARRAY['Amphibious Excavator', 'Rock Placement Equipment', 'Channel Tools'],
 18, 'WQ-CD-2022-567', 'River Ecosystem Management',
 'Completed', 4, '2022-12-15', 'River-connected pond supporting ecosystem and water supply. Fish habitat included.'),

-- Lake Chad Retention Pond
('lake_chad_retention_pond', 'pond', 'Lake Chad Basin Authority', 'LCBA-2023-890', '+235 99 87 65 43',
 'Large Scale Excavation with Multi-Layer Lining', '2023-01-15', '2023-06-30', 166,
 125600.00, 5.5, 120.0, 80.0, 'Multi-Layer Composite',
 ARRAY['Clay Base Layer', 'Geomembrane Liner', 'Protection Layer', 'Wave Protection'],
 ARRAY['Fleet of Excavators', 'Liner Installation Crew', 'Quality Control Equipment'],
 60, 'WQ-CD-2023-890', 'Lake Chad Basin Management',
 'Completed', 5, '2023-07-05', 'Large retention pond connected to Lake Chad. Critical water infrastructure.'),

-- Logone Valley Pond
('logone_valley_pond', 'pond', 'Valley Development Corp', 'VDC-2022-345', '+235 99 55 44 33',
 'Valley Excavation with Flood Control', '2022-10-01', '2023-01-30', 121,
 38900.00, 4.0, 65.0, 45.0, 'Clay with Flood Barriers',
 ARRAY['Compacted Clay', 'Flood Barriers', 'Spillway', 'Access Roads'],
 ARRAY['Heavy Excavator', 'Barrier Construction', 'Road Equipment'],
 30, 'WQ-CD-2022-345', 'Flood Management Integration',
 'Completed', 4, '2023-02-05', 'Valley pond with integrated flood control. Seasonal water management.');

-- Water Quality Reports for Wells
INSERT INTO feature_water_quality_reports (
    feature_id, test_date, ph_level, turbidity, tds_ppm, conductivity, temperature,
    coliform_count, ecoli_count, overall_quality, testing_laboratory, 
    recommended_treatment, next_test_due_date, notes
) VALUES
-- Abeche Community Well - Multiple test dates
('abeche_community_well', '2023-03-15', 7.1, 1.2, 280, 420, 27.5, 2, 0, 'good', 'Chad National Water Quality Lab', 'Monthly chlorination', '2023-09-15', 'Minor coliform detection, treatment recommended'),
('abeche_community_well', '2023-06-15', 7.3, 0.8, 265, 398, 28.2, 0, 0, 'excellent', 'Chad National Water Quality Lab', 'Continue current maintenance', '2023-12-15', 'Quality improved after treatment'),
('abeche_community_well', '2023-09-15', 7.2, 1.0, 275, 412, 26.8, 1, 0, 'good', 'Chad National Water Quality Lab', 'Quarterly monitoring', '2024-03-15', 'Stable water quality maintained'),

-- Abeche Deep Well
('abeche_deep_well', '2022-12-01', 7.4, 0.5, 220, 335, 25.0, 0, 0, 'excellent', 'Chad National Water Quality Lab', 'No treatment required', '2023-06-01', 'Deep aquifer provides excellent quality'),
('abeche_deep_well', '2023-06-01', 7.3, 0.6, 225, 340, 25.5, 0, 0, 'excellent', 'Chad National Water Quality Lab', 'Annual monitoring sufficient', '2024-06-01', 'Consistently excellent quality'),

-- Adre Border Well
('adre_border_well', '2023-05-30', 7.0, 1.5, 295, 445, 29.0, 3, 1, 'fair', 'Cross-Border Lab Services', 'Disinfection and filtration', '2023-11-30', 'Higher mineralization, treatment needed'),
('adre_border_well', '2023-08-30', 7.2, 1.0, 285, 430, 28.5, 1, 0, 'good', 'Cross-Border Lab Services', 'Continue treatment', '2024-02-28', 'Improvement after treatment implementation'),

-- Doba Community Well
('doba_community_well', '2023-01-10', 6.9, 2.0, 315, 472, 30.2, 5, 2, 'fair', 'Southern Chad Lab', 'Immediate disinfection required', '2023-07-10', 'Elevated bacteria levels detected'),
('doba_community_well', '2023-04-10', 7.1, 1.5, 305, 458, 29.8, 2, 0, 'good', 'Southern Chad Lab', 'Monthly disinfection', '2023-10-10', 'Bacterial levels reduced'),
('doba_community_well', '2023-07-10', 7.2, 1.2, 298, 447, 29.5, 1, 0, 'good', 'Southern Chad Lab', 'Continue monitoring', '2024-01-10', 'Stable improvement maintained');

-- Water Quality Reports for Boreholes
INSERT INTO feature_water_quality_reports (
    feature_id, test_date, ph_level, turbidity, tds_ppm, conductivity, temperature,
    coliform_count, ecoli_count, overall_quality, testing_laboratory, 
    recommended_treatment, next_test_due_date, notes
) VALUES
-- Abeche Deep Borehole
('abeche_deep_borehole', '2023-02-01', 7.8, 0.3, 185, 280, 23.5, 0, 0, 'excellent', 'Deep Aquifer Testing Lab', 'No treatment required', '2024-02-01', 'Pristine deep aquifer water'),
('abeche_deep_borehole', '2023-08-01', 7.7, 0.4, 190, 285, 24.0, 0, 0, 'excellent', 'Deep Aquifer Testing Lab', 'Annual monitoring', '2024-08-01', 'Consistent excellent quality'),

-- Central Chad Borehole 1
('central_chad_borehole_1', '2023-06-15', 7.5, 0.7, 245, 365, 26.2, 0, 0, 'excellent', 'Multi-Zone Analysis Lab', 'Selective zone monitoring', '2024-06-15', 'Multi-zone completion provides optimal quality'),
('central_chad_borehole_1', '2023-09-15', 7.6, 0.6, 240, 360, 25.8, 0, 0, 'excellent', 'Multi-Zone Analysis Lab', 'Continue selective pumping', '2024-12-15', 'Zone isolation maintaining quality'),

-- Eastern Chad Borehole
('eastern_chad_borehole', '2023-04-01', 7.3, 0.9, 265, 398, 27.8, 0, 0, 'excellent', 'Solar System Water Lab', 'UV sterilization available', '2023-10-01', 'Solar UV system provides additional safety'),
('eastern_chad_borehole', '2023-07-01', 7.4, 0.8, 260, 390, 28.2, 0, 0, 'excellent', 'Solar System Water Lab', 'UV system functioning well', '2024-01-01', 'Solar disinfection effective');

-- Water Quality Reports for Ponds
INSERT INTO feature_water_quality_reports (
    feature_id, test_date, ph_level, turbidity, tds_ppm, conductivity, temperature,
    coliform_count, ecoli_count, overall_quality, testing_laboratory, 
    recommended_treatment, next_test_due_date, notes
) VALUES
-- Abeche Seasonal Pond
('abeche_seasonal_pond', '2023-02-15', 8.2, 15.0, 450, 675, 22.0, 25, 8, 'poor', 'Surface Water Testing Lab', 'Multi-stage treatment required', '2023-05-15', 'Seasonal pond requires treatment before use'),
('abeche_seasonal_pond', '2023-05-15', 7.8, 12.0, 420, 630, 25.5, 15, 3, 'fair', 'Surface Water Testing Lab', 'Coagulation and disinfection', '2023-08-15', 'Improvement with settling time'),
('abeche_seasonal_pond', '2023-08-15', 7.6, 8.0, 385, 578, 28.0, 8, 1, 'fair', 'Surface Water Testing Lab', 'Disinfection before use', '2023-11-15', 'Quality improves during dry season'),

-- Lake Chad Retention Pond
('lake_chad_retention_pond', '2023-07-15', 8.0, 8.5, 380, 570, 29.5, 12, 2, 'fair', 'Lake Chad Monitoring Station', 'Sedimentation and chlorination', '2023-10-15', 'Large volume provides natural treatment'),
('lake_chad_retention_pond', '2023-10-15', 7.9, 7.0, 365, 548, 27.0, 8, 1, 'good', 'Lake Chad Monitoring Station', 'Basic disinfection', '2024-01-15', 'Natural processes improving quality'),

-- Chari River Pond
('chari_river_pond', '2023-01-01', 7.5, 12.0, 395, 593, 24.0, 18, 4, 'fair', 'River System Lab', 'Biological treatment recommended', '2023-04-01', 'River connection maintains flow'),
('chari_river_pond', '2023-04-01', 7.6, 10.0, 385, 578, 26.5, 12, 2, 'fair', 'River System Lab', 'Continue biological treatment', '2023-07-01', 'Fish population helping with biological treatment'),
('chari_river_pond', '2023-07-01', 7.7, 8.5, 375, 563, 28.8, 8, 1, 'good', 'River System Lab', 'Maintenance of ecosystem', '2023-10-01', 'Ecosystem approach showing results');

-- Maintenance Activities for Wells
INSERT INTO feature_maintenance_activities (
    feature_id, feature_type, activity_date, activity_type, activity_status, priority,
    cost, duration_hours, technician, description, parts_replaced, equipment_used,
    effectiveness_rating, next_maintenance_date, notes
) VALUES
-- Abeche Community Well
('abeche_community_well', 'well', '2023-04-15', 'Hand Pump Repair', 'completed', 'high', 350.00, 4, 'Local Technician - Abakar Ahmed', 'Hand pump cylinder replacement and seal maintenance', ARRAY['Pump Cylinder', 'Rubber Seals'], ARRAY['Hand Tools', 'Pump Jack'], 4, '2023-10-15', 'Pump efficiency restored to 90%'),
('abeche_community_well', 'well', '2023-07-20', 'Well Head Cleaning', 'completed', 'medium', 150.00, 2, 'Community Volunteer - Fatima Hassan', 'Well head sanitization and protective cover repair', ARRAY['Cleaning Supplies', 'Cover Repair Kit'], ARRAY['Cleaning Equipment', 'Basic Tools'], 4, '2024-01-20', 'Improved hygiene and protection'),
('abeche_community_well', 'well', '2023-10-15', 'Quarterly Inspection', 'completed', 'low', 100.00, 3, 'Regional Inspector - Mohamed Saleh', 'Routine quarterly safety and performance inspection', ARRAY[], ARRAY['Inspection Tools', 'Water Testing Kit'], 4, '2024-01-15', 'All systems functioning normally'),

-- Abeche Deep Well
('abeche_deep_well', 'well', '2023-01-10', 'Submersible Pump Service', 'completed', 'medium', 2200.00, 8, 'Pump Specialist - Ali Mahmoud', 'Annual submersible pump inspection and motor service', ARRAY['Motor Bearings', 'Impeller'], ARRAY['Pump Hoist', 'Motor Testing Equipment'], 5, '2024-01-10', 'Pump performance optimized, efficiency increased 12%'),
('abeche_deep_well', 'well', '2023-06-15', 'Control Panel Upgrade', 'completed', 'low', 850.00, 6, 'Electrical Technician - Ibrahim Yousif', 'Control panel modernization and safety improvements', ARRAY['Control Relays', 'Safety Switches'], ARRAY['Electrical Tools', 'Testing Equipment'], 4, '2025-06-15', 'Enhanced safety and automated controls'),
('abeche_deep_well', 'well', '2024-01-10', 'Annual Comprehensive Service', 'scheduled', 'medium', 2800.00, 12, 'Deep Well Team - Specialized Crew', 'Complete system inspection, pump service, and performance testing', ARRAY['TBD based on inspection'], ARRAY['Full Service Equipment'], NULL, '2025-01-10', 'Comprehensive annual maintenance scheduled'),

-- Adre Border Well
('adre_border_well', 'well', '2023-06-30', 'Solar Panel Cleaning', 'completed', 'medium', 200.00, 3, 'Solar Technician - Oumar Deby', 'Solar panel cleaning and electrical connection inspection', ARRAY['Cleaning Supplies'], ARRAY['Panel Cleaning Equipment', 'Electrical Tester'], 4, '2023-12-30', 'Solar efficiency improved by 8%'),
('adre_border_well', 'well', '2023-09-15', 'Battery Bank Service', 'completed', 'high', 450.00, 4, 'Energy Storage Specialist - Amina Abdel', 'Battery testing, replacement of weak cells, charging system check', ARRAY['Battery Cells', 'Terminal Connectors'], ARRAY['Battery Tester', 'Charging Equipment'], 4, '2024-03-15', 'Energy storage capacity restored'),
('adre_border_well', 'well', '2023-12-30', 'Winter Preparation', 'completed', 'low', 300.00, 5, 'Border Maintenance Team', 'Winterization and cross-border coordination meeting', ARRAY['Insulation Materials'], ARRAY['Weatherproofing Tools'], 3, '2024-06-30', 'System prepared for seasonal changes');

-- Maintenance Activities for Boreholes
INSERT INTO feature_maintenance_activities (
    feature_id, feature_type, activity_date, activity_type, activity_status, priority,
    cost, duration_hours, technician, description, parts_replaced, equipment_used,
    effectiveness_rating, next_maintenance_date, notes
) VALUES
-- Abeche Deep Borehole
('abeche_deep_borehole', 'borehole', '2023-03-01', 'Deep Pump Overhaul', 'completed', 'high', 8500.00, 16, 'Deep Drilling Specialist - Hassan Mahamat', 'Complete pump system overhaul and performance optimization', ARRAY['Pump Assembly', 'Drive Shaft', 'Pump Controller'], ARRAY['Heavy Lifting Equipment', 'Pump Testing Rig'], 5, '2024-03-01', 'Pump performance increased 18%, excellent condition'),
('abeche_deep_borehole', 'borehole', '2023-08-15', 'Geological Monitoring', 'completed', 'low', 1200.00, 6, 'Hydrogeologist - Dr. Khadija Omar', 'Aquifer monitoring and geological assessment', ARRAY[], ARRAY['Logging Equipment', 'Monitoring Instruments'], 5, '2024-08-15', 'Aquifer stable, excellent recharge rates'),

-- Central Chad Borehole 1
('central_chad_borehole_1', 'borehole', '2023-07-20', 'Multi-Zone System Service', 'completed', 'medium', 4200.00, 12, 'Multi-Zone Specialist - Ahmed Zakaria', 'Zone isolation system inspection and pump synchronization', ARRAY['Zone Packers', 'Control Valves'], ARRAY['Zone Testing Equipment', 'Synchronization Tools'], 5, '2024-07-20', 'All zones operating optimally, perfect isolation'),
('central_chad_borehole_1', 'borehole', '2023-11-10', 'Production Optimization', 'completed', 'low', 1800.00, 8, 'Production Engineer - Mariam Abdallah', 'Flow rate optimization and energy efficiency improvements', ARRAY['Flow Controllers'], ARRAY['Flow Measurement Equipment'], 4, '2024-11-10', 'Energy consumption reduced 12%'),

-- Eastern Chad Borehole
('eastern_chad_borehole', 'borehole', '2023-05-10', 'Solar System Maintenance', 'completed', 'medium', 1500.00, 10, 'Renewable Energy Team', 'Complete solar system inspection and battery replacement', ARRAY['Solar Batteries', 'Charge Controller'], ARRAY['Solar Testing Equipment', 'Battery Tools'], 4, '2024-05-10', 'Solar system efficiency restored to 95%'),
('eastern_chad_borehole', 'borehole', '2023-09-25', 'Pump Motor Service', 'completed', 'high', 2800.00, 8, 'Motor Specialist - Saleh Adam', 'Motor rewinding and bearing replacement', ARRAY['Motor Windings', 'Motor Bearings'], ARRAY['Motor Service Equipment'], 5, '2024-09-25', 'Motor performance excellent after service');

-- Maintenance Activities for Ponds
INSERT INTO feature_maintenance_activities (
    feature_id, feature_type, activity_date, activity_type, activity_status, priority,
    cost, duration_hours, technician, description, parts_replaced, equipment_used,
    effectiveness_rating, next_maintenance_date, notes
) VALUES
-- Abeche Seasonal Pond
('abeche_seasonal_pond', 'pond', '2023-03-30', 'Sediment Removal', 'completed', 'high', 2200.00, 24, 'Excavation Team - Pond Specialists', 'Annual sediment removal and capacity restoration', ARRAY[], ARRAY['Excavator', 'Sediment Removal Equipment'], 4, '2024-03-30', 'Storage capacity restored to 95%'),
('abeche_seasonal_pond', 'pond', '2023-08-15', 'Clay Lining Repair', 'completed', 'medium', 1200.00, 12, 'Lining Specialist - Omar Hassan', 'Clay lining inspection and crack repair', ARRAY['Bentonite Clay', 'Sealant'], ARRAY['Compaction Equipment', 'Repair Tools'], 4, '2024-08-15', 'Lining integrity restored, minimal seepage'),
('abeche_seasonal_pond', 'pond', '2023-11-20', 'Pre-Season Preparation', 'completed', 'low', 400.00, 6, 'Maintenance Crew', 'Inlet cleaning and overflow system check', ARRAY['Filter Media'], ARRAY['Cleaning Equipment'], 3, '2024-05-20', 'Ready for next rainy season'),

-- Lake Chad Retention Pond
('lake_chad_retention_pond', 'pond', '2023-08-30', 'Liner Inspection', 'completed', 'high', 3500.00, 18, 'Geomembrane Specialist - Expert Team', 'Complete liner system inspection and minor repairs', ARRAY['Liner Patches', 'Welding Materials'], ARRAY['Leak Detection Equipment', 'Welding Tools'], 5, '2024-08-30', 'Liner integrity excellent, minor repairs completed'),
('lake_chad_retention_pond', 'pond', '2023-12-01', 'Wave Protection Maintenance', 'completed', 'medium', 1800.00, 14, 'Coastal Engineering Team', 'Wave barrier inspection and reinforcement', ARRAY['Rock Armor', 'Geotextile'], ARRAY['Heavy Equipment', 'Placement Tools'], 4, '2024-12-01', 'Wave protection reinforced for next season'),

-- Chari River Pond
('chari_river_pond', 'pond', '2023-02-28', 'Fish Ladder Maintenance', 'completed', 'low', 800.00, 8, 'Aquatic Ecosystem Specialist', 'Fish passage system cleaning and ecosystem monitoring', ARRAY['Cleaning Materials'], ARRAY['Aquatic Tools', 'Monitoring Equipment'], 4, '2024-02-28', 'Fish migration patterns healthy'),
('chari_river_pond', 'pond', '2023-06-15', 'Inlet Channel Dredging', 'completed', 'medium', 1500.00, 16, 'River Management Crew', 'Channel dredging and flow optimization', ARRAY[], ARRAY['Dredging Equipment', 'Flow Measurement'], 4, '2024-06-15', 'Optimal flow rates restored'),
('chari_river_pond', 'pond', '2023-10-10', 'Ecosystem Assessment', 'completed', 'low', 600.00, 6, 'Environmental Biologist - Dr. Aicha Idriss', 'Annual ecosystem health assessment and fish population survey', ARRAY[], ARRAY['Biological Sampling Equipment'], 5, '2024-10-10', 'Ecosystem thriving, biodiversity excellent');

-- Add more water quality reports for remaining features
INSERT INTO feature_water_quality_reports (
    feature_id, test_date, ph_level, turbidity, tds_ppm, conductivity, temperature,
    coliform_count, ecoli_count, overall_quality, testing_laboratory, 
    recommended_treatment, next_test_due_date, notes
) VALUES
-- Additional reports for remaining wells
('guereda_village_well', '2023-04-25', 7.0, 2.5, 340, 510, 31.0, 8, 2, 'fair', 'Village Testing Cooperative', 'Local disinfection methods', '2023-10-25', 'Village-managed well, local treatment methods applied'),
('moundou_community_well', '2023-04-20', 7.4, 0.9, 258, 387, 28.5, 1, 0, 'good', 'Municipal Lab Services', 'Monthly monitoring', '2023-10-20', 'Municipal system maintains good quality'),
('ndjamena_community_well_1', '2022-11-15', 7.6, 0.4, 195, 293, 26.0, 0, 0, 'excellent', 'Capital City Lab', 'Automated monitoring', '2023-11-15', 'Advanced system maintains excellent quality'),
('northern_chad_test_well', '2023-06-25', 7.2, 1.1, 275, 413, 29.5, 2, 0, 'good', 'Research Laboratory', 'Research-grade treatment', '2023-12-25', 'Research well with monitoring equipment'),
('sarh_traditional_well', '2023-03-20', 6.8, 3.0, 385, 578, 30.5, 12, 3, 'poor', 'Traditional Water Testing', 'Traditional purification methods', '2023-09-20', 'Traditional well requires conventional treatment'),

-- Additional reports for remaining boreholes
('guereda_agricultural_borehole', '2023-07-30', 7.5, 0.8, 235, 353, 27.0, 0, 0, 'excellent', 'Agricultural Testing Lab', 'Irrigation quality monitoring', '2024-07-30', 'Excellent quality for agricultural use'),
('northern_chad_borehole', '2023-05-15', 7.3, 1.0, 290, 435, 28.8, 1, 0, 'good', 'Desert Conditions Lab', 'Wind-powered UV treatment', '2023-11-15', 'Wind power system provides additional treatment'),
('northern_chad_test_borehole', '2023-07-20', 7.7, 0.5, 210, 315, 24.5, 0, 0, 'excellent', 'Geological Research Lab', 'Research monitoring only', '2024-07-20', 'Research-grade monitoring and analysis'),

-- Additional reports for remaining ponds
('adre_water_reserve', '2023-05-20', 7.8, 5.0, 320, 480, 26.0, 10, 1, 'fair', 'Reserve Management Lab', 'Multi-stage treatment system', '2023-11-20', 'Large reserve requires treatment before distribution'),
('adre_area_test_pond', '2023-07-25', 8.1, 8.0, 365, 548, 27.5, 15, 3, 'fair', 'Experimental Water Lab', 'Test treatment protocols', '2023-10-25', 'Experimental treatments being evaluated'),
('central_chad_test_pond', '2023-05-30', 7.7, 3.0, 295, 443, 28.0, 5, 1, 'good', 'Municipal Testing Center', 'Concrete pond maintenance', '2023-11-30', 'Concrete lining maintains good quality'),
('logone_valley_pond', '2023-02-15', 7.9, 10.0, 420, 630, 25.0, 20, 5, 'poor', 'Valley Management Lab', 'Flood management treatment', '2023-08-15', 'Valley flooding affects seasonal quality');

-- Additional maintenance activities for remaining features
INSERT INTO feature_maintenance_activities (
    feature_id, feature_type, activity_date, activity_type, activity_status, priority,
    cost, duration_hours, technician, description, parts_replaced, equipment_used,
    effectiveness_rating, next_maintenance_date, notes
) VALUES
-- Remaining wells maintenance
('guereda_village_well', 'well', '2023-05-10', 'Rope Pump Maintenance', 'completed', 'medium', 180.00, 3, 'Village Technician - Haroun Moussa', 'Rope pump system maintenance and rope replacement', ARRAY['Pump Rope', 'Pulley Bearings'], ARRAY['Village Tools', 'Rope Installation Kit'], 3, '2023-11-10', 'Village-managed maintenance successful'),
('moundou_community_well', 'well', '2023-05-15', 'Electric Pump Service', 'completed', 'high', 1200.00, 6, 'Municipal Electrician - Jean-Claude Ngarta', 'Electric pump motor service and electrical system check', ARRAY['Motor Capacitor', 'Electrical Contacts'], ARRAY['Electrical Testing Equipment'], 4, '2024-05-15', 'Municipal system efficiency improved'),
('ndjamena_community_well_1', 'well', '2022-12-10', 'SCADA System Update', 'completed', 'low', 2500.00, 8, 'Automation Specialist - Advanced Systems Team', 'SCADA system software update and sensor calibration', ARRAY['Software License', 'Sensor Calibration Kit'], ARRAY['Computer Equipment', 'Calibration Tools'], 5, '2023-12-10', 'Automated monitoring system optimized'),
('northern_chad_test_well', 'well', '2023-07-05', 'Monitoring Equipment Service', 'completed', 'medium', 950.00, 4, 'Research Technician - Dr. Amina Bashir', 'Data logger service and monitoring equipment calibration', ARRAY['Data Logger Battery', 'Sensor Cables'], ARRAY['Calibration Equipment', 'Data Tools'], 4, '2024-07-05', 'Research monitoring equipment functioning perfectly'),
('sarh_traditional_well', 'well', '2023-04-01', 'Traditional Well Restoration', 'completed', 'high', 400.00, 8, 'Traditional Well Master - Elder Brahim', 'Stone work repair and traditional safety improvements', ARRAY['Natural Stone', 'Traditional Mortar'], ARRAY['Traditional Tools', 'Stone Working Equipment'], 3, '2024-04-01', 'Traditional methods preserve cultural heritage'),

-- Remaining boreholes maintenance
('guereda_agricultural_borehole', 'borehole', '2023-08-20', 'Irrigation System Service', 'completed', 'medium', 3200.00, 12, 'Irrigation Specialist - Agricultural Team', 'Irrigation pump service and distribution network maintenance', ARRAY['Irrigation Pumps', 'Distribution Valves'], ARRAY['Irrigation Equipment', 'Network Tools'], 4, '2024-08-20', 'Agricultural irrigation system optimized'),
('northern_chad_borehole', 'borehole', '2023-06-10', 'Wind Power System Service', 'completed', 'medium', 2200.00, 10, 'Wind Energy Technician - Renewable Team', 'Wind turbine maintenance and power system optimization', ARRAY['Wind Turbine Parts', 'Power Controllers'], ARRAY['Wind Service Equipment'], 4, '2024-06-10', 'Wind power system efficiency excellent'),
('northern_chad_test_borehole', 'borehole', '2023-08-15', 'Research Equipment Maintenance', 'completed', 'low', 1500.00, 6, 'Research Equipment Specialist', 'Geological monitoring equipment service and data system update', ARRAY['Monitoring Sensors', 'Data Storage'], ARRAY['Research Equipment'], 5, '2024-08-15', 'Research monitoring systems excellent condition'),

-- Remaining ponds maintenance
('adre_water_reserve', 'pond', '2023-06-15', 'Liner System Inspection', 'completed', 'high', 2800.00, 16, 'Large Pond Specialist Team', 'HDPE liner comprehensive inspection and inlet structure service', ARRAY['Liner Repair Kit', 'Inlet Seals'], ARRAY['Liner Testing Equipment', 'Repair Tools'], 5, '2024-06-15', 'Large reserve liner system in excellent condition'),
('adre_area_test_pond', 'pond', '2023-08-10', 'Monitoring System Calibration', 'completed', 'low', 600.00, 4, 'Experimental Systems Technician', 'Water monitoring sensors calibration and data system check', ARRAY['Sensor Batteries', 'Calibration Solutions'], ARRAY['Calibration Equipment'], 4, '2024-08-10', 'Experimental monitoring systems accurate'),
('central_chad_test_pond', 'pond', '2023-06-20', 'Concrete Lining Maintenance', 'completed', 'medium', 1800.00, 14, 'Concrete Specialist - Municipal Works', 'Concrete liner crack repair and control structure service', ARRAY['Concrete Repair Material', 'Sealants'], ARRAY['Concrete Repair Equipment'], 4, '2024-06-20', 'Concrete pond structure maintained excellent condition'),
('logone_valley_pond', 'pond', '2023-03-30', 'Flood Control System Check', 'completed', 'high', 2500.00, 20, 'Flood Management Team', 'Spillway maintenance and flood barrier inspection', ARRAY['Spillway Gates', 'Barrier Reinforcement'], ARRAY['Heavy Maintenance Equipment'], 4, '2024-03-30', 'Flood control systems ready for next season');