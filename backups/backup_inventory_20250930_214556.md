# Water Resources Database Backup Inventory
**Backup Date**: Tue Sep 30 21:45:57 UTC 2025
**Database**: geodb
**PostgreSQL Version**: PostgreSQL 15.4 (Debian 15.4-1.pgdg110+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 10.2.1-6) 10.2.1 20210110, 64-bit

## Backup Files Created

### 1. Full Database Backup
- **File**: `water_resources_full_20250930_214556.sql`
- **Type**: Complete SQL dump
- **Size**: 102K
- **Purpose**: Complete database restoration
- **Restore Command**: `psql -U geouser -d geodb < water_resources_full_20250930_214556.sql`

### 2. Custom Format Backup  
- **File**: `water_resources_custom_20250930_214556.backup`
- **Type**: Compressed binary format
- **Size**: 69K
- **Purpose**: Fast restoration, selective restore
- **Restore Command**: `pg_restore -U geouser -d geodb water_resources_custom_20250930_214556.backup`

### 3. Schema-Only Backup
- **File**: `water_resources_schema_20250930_214556.sql`
- **Type**: Database structure only
- **Size**: 28K
- **Purpose**: Structure verification, migration planning

### 4. Data-Only Backup
- **File**: `water_resources_data_20250930_214556.sql`
- **Type**: Data without structure
- **Size**: 75K
- **Purpose**: Data analysis, data migration

### 5. Water Infrastructure Tables
- **File**: `water_infrastructure_tables_20250930_214556.sql`
- **Type**: Core water infrastructure tables
- **Size**: 92K
- **Purpose**: Core data backup for water management system

## Database Statistics
```

```

## Water Infrastructure Summary
```
          type          | count 
------------------------+-------
 Wells                  |    12
 Boreholes              |     6
 Ponds                  |     7
 Water Zones            |     6
 Construction Details   |    52
 Water Quality Reports  |    72
 Maintenance Activities |    58
(7 rows)
```

## Restoration Instructions

### Complete Database Restore
```bash
# Stop the current database
docker compose down

# Start fresh database
docker compose up -d postgres

# Wait for database to be ready
sleep 10

# Restore from SQL dump
cat water_resources_full_20250930_214556.sql | docker exec -i postgres psql -U geouser -d geodb

# Or restore from custom format
docker cp water_resources_custom_20250930_214556.backup postgres:/tmp/
docker exec postgres pg_restore -U geouser -d geodb /tmp/water_resources_custom_20250930_214556.backup
```

### Selective Restore
```bash
# Restore only water infrastructure tables
cat water_infrastructure_tables_20250930_214556.sql | docker exec -i postgres psql -U geouser -d geodb

# Restore specific table from custom backup
docker exec postgres pg_restore -U geouser -d geodb -t wells water_resources_custom_20250930_214556.backup
```
