#!/bin/bash

# Water Resources Database Backup Script
# Creates comprehensive backups of the PostgreSQL/PostGIS database

set -e

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="backups"
DATABASE="geodb"
USERNAME="geouser"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo "🚀 Creating Water Resources Database Backup - $TIMESTAMP"
echo "=================================================="

# 1. Full SQL dump (human readable, good for version control)
echo "📄 Creating SQL dump backup..."
docker exec postgres pg_dump -U "$USERNAME" -d "$DATABASE" > "$BACKUP_DIR/water_resources_full_$TIMESTAMP.sql"

# 2. Custom format backup (compressed, faster restore)
echo "📦 Creating compressed custom format backup..."
docker exec postgres pg_dump -U "$USERNAME" -d "$DATABASE" --format=custom --compress=9 --file="/tmp/water_resources_custom_$TIMESTAMP.backup"
docker cp postgres:/tmp/water_resources_custom_$TIMESTAMP.backup "$BACKUP_DIR/"
docker exec postgres rm "/tmp/water_resources_custom_$TIMESTAMP.backup"

# 3. Schema-only backup (for structure verification)
echo "🏗️ Creating schema-only backup..."
docker exec postgres pg_dump -U "$USERNAME" -d "$DATABASE" --schema-only > "$BACKUP_DIR/water_resources_schema_$TIMESTAMP.sql"

# 4. Data-only backup (for data analysis)
echo "📊 Creating data-only backup..."
docker exec postgres pg_dump -U "$USERNAME" -d "$DATABASE" --data-only > "$BACKUP_DIR/water_resources_data_$TIMESTAMP.sql"

# 5. Specific tables backup (water infrastructure focus)
echo "🌊 Creating water infrastructure tables backup..."
docker exec postgres pg_dump -U "$USERNAME" -d "$DATABASE" \
  --table=wells \
  --table=boreholes \
  --table=ponds \
  --table=water_management_zones_detailed \
  --table=feature_construction_details \
  --table=feature_water_quality_reports \
  --table=feature_maintenance_activities \
  --table=v_water_infrastructure_comprehensive \
  > "$BACKUP_DIR/water_infrastructure_tables_$TIMESTAMP.sql"

# 6. Generate backup inventory
echo "📋 Generating backup inventory..."
cat > "$BACKUP_DIR/backup_inventory_$TIMESTAMP.md" << EOF
# Water Resources Database Backup Inventory
**Backup Date**: $(date)
**Database**: $DATABASE
**PostgreSQL Version**: $(docker exec postgres psql -U $USERNAME -d $DATABASE -t -c "SELECT version();" | head -1 | xargs)

## Backup Files Created

### 1. Full Database Backup
- **File**: \`water_resources_full_$TIMESTAMP.sql\`
- **Type**: Complete SQL dump
- **Size**: $(ls -lh "$BACKUP_DIR/water_resources_full_$TIMESTAMP.sql" | awk '{print $5}')
- **Purpose**: Complete database restoration
- **Restore Command**: \`psql -U geouser -d geodb < water_resources_full_$TIMESTAMP.sql\`

### 2. Custom Format Backup  
- **File**: \`water_resources_custom_$TIMESTAMP.backup\`
- **Type**: Compressed binary format
- **Size**: $(ls -lh "$BACKUP_DIR/water_resources_custom_$TIMESTAMP.backup" | awk '{print $5}')
- **Purpose**: Fast restoration, selective restore
- **Restore Command**: \`pg_restore -U geouser -d geodb water_resources_custom_$TIMESTAMP.backup\`

### 3. Schema-Only Backup
- **File**: \`water_resources_schema_$TIMESTAMP.sql\`
- **Type**: Database structure only
- **Size**: $(ls -lh "$BACKUP_DIR/water_resources_schema_$TIMESTAMP.sql" | awk '{print $5}')
- **Purpose**: Structure verification, migration planning

### 4. Data-Only Backup
- **File**: \`water_resources_data_$TIMESTAMP.sql\`
- **Type**: Data without structure
- **Size**: $(ls -lh "$BACKUP_DIR/water_resources_data_$TIMESTAMP.sql" | awk '{print $5}')
- **Purpose**: Data analysis, data migration

### 5. Water Infrastructure Tables
- **File**: \`water_infrastructure_tables_$TIMESTAMP.sql\`
- **Type**: Core water infrastructure tables
- **Size**: $(ls -lh "$BACKUP_DIR/water_infrastructure_tables_$TIMESTAMP.sql" | awk '{print $5}')
- **Purpose**: Core data backup for water management system

## Database Statistics
\`\`\`
$(docker exec postgres psql -U $USERNAME -d $DATABASE -c "
SELECT 
    schemaname,
    tablename,
    n_tup_ins as inserts,
    n_tup_upd as updates,
    n_tup_del as deletes,
    n_live_tup as live_rows
FROM pg_stat_user_tables 
WHERE schemaname = 'public' 
ORDER BY live_rows DESC;")
\`\`\`

## Water Infrastructure Summary
\`\`\`
$(docker exec postgres psql -U $USERNAME -d $DATABASE -c "
SELECT 'Wells' as type, COUNT(*) as count FROM wells
UNION ALL
SELECT 'Boreholes', COUNT(*) FROM boreholes  
UNION ALL
SELECT 'Ponds', COUNT(*) FROM ponds
UNION ALL
SELECT 'Water Zones', COUNT(*) FROM water_management_zones_detailed
UNION ALL
SELECT 'Construction Details', COUNT(*) FROM feature_construction_details
UNION ALL
SELECT 'Water Quality Reports', COUNT(*) FROM feature_water_quality_reports
UNION ALL  
SELECT 'Maintenance Activities', COUNT(*) FROM feature_maintenance_activities;")
\`\`\`

## Restoration Instructions

### Complete Database Restore
\`\`\`bash
# Stop the current database
docker compose down

# Start fresh database
docker compose up -d postgres

# Wait for database to be ready
sleep 10

# Restore from SQL dump
cat water_resources_full_$TIMESTAMP.sql | docker exec -i postgres psql -U geouser -d geodb

# Or restore from custom format
docker cp water_resources_custom_$TIMESTAMP.backup postgres:/tmp/
docker exec postgres pg_restore -U geouser -d geodb /tmp/water_resources_custom_$TIMESTAMP.backup
\`\`\`

### Selective Restore
\`\`\`bash
# Restore only water infrastructure tables
cat water_infrastructure_tables_$TIMESTAMP.sql | docker exec -i postgres psql -U geouser -d geodb

# Restore specific table from custom backup
docker exec postgres pg_restore -U geouser -d geodb -t wells water_resources_custom_$TIMESTAMP.backup
\`\`\`
EOF

# Display summary
echo ""
echo "✅ Backup Complete!"
echo "=================="
echo "📁 Backup Directory: $BACKUP_DIR"
echo "📊 Files Created:"
ls -lh "$BACKUP_DIR"/*"$TIMESTAMP"* | awk '{print "   " $9 " (" $5 ")"}'
echo ""
echo "📖 Backup Documentation: $BACKUP_DIR/backup_inventory_$TIMESTAMP.md"
echo ""
echo "🔍 Total Backup Size: $(du -sh "$BACKUP_DIR" | cut -f1)"