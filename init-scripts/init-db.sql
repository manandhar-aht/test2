-- Simple initialization for feature analysis functionality
-- Load only the essential schema and data for the API

-- Create feature analysis schema
\i /docker-entrypoint-initdb.d/simple-feature-schema.sql

-- Insert sample data
\i /docker-entrypoint-initdb.d/simple-feature-data.sql

-- Grant permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO geouser;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO geouser;
('BH_CHAD_020', 'Chad Drilling Co.', 71.0, 1600, ST_GeomFromText('POINT(18.9933 12.2125)', 4326)),
('BH_CHAD_021', 'Chad Drilling Co.', 79.0, 1950, ST_GeomFromText('POINT(18.2433 13.5212)', 4326)),
('BH_CHAD_022', 'Chad Drilling Co.', 76.0, 1800, ST_GeomFromText('POINT(18.5534 12.1123)', 4326)),
('BH_CHAD_023', 'Chad Drilling Co.', 82.0, 2100, ST_GeomFromText('POINT(18.2934 13.5896)', 4326)),
('BH_CHAD_024', 'Chad Drilling Co.', 73.0, 1700, ST_GeomFromText('POINT(18.1234 13.6333)', 4326)),
('BH_CHAD_025', 'Chad Drilling Co.', 78.0, 1900, ST_GeomFromText('POINT(18.9934 12.3324)', 4326));

-- Chad sample ponds (using polygon geometry for water bodies)
INSERT INTO ponds (pond_id, name, is_perennial, capacity_liters, maximum_depth_m, geom) VALUES
('POND_NIGERIA_001', 'Pond in Nigeria', true, 150000, 4.5, ST_GeomFromText('POLYGON((7.69 11.38, 7.71 11.38, 7.71 11.40, 7.69 11.40, 7.69 11.38))', 4326)),
('POND_MALI_SEASONAL_001', 'Seasonal Pond in Mali', false, 80000, 3.2, ST_GeomFromText('POLYGON((-4.51 16.99, -4.49 16.99, -4.49 17.01, -4.51 17.01, -4.51 16.99))', 4326)),
('POND_CHAD_001', 'Chad Pond 1', true, 200000, 5.0, ST_GeomFromText('POLYGON((19.99 14.92, 20.02 14.92, 20.02 14.94, 19.99 14.94, 19.99 14.92))', 4326)),
('POND_CHAD_002', 'Chad Pond 2', false, 120000, 3.8, ST_GeomFromText('POLYGON((18.91 12.43, 18.94 12.43, 18.94 12.45, 18.91 12.45, 18.91 12.43))', 4326)),
('POND_CHAD_003', 'Chad Pond 3', true, 180000, 4.7, ST_GeomFromText('POLYGON((16.10 20.14, 16.13 20.14, 16.13 20.17, 16.10 20.17, 16.10 20.14))', 4326)),
('POND_CHAD_004', 'Chad Pond 4', false, 100000, 3.5, ST_GeomFromText('POLYGON((16.54 12.00, 16.57 12.00, 16.57 12.03, 16.54 12.03, 16.54 12.00))', 4326)),
('POND_CHAD_005', 'Chad Pond 5', true, 250000, 5.5, ST_GeomFromText('POLYGON((23.81 14.10, 23.84 14.10, 23.84 14.12, 23.81 14.12, 23.81 14.10))', 4326)),
('POND_CHAD_006', 'Chad Pond 6', false, 90000, 3.3, ST_GeomFromText('POLYGON((17.30 14.33, 17.33 14.33, 17.33 14.35, 17.30 14.35, 17.30 14.33))', 4326)),
('POND_CHAD_007', 'Chad Pond 7', true, 170000, 4.5, ST_GeomFromText('POLYGON((19.13 13.33, 19.16 13.33, 19.16 13.35, 19.13 13.35, 19.13 13.33))', 4326)),
('POND_CHAD_008', 'Chad Pond 8', false, 110000, 3.6, ST_GeomFromText('POLYGON((19.92 13.37, 19.95 13.37, 19.95 13.39, 19.92 13.39, 19.92 13.37))', 4326)),
('POND_CHAD_009', 'Chad Pond 9', true, 190000, 4.8, ST_GeomFromText('POLYGON((20.37 11.51, 20.40 11.51, 20.40 11.53, 20.37 11.53, 20.37 11.51))', 4326)),
('POND_CHAD_010', 'Chad Pond 10', false, 130000, 3.9, ST_GeomFromText('POLYGON((19.36 13.81, 19.39 13.81, 19.39 13.83, 19.36 13.83, 19.36 13.81))', 4326));