-- Water Infrastructure Construction Details Table
-- This table stores detailed construction information for water infrastructure features

DROP TABLE IF EXISTS feature_construction_details CASCADE;

CREATE TABLE feature_construction_details (
    id SERIAL PRIMARY KEY,
    feature_id VARCHAR(255) NOT NULL UNIQUE,
    feature_type VARCHAR(50) NOT NULL,
    
    -- Contractor Information
    contractor_name VARCHAR(255) NOT NULL,
    contractor_license VARCHAR(100),
    contractor_contact VARCHAR(255),
    
    -- Construction Details
    construction_method VARCHAR(255) NOT NULL,
    construction_start_date DATE NOT NULL,
    construction_end_date DATE NOT NULL,
    construction_duration_days INTEGER NOT NULL,
    construction_cost DECIMAL(12,2) NOT NULL,
    
    -- Physical Specifications
    depth_m DECIMAL(8,2) NOT NULL,
    diameter_m DECIMAL(8,2), -- For wells and boreholes
    length_m DECIMAL(8,2),   -- For ponds
    width_m DECIMAL(8,2),    -- For ponds
    lining_material VARCHAR(255),
    
    -- Materials and Equipment
    materials_used TEXT[], -- Array of materials
    equipment_used TEXT[], -- Array of equipment
    
    -- Quality and Certification
    warranty_period_months INTEGER,
    quality_certificate_number VARCHAR(100),
    environmental_compliance VARCHAR(255),
    project_status VARCHAR(50) DEFAULT 'Completed',
    quality_rating INTEGER CHECK (quality_rating BETWEEN 1 AND 5),
    final_inspection_date DATE,
    
    -- Additional Information
    additional_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX idx_feature_construction_feature_id ON feature_construction_details(feature_id);
CREATE INDEX idx_feature_construction_type ON feature_construction_details(feature_type);
CREATE INDEX idx_feature_construction_contractor ON feature_construction_details(contractor_name);
CREATE INDEX idx_feature_construction_status ON feature_construction_details(project_status);

-- Insert sample construction data for existing features
INSERT INTO feature_construction_details (
    feature_id, feature_type, contractor_name, contractor_license, contractor_contact,
    construction_method, construction_start_date, construction_end_date, construction_duration_days,
    construction_cost, depth_m, diameter_m, lining_material, materials_used, equipment_used,
    warranty_period_months, quality_certificate_number, environmental_compliance,
    project_status, quality_rating, final_inspection_date, additional_notes
) VALUES 
-- Wells
('well_central_chad', 'well', 'Sahel Water Contractors Ltd', 'SWC-2023-001', 'contact@sahelwater.td',
 'Rotary Drilling with PVC Casing', '2023-01-15', '2023-02-28', 44, 15750.00,
 45.0, 0.20, 'PVC Schedule 40', 
 ARRAY['PVC Casing 8" diameter', 'Bentonite Clay', 'Gravel Pack', 'Concrete Wellhead'],
 ARRAY['Rotary Drilling Rig', 'Water Pump', 'Compressor', 'Welding Equipment'],
 24, 'WQ-CD-2023-078', 'Compliant with Chad Water Ministry Standards',
 'Completed', 4, '2023-03-05', 'High-yield well serving 250+ households. Water quality excellent.'),

('well_north_chad', 'well', 'Desert Wells Engineering', 'DWE-2023-012', 'info@desertwells.td',
 'Hand Drilling with Steel Casing', '2023-03-10', '2023-04-15', 36, 12300.00,
 32.0, 0.15, 'Galvanized Steel',
 ARRAY['Steel Casing 6" diameter', 'Sand Filter', 'Concrete Apron', 'Hand Pump'],
 ARRAY['Hand Drilling Tools', 'Portable Compressor', 'Hand Pump Installation Kit'],
 18, 'WQ-NC-2023-045', 'Environmental Impact Assessment Approved',
 'Completed', 5, '2023-04-20', 'Community-managed well with excellent sustainability track record.'),

('well_eastern_chad', 'well', 'East Chad Infrastructure Co.', 'ECIC-2023-007', 'projects@eastchad.td',
 'Machine Drilling with Submersible Pump', '2023-05-01', '2023-06-10', 40, 22500.00,
 55.0, 0.25, 'HDPE Casing',
 ARRAY['HDPE Casing 10" diameter', 'Submersible Pump', 'Control Panel', 'Distribution Network'],
 ARRAY['Truck-mounted Drilling Rig', 'Crane', 'Electrical Installation Tools'],
 36, 'WQ-EC-2023-089', 'Full Environmental Compliance Certificate',
 'Completed', 4, '2023-06-15', 'Modern well system with automated controls and distribution network.'),

-- Ponds
('pond_central_chad', 'pond', 'Sahel Water Contractors Ltd', 'SWC-2023-002', 'contact@sahelwater.td',
 'Excavation with Clay Lining', '2023-02-01', '2023-03-20', 47, 28750.00,
 3.5, NULL, 'Compacted Clay with Plastic Liner',
 ARRAY['Clay Liner', 'Plastic Sheeting', 'Gabion Retaining Walls', 'Inlet/Outlet Pipes'],
 ARRAY['Excavator', 'Compactor', 'Dump Trucks', 'Water Pumps'],
 24, 'WQ-PD-2023-134', 'Wildlife Protection Measures Implemented',
 'Completed', 4, '2023-03-25', 'Community water storage pond with 50,000L capacity. Includes livestock watering area.'),

('pond_northern_chad', 'pond', 'Aqua Solutions Chad', 'ASC-2023-018', 'build@aquasolutions.td',
 'Excavation with Concrete Lining', '2023-04-05', '2023-05-25', 50, 35600.00,
 4.0, NULL, 'Reinforced Concrete',
 ARRAY['Reinforced Concrete', 'Waterproof Membrane', 'Steel Reinforcement', 'Filtration System'],
 ARRAY['Excavator', 'Concrete Mixer', 'Crane', 'Vibrating Equipment'],
 60, 'WQ-PN-2023-167', 'Advanced Water Quality Treatment Systems',
 'Completed', 5, '2023-05-30', 'Modern concrete-lined pond with integrated filtration and treatment systems.'),

-- Boreholes
('borehole_central_chad', 'borehole', 'Chad Drilling Specialists', 'CDS-2023-025', 'drilling@chadspec.td',
 'Percussion Drilling with Steel Casing', '2023-06-01', '2023-07-05', 34, 18900.00,
 75.0, 0.18, 'Stainless Steel Schedule 80',
 ARRAY['Stainless Steel Casing', 'Grout Seal', 'Wellhead Protection', 'Test Pumping Equipment'],
 ARRAY['Percussion Drilling Rig', 'Air Compressor', 'Test Pump', 'Water Quality Testing Kit'],
 30, 'WQ-BC-2023-201', 'Groundwater Protection Compliance Certificate',
 'Completed', 4, '2023-07-10', 'Deep groundwater access point with excellent yield and water quality.'),

('borehole_eastern_chad', 'borehole', 'Professional Well Services', 'PWS-2023-031', 'service@prowell.td',
 'Rotary Drilling with Monitoring Equipment', '2023-07-15', '2023-08-20', 36, 21200.00,
 68.0, 0.20, 'PVC with Steel Screen',
 ARRAY['PVC Casing with Steel Screen', 'Bentonite Grout', 'Monitoring Equipment', 'Data Logger'],
 ARRAY['Rotary Drilling Rig', 'Mud Circulation System', 'Monitoring Equipment', 'Installation Tools'],
 24, 'WQ-BE-2023-245', 'Continuous Monitoring System Approved',
 'Completed', 5, '2023-08-25', 'Advanced borehole with real-time monitoring and data collection systems.');

-- Water Quality History Table
DROP TABLE IF EXISTS water_quality_history CASCADE;

CREATE TABLE water_quality_history (
    id SERIAL PRIMARY KEY,
    feature_id VARCHAR(255) NOT NULL,
    test_date DATE NOT NULL,
    ph_level DECIMAL(3,2),
    turbidity_ntu DECIMAL(8,2),
    tds_ppm INTEGER,
    chlorine_residual_ppm DECIMAL(4,2),
    bacteria_count_cfu INTEGER,
    nitrate_ppm DECIMAL(6,2),
    fluoride_ppm DECIMAL(4,2),
    arsenic_ppb DECIMAL(6,2),
    iron_ppm DECIMAL(5,2),
    manganese_ppm DECIMAL(5,2),
    hardness_ppm INTEGER,
    conductivity_us_cm INTEGER,
    temperature_c DECIMAL(4,1),
    dissolved_oxygen_ppm DECIMAL(4,2),
    test_lab VARCHAR(255),
    lab_technician VARCHAR(255),
    compliance_status VARCHAR(50),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_water_quality_feature_id ON water_quality_history(feature_id);
CREATE INDEX idx_water_quality_test_date ON water_quality_history(test_date);
CREATE INDEX idx_water_quality_compliance ON water_quality_history(compliance_status);

-- Maintenance History Table
DROP TABLE IF EXISTS maintenance_history CASCADE;

CREATE TABLE maintenance_history (
    id SERIAL PRIMARY KEY,
    feature_id VARCHAR(255) NOT NULL,
    maintenance_date DATE NOT NULL,
    maintenance_type VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    technician_name VARCHAR(255),
    cost DECIMAL(10,2),
    parts_replaced TEXT[],
    hours_spent DECIMAL(4,1),
    next_maintenance_due DATE,
    urgency_level VARCHAR(20) DEFAULT 'Routine',
    completion_status VARCHAR(20) DEFAULT 'Completed',
    before_photos TEXT[],
    after_photos TEXT[],
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_maintenance_feature_id ON maintenance_history(feature_id);
CREATE INDEX idx_maintenance_date ON maintenance_history(maintenance_date);
CREATE INDEX idx_maintenance_type ON maintenance_history(maintenance_type);
CREATE INDEX idx_maintenance_urgency ON maintenance_history(urgency_level);

-- Grant permissions
GRANT ALL PRIVILEGES ON feature_construction_details TO geouser;
GRANT ALL PRIVILEGES ON water_quality_history TO geouser;
GRANT ALL PRIVILEGES ON maintenance_history TO geouser;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO geouser;

COMMENT ON TABLE feature_construction_details IS 'Detailed construction information for water infrastructure features';
COMMENT ON TABLE water_quality_history IS 'Historical water quality test results for water infrastructure features';
COMMENT ON TABLE maintenance_history IS 'Maintenance records and schedules for water infrastructure features';