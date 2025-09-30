-- Add sample data in Eastern Chad region (around 20°E, 13°N)
-- This will help with testing when users click in this region

-- Add wells in the eastern region
INSERT INTO wells (well_id, name, geom, depth_m, static_water_level_m, well_type, status, owner, description) VALUES
('well_6', 'Abeche Community Well', ST_GeomFromText('POINT(20.8311 13.8467)', 4326), 45.0, 12.0, 'Hand Pump', 'active', 'Abeche Municipality', 'Community well serving eastern suburbs'),
('well_7', 'Adre Border Well', ST_GeomFromText('POINT(20.5534 13.4635)', 4326), 38.0, 8.5, 'Solar Pump', 'active', 'Border Development Authority', 'Solar-powered well near Sudan border'),
('well_8', 'Guereda Village Well', ST_GeomFromText('POINT(20.9221 15.3421)', 4326), 52.0, 15.0, 'Hand Pump', 'maintenance', 'Guereda Village Council', 'Traditional hand pump well, needs maintenance');

-- Add ponds in the eastern region  
INSERT INTO ponds (pond_id, name, geom, surface_area_sqm, maximum_depth_m, primary_use, status, description) VALUES
('pond_4', 'Abeche Seasonal Pond', ST_GeomFromText('POINT(20.7892 13.7234)', 4326), 2800.0, 3.2, 'Livestock', 'active', 'Seasonal water storage for livestock'),
('pond_5', 'Adre Water Reserve', ST_GeomFromText('POINT(20.6123 13.5987)', 4326), 1950.0, 2.8, 'Municipal', 'active', 'Municipal water reserve with treatment facility');

-- Add boreholes in the eastern region
INSERT INTO boreholes (borehole_id, name, geom, total_depth_m, pump_capacity_lph, drilling_company, status, description, completion_date) VALUES
('borehole_4', 'Abeche Deep Borehole', ST_GeomFromText('POINT(20.7245 13.9012)', 4326), 78.0, 450.0, 'Deep Well Drilling Co', 'active', 'High-capacity borehole for urban water supply', '2020-11-18'),
('borehole_5', 'Guereda Agricultural Borehole', ST_GeomFromText('POINT(20.8765 15.2198)', 4326), 65.0, 380.0, 'Agricultural Development Agency', 'active', 'Agricultural borehole with modern irrigation setup', '2021-04-22');

-- Add feature analysis data for these new features
INSERT INTO feature_construction_details (feature_id, construction_date, contractor, cost_usd, materials_used, quality_rating, notes) VALUES
('well_6', '2021-03-15', 'Chad Water Development Corp', 12500.00, 'Concrete rings, steel pump, PVC pipes', 8.5, 'Community well serving 450 people in Abeche suburb'),
('well_7', '2022-01-20', 'Border Infrastructure Ltd', 18900.00, 'Solar panels, submersible pump, concrete platform', 9.2, 'Solar-powered well near Sudan border'),
('well_8', '2020-08-10', 'Village Development Association', 8200.00, 'Hand pump, concrete apron, steel casing', 7.8, 'Traditional hand pump well, needs maintenance'),
('pond_4', '2019-06-12', 'Regional Water Authority', 15600.00, 'Clay lining, concrete spillway, fencing', 8.0, 'Seasonal water storage for livestock'),
('pond_5', '2021-09-05', 'Adre Municipal Works', 22100.00, 'Rubber lining, pump house, filtration system', 9.1, 'Modern water reserve with treatment facility'),
('borehole_4', '2020-11-18', 'Deep Well Drilling Co', 28500.00, 'Steel casing, centrifugal pump, electrical controls', 8.7, 'High-capacity borehole for urban water supply'),
('borehole_5', '2021-04-22', 'Agricultural Development Agency', 32200.00, 'Stainless steel pump, irrigation system, storage tank', 9.0, 'Agricultural borehole with modern irrigation setup');

INSERT INTO feature_water_quality_reports (feature_id, test_date, ph_level, turbidity_ntu, chlorine_mg_l, bacteria_count, nitrate_mg_l, fluoride_mg_l, overall_quality, notes) VALUES
('well_6', '2024-08-15', 7.2, 3.5, 0.2, 0, 15.2, 0.8, 'Good', 'Regular monitoring shows consistent quality'),
('well_6', '2024-06-20', 7.1, 4.1, 0.3, 0, 16.8, 0.7, 'Good', 'Seasonal variation within acceptable limits'),
('well_7', '2024-07-30', 6.9, 2.8, 0.4, 0, 12.5, 0.6, 'Excellent', 'Solar pumping maintains excellent water quality'),
('well_8', '2024-05-12', 7.4, 5.2, 0.1, 2, 18.9, 1.1, 'Fair', 'Needs maintenance - slight bacterial contamination'),
('pond_4', '2024-07-10', 7.8, 8.5, 0.0, 5, 22.1, 0.4, 'Fair', 'Seasonal pond - quality varies with rainfall'),
('pond_5', '2024-08-25', 7.3, 3.2, 0.5, 0, 14.2, 0.9, 'Good', 'Treatment facility maintains good quality'),
('borehole_4', '2024-09-05', 7.0, 1.8, 0.3, 0, 11.8, 0.5, 'Excellent', 'Deep borehole provides pristine water'),
('borehole_5', '2024-08-18', 6.8, 2.1, 0.2, 0, 13.4, 0.7, 'Excellent', 'Agricultural use - excellent for irrigation');

INSERT INTO feature_maintenance_activities (feature_id, activity_date, activity_type, description, cost_usd, performed_by, next_scheduled, status) VALUES
('well_6', '2024-07-20', 'Routine Maintenance', 'Pump cleaning and lubrication', 150.00, 'Local Technician Team', '2025-01-20', 'Completed'),
('well_6', '2024-03-15', 'Major Repair', 'Pump replacement and well cleaning', 1200.00, 'Chad Water Development Corp', '2024-09-15', 'Completed'),
('well_7', '2024-08-10', 'Solar Panel Cleaning', 'Panel cleaning and electrical check', 200.00, 'Solar Maintenance Crew', '2024-11-10', 'Completed'),
('well_8', '2024-06-05', 'Emergency Repair', 'Hand pump repair - handle replacement', 180.00, 'Village Maintenance Team', '2024-12-05', 'Pending'),
('pond_4', '2024-04-20', 'Seasonal Preparation', 'Spillway cleaning and fence repair', 350.00, 'Regional Water Authority', '2024-10-20', 'Completed'),
('pond_5', '2024-09-01', 'Filter Replacement', 'Water treatment filter replacement', 450.00, 'Adre Municipal Works', '2025-03-01', 'Scheduled'),
('borehole_4', '2024-05-30', 'Pump Calibration', 'Electrical system check and pump calibration', 300.00, 'Electrical Specialists', '2024-11-30', 'Completed'),
('borehole_5', '2024-07-15', 'Irrigation System Check', 'Complete irrigation system inspection', 400.00, 'Agricultural Technicians', '2025-01-15', 'Scheduled');

COMMIT;