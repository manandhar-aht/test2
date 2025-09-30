#!/bin/bash

# Water Resources Database Restore Script
# Restores the PostgreSQL/PostGIS database from backup files

set -e

BACKUP_DIR="backups"

# Function to list available backups
list_backups() {
    echo "📋 Available Backup Files:"
    echo "=========================="
    ls -lh "$BACKUP_DIR"/*.sql "$BACKUP_DIR"/*.backup 2>/dev/null | awk '{print $9 " (" $5 ")"}'
    echo ""
}

# Function to restore from SQL file
restore_sql() {
    local backup_file="$1"
    echo "🔄 Restoring from SQL backup: $backup_file"
    
    # Stop current services
    echo "⏹️  Stopping current services..."
    docker compose down
    
    # Start fresh database
    echo "🚀 Starting fresh database..."
    docker compose up -d postgres
    
    # Wait for database to be ready
    echo "⏱️  Waiting for database to be ready..."
    sleep 15
    
    # Restore the backup
    echo "📤 Restoring backup..."
    cat "$backup_file" | docker exec -i postgres psql -U geouser -d geodb
    
    echo "✅ SQL Restore completed!"
}

# Function to restore from custom format
restore_custom() {
    local backup_file="$1"
    echo "🔄 Restoring from custom backup: $backup_file"
    
    # Stop current services
    echo "⏹️  Stopping current services..."
    docker compose down
    
    # Start fresh database
    echo "🚀 Starting fresh database..."
    docker compose up -d postgres
    
    # Wait for database to be ready
    echo "⏱️  Waiting for database to be ready..."
    sleep 15
    
    # Copy backup to container and restore
    echo "📤 Copying backup to container..."
    docker cp "$backup_file" postgres:/tmp/restore.backup
    
    echo "📥 Restoring backup..."
    docker exec postgres pg_restore -U geouser -d geodb -v /tmp/restore.backup
    
    echo "🧹 Cleaning up..."
    docker exec postgres rm /tmp/restore.backup
    
    echo "✅ Custom format restore completed!"
}

# Function to verify restoration
verify_restore() {
    echo "🔍 Verifying restoration..."
    echo "=========================="
    
    # Check table counts
    docker exec postgres psql -U geouser -d geodb -c "
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
    SELECT 'Maintenance Activities', COUNT(*) FROM feature_maintenance_activities;
    "
    
    echo ""
    echo "🌐 Testing GeoServer connectivity..."
    sleep 5  # Give GeoServer time to reconnect
    
    # Test a simple WFS request
    if curl -s "http://localhost:8080/geoserver/sahel/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=sahel:wells&maxFeatures=1" | grep -q "FeatureCollection"; then
        echo "✅ GeoServer connectivity verified"
    else
        echo "⚠️  GeoServer may need restart: docker compose restart geoserver"
    fi
    
    echo ""
    echo "🎯 Restoration verification complete!"
}

# Main script logic
case "${1:-}" in
    "list"|"ls")
        list_backups
        ;;
    "sql")
        if [ -z "$2" ]; then
            echo "❌ Error: Please specify backup file"
            echo "Usage: $0 sql <backup_file.sql>"
            exit 1
        fi
        restore_sql "$2"
        verify_restore
        ;;
    "custom")
        if [ -z "$2" ]; then
            echo "❌ Error: Please specify backup file"
            echo "Usage: $0 custom <backup_file.backup>"
            exit 1
        fi
        restore_custom "$2"
        verify_restore
        ;;
    "auto")
        # Find the most recent backup
        latest_sql=$(ls -t "$BACKUP_DIR"/water_resources_full_*.sql 2>/dev/null | head -1)
        if [ -n "$latest_sql" ]; then
            echo "🔍 Found latest backup: $latest_sql"
            restore_sql "$latest_sql"
            verify_restore
        else
            echo "❌ No SQL backup files found in $BACKUP_DIR"
            exit 1
        fi
        ;;
    "help"|"--help"|"-h"|"")
        echo "🌊 Water Resources Database Restore Script"
        echo "=========================================="
        echo ""
        echo "Usage:"
        echo "  $0 list                    # List available backups"
        echo "  $0 sql <file.sql>         # Restore from SQL backup"
        echo "  $0 custom <file.backup>   # Restore from custom format backup"
        echo "  $0 auto                   # Restore from latest SQL backup"
        echo "  $0 help                   # Show this help"
        echo ""
        echo "Examples:"
        echo "  $0 list"
        echo "  $0 sql backups/water_resources_full_20250930_214556.sql"
        echo "  $0 custom backups/water_resources_custom_20250930_214556.backup"
        echo "  $0 auto"
        echo ""
        list_backups
        ;;
    *)
        echo "❌ Unknown command: $1"
        echo "Use '$0 help' for usage information"
        exit 1
        ;;
esac