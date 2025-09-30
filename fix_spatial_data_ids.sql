-- Add missing construction details records for spatial data IDs
-- This will fix the frontend "API unavailable" messages by ensuring all map features have corresponding construction details

-- Insert construction details for missing well IDs
INSERT INTO feature_construction_details (
    feature_id, feature_type, contractor_name, contractor_license, contractor_contact,
    construction_method, construction_start_date, construction_end_date, construction_duration_days,
    construction_cost, depth_m, diameter_m, lining_material, materials_used, equipment_used,
    warranty_period_months, quality_certificate_number, environmental_compliance,
    project_status, quality_rating, final_inspection_date, additional_notes
) VALUES
-- well_1 (NDjamena Community Well 1) - already exists as ndjamena_community_well_1, but need well_1
('well_1', 'well', 'Capital City Water Works', 'CCWW-2022-890', '+235 99 11 22 33',
 'Advanced Rotary Drilling with Automated System', '2022-08-15', '2022-10-30', 76,
 45200.00, 95.5, 0.30, 'Steel Casing with Stainless Steel Screen',
 ARRAY['Steel Casing 12" diameter', 'Stainless Steel Screen', 'Variable Speed Pump', 'SCADA System'],
 ARRAY['Advanced Drilling Rig', 'SCADA Installation', 'Electrical Systems', 'Control Room Equipment'],
 60, 'WQ-CD-2022-890', 'Capital City Development Standards',
 'Completed', 5, '2022-11-05', 'Advanced municipal well with automated monitoring and control systems.'),

-- well_2 (Moundou Community Well) - already exists as moundou_community_well, but need well_2
('well_2', 'well', 'Southwest Water Development', 'SWD-2023-567', '+235 99 88 99 00',
 'Rotary Drilling with Electric Pump', '2023-02-10', '2023-04-05', 54,
 22400.00, 48.5, 0.22, 'Steel Casing with Concrete Lining',
 ARRAY['Steel Casing 9" diameter', 'Electric Pump', 'Power Connection', 'Water Tank'],
 ARRAY['Rotary Drilling Rig', 'Electrical Installation', 'Concrete Equipment', 'Lifting Equipment'],
 30, 'WQ-CD-2023-567', 'Municipal Development Approval',
 'Completed', 5, '2023-04-10', 'Municipal well with electric pump and storage tank. Serves multiple neighborhoods.'),

-- well_3 (Sarh Traditional Well) - already exists as sarh_traditional_well, but need well_3
('well_3', 'well', 'Traditional Wells Restoration', 'TWR-2023-789', '+235 99 66 77 88',
 'Traditional Restoration with Modern Safety', '2023-01-20', '2023-03-10', 49,
 9200.00, 18.5, 0.25, 'Stone and Mortar with Safety Features',
 ARRAY['Natural Stone', 'Cement Mortar', 'Safety Rails', 'Pulley System'],
 ARRAY['Traditional Tools', 'Safety Equipment', 'Stone Working Tools', 'Pulley Installation'],
 12, 'WQ-CD-2023-789', 'Cultural Heritage Compliance',
 'Completed', 3, '2023-03-15', 'Restored traditional well with modern safety features. Cultural heritage preservation.'),

-- well_4 (Abeche Deep Well) - already exists as abeche_deep_well, but need well_4
('well_4', 'well', 'Desert Water Solutions', 'DWS-2022-156', '+235 99 87 65 43',
 'Rotary Drilling with Submersible Pump', '2022-09-10', '2022-11-22', 73,
 28750.00, 85.2, 0.25, 'Steel Casing with PVC Liner',
 ARRAY['Steel Casing 10" diameter', 'PVC Liner 8" diameter', 'Submersible Pump', 'Control Panel'],
 ARRAY['Rotary Drilling Rig', 'Crane', 'Electrical Installation Equipment', 'Generator'],
 36, 'WQ-CD-2022-156', 'Environmental Impact Assessment Approved',
 'Completed', 5, '2022-11-28', 'Deep aquifer access. High yield well with automated pumping system.'),

-- well_5 (Doba Community Well) - already exists as doba_community_well, but need well_5
('well_5', 'well', 'Southern Chad Contractors', 'SCC-2022-345', '+235 99 77 66 55',
 'Rotary Drilling with Community Hand Pump', '2022-11-01', '2022-12-20', 49,
 14750.00, 42.8, 0.18, 'PVC Schedule 40',
 ARRAY['PVC Casing 7" diameter', 'Community Hand Pump', 'Concrete Platform', 'Drainage System'],
 ARRAY['Rotary Drilling Rig', 'Concrete Mixer', 'Hand Tools', 'Water Quality Kit'],
 24, 'WQ-CD-2022-345', 'Community Development Approval',
 'Completed', 4, '2022-12-28', 'Community-managed well with training provided for local maintenance.'),

-- well_6 (Abeche Community Well) - already exists as abeche_community_well, but need well_6
('well_6', 'well', 'Sahel Infrastructure Ltd', 'SIL-2023-089', '+235 99 12 34 56',
 'Manual Drilling with Hand Pump', '2023-01-15', '2023-02-28', 44,
 12500.00, 38.5, 0.15, 'PVC Schedule 40', 
 ARRAY['PVC Casing 6" diameter', 'Bentonite Clay', 'Gravel Pack', 'Hand Pump System'],
 ARRAY['Manual Drilling Rig', 'Hand Tools', 'Water Testing Kit'],
 18, 'WQ-CD-2023-089', 'Compliant with Chad Water Ministry Standards',
 'Completed', 4, '2023-03-05', 'Community well serving 180 households. Manual pump requires regular maintenance.'),

-- well_7 (Adre Border Well) - already exists as adre_border_well, but need well_7
('well_7', 'well', 'Chad-Sudan Water Co.', 'CSWC-2023-234', '+235 99 55 44 33',
 'Percussion Drilling with Solar Pump', '2023-04-01', '2023-05-20', 49,
 19800.00, 52.0, 0.20, 'PVC Schedule 80',
 ARRAY['PVC Casing 8" diameter', 'Solar Panel System', 'Battery Storage', 'Distribution Network'],
 ARRAY['Percussion Drilling Rig', 'Solar Installation Kit', 'Electrical Components'],
 24, 'WQ-CD-2023-234', 'Cross-border Environmental Compliance',
 'Completed', 4, '2023-05-25', 'Solar-powered well serving border communities. Sustainable energy solution.'),

-- well_8 (Guereda Village Well) - already exists as guereda_village_well, but need well_8
('well_8', 'well', 'Guereda Water Cooperative', 'GWC-2023-123', '+235 99 33 22 77',
 'Hand Drilling with Rope Pump', '2023-03-01', '2023-04-15', 45,
 6800.00, 22.0, 0.10, 'PVC Schedule 20',
 ARRAY['PVC Casing 4" diameter', 'Rope Pump System', 'Well Head Protection', 'Manual Tools'],
 ARRAY['Hand Drilling Tools', 'Rope Pump Kit', 'Basic Construction Tools'],
 12, 'WQ-CD-2023-123', 'Village Council Approval',
 'Completed', 3, '2023-04-18', 'Village-built well using local labor and training. Cost-effective solution.'),

-- well_click_test (Test Well at Click Location)
('well_click_test', 'well', 'Test Drilling Services', 'TDS-2023-TEST', '+235 99 00 11 22',
 'Test Drilling for Location Verification', '2023-09-01', '2023-09-15', 14,
 5500.00, 25.0, 0.12, 'Temporary PVC Casing',
 ARRAY['PVC Casing 5" diameter', 'Test Pump', 'Basic Equipment'],
 ARRAY['Portable Drilling Rig', 'Test Equipment'],
 6, 'WQ-CD-2023-TEST', 'Test Location Permit',
 'Completed', 3, '2023-09-18', 'Test well for click location functionality demonstration.'),

-- well_adre_area (Adre Area Test Well) - already exists as adre_area_test_well, but need well_adre_area
('well_adre_area', 'well', 'Exploration Water Services', 'EWS-2023-078', '+235 99 22 11 88',
 'Test Drilling with Temporary Pump', '2023-06-15', '2023-07-10', 25,
 8500.00, 28.5, 0.12, 'Temporary PVC Casing',
 ARRAY['PVC Casing 5" diameter', 'Temporary Pump', 'Flow Meter', 'Water Samples'],
 ARRAY['Portable Drilling Rig', 'Testing Equipment', 'Sample Collection Kit'],
 6, 'WQ-CD-2023-078', 'Exploratory Drilling Permit',
 'Completed', 3, '2023-07-12', 'Exploratory well for aquifer assessment. Limited production capacity.'),

-- well_north_chad (Northern Chad Test Well) - already exists as northern_chad_test_well, but need well_north_chad
('well_north_chad', 'well', 'Desert Exploration Co.', 'DEC-2023-456', '+235 99 44 55 66',
 'Exploration Drilling with Monitoring Equipment', '2023-05-01', '2023-06-15', 45,
 18900.00, 68.0, 0.15, 'PVC with Monitoring Equipment',
 ARRAY['PVC Casing 6" diameter', 'Data Loggers', 'Pressure Sensors', 'Sampling Equipment'],
 ARRAY['Exploration Drilling Rig', 'Monitoring Equipment', 'Data Collection Systems'],
 18, 'WQ-CD-2023-456', 'Research and Development Permit',
 'Completed', 4, '2023-06-18', 'Research well for aquifer studies. Equipped with continuous monitoring systems.');

-- Insert construction details for missing borehole IDs
INSERT INTO feature_construction_details (
    feature_id, feature_type, contractor_name, contractor_license, contractor_contact,
    construction_method, construction_start_date, construction_end_date, construction_duration_days,
    construction_cost, depth_m, diameter_m, lining_material, materials_used, equipment_used,
    warranty_period_months, quality_certificate_number, environmental_compliance,
    project_status, quality_rating, final_inspection_date, additional_notes
) VALUES
-- borehole_1 (Central Chad Borehole 1) - already exists as central_chad_borehole_1, but need borehole_1
('borehole_1', 'borehole', 'Chad Drilling Consortium', 'CDC-2023-345', '+235 99 87 65 43',
 'Rotary Drilling with Multi-Zone Completion', '2023-02-15', '2023-05-30', 104,
 72400.00, 125.0, 0.30, 'Multi-Zone Steel Casing',
 ARRAY['Steel Casing 12" diameter', 'Zone Isolation Packers', 'Multi-Level Pump', 'Control Valves'],
 ARRAY['Rotary Drilling Rig', 'Zone Completion Equipment', 'Multi-Pump System'],
 48, 'WQ-CD-2023-345', 'Multi-Zone Aquifer Development',
 'Completed', 5, '2023-06-05', 'Advanced borehole with multiple aquifer zones. Optimized water production.'),

-- borehole_2 (Eastern Chad Borehole) - already exists as eastern_chad_borehole, but need borehole_2
('borehole_2', 'borehole', 'Eastern Development Corp', 'EDC-2022-890', '+235 99 55 44 33',
 'Percussion Drilling with Solar Pumping', '2022-12-01', '2023-03-20', 109,
 54800.00, 95.8, 0.25, 'PVC Casing with Solar Integration',
 ARRAY['PVC Casing 10" diameter', 'Solar Panel Array', 'Battery Bank', 'Inverter System'],
 ARRAY['Percussion Drilling Rig', 'Solar Installation Equipment', 'Electrical Components'],
 36, 'WQ-CD-2022-890', 'Renewable Energy Integration Approval',
 'Completed', 4, '2023-03-25', 'Solar-powered borehole system. Sustainable and environmentally friendly.'),

-- borehole_3 (Northern Chad Borehole) - already exists as northern_chad_borehole, but need borehole_3
('borehole_3', 'borehole', 'Northern Development Agency', 'NDA-2023-234', '+235 99 77 66 55',
 'Desert Drilling with Wind Power', '2023-01-10', '2023-04-25', 105,
 62100.00, 88.5, 0.22, 'Corrosion-Resistant Steel',
 ARRAY['Stainless Steel Casing 9" diameter', 'Wind Turbine', 'Pump Controller', 'Storage Tank'],
 ARRAY['Desert Drilling Rig', 'Wind Power Installation', 'Storage Equipment'],
 36, 'WQ-CD-2023-234', 'Desert Environment Compliance',
 'Completed', 4, '2023-04-30', 'Wind-powered borehole for desert communities. Adapted for harsh conditions.'),

-- borehole_4 (Abeche Deep Borehole) - already exists as abeche_deep_borehole, but need borehole_4
('borehole_4', 'borehole', 'Deep Aquifer Specialists', 'DAS-2022-678', '+235 99 12 34 56',
 'Deep Rotary Drilling with Advanced Logging', '2022-10-01', '2023-01-15', 106,
 85600.00, 180.5, 0.35, 'Steel Casing with Gravel Pack',
 ARRAY['Steel Casing 14" diameter', 'Gravel Pack', 'Bentonite Seal', 'Submersible Pump System'],
 ARRAY['Heavy Duty Drilling Rig', 'Geological Logging Equipment', 'Pump Installation Rig'],
 60, 'WQ-CD-2022-678', 'Deep Aquifer Exploitation Permit',
 'Completed', 5, '2023-01-20', 'Deep borehole accessing confined aquifer. High yield with excellent water quality.'),

-- borehole_5 (Guereda Agricultural Borehole) - already exists as guereda_agricultural_borehole, but need borehole_5
('borehole_5', 'borehole', 'Agricultural Water Solutions', 'AWS-2023-567', '+235 99 22 11 88',
 'Agricultural Drilling with Irrigation System', '2023-04-01', '2023-07-15', 105,
 68200.00, 110.0, 0.28, 'Agricultural Grade Steel Casing',
 ARRAY['Steel Casing 11" diameter', 'Irrigation Pump', 'Distribution Network', 'Control Systems'],
 ARRAY['Agricultural Drilling Rig', 'Irrigation Equipment', 'Network Installation Tools'],
 42, 'WQ-CD-2023-567', 'Agricultural Development Permit',
 'Completed', 4, '2023-07-20', 'Agricultural borehole with irrigation system. Supports local farming operations.'),

-- borehole_north_chad (Northern Chad Test Borehole) - already exists as northern_chad_test_borehole, but need borehole_north_chad
('borehole_north_chad', 'borehole', 'Geological Survey Chad', 'GSC-2023-456', '+235 99 33 22 77',
 'Research Drilling with Monitoring', '2023-03-15', '2023-06-30', 107,
 45600.00, 150.0, 0.20, 'Research Grade Equipment',
 ARRAY['Monitoring Casing 8" diameter', 'Data Collection Equipment', 'Sample Ports', 'Logging Instruments'],
 ARRAY['Research Drilling Rig', 'Geological Logging Equipment', 'Monitoring Installation'],
 24, 'WQ-CD-2023-456', 'Geological Research Permit',
 'Completed', 5, '2023-07-05', 'Research borehole for geological and hydrological studies. Scientific monitoring.');

-- Insert construction details for missing pond IDs  
INSERT INTO feature_construction_details (
    feature_id, feature_type, contractor_name, contractor_license, contractor_contact,
    construction_method, construction_start_date, construction_end_date, construction_duration_days,
    construction_cost, depth_m, length_m, width_m, lining_material, materials_used, equipment_used,
    warranty_period_months, quality_certificate_number, environmental_compliance,
    project_status, quality_rating, final_inspection_date, additional_notes
) VALUES
-- pond_1 (Lake Chad Retention Pond) - already exists as lake_chad_retention_pond, but need pond_1
('pond_1', 'pond', 'Lake Chad Basin Authority', 'LCBA-2023-890', '+235 99 87 65 43',
 'Large Scale Excavation with Multi-Layer Lining', '2023-01-15', '2023-06-30', 166,
 125600.00, 5.5, 120.0, 80.0, 'Multi-Layer Composite',
 ARRAY['Clay Base Layer', 'Geomembrane Liner', 'Protection Layer', 'Wave Protection'],
 ARRAY['Fleet of Excavators', 'Liner Installation Crew', 'Quality Control Equipment'],
 60, 'WQ-CD-2023-890', 'Lake Chad Basin Management',
 'Completed', 5, '2023-07-05', 'Large retention pond connected to Lake Chad. Critical water infrastructure.'),

-- pond_2 (Chari River Pond) - already exists as chari_river_pond, but need pond_2
('pond_2', 'pond', 'River Management Authority', 'RMA-2022-567', '+235 99 12 34 56',
 'River-Fed Excavation with Natural Lining', '2022-09-15', '2022-12-10', 86,
 22800.00, 2.8, 50.0, 35.0, 'Natural River Sediment',
 ARRAY['River Sediment', 'Rock Armoring', 'Inlet Channel', 'Fish Ladder'],
 ARRAY['Amphibious Excavator', 'Rock Placement Equipment', 'Channel Tools'],
 18, 'WQ-CD-2022-567', 'River Ecosystem Management',
 'Completed', 4, '2022-12-15', 'River-connected pond supporting ecosystem and water supply. Fish habitat included.'),

-- pond_3 (Logone Valley Pond) - already exists as logone_valley_pond, but need pond_3
('pond_3', 'pond', 'Valley Development Corp', 'VDC-2022-345', '+235 99 55 44 33',
 'Valley Excavation with Flood Control', '2022-10-01', '2023-01-30', 121,
 38900.00, 4.0, 65.0, 45.0, 'Clay with Flood Barriers',
 ARRAY['Compacted Clay', 'Flood Barriers', 'Spillway', 'Access Roads'],
 ARRAY['Heavy Excavator', 'Barrier Construction', 'Road Equipment'],
 30, 'WQ-CD-2022-345', 'Flood Management Integration',
 'Completed', 4, '2023-02-05', 'Valley pond with integrated flood control. Seasonal water management.'),

-- pond_4 (Abeche Seasonal Pond) - already exists as abeche_seasonal_pond, but need pond_4
('pond_4', 'pond', 'Pond Construction Specialists', 'PCS-2022-123', '+235 99 88 99 00',
 'Excavation with Clay Lining', '2022-11-01', '2023-01-20', 80,
 28500.00, 3.5, 45.0, 30.0, 'Compacted Clay with Bentonite',
 ARRAY['Bentonite Clay', 'Gravel Base', 'Overflow Pipe', 'Access Ramp'],
 ARRAY['Excavator', 'Compaction Equipment', 'Survey Equipment', 'Pipe Installation'],
 24, 'WQ-CD-2022-123', 'Seasonal Water Storage Permit',
 'Completed', 4, '2023-01-25', 'Seasonal pond for rainwater harvesting. Clay lining prevents seepage.'),

-- pond_5 (Adre Water Reserve) - already exists as adre_water_reserve, but need pond_5
('pond_5', 'pond', 'Water Storage Solutions', 'WSS-2023-789', '+235 99 11 22 33',
 'Engineered Excavation with Synthetic Liner', '2023-02-01', '2023-04-30', 88,
 45200.00, 4.2, 60.0, 40.0, 'HDPE Geomembrane Liner',
 ARRAY['HDPE Liner 2mm', 'Geotextile Protection', 'Inlet Structure', 'Outlet Control'],
 ARRAY['Large Excavator', 'Liner Installation Equipment', 'Welding Equipment'],
 36, 'WQ-CD-2023-789', 'Water Reserve Development Permit',
 'Completed', 5, '2023-05-05', 'Large water reserve with synthetic liner. Long-term water storage capacity.'),

-- pond_adre_area (Adre Area Test Pond) - already exists as adre_area_test_pond, but need pond_adre_area
('pond_adre_area', 'pond', 'Experimental Water Systems', 'EWS-2023-456', '+235 99 44 55 66',
 'Test Excavation with Monitoring', '2023-05-15', '2023-07-10', 56,
 18200.00, 2.0, 25.0, 15.0, 'Natural Clay with Monitoring',
 ARRAY['Natural Clay Lining', 'Water Level Sensors', 'Quality Monitors', 'Sampling Points'],
 ARRAY['Mini Excavator', 'Monitoring Equipment', 'Installation Tools'],
 12, 'WQ-CD-2023-456', 'Experimental Water Project',
 'Completed', 3, '2023-07-15', 'Test pond for water storage experiments. Equipped with monitoring systems.');