-- Corrected Comprehensive Sample Data for Construction Details, Water Quality Reports, and Maintenance Activities
-- For all wells, boreholes, and ponds in the Chad Water Infrastructure System

-- Water Quality Reports for Wells (with feature_type)
INSERT INTO feature_water_quality_reports (
    feature_id, feature_type, test_date, ph_level, turbidity, tds_ppm, conductivity, temperature,
    coliform_count, ecoli_count, overall_quality, testing_laboratory, 
    recommended_treatment, next_test_due_date, notes
) VALUES
-- Abeche Community Well - Multiple test dates
('abeche_community_well', 'well', '2023-03-15', 7.1, 1.2, 280, 420, 27.5, 2, 0, 'good', 'Chad National Water Quality Lab', 'Monthly chlorination', '2023-09-15', 'Minor coliform detection, treatment recommended'),
('abeche_community_well', 'well', '2023-06-15', 7.3, 0.8, 265, 398, 28.2, 0, 0, 'excellent', 'Chad National Water Quality Lab', 'Continue current maintenance', '2023-12-15', 'Quality improved after treatment'),
('abeche_community_well', 'well', '2023-09-15', 7.2, 1.0, 275, 412, 26.8, 1, 0, 'good', 'Chad National Water Quality Lab', 'Quarterly monitoring', '2024-03-15', 'Stable water quality maintained'),

-- Abeche Deep Well
('abeche_deep_well', 'well', '2022-12-01', 7.4, 0.5, 220, 335, 25.0, 0, 0, 'excellent', 'Chad National Water Quality Lab', 'No treatment required', '2023-06-01', 'Deep aquifer provides excellent quality'),
('abeche_deep_well', 'well', '2023-06-01', 7.3, 0.6, 225, 340, 25.5, 0, 0, 'excellent', 'Chad National Water Quality Lab', 'Annual monitoring sufficient', '2024-06-01', 'Consistently excellent quality'),

-- Adre Border Well
('adre_border_well', 'well', '2023-05-30', 7.0, 1.5, 295, 445, 29.0, 3, 1, 'fair', 'Cross-Border Lab Services', 'Disinfection and filtration', '2023-11-30', 'Higher mineralization, treatment needed'),
('adre_border_well', 'well', '2023-08-30', 7.2, 1.0, 285, 430, 28.5, 1, 0, 'good', 'Cross-Border Lab Services', 'Continue treatment', '2024-02-28', 'Improvement after treatment implementation'),

-- Doba Community Well
('doba_community_well', 'well', '2023-01-10', 6.9, 2.0, 315, 472, 30.2, 5, 2, 'fair', 'Southern Chad Lab', 'Immediate disinfection required', '2023-07-10', 'Elevated bacteria levels detected'),
('doba_community_well', 'well', '2023-04-10', 7.1, 1.5, 305, 458, 29.8, 2, 0, 'good', 'Southern Chad Lab', 'Monthly disinfection', '2023-10-10', 'Bacterial levels reduced'),
('doba_community_well', 'well', '2023-07-10', 7.2, 1.2, 298, 447, 29.5, 1, 0, 'good', 'Southern Chad Lab', 'Continue monitoring', '2024-01-10', 'Stable improvement maintained'),

-- Additional wells
('guereda_village_well', 'well', '2023-04-25', 7.0, 2.5, 340, 510, 31.0, 8, 2, 'fair', 'Village Testing Cooperative', 'Local disinfection methods', '2023-10-25', 'Village-managed well, local treatment methods applied'),
('moundou_community_well', 'well', '2023-04-20', 7.4, 0.9, 258, 387, 28.5, 1, 0, 'good', 'Municipal Lab Services', 'Monthly monitoring', '2023-10-20', 'Municipal system maintains good quality'),
('ndjamena_community_well_1', 'well', '2022-11-15', 7.6, 0.4, 195, 293, 26.0, 0, 0, 'excellent', 'Capital City Lab', 'Automated monitoring', '2023-11-15', 'Advanced system maintains excellent quality'),
('northern_chad_test_well', 'well', '2023-06-25', 7.2, 1.1, 275, 413, 29.5, 2, 0, 'good', 'Research Laboratory', 'Research-grade treatment', '2023-12-25', 'Research well with monitoring equipment'),
('sarh_traditional_well', 'well', '2023-03-20', 6.8, 3.0, 385, 578, 30.5, 12, 3, 'poor', 'Traditional Water Testing', 'Traditional purification methods', '2023-09-20', 'Traditional well requires conventional treatment');

-- Water Quality Reports for Boreholes
INSERT INTO feature_water_quality_reports (
    feature_id, feature_type, test_date, ph_level, turbidity, tds_ppm, conductivity, temperature,
    coliform_count, ecoli_count, overall_quality, testing_laboratory, 
    recommended_treatment, next_test_due_date, notes
) VALUES
-- Abeche Deep Borehole
('abeche_deep_borehole', 'borehole', '2023-02-01', 7.8, 0.3, 185, 280, 23.5, 0, 0, 'excellent', 'Deep Aquifer Testing Lab', 'No treatment required', '2024-02-01', 'Pristine deep aquifer water'),
('abeche_deep_borehole', 'borehole', '2023-08-01', 7.7, 0.4, 190, 285, 24.0, 0, 0, 'excellent', 'Deep Aquifer Testing Lab', 'Annual monitoring', '2024-08-01', 'Consistent excellent quality'),

-- Central Chad Borehole 1
('central_chad_borehole_1', 'borehole', '2023-06-15', 7.5, 0.7, 245, 365, 26.2, 0, 0, 'excellent', 'Multi-Zone Analysis Lab', 'Selective zone monitoring', '2024-06-15', 'Multi-zone completion provides optimal quality'),
('central_chad_borehole_1', 'borehole', '2023-09-15', 7.6, 0.6, 240, 360, 25.8, 0, 0, 'excellent', 'Multi-Zone Analysis Lab', 'Continue selective pumping', '2024-12-15', 'Zone isolation maintaining quality'),

-- Eastern Chad Borehole
('eastern_chad_borehole', 'borehole', '2023-04-01', 7.3, 0.9, 265, 398, 27.8, 0, 0, 'excellent', 'Solar System Water Lab', 'UV sterilization available', '2023-10-01', 'Solar UV system provides additional safety'),
('eastern_chad_borehole', 'borehole', '2023-07-01', 7.4, 0.8, 260, 390, 28.2, 0, 0, 'excellent', 'Solar System Water Lab', 'UV system functioning well', '2024-01-01', 'Solar disinfection effective'),

-- Additional boreholes
('guereda_agricultural_borehole', 'borehole', '2023-07-30', 7.5, 0.8, 235, 353, 27.0, 0, 0, 'excellent', 'Agricultural Testing Lab', 'Irrigation quality monitoring', '2024-07-30', 'Excellent quality for agricultural use'),
('northern_chad_borehole', 'borehole', '2023-05-15', 7.3, 1.0, 290, 435, 28.8, 1, 0, 'good', 'Desert Conditions Lab', 'Wind-powered UV treatment', '2023-11-15', 'Wind power system provides additional treatment'),
('northern_chad_test_borehole', 'borehole', '2023-07-20', 7.7, 0.5, 210, 315, 24.5, 0, 0, 'excellent', 'Geological Research Lab', 'Research monitoring only', '2024-07-20', 'Research-grade monitoring and analysis');

-- Water Quality Reports for Ponds
INSERT INTO feature_water_quality_reports (
    feature_id, feature_type, test_date, ph_level, turbidity, tds_ppm, conductivity, temperature,
    coliform_count, ecoli_count, overall_quality, testing_laboratory, 
    recommended_treatment, next_test_due_date, notes
) VALUES
-- Abeche Seasonal Pond
('abeche_seasonal_pond', 'pond', '2023-02-15', 8.2, 15.0, 450, 675, 22.0, 25, 8, 'poor', 'Surface Water Testing Lab', 'Multi-stage treatment required', '2023-05-15', 'Seasonal pond requires treatment before use'),
('abeche_seasonal_pond', 'pond', '2023-05-15', 7.8, 12.0, 420, 630, 25.5, 15, 3, 'fair', 'Surface Water Testing Lab', 'Coagulation and disinfection', '2023-08-15', 'Improvement with settling time'),
('abeche_seasonal_pond', 'pond', '2023-08-15', 7.6, 8.0, 385, 578, 28.0, 8, 1, 'fair', 'Surface Water Testing Lab', 'Disinfection before use', '2023-11-15', 'Quality improves during dry season'),

-- Lake Chad Retention Pond
('lake_chad_retention_pond', 'pond', '2023-07-15', 8.0, 8.5, 380, 570, 29.5, 12, 2, 'fair', 'Lake Chad Monitoring Station', 'Sedimentation and chlorination', '2023-10-15', 'Large volume provides natural treatment'),
('lake_chad_retention_pond', 'pond', '2023-10-15', 7.9, 7.0, 365, 548, 27.0, 8, 1, 'good', 'Lake Chad Monitoring Station', 'Basic disinfection', '2024-01-15', 'Natural processes improving quality'),

-- Chari River Pond
('chari_river_pond', 'pond', '2023-01-01', 7.5, 12.0, 395, 593, 24.0, 18, 4, 'fair', 'River System Lab', 'Biological treatment recommended', '2023-04-01', 'River connection maintains flow'),
('chari_river_pond', 'pond', '2023-04-01', 7.6, 10.0, 385, 578, 26.5, 12, 2, 'fair', 'River System Lab', 'Continue biological treatment', '2023-07-01', 'Fish population helping with biological treatment'),
('chari_river_pond', 'pond', '2023-07-01', 7.7, 8.5, 375, 563, 28.8, 8, 1, 'good', 'River System Lab', 'Maintenance of ecosystem', '2023-10-01', 'Ecosystem approach showing results'),

-- Additional ponds
('adre_water_reserve', 'pond', '2023-05-20', 7.8, 5.0, 320, 480, 26.0, 10, 1, 'fair', 'Reserve Management Lab', 'Multi-stage treatment system', '2023-11-20', 'Large reserve requires treatment before distribution'),
('adre_area_test_pond', 'pond', '2023-07-25', 8.1, 8.0, 365, 548, 27.5, 15, 3, 'fair', 'Experimental Water Lab', 'Test treatment protocols', '2023-10-25', 'Experimental treatments being evaluated'),
('central_chad_test_pond', 'pond', '2023-05-30', 7.7, 3.0, 295, 443, 28.0, 5, 1, 'good', 'Municipal Testing Center', 'Concrete pond maintenance', '2023-11-30', 'Concrete lining maintains good quality'),
('logone_valley_pond', 'pond', '2023-02-15', 7.9, 10.0, 420, 630, 25.0, 20, 5, 'poor', 'Valley Management Lab', 'Flood management treatment', '2023-08-15', 'Valley flooding affects seasonal quality');

-- Maintenance Activities for Wells (with proper empty arrays)
INSERT INTO feature_maintenance_activities (
    feature_id, feature_type, activity_date, activity_type, activity_status, priority,
    cost, duration_hours, technician, description, parts_replaced, equipment_used,
    effectiveness_rating, next_maintenance_date, notes
) VALUES
-- Abeche Community Well
('abeche_community_well', 'well', '2023-04-15', 'Hand Pump Repair', 'completed', 'high', 350.00, 4, 'Local Technician - Abakar Ahmed', 'Hand pump cylinder replacement and seal maintenance', ARRAY['Pump Cylinder', 'Rubber Seals'], ARRAY['Hand Tools', 'Pump Jack'], 4, '2023-10-15', 'Pump efficiency restored to 90%'),
('abeche_community_well', 'well', '2023-07-20', 'Well Head Cleaning', 'completed', 'medium', 150.00, 2, 'Community Volunteer - Fatima Hassan', 'Well head sanitization and protective cover repair', ARRAY['Cleaning Supplies', 'Cover Repair Kit'], ARRAY['Cleaning Equipment', 'Basic Tools'], 4, '2024-01-20', 'Improved hygiene and protection'),
('abeche_community_well', 'well', '2023-10-15', 'Quarterly Inspection', 'completed', 'low', 100.00, 3, 'Regional Inspector - Mohamed Saleh', 'Routine quarterly safety and performance inspection', ARRAY[]::text[], ARRAY['Inspection Tools', 'Water Testing Kit'], 4, '2024-01-15', 'All systems functioning normally'),

-- Abeche Deep Well
('abeche_deep_well', 'well', '2023-01-10', 'Submersible Pump Service', 'completed', 'medium', 2200.00, 8, 'Pump Specialist - Ali Mahmoud', 'Annual submersible pump inspection and motor service', ARRAY['Motor Bearings', 'Impeller'], ARRAY['Pump Hoist', 'Motor Testing Equipment'], 5, '2024-01-10', 'Pump performance optimized, efficiency increased 12%'),
('abeche_deep_well', 'well', '2023-06-15', 'Control Panel Upgrade', 'completed', 'low', 850.00, 6, 'Electrical Technician - Ibrahim Yousif', 'Control panel modernization and safety improvements', ARRAY['Control Relays', 'Safety Switches'], ARRAY['Electrical Tools', 'Testing Equipment'], 4, '2025-06-15', 'Enhanced safety and automated controls'),
('abeche_deep_well', 'well', '2024-01-10', 'Annual Comprehensive Service', 'scheduled', 'medium', 2800.00, 12, 'Deep Well Team - Specialized Crew', 'Complete system inspection, pump service, and performance testing', ARRAY['TBD based on inspection'], ARRAY['Full Service Equipment'], NULL, '2025-01-10', 'Comprehensive annual maintenance scheduled'),

-- Additional well maintenance activities
('guereda_village_well', 'well', '2023-05-10', 'Rope Pump Maintenance', 'completed', 'medium', 180.00, 3, 'Village Technician - Haroun Moussa', 'Rope pump system maintenance and rope replacement', ARRAY['Pump Rope', 'Pulley Bearings'], ARRAY['Village Tools', 'Rope Installation Kit'], 3, '2023-11-10', 'Village-managed maintenance successful'),
('moundou_community_well', 'well', '2023-05-15', 'Electric Pump Service', 'completed', 'high', 1200.00, 6, 'Municipal Electrician - Jean-Claude Ngarta', 'Electric pump motor service and electrical system check', ARRAY['Motor Capacitor', 'Electrical Contacts'], ARRAY['Electrical Testing Equipment'], 4, '2024-05-15', 'Municipal system efficiency improved'),
('ndjamena_community_well_1', 'well', '2022-12-10', 'SCADA System Update', 'completed', 'low', 2500.00, 8, 'Automation Specialist - Advanced Systems Team', 'SCADA system software update and sensor calibration', ARRAY['Software License', 'Sensor Calibration Kit'], ARRAY['Computer Equipment', 'Calibration Tools'], 5, '2023-12-10', 'Automated monitoring system optimized'),
('northern_chad_test_well', 'well', '2023-07-05', 'Monitoring Equipment Service', 'completed', 'medium', 950.00, 4, 'Research Technician - Dr. Amina Bashir', 'Data logger service and monitoring equipment calibration', ARRAY['Data Logger Battery', 'Sensor Cables'], ARRAY['Calibration Equipment', 'Data Tools'], 4, '2024-07-05', 'Research monitoring equipment functioning perfectly'),
('sarh_traditional_well', 'well', '2023-04-01', 'Traditional Well Restoration', 'completed', 'high', 400.00, 8, 'Traditional Well Master - Elder Brahim', 'Stone work repair and traditional safety improvements', ARRAY['Natural Stone', 'Traditional Mortar'], ARRAY['Traditional Tools', 'Stone Working Equipment'], 3, '2024-04-01', 'Traditional methods preserve cultural heritage');

-- Maintenance Activities for Boreholes
INSERT INTO feature_maintenance_activities (
    feature_id, feature_type, activity_date, activity_type, activity_status, priority,
    cost, duration_hours, technician, description, parts_replaced, equipment_used,
    effectiveness_rating, next_maintenance_date, notes
) VALUES
-- Abeche Deep Borehole
('abeche_deep_borehole', 'borehole', '2023-03-01', 'Deep Pump Overhaul', 'completed', 'high', 8500.00, 16, 'Deep Drilling Specialist - Hassan Mahamat', 'Complete pump system overhaul and performance optimization', ARRAY['Pump Assembly', 'Drive Shaft', 'Pump Controller'], ARRAY['Heavy Lifting Equipment', 'Pump Testing Rig'], 5, '2024-03-01', 'Pump performance increased 18%, excellent condition'),
('abeche_deep_borehole', 'borehole', '2023-08-15', 'Geological Monitoring', 'completed', 'low', 1200.00, 6, 'Hydrogeologist - Dr. Khadija Omar', 'Aquifer monitoring and geological assessment', ARRAY[]::text[], ARRAY['Logging Equipment', 'Monitoring Instruments'], 5, '2024-08-15', 'Aquifer stable, excellent recharge rates'),

-- Central Chad Borehole 1
('central_chad_borehole_1', 'borehole', '2023-07-20', 'Multi-Zone System Service', 'completed', 'medium', 4200.00, 12, 'Multi-Zone Specialist - Ahmed Zakaria', 'Zone isolation system inspection and pump synchronization', ARRAY['Zone Packers', 'Control Valves'], ARRAY['Zone Testing Equipment', 'Synchronization Tools'], 5, '2024-07-20', 'All zones operating optimally, perfect isolation'),
('central_chad_borehole_1', 'borehole', '2023-11-10', 'Production Optimization', 'completed', 'low', 1800.00, 8, 'Production Engineer - Mariam Abdallah', 'Flow rate optimization and energy efficiency improvements', ARRAY['Flow Controllers'], ARRAY['Flow Measurement Equipment'], 4, '2024-11-10', 'Energy consumption reduced 12%'),

-- Additional borehole maintenance
('guereda_agricultural_borehole', 'borehole', '2023-08-20', 'Irrigation System Service', 'completed', 'medium', 3200.00, 12, 'Irrigation Specialist - Agricultural Team', 'Irrigation pump service and distribution network maintenance', ARRAY['Irrigation Pumps', 'Distribution Valves'], ARRAY['Irrigation Equipment', 'Network Tools'], 4, '2024-08-20', 'Agricultural irrigation system optimized'),
('northern_chad_borehole', 'borehole', '2023-06-10', 'Wind Power System Service', 'completed', 'medium', 2200.00, 10, 'Wind Energy Technician - Renewable Team', 'Wind turbine maintenance and power system optimization', ARRAY['Wind Turbine Parts', 'Power Controllers'], ARRAY['Wind Service Equipment'], 4, '2024-06-10', 'Wind power system efficiency excellent'),
('northern_chad_test_borehole', 'borehole', '2023-08-15', 'Research Equipment Maintenance', 'completed', 'low', 1500.00, 6, 'Research Equipment Specialist', 'Geological monitoring equipment service and data system update', ARRAY['Monitoring Sensors', 'Data Storage'], ARRAY['Research Equipment'], 5, '2024-08-15', 'Research monitoring systems excellent condition');

-- Maintenance Activities for Ponds
INSERT INTO feature_maintenance_activities (
    feature_id, feature_type, activity_date, activity_type, activity_status, priority,
    cost, duration_hours, technician, description, parts_replaced, equipment_used,
    effectiveness_rating, next_maintenance_date, notes
) VALUES
-- Abeche Seasonal Pond
('abeche_seasonal_pond', 'pond', '2023-03-30', 'Sediment Removal', 'completed', 'high', 2200.00, 24, 'Excavation Team - Pond Specialists', 'Annual sediment removal and capacity restoration', ARRAY[]::text[], ARRAY['Excavator', 'Sediment Removal Equipment'], 4, '2024-03-30', 'Storage capacity restored to 95%'),
('abeche_seasonal_pond', 'pond', '2023-08-15', 'Clay Lining Repair', 'completed', 'medium', 1200.00, 12, 'Lining Specialist - Omar Hassan', 'Clay lining inspection and crack repair', ARRAY['Bentonite Clay', 'Sealant'], ARRAY['Compaction Equipment', 'Repair Tools'], 4, '2024-08-15', 'Lining integrity restored, minimal seepage'),
('abeche_seasonal_pond', 'pond', '2023-11-20', 'Pre-Season Preparation', 'completed', 'low', 400.00, 6, 'Maintenance Crew', 'Inlet cleaning and overflow system check', ARRAY['Filter Media'], ARRAY['Cleaning Equipment'], 3, '2024-05-20', 'Ready for next rainy season'),

-- Additional pond maintenance
('adre_water_reserve', 'pond', '2023-06-15', 'Liner System Inspection', 'completed', 'high', 2800.00, 16, 'Large Pond Specialist Team', 'HDPE liner comprehensive inspection and inlet structure service', ARRAY['Liner Repair Kit', 'Inlet Seals'], ARRAY['Liner Testing Equipment', 'Repair Tools'], 5, '2024-06-15', 'Large reserve liner system in excellent condition'),
('central_chad_test_pond', 'pond', '2023-06-20', 'Concrete Lining Maintenance', 'completed', 'medium', 1800.00, 14, 'Concrete Specialist - Municipal Works', 'Concrete liner crack repair and control structure service', ARRAY['Concrete Repair Material', 'Sealants'], ARRAY['Concrete Repair Equipment'], 4, '2024-06-20', 'Concrete pond structure maintained excellent condition'),
('logone_valley_pond', 'pond', '2023-03-30', 'Flood Control System Check', 'completed', 'high', 2500.00, 20, 'Flood Management Team', 'Spillway maintenance and flood barrier inspection', ARRAY['Spillway Gates', 'Barrier Reinforcement'], ARRAY['Heavy Maintenance Equipment'], 4, '2024-03-30', 'Flood control systems ready for next season');