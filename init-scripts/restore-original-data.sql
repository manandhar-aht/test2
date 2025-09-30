-- Insert sample data for wells, ponds, and boreholes as POINTS
-- This restores the data that GeoServer layers expect

-- Sample Wells (Chad region coordinates)
INSERT INTO wells (well_id, owner, well_type, depth_m, static_water_level_m, yield_liters_per_hour, status, name, description, geom) VALUES 
('well_1', 'Chad Community 1', 'tube_well', 45.0, 8.0, 1200, 'active', 'NDjamena Community Well 1', 'Primary water source for urban community', ST_GeomFromText('POINT(15.0557 12.1348)', 4326)),
('well_2', 'Chad Community 2', 'tube_well', 38.0, 9.0, 1000, 'active', 'Moundou Community Well', 'Secondary water source with good yield', ST_GeomFromText('POINT(16.0841 8.5667)', 4326)),
('well_3', 'Chad Community 3', 'traditional', 28.0, 7.0, 800, 'active', 'Sarh Traditional Well', 'Traditional community well with hand pump', ST_GeomFromText('POINT(18.3923 9.1434)', 4326)),
('well_4', 'Chad Community 4', 'tube_well', 52.0, 12.0, 1500, 'active', 'Abeche Deep Well', 'Deep well serving large community', ST_GeomFromText('POINT(20.8316 13.8292)', 4326)),
('well_5', 'Chad Community 5', 'community', 35.0, 10.0, 1100, 'active', 'Doba Community Well', 'Oil region community water source', ST_GeomFromText('POINT(16.8501 8.6500)', 4326));

-- Sample Ponds (Chad region coordinates as points representing pond centers)
INSERT INTO ponds (pond_id, name, surface_area_sqm, maximum_depth_m, is_perennial, primary_use, capacity_liters, status, description, geom) VALUES
('pond_1', 'Lake Chad Retention Pond', 250000, 3.5, true, 'irrigation', 875000000, 'active', 'Large irrigation pond near Lake Chad', ST_GeomFromText('POINT(14.1053 13.8229)', 4326)),
('pond_2', 'Chari River Pond', 180000, 2.8, true, 'fishery', 504000000, 'active', 'Fish farming pond along Chari River', ST_GeomFromText('POINT(15.3103 11.3439)', 4326)),
('pond_3', 'Logone Valley Pond', 320000, 4.0, false, 'irrigation', 1280000000, 'active', 'Seasonal irrigation pond in fertile valley', ST_GeomFromText('POINT(16.1451 10.3406)', 4326));

-- Sample Boreholes (Chad region coordinates)
INSERT INTO boreholes (borehole_id, drilling_company, total_depth_m, pump_capacity_lph, drilling_cost, completion_date, status, name, description, geom) VALUES
('borehole_1', 'Chad Drilling Co.', 65.0, 1800, 22000.00, '2024-02-15', 'active', 'Central Chad Borehole 1', 'High-capacity borehole with submersible pump', ST_GeomFromText('POINT(18.9103 12.9284)', 4326)),
('borehole_2', 'Sahara Water Solutions', 72.0, 2000, 25000.00, '2024-03-20', 'active', 'Eastern Chad Borehole', 'Deep borehole serving remote communities', ST_GeomFromText('POINT(20.9248 14.4353)', 4326)),
('borehole_3', 'Lake Chad Engineering', 58.0, 1600, 18500.00, '2024-01-10', 'active', 'Northern Chad Borehole', 'Solar-powered borehole system', ST_GeomFromText('POINT(17.1165 15.1531)', 4326));

COMMIT;