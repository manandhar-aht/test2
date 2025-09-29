-- Sample Water Quality Reports and Maintenance Activities
-- for Wells, Ponds, and Boreholes

-- ============================================
-- WATER QUALITY REPORTS
-- ============================================

-- Water Quality Reports for Wells
INSERT INTO water_quality_reports (
    report_id, feature_type, feature_id, test_date, ph_level, tds_ppm, hardness_ppm, 
    chloride_ppm, fluoride_ppm, nitrate_ppm, iron_ppm, bacterial_contamination, 
    overall_quality, testing_laboratory, lab_certificate_number, 
    recommended_treatment, next_test_due_date
) VALUES
-- WELL_BNG_001 reports
('WQR_WELL_BNG_001_2024_01', 'well', 'WELL_BNG_001', '2024-01-15', 7.2, 450.5, 180.2, 25.3, 0.8, 15.2, 0.15, false, 'good', 'Central Water Testing Lab', 'CWT-2024-001', 'Minor chlorination recommended', '2024-07-15'),
('WQR_WELL_BNG_001_2024_07', 'well', 'WELL_BNG_001', '2024-07-20', 7.1, 465.3, 175.8, 27.1, 0.9, 16.8, 0.18, false, 'good', 'Central Water Testing Lab', 'CWT-2024-142', 'Continue current treatment', '2025-01-20'),
('WQR_WELL_BNG_001_2025_01', 'well', 'WELL_BNG_001', '2025-01-25', 7.0, 470.2, 182.5, 28.5, 1.0, 17.2, 0.20, false, 'fair', 'Central Water Testing Lab', 'CWT-2025-025', 'Enhanced filtration needed', '2025-07-25'),

-- WELL_BNG_002 reports
('WQR_WELL_BNG_002_2024_02', 'well', 'WELL_BNG_002', '2024-02-10', 6.8, 520.8, 220.5, 35.2, 1.2, 22.5, 0.25, true, 'poor', 'Regional Health Lab', 'RHL-2024-035', 'Immediate disinfection required', '2024-05-10'),
('WQR_WELL_BNG_002_2024_08', 'well', 'WELL_BNG_002', '2024-08-15', 7.0, 485.3, 200.8, 30.8, 1.0, 18.5, 0.20, false, 'fair', 'Regional Health Lab', 'RHL-2024-198', 'Continued monitoring needed', '2025-02-15'),
('WQR_WELL_BNG_002_2025_02', 'well', 'WELL_BNG_002', '2025-02-20', 7.2, 465.2, 195.3, 28.9, 0.9, 16.8, 0.18, false, 'good', 'Regional Health Lab', 'RHL-2025-045', 'Quality improved, maintain protocol', '2025-08-20'),

-- WELL_BNG_003 reports
('WQR_WELL_BNG_003_2024_03', 'well', 'WELL_BNG_003', '2024-03-05', 8.1, 380.2, 120.5, 18.3, 0.5, 8.2, 0.08, false, 'excellent', 'National Water Institute', 'NWI-2024-078', 'No treatment required', '2024-09-05'),
('WQR_WELL_BNG_003_2024_09', 'well', 'WELL_BNG_003', '2024-09-10', 8.0, 385.8, 125.2, 19.1, 0.6, 9.1, 0.10, false, 'excellent', 'National Water Institute', 'NWI-2024-245', 'Maintain excellent standards', '2025-03-10'),
('WQR_WELL_BNG_003_2025_03', 'well', 'WELL_BNG_003', '2025-03-15', 7.9, 390.5, 128.8, 20.2, 0.7, 9.8, 0.12, false, 'excellent', 'National Water Institute', 'NWI-2025-067', 'Excellent quality maintained', '2025-09-15'),

-- WELL_MYS_001 reports
('WQR_WELL_MYS_001_2024_04', 'well', 'WELL_MYS_001', '2024-04-12', 7.5, 320.8, 95.5, 12.8, 0.3, 5.2, 0.05, false, 'excellent', 'Mysore Water Labs', 'MWL-2024-089', 'Excellent source, no treatment needed', '2024-10-12'),
('WQR_WELL_MYS_001_2024_10', 'well', 'WELL_MYS_001', '2024-10-18', 7.4, 325.3, 98.2, 13.5, 0.4, 5.8, 0.06, false, 'excellent', 'Mysore Water Labs', 'MWL-2024-278', 'Continue monitoring', '2025-04-18'),
('WQR_WELL_MYS_001_2025_04', 'well', 'WELL_MYS_001', '2025-04-22', 7.6, 318.9, 93.8, 12.2, 0.3, 4.9, 0.04, false, 'excellent', 'Mysore Water Labs', 'MWL-2025-098', 'Outstanding water quality', '2025-10-22'),

-- WELL_MYS_002 reports
('WQR_WELL_MYS_002_2024_05', 'well', 'WELL_MYS_002', '2024-05-08', 7.8, 420.5, 155.8, 22.3, 0.7, 12.5, 0.12, false, 'good', 'Mysore Water Labs', 'MWL-2024-125', 'Good quality, minor monitoring', '2024-11-08'),
('WQR_WELL_MYS_002_2024_11', 'well', 'WELL_MYS_002', '2024-11-15', 7.7, 425.8, 158.3, 23.1, 0.8, 13.2, 0.14, false, 'good', 'Mysore Water Labs', 'MWL-2024-298', 'Stable quality maintained', '2025-05-15'),
('WQR_WELL_MYS_002_2025_05', 'well', 'WELL_MYS_002', '2025-05-20', 7.9, 415.2, 152.5, 21.8, 0.6, 11.8, 0.11, false, 'good', 'Mysore Water Labs', 'MWL-2025-125', 'Quality improvement noted', '2025-11-20'),

-- WELL_CHAD_001 reports
('WQR_WELL_CHAD_001_2024_06', 'well', 'WELL_CHAD_001', '2024-06-03', 6.5, 680.5, 320.8, 55.2, 1.8, 35.5, 0.35, true, 'poor', 'Chad National Lab', 'CNL-2024-156', 'Urgent treatment and disinfection required', '2024-09-03'),
('WQR_WELL_CHAD_001_2024_12', 'well', 'WELL_CHAD_001', '2024-12-08', 6.8, 620.3, 285.5, 48.8, 1.5, 28.2, 0.28, false, 'fair', 'Chad National Lab', 'CNL-2024-334', 'Improvement after treatment, continue monitoring', '2025-06-08'),
('WQR_WELL_CHAD_001_2025_06', 'well', 'WELL_CHAD_001', '2025-06-12', 7.0, 580.8, 265.2, 42.5, 1.2, 25.8, 0.25, false, 'fair', 'Chad National Lab', 'CNL-2025-145', 'Continued improvement trend', '2025-12-12'),

-- WELL_AGADEZ_001 reports
('WQR_WELL_AGADEZ_001_2024_07', 'well', 'WELL_AGADEZ_001', '2024-07-14', 8.3, 280.2, 85.5, 8.8, 0.2, 3.2, 0.03, false, 'excellent', 'Agadez Regional Lab', 'ARL-2024-189', 'Exceptional quality, minimal treatment', '2025-01-14'),
('WQR_WELL_AGADEZ_001_2025_01', 'well', 'WELL_AGADEZ_001', '2025-01-18', 8.2, 285.8, 88.2, 9.2, 0.3, 3.8, 0.04, false, 'excellent', 'Agadez Regional Lab', 'ARL-2025-018', 'Excellent standards maintained', '2025-07-18'),
('WQR_WELL_AGADEZ_001_2025_07', 'well', 'WELL_AGADEZ_001', '2025-07-22', 8.4, 275.5, 82.8, 8.2, 0.2, 2.9, 0.02, false, 'excellent', 'Agadez Regional Lab', 'ARL-2025-189', 'Outstanding desert well quality', '2026-01-22'),

-- Water Quality Reports for Ponds
-- POND_LALBAGH reports
('WQR_POND_LALBAGH_2024_01', 'pond', 'POND_LALBAGH', '2024-01-20', 7.8, 380.5, 140.2, 20.3, 0.6, 10.2, 0.08, false, 'good', 'Bangalore Environment Lab', 'BEL-2024-020', 'Algae control recommended', '2024-04-20'),
('WQR_POND_LALBAGH_2024_07', 'pond', 'POND_LALBAGH', '2024-07-25', 7.6, 420.8, 165.5, 28.2, 0.8, 15.5, 0.12, false, 'fair', 'Bangalore Environment Lab', 'BEL-2024-185', 'Increased organic matter, treatment needed', '2024-10-25'),
('WQR_POND_LALBAGH_2025_01', 'pond', 'POND_LALBAGH', '2025-01-30', 7.9, 365.2, 135.8, 18.5, 0.5, 8.8, 0.07, false, 'good', 'Bangalore Environment Lab', 'BEL-2025-030', 'Quality improved after treatment', '2025-04-30'),

-- POND_VRISH_01 reports
('WQR_POND_VRISH_01_2024_02', 'pond', 'POND_VRISH_01', '2024-02-15', 8.1, 320.5, 110.8, 15.2, 0.4, 6.5, 0.05, false, 'excellent', 'Rural Water Testing', 'RWT-2024-045', 'Excellent pond water quality', '2024-08-15'),
('WQR_POND_VRISH_01_2024_08', 'pond', 'POND_VRISH_01', '2024-08-20', 7.9, 335.8, 118.5, 17.8, 0.5, 7.8, 0.06, false, 'good', 'Rural Water Testing', 'RWT-2024-225', 'Slight quality decrease, monitoring needed', '2025-02-20'),
('WQR_POND_VRISH_01_2025_02', 'pond', 'POND_VRISH_01', '2025-02-25', 8.0, 325.2, 115.2, 16.5, 0.4, 7.2, 0.05, false, 'excellent', 'Rural Water Testing', 'RWT-2025-055', 'Quality restored to excellent', '2025-08-25'),

-- POND_MYSORE_CENTRAL reports
('WQR_POND_MYSORE_CENTRAL_2024_03', 'pond', 'POND_MYSORE_CENTRAL', '2024-03-10', 7.2, 480.5, 220.8, 35.2, 1.0, 18.5, 0.18, false, 'fair', 'Mysore Municipal Lab', 'MML-2024-068', 'Urban pollution impact, treatment required', '2024-06-10'),
('WQR_POND_MYSORE_CENTRAL_2024_09', 'pond', 'POND_MYSORE_CENTRAL', '2024-09-15', 7.4, 465.2, 210.5, 32.8, 0.9, 16.8, 0.16, false, 'fair', 'Mysore Municipal Lab', 'MML-2024-255', 'Slight improvement noted', '2024-12-15'),
('WQR_POND_MYSORE_CENTRAL_2025_03', 'pond', 'POND_MYSORE_CENTRAL', '2025-03-20', 7.6, 445.8, 195.2, 29.5, 0.8, 14.2, 0.14, false, 'good', 'Mysore Municipal Lab', 'MML-2025-075', 'Quality improvement after interventions', '2025-06-20'),

-- POND_NDJAMENA_01 reports
('WQR_POND_NDJAMENA_01_2024_04', 'pond', 'POND_NDJAMENA_01', '2024-04-05', 6.8, 620.8, 290.5, 48.5, 1.5, 28.2, 0.28, true, 'poor', 'Chad Water Institute', 'CWI-2024-095', 'Contamination detected, immediate treatment', '2024-07-05'),
('WQR_POND_NDJAMENA_01_2024_10', 'pond', 'POND_NDJAMENA_01', '2024-10-12', 7.0, 580.5, 265.8, 42.8, 1.2, 24.5, 0.24, false, 'fair', 'Chad Water Institute', 'CWI-2024-285', 'Treatment effective, continue monitoring', '2025-01-12'),
('WQR_POND_NDJAMENA_01_2025_04', 'pond', 'POND_NDJAMENA_01', '2025-04-08', 7.2, 555.2, 248.5, 38.2, 1.0, 22.8, 0.22, false, 'fair', 'Chad Water Institute', 'CWI-2025-098', 'Gradual quality improvement', '2025-07-08'),

-- POND_AGADEZ_SEASONAL reports
('WQR_POND_AGADEZ_SEASONAL_2024_05', 'pond', 'POND_AGADEZ_SEASONAL', '2024-05-18', 8.5, 250.2, 75.5, 6.8, 0.1, 2.5, 0.02, false, 'excellent', 'Niger Desert Labs', 'NDL-2024-138', 'Seasonal pond, excellent during filling', '2024-08-18'),
('WQR_POND_AGADEZ_SEASONAL_2024_11', 'pond', 'POND_AGADEZ_SEASONAL', '2024-11-22', 9.2, 180.5, 45.2, 4.2, 0.05, 1.8, 0.01, false, 'excellent', 'Niger Desert Labs', 'NDL-2024-315', 'Concentrated but excellent quality', '2025-02-22'),
('WQR_POND_AGADEZ_SEASONAL_2025_05', 'pond', 'POND_AGADEZ_SEASONAL', '2025-05-25', 8.3, 265.8, 82.5, 7.5, 0.2, 3.2, 0.03, false, 'excellent', 'Niger Desert Labs', 'NDL-2025-145', 'New season, maintained quality', '2025-08-25'),

-- Water Quality Reports for Boreholes
-- BH_BNG_001 reports
('WQR_BH_BNG_001_2024_01', 'borehole', 'BH_BNG_001', '2024-01-08', 7.4, 420.5, 165.8, 25.2, 0.7, 12.5, 0.12, false, 'good', 'Geological Survey Lab', 'GSL-2024-008', 'Deep source, good quality', '2024-07-08'),
('WQR_BH_BNG_001_2024_07', 'borehole', 'BH_BNG_001', '2024-07-12', 7.3, 435.8, 172.5, 27.8, 0.8, 14.2, 0.14, false, 'good', 'Geological Survey Lab', 'GSL-2024-185', 'Stable borehole quality', '2025-01-12'),
('WQR_BH_BNG_001_2025_01', 'borehole', 'BH_BNG_001', '2025-01-15', 7.5, 425.2, 168.8, 26.5, 0.7, 13.8, 0.13, false, 'good', 'Geological Survey Lab', 'GSL-2025-015', 'Consistent quality maintained', '2025-07-15'),

-- BH_BNG_002 reports
('WQR_BH_BNG_002_2024_02', 'borehole', 'BH_BNG_002', '2024-02-18', 6.9, 580.5, 285.2, 42.8, 1.3, 25.5, 0.25, false, 'fair', 'Geological Survey Lab', 'GSL-2024-048', 'Higher mineralization, acceptable', '2024-08-18'),
('WQR_BH_BNG_002_2024_08', 'borehole', 'BH_BNG_002', '2024-08-25', 7.1, 565.8, 275.8, 40.2, 1.2, 23.8, 0.23, false, 'fair', 'Geological Survey Lab', 'GSL-2024-235', 'Slight improvement noted', '2025-02-25'),
('WQR_BH_BNG_002_2025_02', 'borehole', 'BH_BNG_002', '2025-02-28', 7.2, 555.2, 268.5, 38.5, 1.1, 22.2, 0.22, false, 'good', 'Geological Survey Lab', 'GSL-2025-058', 'Quality improvement achieved', '2025-08-28'),

-- BH_MYS_001 reports
('WQR_BH_MYS_001_2024_03', 'borehole', 'BH_MYS_001', '2024-03-12', 7.8, 320.5, 98.5, 14.2, 0.4, 6.8, 0.06, false, 'excellent', 'Karnataka Geological Lab', 'KGL-2024-072', 'Excellent aquifer source', '2024-09-12'),
('WQR_BH_MYS_001_2024_09', 'borehole', 'BH_MYS_001', '2024-09-18', 7.7, 325.8, 102.2, 15.5, 0.5, 7.5, 0.07, false, 'excellent', 'Karnataka Geological Lab', 'KGL-2024-258', 'Maintained excellent standards', '2025-03-18'),
('WQR_BH_MYS_001_2025_03', 'borehole', 'BH_MYS_001', '2025-03-22', 7.9, 315.2, 95.8, 13.8, 0.3, 6.2, 0.05, false, 'excellent', 'Karnataka Geological Lab', 'KGL-2025-082', 'Outstanding deep water quality', '2025-09-22'),

-- BH_CHAD_001 reports
('WQR_BH_CHAD_001_2024_04', 'borehole', 'BH_CHAD_001', '2024-04-15', 6.6, 720.8, 350.5, 58.2, 1.8, 38.5, 0.38, true, 'poor', 'Chad Geological Survey', 'CGS-2024-105', 'Deep contamination, treatment essential', '2024-07-15'),
('WQR_BH_CHAD_001_2024_10', 'borehole', 'BH_CHAD_001', '2024-10-20', 6.9, 680.5, 325.8, 52.8, 1.5, 32.2, 0.32, false, 'fair', 'Chad Geological Survey', 'CGS-2024-295', 'Treatment partially effective', '2025-01-20'),
('WQR_BH_CHAD_001_2025_04', 'borehole', 'BH_CHAD_001', '2025-04-25', 7.1, 650.2, 308.5, 48.5, 1.3, 28.8, 0.28, false, 'fair', 'Chad Geological Survey', 'CGS-2025-115', 'Continued improvement trend', '2025-07-25'),

-- BH_AGADEZ_001 reports
('WQR_BH_AGADEZ_001_2024_05', 'borehole', 'BH_AGADEZ_001', '2024-05-22', 8.1, 285.2, 88.5, 9.8, 0.3, 4.2, 0.04, false, 'excellent', 'Niger Geological Institute', 'NGI-2024-142', 'Pristine aquifer, excellent quality', '2024-11-22'),
('WQR_BH_AGADEZ_001_2024_11', 'borehole', 'BH_AGADEZ_001', '2024-11-28', 8.0, 290.8, 92.2, 10.5, 0.4, 4.8, 0.05, false, 'excellent', 'Niger Geological Institute', 'NGI-2024-325', 'Stable excellent quality', '2025-05-28'),
('WQR_BH_AGADEZ_001_2025_05', 'borehole', 'BH_AGADEZ_001', '2025-05-30', 8.2, 280.5, 85.8, 9.2, 0.2, 3.8, 0.03, false, 'excellent', 'Niger Geological Institute', 'NGI-2025-150', 'Exceptional desert aquifer', '2025-11-30');

-- ============================================
-- MAINTENANCE ACTIVITIES
-- ============================================

-- Maintenance Activities for Wells
INSERT INTO maintenance_activities (
    activity_id, feature_type, feature_id, activity_type, scheduled_date, 
    completed_date, maintenance_team, activity_description, cost, 
    materials_used, activity_status, next_maintenance_date, 
    emergency_repair, effectiveness_rating
) VALUES
-- WELL_BNG_001 maintenance
('MAINT_WELL_BNG_001_2024_001', 'well', 'WELL_BNG_001', 'routine_inspection', '2024-01-10', '2024-01-10', 'Bangalore Water Team A', 'Monthly routine inspection and cleaning of well head', 850.00, 'Cleaning agents, basic tools', 'completed', '2024-02-10', false, 4),
('MAINT_WELL_BNG_001_2024_002', 'well', 'WELL_BNG_001', 'pump_maintenance', '2024-03-15', '2024-03-16', 'Technical Services Ltd', 'Pump motor servicing and impeller replacement', 2500.00, 'Motor parts, impeller, lubricants', 'completed', '2024-09-15', false, 5),
('MAINT_WELL_BNG_001_2024_003', 'well', 'WELL_BNG_001', 'water_quality_treatment', '2024-07-20', '2024-07-22', 'Water Treatment Specialists', 'Chlorination system installation and calibration', 3200.00, 'Chlorination equipment, PVC pipes', 'completed', '2025-01-20', false, 4),
('MAINT_WELL_BNG_001_2025_001', 'well', 'WELL_BNG_001', 'routine_inspection', '2025-02-10', '2025-02-10', 'Bangalore Water Team A', 'Quarterly inspection and minor repairs', 950.00, 'Cleaning supplies, minor hardware', 'completed', '2025-05-10', false, 4),
('MAINT_WELL_BNG_001_2025_002', 'well', 'WELL_BNG_001', 'pump_repair', '2025-06-15', null, 'Technical Services Ltd', 'Scheduled pump efficiency check and maintenance', 1800.00, 'Pump components, testing equipment', 'scheduled', '2025-12-15', false, null),

-- WELL_BNG_002 maintenance
('MAINT_WELL_BNG_002_2024_001', 'well', 'WELL_BNG_002', 'emergency_repair', '2024-02-05', '2024-02-06', 'Emergency Response Team', 'Emergency pump failure repair', 4500.00, 'New pump, electrical components', 'completed', '2024-05-05', true, 3),
('MAINT_WELL_BNG_002_2024_002', 'well', 'WELL_BNG_002', 'disinfection', '2024-02-12', '2024-02-13', 'Health Safety Team', 'Well disinfection after contamination detection', 1200.00, 'Disinfectants, protective equipment', 'completed', '2024-05-12', false, 5),
('MAINT_WELL_BNG_002_2024_003', 'well', 'WELL_BNG_002', 'water_quality_treatment', '2024-08-20', '2024-08-22', 'Water Treatment Specialists', 'Advanced filtration system installation', 5800.00, 'Filtration units, monitoring equipment', 'completed', '2025-02-20', false, 5),
('MAINT_WELL_BNG_002_2025_001', 'well', 'WELL_BNG_002', 'routine_inspection', '2025-02-22', '2025-02-22', 'Quality Control Team', 'Post-treatment quality verification', 750.00, 'Testing kits, calibration tools', 'completed', '2025-05-22', false, 5),
('MAINT_WELL_BNG_002_2025_002', 'well', 'WELL_BNG_002', 'system_upgrade', '2025-08-25', null, 'Advanced Systems Inc', 'Automated monitoring system installation', 7200.00, 'Sensors, control panels, software', 'scheduled', '2026-02-25', false, null),

-- WELL_BNG_003 maintenance
('MAINT_WELL_BNG_003_2024_001', 'well', 'WELL_BNG_003', 'routine_inspection', '2024-03-01', '2024-03-01', 'Premium Maintenance', 'High-quality well maintained routinely', 1200.00, 'Premium cleaning supplies', 'completed', '2024-06-01', false, 5),
('MAINT_WELL_BNG_003_2024_002', 'well', 'WELL_BNG_003', 'preventive_maintenance', '2024-09-05', '2024-09-05', 'Premium Maintenance', 'Comprehensive preventive maintenance', 2800.00, 'High-grade components, testing equipment', 'completed', '2025-03-05', false, 5),
('MAINT_WELL_BNG_003_2025_001', 'well', 'WELL_BNG_003', 'routine_inspection', '2025-03-10', '2025-03-10', 'Premium Maintenance', 'Quarterly excellence check', 1100.00, 'Quality materials, calibration tools', 'completed', '2025-06-10', false, 5),
('MAINT_WELL_BNG_003_2025_002', 'well', 'WELL_BNG_003', 'efficiency_optimization', '2025-09-20', null, 'Advanced Well Systems', 'Performance optimization and monitoring upgrade', 3500.00, 'Efficiency sensors, optimization software', 'scheduled', '2026-03-20', false, null),

-- WELL_MYS_001 maintenance
('MAINT_WELL_MYS_001_2024_001', 'well', 'WELL_MYS_001', 'routine_inspection', '2024-04-08', '2024-04-08', 'Mysore Water Services', 'Regular maintenance of excellent well', 900.00, 'Standard maintenance supplies', 'completed', '2024-07-08', false, 5),
('MAINT_WELL_MYS_001_2024_002', 'well', 'WELL_MYS_001', 'pump_maintenance', '2024-10-15', '2024-10-15', 'Mysore Technical Team', 'Pump efficiency maintenance', 2200.00, 'Pump parts, lubricants', 'completed', '2025-04-15', false, 5),
('MAINT_WELL_MYS_001_2025_001', 'well', 'WELL_MYS_001', 'routine_inspection', '2025-04-20', '2025-04-20', 'Mysore Water Services', 'Continued excellence maintenance', 950.00, 'Quality supplies', 'completed', '2025-07-20', false, 5),
('MAINT_WELL_MYS_001_2025_002', 'well', 'WELL_MYS_001', 'system_monitoring', '2025-10-25', null, 'Smart Systems Mysore', 'IoT monitoring system installation', 4200.00, 'Smart sensors, connectivity equipment', 'scheduled', '2026-04-25', false, null),

-- WELL_MYS_002 maintenance
('MAINT_WELL_MYS_002_2024_001', 'well', 'WELL_MYS_002', 'routine_inspection', '2024-05-05', '2024-05-05', 'Mysore Water Services', 'Standard maintenance procedure', 850.00, 'Cleaning materials, tools', 'completed', '2024-08-05', false, 4),
('MAINT_WELL_MYS_002_2024_002', 'well', 'WELL_MYS_002', 'pump_repair', '2024-11-12', '2024-11-13', 'Mysore Technical Team', 'Minor pump adjustments and servicing', 1800.00, 'Pump components, seals', 'completed', '2025-05-12', false, 4),
('MAINT_WELL_MYS_002_2025_001', 'well', 'WELL_MYS_002', 'quality_improvement', '2025-05-18', '2025-05-19', 'Water Quality Team', 'Quality enhancement measures', 2600.00, 'Filtration components, monitoring tools', 'completed', '2025-11-18', false, 5),
('MAINT_WELL_MYS_002_2025_002', 'well', 'WELL_MYS_002', 'routine_inspection', '2025-11-25', null, 'Mysore Water Services', 'Regular maintenance check', 900.00, 'Standard supplies', 'scheduled', '2026-02-25', false, null),

-- WELL_CHAD_001 maintenance
('MAINT_WELL_CHAD_001_2024_001', 'well', 'WELL_CHAD_001', 'emergency_repair', '2024-06-01', '2024-06-04', 'Chad Emergency Services', 'Critical contamination response', 6500.00, 'Disinfection equipment, new pump parts', 'completed', '2024-09-01', true, 3),
('MAINT_WELL_CHAD_001_2024_002', 'well', 'WELL_CHAD_001', 'comprehensive_treatment', '2024-09-10', '2024-09-15', 'International Water Aid', 'Complete water treatment system installation', 15000.00, 'Treatment plant, filtration system', 'completed', '2024-12-10', false, 4),
('MAINT_WELL_CHAD_001_2024_003', 'well', 'WELL_CHAD_001', 'monitoring_setup', '2024-12-15', '2024-12-18', 'Chad Technical Services', 'Water quality monitoring system', 3800.00, 'Monitoring equipment, sensors', 'completed', '2025-06-15', false, 4),
('MAINT_WELL_CHAD_001_2025_001', 'well', 'WELL_CHAD_001', 'routine_inspection', '2025-06-20', null, 'Chad Water Management', 'Regular quality and system check', 1200.00, 'Testing supplies, maintenance tools', 'scheduled', '2025-09-20', false, null),

-- WELL_AGADEZ_001 maintenance
('MAINT_WELL_AGADEZ_001_2024_001', 'well', 'WELL_AGADEZ_001', 'routine_inspection', '2024-07-10', '2024-07-10', 'Desert Well Specialists', 'Desert environment maintenance', 1500.00, 'Dust-resistant materials, tools', 'completed', '2024-10-10', false, 5),
('MAINT_WELL_AGADEZ_001_2025_001', 'well', 'WELL_AGADEZ_001', 'sand_protection', '2025-01-20', '2025-01-22', 'Sahara Engineering', 'Sand infiltration prevention system', 4500.00, 'Sand filters, protective covers', 'completed', '2025-07-20', false, 5),
('MAINT_WELL_AGADEZ_001_2025_002', 'well', 'WELL_AGADEZ_001', 'routine_inspection', '2025-07-25', '2025-07-25', 'Desert Well Specialists', 'Excellence maintenance in desert', 1400.00, 'Specialized desert materials', 'completed', '2025-10-25', false, 5),
('MAINT_WELL_AGADEZ_001_2025_003', 'well', 'WELL_AGADEZ_001', 'solar_upgrade', '2026-01-30', null, 'Renewable Energy Systems', 'Solar-powered pumping system upgrade', 8500.00, 'Solar panels, battery system, controllers', 'scheduled', '2026-07-30', false, null),

-- Maintenance Activities for Ponds
-- POND_LALBAGH maintenance
('MAINT_POND_LALBAGH_2024_001', 'pond', 'POND_LALBAGH', 'algae_control', '2024-01-25', '2024-01-27', 'Bangalore Parks Dept', 'Algae bloom control and water circulation', 3200.00, 'Algaecides, aeration equipment', 'completed', '2024-04-25', false, 4),
('MAINT_POND_LALBAGH_2024_002', 'pond', 'POND_LALBAGH', 'sediment_removal', '2024-07-30', '2024-08-05', 'Aquatic Services Ltd', 'Bottom sediment cleaning and dredging', 8500.00, 'Dredging equipment, disposal services', 'completed', '2025-01-30', false, 4),
('MAINT_POND_LALBAGH_2025_001', 'pond', 'POND_LALBAGH', 'water_quality_treatment', '2025-02-05', '2025-02-08', 'Environmental Solutions', 'Bio-remediation and filtration system', 5200.00, 'Bio-filters, beneficial bacteria, pumps', 'completed', '2025-05-05', false, 5),
('MAINT_POND_LALBAGH_2025_002', 'pond', 'POND_LALBAGH', 'routine_maintenance', '2025-05-10', null, 'Bangalore Parks Dept', 'Regular maintenance and monitoring', 1800.00, 'Testing kits, cleaning supplies', 'scheduled', '2025-08-10', false, null),

-- POND_VRISH_01 maintenance
('MAINT_POND_VRISH_01_2024_001', 'pond', 'POND_VRISH_01', 'routine_inspection', '2024-02-20', '2024-02-20', 'Rural Maintenance Team', 'Excellent pond routine maintenance', 1200.00, 'Basic maintenance supplies', 'completed', '2024-05-20', false, 5),
('MAINT_POND_VRISH_01_2024_002', 'pond', 'POND_VRISH_01', 'inlet_outlet_maintenance', '2024-08-25', '2024-08-26', 'Hydraulic Services', 'Inlet and outlet channel cleaning', 2800.00, 'Channel cleaning equipment, concrete', 'completed', '2025-02-25', false, 4),
('MAINT_POND_VRISH_01_2025_001', 'pond', 'POND_VRISH_01', 'quality_restoration', '2025-03-01', '2025-03-03', 'Water Quality Specialists', 'Quality restoration after decline', 3500.00, 'Water treatment chemicals, monitoring equipment', 'completed', '2025-09-01', false, 5),
('MAINT_POND_VRISH_01_2025_002', 'pond', 'POND_VRISH_01', 'preventive_maintenance', '2025-09-05', null, 'Rural Maintenance Team', 'Preventive maintenance for excellence', 1500.00, 'Quality materials, testing kits', 'scheduled', '2025-12-05', false, null),

-- POND_MYSORE_CENTRAL maintenance
('MAINT_POND_MYSORE_CENTRAL_2024_001', 'pond', 'POND_MYSORE_CENTRAL', 'pollution_control', '2024-03-15', '2024-03-20', 'Urban Water Management', 'Urban pollution mitigation measures', 12000.00, 'Filtration systems, barriers, pumps', 'completed', '2024-06-15', false, 3),
('MAINT_POND_MYSORE_CENTRAL_2024_002', 'pond', 'POND_MYSORE_CENTRAL', 'water_treatment', '2024-09-20', '2024-09-25', 'City Environmental Services', 'Advanced water treatment installation', 18500.00, 'Treatment plant, chemical dosing systems', 'completed', '2024-12-20', false, 4),
('MAINT_POND_MYSORE_CENTRAL_2025_001', 'pond', 'POND_MYSORE_CENTRAL', 'system_monitoring', '2025-03-25', '2025-03-27', 'Smart City Solutions', 'Automated monitoring system setup', 8200.00, 'Sensors, data loggers, software', 'completed', '2025-09-25', false, 4),
('MAINT_POND_MYSORE_CENTRAL_2025_002', 'pond', 'POND_MYSORE_CENTRAL', 'quality_improvement', '2025-06-25', null, 'Advanced Water Tech', 'Continued quality improvement measures', 6500.00, 'Advanced filtration, chemical treatment', 'scheduled', '2025-12-25', false, null),

-- POND_NDJAMENA_01 maintenance
('MAINT_POND_NDJAMENA_01_2024_001', 'pond', 'POND_NDJAMENA_01', 'emergency_treatment', '2024-04-08', '2024-04-12', 'Chad Emergency Response', 'Emergency contamination treatment', 15000.00, 'Disinfection systems, emergency equipment', 'completed', '2024-07-08', true, 3),
('MAINT_POND_NDJAMENA_01_2024_002', 'pond', 'POND_NDJAMENA_01', 'comprehensive_cleanup', '2024-07-15', '2024-07-25', 'International Water Aid', 'Complete pond rehabilitation', 25000.00, 'Dredging equipment, treatment systems', 'completed', '2024-10-15', false, 4),
('MAINT_POND_NDJAMENA_01_2024_003', 'pond', 'POND_NDJAMENA_01', 'monitoring_setup', '2024-10-20', '2024-10-25', 'Chad Water Institute', 'Water quality monitoring installation', 5500.00, 'Monitoring equipment, solar power systems', 'completed', '2025-01-20', false, 4),
('MAINT_POND_NDJAMENA_01_2025_001', 'pond', 'POND_NDJAMENA_01', 'routine_maintenance', '2025-04-15', null, 'Chad Water Management', 'Regular maintenance and monitoring', 2800.00, 'Testing equipment, maintenance supplies', 'scheduled', '2025-07-15', false, null),

-- POND_AGADEZ_SEASONAL maintenance
('MAINT_POND_AGADEZ_SEASONAL_2024_001', 'pond', 'POND_AGADEZ_SEASONAL', 'seasonal_prep', '2024-05-25', '2024-05-27', 'Desert Water Systems', 'Seasonal filling preparation', 4200.00, 'Inlet cleaning, liner repair', 'completed', '2024-11-25', false, 5),
('MAINT_POND_AGADEZ_SEASONAL_2024_002', 'pond', 'POND_AGADEZ_SEASONAL', 'evaporation_control', '2024-11-30', '2024-12-03', 'Sahara Engineering', 'Evaporation reduction measures', 7500.00, 'Floating covers, shade structures', 'completed', '2025-05-30', false, 5),
('MAINT_POND_AGADEZ_SEASONAL_2025_001', 'pond', 'POND_AGADEZ_SEASONAL', 'seasonal_prep', '2025-05-30', '2025-06-01', 'Desert Water Systems', 'Annual seasonal preparation', 4500.00, 'Maintenance supplies, cleaning equipment', 'completed', '2025-11-30', false, 5),
('MAINT_POND_AGADEZ_SEASONAL_2025_002', 'pond', 'POND_AGADEZ_SEASONAL', 'efficiency_upgrade', '2025-12-05', null, 'Advanced Desert Tech', 'Water conservation efficiency upgrade', 9200.00, 'Smart covers, automated systems', 'scheduled', '2026-06-05', false, null),

-- Maintenance Activities for Boreholes
-- BH_BNG_001 maintenance
('MAINT_BH_BNG_001_2024_001', 'borehole', 'BH_BNG_001', 'routine_inspection', '2024-01-12', '2024-01-12', 'Geological Services', 'Deep well routine inspection', 1800.00, 'Inspection equipment, testing tools', 'completed', '2024-04-12', false, 4),
('MAINT_BH_BNG_001_2024_002', 'borehole', 'BH_BNG_001', 'pump_maintenance', '2024-07-18', '2024-07-20', 'Deep Well Specialists', 'Submersible pump maintenance', 4500.00, 'Pump components, cable, tools', 'completed', '2025-01-18', false, 4),
('MAINT_BH_BNG_001_2025_001', 'borehole', 'BH_BNG_001', 'well_testing', '2025-01-20', '2025-01-22', 'Hydrogeological Services', 'Comprehensive well performance testing', 3200.00, 'Testing equipment, data loggers', 'completed', '2025-07-20', false, 4),
('MAINT_BH_BNG_001_2025_002', 'borehole', 'BH_BNG_001', 'system_upgrade', '2025-07-25', null, 'Advanced Drilling Tech', 'Monitoring and control system upgrade', 6500.00, 'Smart sensors, control systems', 'scheduled', '2026-01-25', false, null),

-- BH_BNG_002 maintenance
('MAINT_BH_BNG_002_2024_001', 'borehole', 'BH_BNG_002', 'water_treatment', '2024-02-25', '2024-03-01', 'Water Treatment Corp', 'Treatment system for high mineralization', 8500.00, 'RO system, pre-filters, monitoring', 'completed', '2024-08-25', false, 4),
('MAINT_BH_BNG_002_2024_002', 'borehole', 'BH_BNG_002', 'pump_repair', '2024-08-30', '2024-09-02', 'Deep Well Specialists', 'Pump efficiency improvement', 3800.00, 'New impeller, motor servicing', 'completed', '2025-02-28', false, 4),
('MAINT_BH_BNG_002_2025_001', 'borehole', 'BH_BNG_002', 'quality_monitoring', '2025-03-05', '2025-03-06', 'Quality Assurance Team', 'Enhanced water quality monitoring setup', 2800.00, 'Monitoring instruments, calibration', 'completed', '2025-09-05', false, 5),
('MAINT_BH_BNG_002_2025_002', 'borehole', 'BH_BNG_002', 'routine_maintenance', '2025-09-10', null, 'Geological Services', 'Regular maintenance and inspection', 2200.00, 'Maintenance supplies, testing equipment', 'scheduled', '2025-12-10', false, null),

-- BH_MYS_001 maintenance
('MAINT_BH_MYS_001_2024_001', 'borehole', 'BH_MYS_001', 'routine_inspection', '2024-03-18', '2024-03-18', 'Karnataka Geological', 'Excellence maintenance routine', 1500.00, 'Premium inspection tools', 'completed', '2024-06-18', false, 5),
('MAINT_BH_MYS_001_2024_002', 'borehole', 'BH_MYS_001', 'pump_optimization', '2024-09-25', '2024-09-26', 'Precision Pump Systems', 'Pump efficiency optimization', 3200.00, 'High-efficiency components', 'completed', '2025-03-25', false, 5),
('MAINT_BH_MYS_001_2025_001', 'borehole', 'BH_MYS_001', 'preventive_maintenance', '2025-03-28', '2025-03-28', 'Karnataka Geological', 'Preventive excellence maintenance', 1800.00, 'Quality materials, precision tools', 'completed', '2025-09-28', false, 5),
('MAINT_BH_MYS_001_2025_002', 'borehole', 'BH_MYS_001', 'smart_monitoring', '2025-10-05', null, 'Smart Well Technologies', 'IoT-based monitoring system installation', 5500.00, 'Smart sensors, connectivity, software', 'scheduled', '2026-04-05', false, null),

-- BH_CHAD_001 maintenance
('MAINT_BH_CHAD_001_2024_001', 'borehole', 'BH_CHAD_001', 'emergency_treatment', '2024-04-20', '2024-04-28', 'Chad Emergency Services', 'Emergency contamination response', 18000.00, 'Advanced treatment systems, disinfection', 'completed', '2024-07-20', true, 3),
('MAINT_BH_CHAD_001_2024_002', 'borehole', 'BH_CHAD_001', 'comprehensive_rehabilitation', '2024-07-25', '2024-08-10', 'International Drilling', 'Complete borehole rehabilitation', 35000.00, 'New casing, pumps, treatment system', 'completed', '2024-10-25', false, 4),
('MAINT_BH_CHAD_001_2024_003', 'borehole', 'BH_CHAD_001', 'monitoring_installation', '2024-10-30', '2024-11-05', 'Chad Technical Institute', 'Continuous monitoring system setup', 8500.00, 'Monitoring equipment, telemetry', 'completed', '2025-04-30', false, 4),
('MAINT_BH_CHAD_001_2025_001', 'borehole', 'BH_CHAD_001', 'quality_verification', '2025-05-05', null, 'Chad Water Quality', 'Treatment effectiveness verification', 3500.00, 'Testing equipment, analysis tools', 'scheduled', '2025-08-05', false, null),

-- BH_AGADEZ_001 maintenance
('MAINT_BH_AGADEZ_001_2024_001', 'borehole', 'BH_AGADEZ_001', 'sand_protection', '2024-05-28', '2024-05-30', 'Sahara Drilling', 'Sand infiltration prevention', 5500.00, 'Sand screens, protective equipment', 'completed', '2024-11-28', false, 5),
('MAINT_BH_AGADEZ_001_2024_002', 'borehole', 'BH_AGADEZ_001', 'pump_maintenance', '2024-12-05', '2024-12-06', 'Desert Pump Systems', 'Desert-specialized pump maintenance', 4200.00, 'Desert-rated components, seals', 'completed', '2025-06-05', false, 5),
('MAINT_BH_AGADEZ_001_2025_001', 'borehole', 'BH_AGADEZ_001', 'routine_inspection', '2025-06-08', '2025-06-08', 'Sahara Drilling', 'Excellence maintenance in extreme conditions', 2200.00, 'Specialized equipment, testing tools', 'completed', '2025-12-08', false, 5),
('MAINT_BH_AGADEZ_001_2025_002', 'borehole', 'BH_AGADEZ_001', 'solar_system_upgrade', '2026-02-05', null, 'Desert Energy Solutions', 'Solar pumping system with battery backup', 12500.00, 'Solar panels, batteries, controllers, pumps', 'scheduled', '2026-08-05', false, null);

-- Verify the data insertion
SELECT 'Water Quality Reports inserted: ' || COUNT(*) FROM water_quality_reports;
SELECT 'Maintenance Activities inserted: ' || COUNT(*) FROM maintenance_activities;