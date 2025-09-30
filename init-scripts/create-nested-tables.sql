-- Create tables for nested water infrastructure data
-- Construction Details Table
CREATE TABLE IF NOT EXISTS construction_details (
    id SERIAL PRIMARY KEY,
    feature_id VARCHAR(50) NOT NULL,
    feature_type VARCHAR(20) NOT NULL CHECK (feature_type IN ('well', 'pond', 'borehole')),
    contractor_name VARCHAR(100) NOT NULL,
    construction_method VARCHAR(100) NOT NULL,
    construction_start_date DATE NOT NULL,
    construction_end_date DATE NOT NULL,
    construction_duration_days INTEGER NOT NULL,
    construction_cost DECIMAL(10,2) NOT NULL,
    depth_m DECIMAL(5,2) NOT NULL,
    diameter_m DECIMAL(5,2), -- For wells and boreholes
    length_m DECIMAL(5,2), -- For ponds
    width_m DECIMAL(5,2), -- For ponds
    lining_material VARCHAR(50), -- For ponds primarily
    materials_used TEXT[], -- Array of materials
    equipment_used TEXT[], -- Array of equipment
    warranty_period_months INTEGER NOT NULL,
    quality_certificate_number VARCHAR(50) NOT NULL,
    environmental_compliance VARCHAR(200),
    project_status VARCHAR(20) DEFAULT 'completed',
    quality_rating INTEGER CHECK (quality_rating >= 1 AND quality_rating <= 5),
    final_inspection_date DATE,
    additional_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Water Quality Reports Table
CREATE TABLE IF NOT EXISTS water_quality_reports (
    id SERIAL PRIMARY KEY,
    feature_id VARCHAR(50) NOT NULL,
    feature_type VARCHAR(20) NOT NULL CHECK (feature_type IN ('well', 'pond', 'borehole')),
    test_date DATE NOT NULL,
    ph_level DECIMAL(3,1) NOT NULL,
    tds_ppm INTEGER NOT NULL, -- Total Dissolved Solids
    conductivity INTEGER NOT NULL, -- μS/cm
    turbidity DECIMAL(4,1) NOT NULL, -- NTU
    temperature DECIMAL(4,1) NOT NULL, -- Celsius
    ecoli_count INTEGER NOT NULL DEFAULT 0, -- CFU/100ml
    coliform_count INTEGER NOT NULL DEFAULT 0, -- CFU/100ml
    overall_quality VARCHAR(20) NOT NULL CHECK (overall_quality IN ('excellent', 'good', 'fair', 'poor', 'unacceptable')),
    testing_laboratory VARCHAR(100) NOT NULL,
    next_test_due_date DATE,
    recommended_treatment TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Maintenance Activities Table
CREATE TABLE IF NOT EXISTS maintenance_activities (
    id SERIAL PRIMARY KEY,
    feature_id VARCHAR(50) NOT NULL,
    feature_type VARCHAR(20) NOT NULL CHECK (feature_type IN ('well', 'pond', 'borehole')),
    activity_date DATE NOT NULL,
    activity_type VARCHAR(50) NOT NULL,
    activity_status VARCHAR(20) NOT NULL CHECK (activity_status IN ('completed', 'in_progress', 'scheduled', 'overdue')),
    priority VARCHAR(10) NOT NULL CHECK (priority IN ('low', 'medium', 'high')),
    cost DECIMAL(8,2) NOT NULL,
    duration_hours INTEGER NOT NULL,
    technician VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    parts_replaced TEXT[], -- Array of parts
    equipment_used TEXT[], -- Array of equipment
    effectiveness_rating INTEGER CHECK (effectiveness_rating >= 1 AND effectiveness_rating <= 5),
    next_maintenance_date DATE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_construction_details_feature_id ON construction_details(feature_id);
CREATE INDEX IF NOT EXISTS idx_water_quality_reports_feature_id ON water_quality_reports(feature_id);
CREATE INDEX IF NOT EXISTS idx_water_quality_reports_test_date ON water_quality_reports(test_date DESC);
CREATE INDEX IF NOT EXISTS idx_maintenance_activities_feature_id ON maintenance_activities(feature_id);
CREATE INDEX IF NOT EXISTS idx_maintenance_activities_activity_date ON maintenance_activities(activity_date DESC);

-- Add foreign key constraints (assuming we have a main infrastructure table)
-- ALTER TABLE construction_details ADD CONSTRAINT fk_construction_feature FOREIGN KEY (feature_id) REFERENCES infrastructure(id);
-- ALTER TABLE water_quality_reports ADD CONSTRAINT fk_water_quality_feature FOREIGN KEY (feature_id) REFERENCES infrastructure(id);
-- ALTER TABLE maintenance_activities ADD CONSTRAINT fk_maintenance_feature FOREIGN KEY (feature_id) REFERENCES infrastructure(id);

COMMIT;