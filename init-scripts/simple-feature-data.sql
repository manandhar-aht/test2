-- Insert sample data for feature analysis
-- This populates the tables with realistic demonstration data

-- Insert construction details for various infrastructure types
INSERT INTO feature_construction_details (
    feature_id, feature_type, contractor_name, construction_method, 
    construction_start_date, construction_end_date, construction_duration_days,
    construction_cost, depth_m, diameter_m, length_m, width_m, lining_material,
    materials_used, equipment_used, warranty_period_months,
    quality_certificate_number, environmental_compliance, project_status,
    quality_rating, final_inspection_date, additional_notes
) VALUES

-- Wells Construction Data
('well_1', 'well', 'Chad Drilling & Well Services Ltd.', 'Rotary Drilling', 
 '2024-01-15', '2024-01-25', 10, 15000.00, 45.0, 0.15, NULL, NULL, NULL,
 ARRAY['PVC casing', 'Gravel pack', 'Bentonite seal', 'Stainless steel screen'], 
 ARRAY['Rotary drill rig', 'Air compressor', 'PVC pipes', 'Cement mixer'],
 24, 'CRT-2024-W001', 'Environmental Impact Assessment completed', 'completed', 
 5, '2024-01-26', 'High-quality aquifer encountered at 40m depth'),

('well_2', 'well', 'Sahara Water Solutions', 'Cable Tool Drilling', 
 '2024-02-10', '2024-02-18', 8, 12500.00, 38.0, 0.12, NULL, NULL, NULL,
 ARRAY['Steel casing', 'Sand pack', 'Clay seal', 'Galvanized screen'], 
 ARRAY['Cable tool rig', 'Generator', 'Steel pipes', 'Hand pump'],
 18, 'SWS-2024-W002', 'Local water authority approved', 'completed', 
 4, '2024-02-19', 'Moderate water yield, suitable for community use'),

('well_3', 'well', 'NDjamena Infrastructure Corp.', 'Augering & Drilling', 
 '2024-03-05', '2024-03-12', 7, 9800.00, 28.0, 0.10, NULL, NULL, NULL,
 ARRAY['PVC casing', 'Natural gravel', 'Cement seal', 'Mesh screen'], 
 ARRAY['Auger drill', 'Water truck', 'PVC materials', 'Solar pump'],
 12, 'NIC-2024-W003', 'Community consultation completed', 'completed', 
 4, '2024-03-13', 'Shallow aquifer suitable for hand pump operation'),

-- Boreholes Construction Data
('borehole_1', 'borehole', 'Central African Drilling Co.', 'Percussion Drilling', 
 '2024-01-20', '2024-02-05', 16, 22000.00, 65.0, 0.20, NULL, NULL, NULL,
 ARRAY['Steel casing', 'Gravel pack', 'Bentonite seal', 'Submersible pump'], 
 ARRAY['Percussion drill', 'Compressor', 'Steel pipes', 'Electric pump'],
 36, 'CAD-2024-B001', 'Hydrogeological survey completed', 'completed', 
 5, '2024-02-06', 'Excellent water quality and high yield capacity'),

('borehole_2', 'borehole', 'Chad Hydro Engineering', 'Rotary Mud Drilling', 
 '2024-02-15', '2024-03-02', 15, 18500.00, 52.0, 0.18, NULL, NULL, NULL,
 ARRAY['PVC casing', 'Filter pack', 'Clay seal', 'Centrifugal pump'], 
 ARRAY['Mud rotary rig', 'Mud pumps', 'PVC pipes', 'Motor pump'],
 30, 'CHE-2024-B002', 'Environmental clearance obtained', 'completed', 
 4, '2024-03-03', 'Good water quality with minor iron content'),

('borehole_3', 'borehole', 'Lake Chad Drilling Services', 'Air Rotary Drilling', 
 '2024-03-10', '2024-03-22', 12, 16200.00, 48.0, 0.16, NULL, NULL, NULL,
 ARRAY['Steel casing', 'Silica sand', 'Polymer seal', 'Solar pump'], 
 ARRAY['Air rotary rig', 'Air compressor', 'Steel materials', 'Solar system'],
 24, 'LCD-2024-B003', 'Water quality certification pending', 'completed', 
 4, '2024-03-23', 'Sustainable solar-powered system installed'),

-- Ponds Construction Data
('pond_1', 'pond', 'Chad Earth Works & Construction', 'Excavation & Lining', 
 '2024-01-10', '2024-02-20', 41, 35000.00, 3.5, NULL, 25.0, 15.0, 'HDPE Liner',
 ARRAY['HDPE liner', 'Geotextile', 'Clay base', 'Concrete inlet/outlet'], 
 ARRAY['Excavator', 'Bulldozer', 'Compactor', 'Concrete mixer'],
 60, 'CEW-2024-P001', 'Environmental impact assessment approved', 'completed', 
 5, '2024-02-21', 'Large capacity pond with excellent water retention'),

('pond_2', 'pond', 'Savanna Water Projects Ltd.', 'Natural Clay Lining', 
 '2024-02-01', '2024-03-10', 38, 28000.00, 2.8, NULL, 20.0, 12.0, 'Compacted Clay',
 ARRAY['Natural clay', 'Sand layer', 'Stone protection', 'Pipe fittings'], 
 ARRAY['Excavator', 'Grader', 'Water roller', 'Dump truck'],
 48, 'SWP-2024-P002', 'Community agreement signed', 'completed', 
 4, '2024-03-11', 'Cost-effective solution using local materials'),

('pond_3', 'pond', 'Chari River Engineering', 'Concrete Lining', 
 '2024-03-01', '2024-04-15', 45, 42000.00, 4.0, NULL, 30.0, 18.0, 'Reinforced Concrete',
 ARRAY['Reinforced concrete', 'Steel rebar', 'Waterproof membrane', 'Drainage system'], 
 ARRAY['Concrete truck', 'Crane', 'Vibrator', 'Finishing tools'],
 72, 'CRE-2024-P003', 'Structural engineering certified', 'completed', 
 5, '2024-04-16', 'High-capacity pond with excellent durability');

-- Insert water quality reports
INSERT INTO feature_water_quality_reports (
    feature_id, feature_type, test_date, ph_level, tds_ppm, conductivity,
    turbidity, temperature, ecoli_count, coliform_count, overall_quality,
    testing_laboratory, next_test_due_date, recommended_treatment, notes
) VALUES

-- Well Water Quality Data
('well_1', 'well', '2024-02-01', 7.2, 245, 390, 0.8, 26.5, 0, 0, 'excellent', 
 'Chad National Water Quality Lab', '2024-08-01', 'No treatment required', 'Excellent potable water source'),
('well_1', 'well', '2024-04-01', 7.1, 258, 410, 1.2, 27.8, 0, 2, 'good', 
 'Chad National Water Quality Lab', '2024-10-01', 'Monthly chlorination recommended', 'Minor coliform detection'),
('well_1', 'well', '2024-06-01', 7.3, 235, 375, 0.6, 28.2, 0, 0, 'excellent', 
 'Chad National Water Quality Lab', '2024-12-01', 'Continue current maintenance', 'Optimal water quality maintained'),
('well_1', 'well', '2024-08-01', 7.0, 270, 425, 1.5, 29.1, 1, 3, 'good', 
 'Chad National Water Quality Lab', '2025-02-01', 'Disinfection required', 'Slight bacterial contamination'),
('well_1', 'well', '2024-09-15', 7.2, 252, 395, 0.9, 28.5, 0, 0, 'excellent', 
 'Chad National Water Quality Lab', '2025-03-15', 'Maintain current protocols', 'Quality restored after treatment'),

('well_2', 'well', '2024-02-15', 6.8, 320, 485, 2.1, 25.8, 3, 8, 'fair', 
 'Sahara Testing Services', '2024-08-15', 'UV disinfection recommended', 'Higher TDS levels detected'),
('well_2', 'well', '2024-04-15', 7.0, 295, 450, 1.8, 26.5, 0, 2, 'good', 
 'Sahara Testing Services', '2024-10-15', 'Quarterly testing advised', 'Improvement after maintenance'),
('well_2', 'well', '2024-06-15', 6.9, 310, 470, 2.3, 27.2, 2, 5, 'fair', 
 'Sahara Testing Services', '2024-12-15', 'Water treatment system needed', 'Seasonal quality variation'),
('well_2', 'well', '2024-08-15', 7.1, 285, 430, 1.6, 28.0, 0, 1, 'good', 
 'Sahara Testing Services', '2025-02-15', 'Continue monitoring', 'Quality stabilizing'),
('well_2', 'well', '2024-09-20', 7.0, 298, 445, 1.9, 27.8, 1, 3, 'good', 
 'Sahara Testing Services', '2025-03-20', 'Bi-monthly chlorination', 'Acceptable for community use'),

-- Borehole Water Quality Data
('borehole_1', 'borehole', '2024-02-10', 7.4, 180, 285, 0.5, 25.2, 0, 0, 'excellent', 
 'Central Lab Chad', '2024-08-10', 'No treatment required', 'Premium groundwater quality'),
('borehole_1', 'borehole', '2024-04-10', 7.3, 195, 300, 0.7, 26.1, 0, 0, 'excellent', 
 'Central Lab Chad', '2024-10-10', 'Continue current management', 'Consistently high quality'),
('borehole_1', 'borehole', '2024-06-10', 7.5, 175, 275, 0.4, 26.8, 0, 1, 'excellent', 
 'Central Lab Chad', '2024-12-10', 'Routine monitoring sufficient', 'Exceptional purity maintained'),
('borehole_1', 'borehole', '2024-08-10', 7.2, 205, 315, 0.9, 27.5, 0, 0, 'excellent', 
 'Central Lab Chad', '2025-02-10', 'Maintain protective measures', 'High-quality deep aquifer'),
('borehole_1', 'borehole', '2024-09-25', 7.4, 188, 290, 0.6, 26.9, 0, 0, 'excellent', 
 'Central Lab Chad', '2025-03-25', 'No action required', 'Reliable water source'),

-- Pond Water Quality Data
('pond_1', 'pond', '2024-02-25', 8.1, 450, 685, 12.5, 24.8, 85, 150, 'poor', 
 'Lake Chad Environmental Lab', '2024-05-25', 'Algae treatment and filtration required', 'High algae content typical for surface water'),
('pond_1', 'pond', '2024-05-25', 7.8, 420, 640, 8.2, 28.2, 45, 95, 'fair', 
 'Lake Chad Environmental Lab', '2024-08-25', 'UV treatment before use', 'Improvement after algae management'),
('pond_1', 'pond', '2024-08-25', 7.9, 385, 590, 6.8, 29.5, 25, 60, 'fair', 
 'Lake Chad Environmental Lab', '2024-11-25', 'Sand filtration recommended', 'Seasonal quality improvement'),
('pond_1', 'pond', '2024-09-30', 8.0, 410, 615, 9.1, 28.8, 55, 110, 'fair', 
 'Lake Chad Environmental Lab', '2024-12-30', 'Multi-stage treatment needed', 'Requires treatment for potable use');

-- Insert maintenance activities
INSERT INTO feature_maintenance_activities (
    feature_id, feature_type, activity_date, activity_type, activity_status,
    priority, cost, duration_hours, technician, description,
    parts_replaced, equipment_used, effectiveness_rating,
    next_maintenance_date, notes
) VALUES

-- Well Maintenance Data
('well_1', 'well', '2024-03-15', 'Pump Maintenance', 'completed', 'medium', 
 1200.00, 4, 'Ahmed Hassan - Senior Technician', 
 'Routine pump inspection, bearing replacement, and performance testing',
 ARRAY['Pump bearings', 'Seal kit', 'Oil filter'], 
 ARRAY['Pump hoist', 'Pressure gauge', 'Multimeter'],
 4, '2024-09-15', 'Pump efficiency improved by 15%'),

('well_1', 'well', '2024-06-20', 'Well Cleaning', 'completed', 'high', 
 2500.00, 8, 'Mohamed Idriss - Well Specialist', 
 'Deep well cleaning, sediment removal, and disinfection',
 ARRAY['Chlorine tablets', 'Sand filter media'], 
 ARRAY['Well cleaning equipment', 'Pressure washer', 'Water testing kit'],
 5, '2024-12-20', 'Significant improvement in water quality and flow rate'),

('well_1', 'well', '2024-09-10', 'Electrical System Check', 'completed', 'low', 
 650.00, 3, 'Ibrahim Seid - Electrician', 
 'Electrical connections inspection, control panel maintenance',
 ARRAY['Control relay', 'Electrical wire'], 
 ARRAY['Multimeter', 'Wire strippers', 'Voltage tester'],
 4, '2025-03-10', 'All electrical systems functioning properly'),

('well_1', 'well', '2025-01-15', 'Annual Inspection', 'scheduled', 'medium', 
 1800.00, 6, 'Ahmed Hassan - Senior Technician', 
 'Comprehensive annual inspection and preventive maintenance',
 ARRAY['TBD based on inspection'], 
 ARRAY['Inspection tools', 'Testing equipment'],
 NULL, '2025-07-15', 'Scheduled comprehensive maintenance'),

-- Borehole Maintenance Data
('borehole_1', 'borehole', '2024-04-05', 'Submersible Pump Service', 'completed', 'high', 
 3200.00, 12, 'Ousmane Deby - Pump Engineer', 
 'Submersible pump removal, overhaul, and reinstallation',
 ARRAY['Impeller', 'Motor bearings', 'Cable splice kit'], 
 ARRAY['Crane truck', 'Pressure testing unit', 'Cable puller'],
 5, '2024-10-05', 'Pump restored to optimal performance'),

('borehole_1', 'borehole', '2024-07-12', 'Casing Inspection', 'completed', 'medium', 
 1500.00, 6, 'Hassan Ali - Borehole Technician', 
 'Video inspection of borehole casing and structural integrity check',
 ARRAY['Casing clamps'], 
 ARRAY['Downhole camera', 'Logging equipment'],
 4, '2025-01-12', 'Minor wear detected, no immediate action required'),

('borehole_1', 'borehole', '2024-10-18', 'Water Treatment System', 'completed', 'medium', 
 2100.00, 5, 'Fatima Mahamat - Water Treatment Specialist', 
 'Iron removal system maintenance and filter replacement',
 ARRAY['Iron removal filters', 'Backwash valve'], 
 ARRAY['Water testing kit', 'Filter tools'],
 4, '2025-04-18', 'Iron content reduced to acceptable levels'),

-- Pond Maintenance Data
('pond_1', 'pond', '2024-05-10', 'Algae Control', 'completed', 'high', 
 2800.00, 16, 'Dr. Abakar Mahamat - Aquatic Specialist', 
 'Algae bloom management, water treatment, and ecosystem balancing',
 ARRAY['Algaecide treatment', 'Beneficial bacteria', 'Aeration stones'], 
 ARRAY['Water treatment pump', 'Aeration system', 'Water quality meter'],
 4, '2024-08-10', 'Algae levels controlled, water clarity improved'),

('pond_1', 'pond', '2024-08-22', 'Liner Inspection', 'completed', 'medium', 
 1800.00, 8, 'Mahamat Saleh - Infrastructure Inspector', 
 'HDPE liner inspection, minor repairs, and protective measures',
 ARRAY['HDPE patch material', 'Sealant'], 
 ARRAY['Underwater inspection tools', 'Welding equipment'],
 5, '2025-02-22', 'Liner integrity confirmed, minor patches applied'),

('pond_1', 'pond', '2024-11-30', 'Sediment Removal', 'in_progress', 'medium', 
 3500.00, 24, 'Chad Earth Works Team', 
 'Sediment dredging and pond capacity restoration',
 ARRAY['Filter media'], 
 ARRAY['Dredging equipment', 'Sediment pumps'],
 NULL, '2025-05-30', 'Currently removing accumulated sediment');

COMMIT;