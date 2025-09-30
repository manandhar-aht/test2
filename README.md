# � Advanced Water Resources GIS Platform

**A comprehensive geospatial analysis platform featuring hierarchical data models, complex nested features, advanced geological analytics, and real-time water quality monitoring systems for the Sahel region.**

# 🌊 Advanced Water Resources GIS Platform

**A comprehensive geospatial analysis platform featuring optimized server-side styling, advanced performance optimizations, and real-time water infrastructure monitoring for the Sahel region.**

## 🚀 Platform Capabilities

### 🎯 Core Features
- **Optimized WMS Performance**: Server-side SLD styling with enhanced caching
- **Water Infrastructure Visualization**: Wells, ponds, and boreholes with custom styling
- **Performance Dashboard**: Real-time monitoring and testing capabilities
- **Advanced Layer Controls**: Interactive filtering and visualization options

### 🎯 Key Interfaces
1. **[Main Water Management Interface](http://localhost:8080/)** - Optimized water infrastructure visualization
2. **[Performance Dashboard](http://localhost:8080/performance_dashboard.html)** - Real-time performance monitoring
3. **[Performance Test](http://localhost:8080/test_wms.html)** - WMS optimization verification
4. **[GeoServer Admin](http://localhost:8080/geoserver/)** - Full server management

### ⚡ Performance Features
- **Server-Side SLD Styling**: Eliminated 400 Bad Request errors, 83% URL size reduction
- **Optimized Image Format**: PNG8 with maximum compression for faster loading
- **Enhanced Caching**: 4096 tile cache with intelligent retry logic
- **Regional Optimization**: Custom tile grid optimized for Chad region (13°-24°E, 7°-23°N)

---



## 🏗️ Architecture Overview

- **PostgreSQL/PostGIS**: Spatial database storing wells, boreholes, and ponds data with construction details, water quality reports, and maintenance activities
- **GeoServer**: Map server providing WMS/WFS services with custom styling and optimized performance
- **JavaEE REST API**: WildFly 26.1.3 application server with Jersey JAX-RS providing REST endpoints for feature analysis and infrastructure data
- **Nginx Web App**: OpenLayers-based interactive web map interface with API proxy and CORS support
- **Docker Compose**: Orchestrates all services with proper networking and health checks

## 📋 Prerequisites

- Docker and Docker Compose
- Git (for repository management)
- Web browser for accessing the application

## 🚀 Quick Start

### 1. Build and Start Services
```bash
# Build all Docker images from source
docker compose build
# Reason: Creates custom images with application-specific configurations and dependencies

# Start all services in detached mode
docker compose up -d
# Reason: Runs containers in background, allowing terminal use for other commands
```

### 2. Verify Services Status
```bash
# Check running containers and their health status
docker compose ps
# Reason: Confirms all services are running and healthy before proceeding

# Monitor container logs for troubleshooting
docker compose logs geoserver
# Reason: GeoServer takes time to start; logs help verify successful initialization
```

## 🗄️ Database Setup & Data Publishing

### PostGIS Layer Publishing
```bash
# Publish wells, boreholes, and ponds from PostGIS database
docker exec webapp python3 /publish_postgis_layers.py
# Reason: Automates creation of GeoServer workspace 'sahel' and publishes spatial data layers
```

### Administrative Boundaries Publishing
```bash
# Copy and execute Chad administrative regions publishing script
docker cp /workspaces/test2/publish_chad_admin.py webapp:/publish_chad_admin.py
docker exec webapp python3 /publish_chad_admin.py
# Reason: Publishes Chad administrative boundaries (4 levels) from shapefiles to 'chad' workspace
```

### Custom Styling Application
```bash
# Copy style files and apply custom styling to layers
docker cp /workspaces/test2/styles/ webapp:/styles/
docker cp /workspaces/test2/apply_styles.py webapp:/apply_styles.py
docker exec webapp python3 /apply_styles.py
# Reason: Creates distinct visual styles (blue circles for wells, red squares for boreholes, teal triangles for ponds)
```

## 🎯 Service Access Points

| Service | URL | Credentials |
|---------|-----|-------------|
| **Main Web Map** | http://localhost:8080/ | - |
| **JavaEE REST API** | http://localhost:8080/api/ | - |
| **API Health Check** | http://localhost:8080/api/health | - |
| **Construction Details** | http://localhost:8080/api/features/construction-details/{featureId} | - |
| **Water Quality Reports** | http://localhost:8080/api/features/water-quality/{featureId} | - |
| **Maintenance Activities** | http://localhost:8080/api/features/maintenance/{featureId} | - |
| **Styling Test Page** | http://localhost:8080/styling-test.html | - |
| **GeoServer Admin** | http://localhost:8080/geoserver/web/ | admin/geoserver |
| **WildFly Management** | http://localhost:9990/ | - |
| **PostgreSQL** | localhost:5432 | geouser/geopass |

## 🔍 Testing & Validation Commands

### Layer Verification
```bash
# List all published layers in GeoServer
curl -u admin:geoserver "http://localhost:8080/geoserver/rest/layers" | python3 -m json.tool
# Reason: Confirms all layers (wells, boreholes, ponds, admin regions) are properly published

# Check specific workspace content
curl -u admin:geoserver "http://localhost:8080/geoserver/rest/workspaces/sahel/datastores" | python3 -m json.tool
# Reason: Verifies PostGIS datastore connection and available feature types
```

### WMS Service Testing
```bash
# Test wells layer with custom styling
curl -I "http://localhost:8080/geoserver/sahel/wms?service=WMS&version=1.1.0&request=GetMap&layers=sahel:wells&styles=wells_style&bbox=-30,-20,40,35&width=512&height=512&srs=EPSG:4326&format=image/png"
# Reason: Validates WMS endpoint functionality and custom style application

# Test Chad administrative boundaries
curl -I "http://localhost:8080/geoserver/chad/wms?service=WMS&version=1.1.0&request=GetMap&layers=chad:gadm41_TCD_0&bbox=-24,7,24,23&width=512&height=512&srs=EPSG:4326&format=image/png"
# Reason: Confirms shapefile layers are properly rendered via WMS
```

### JavaEE API Testing & Validation
```bash
# Test JavaEE API health endpoint
curl "http://localhost:8080/api/health" | python3 -m json.tool
# Purpose: Verify JavaEE application server is running and API is accessible
# Expected Response: {"status":"UP","service":"Water Infrastructure API","timestamp":...}

# Test construction details API endpoint
curl "http://localhost:8080/api/features/construction-details/well_central_chad" | python3 -m json.tool
# Purpose: Validate construction details API returns comprehensive infrastructure data
# Returns: contractor info, construction method, costs, materials, equipment, quality ratings

# Test water quality reports API
curl "http://localhost:8080/api/features/water-quality/well_1" | python3 -m json.tool
# Purpose: Verify water quality testing data with pH, turbidity, bacteria counts, laboratory results
# Returns: Array of quality test results with dates, parameters, and recommendations

# Test maintenance activities API
curl "http://localhost:8080/api/features/maintenance/well_1" | python3 -m json.tool
# Purpose: Confirm maintenance records API returns activity history and scheduling
# Returns: Array of maintenance activities with costs, technicians, parts replaced, effectiveness ratings

# Quick API validation with formatted output
echo "=== Health Check ===" && curl -s http://localhost:8080/api/health | jq .
echo "=== Construction Details ===" && curl -s http://localhost:8080/api/features/construction-details/well_central_chad | jq '{contractor: .contractor_name, method: .construction_method, cost: .construction_cost}'
echo "=== Water Quality ===" && curl -s "http://localhost:8080/api/features/water-quality/well_1" | jq '.[0] | {quality: .overall_quality, ph: .ph_level, date: .test_date}'
echo "=== Maintenance ===" && curl -s "http://localhost:8080/api/features/maintenance/well_1" | jq '.[0] | {type: .activity_type, status: .activity_status, cost: .cost}'
# Purpose: Comprehensive API functionality test with formatted JSON output

# Monitor JavaEE application logs
docker compose logs -f javaee-api
# Purpose: Debug JavaEE application issues and monitor API requests

# Test API through nginx proxy (with CORS headers)
curl -s http://localhost:8080/api/health | jq .
# Purpose: Verify nginx reverse proxy routing and CORS configuration
```
```bash
# Check wells data from PostGIS
curl -u admin:geoserver "http://localhost:8080/geoserver/sahel/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=sahel:wells&maxFeatures=5&outputFormat=application/json" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(f'Wells: {len(data[\"features\"])} features')
for f in data['features'][:3]:
    props = f.get('properties', {})
    print(f'  - {props.get(\"name\")}: {props.get(\"type\")} - {props.get(\"description\")}')
"
# Reason: Validates that spatial data is accessible via WFS and contains expected attributes
```

## 🔧 Troubleshooting Commands

### Container Management
```bash
# Restart specific service if issues occur
docker compose restart geoserver
# Reason: GeoServer may need restart after configuration changes

# Rebuild and restart webapp after code changes
docker compose build webapp && docker compose up -d webapp
# Reason: Applies changes to HTML, styling, or configuration files

# View real-time logs for debugging
docker compose logs -f webapp
# Reason: Monitor live application logs for errors or request tracking
```

### Service Health Checks
```bash
# Check GeoServer admin interface accessibility
curl -I "http://localhost:8080/geoserver/web/"
# Reason: Verifies GeoServer web interface is responding and CSP issues are resolved

# Test main application page
curl -I "http://localhost:8080/"
# Reason: Confirms nginx reverse proxy is working and serving the web application

# Verify database connectivity
docker exec postgres psql -U geouser -d geodb -c "SELECT count(*) FROM spatial_data;"
# Reason: Ensures PostGIS database is accessible and contains expected data
```

### Network and Proxy Diagnostics
```bash
# Check internal container networking
docker exec webapp ping geoserver
# Reason: Verifies containers can communicate via Docker network

# Test GeoServer from within webapp container
docker exec webapp curl -I "http://geoserver:8080/geoserver/"
# Reason: Confirms internal service discovery and connectivity works
```

## 📊 Published Layers

### Water Infrastructure (Sahel Workspace)
- `sahel:v_water_infrastructure_comprehensive` - **Optimized comprehensive layer** with server-side SLD styling
- `sahel:wells` - Individual wells layer (legacy)
- `sahel:boreholes` - Individual boreholes layer (legacy)
- `sahel:ponds` - Individual ponds layer (legacy)

### Administrative Boundaries (Chad Workspace)
- `chad:gadm41_TCD_0` - Country level boundaries
- `chad:gadm41_TCD_1` - Province level boundaries
- `chad:gadm41_TCD_2` - Department level boundaries
- `chad:gadm41_TCD_3` - Sub-prefecture level boundaries

## 🎨 Server-Side Styling & Performance

### Optimized Water Infrastructure Styling
Our water infrastructure features are styled using server-side SLD (Styled Layer Descriptor) for optimal performance:

| Type | Symbol | Color | Size | Styling Method |
|------|--------|-------|------|----------------|
| Wells | Circle | Blue (#2980b9) | 12px | Server-side SLD |
| Ponds | Square | Blue (#3498db) | 14px | Server-side SLD |
| Boreholes | Triangle | Purple (#8841da) | 10px | Server-side SLD |

### Performance Optimizations Implemented
- ✅ **Server-Side SLD Styling**: Eliminated 400 Bad Request errors, 83% URL size reduction
- ✅ **Optimized Image Format**: PNG8 with 9-level compression for smaller file sizes
- ✅ **Enhanced Caching**: 4096 tile cache with intelligent retry logic
- ✅ **Regional Tile Grid**: Custom grid optimized for Chad region (13°-24°E, 7°-23°N)
- ✅ **Format Optimization**: `dpi:96;antialias:full;png_compression:9`

### Performance Testing & Monitoring
- **Performance Dashboard**: http://localhost:8080/performance_dashboard.html
- **WMS Test Page**: http://localhost:8080/test_wms.html
- **Automated Performance Script**: `./performance_test.sh`

All symbols include:
- Full antialiasing for crisp rendering
- Optimized transparency and compression
- Server-side style caching for faster loading
- Error handling with automatic retry logic

## �️ JavaEE API Deployment

### WildFly Application Server Features
- **WildFly 26.1.3**: Modern Jakarta EE application server with full EE 8 support
- **PostgreSQL Integration**: JNDI datasource with PostGIS spatial database connectivity
- **Jersey JAX-RS**: REST API framework with JSON processing and error handling
- **Docker Multi-stage Build**: Maven compilation + WildFly runtime optimization
- **Health Monitoring**: Built-in health checks and service status endpoints

### API Endpoint Documentation

#### Health Check Endpoint
```bash
GET /api/health
# Returns: {"status":"UP","service":"Water Infrastructure API","timestamp":1759253915240}
```

#### Construction Details Endpoint
```bash
GET /api/features/construction-details/{featureId}
# Example: /api/features/construction-details/well_central_chad
# Returns: Complete construction data including contractor, method, costs, materials, equipment
```

#### Water Quality Reports Endpoint
```bash
GET /api/features/water-quality/{featureId}
# Example: /api/features/water-quality/well_1
# Returns: Array of quality test results with pH, turbidity, bacteria counts, laboratory info
```

#### Maintenance Activities Endpoint
```bash
GET /api/features/maintenance/{featureId}
# Example: /api/features/maintenance/well_1
# Returns: Array of maintenance history with dates, costs, technicians, parts replaced
```

### JavaEE API Development Commands
```bash
# Build JavaEE API container
docker compose build javaee-api
# Purpose: Compiles Maven project and creates WildFly runtime image with PostgreSQL driver

# Restart JavaEE service after code changes
docker compose stop javaee-api && docker compose up -d javaee-api
# Purpose: Applies Java code changes and restarts WildFly application server

# Monitor JavaEE startup and deployment
docker compose logs -f javaee-api
# Purpose: Track WildFly startup, WAR deployment, and API request logging

# Test database connectivity from JavaEE container
docker exec javaee-api curl -s http://localhost:8080/api/health
# Purpose: Verify internal API functionality and database connection
```

## �🔄 Development Workflow

### Making Changes
```bash
# After modifying frontend code (HTML, CSS, JavaScript)
docker compose build webapp && docker compose up -d webapp
# Purpose: Rebuilds webapp container with latest changes and restarts it

# After modifying JavaEE API code (Java, REST endpoints)
docker compose build javaee-api && docker compose up -d javaee-api
# Purpose: Recompiles Maven project and deploys updated WAR to WildFly

# After modifying GeoServer configuration
docker compose restart geoserver

# After database schema changes
docker compose down && docker compose up -d
```

### Adding New Layers
```bash
# Create new SLD style file in /styles/ directory
# Update apply_styles.py script with new style definitions
# Rebuild and apply: docker exec webapp python3 /apply_styles.py
```

## 🛠️ Configuration Files

- `docker-compose.yml` - Service orchestration and networking with JavaEE API service
- `webapp/nginx.conf` - Reverse proxy configuration with CSP headers and `/api` routing
- `webapp/index.html` - OpenLayers web map interface
- `javaee-api/Dockerfile` - Multi-stage Maven build with WildFly runtime
- `javaee-api/pom.xml` - Maven dependencies including Jersey JAX-RS and PostgreSQL driver
- `javaee-api/standalone-original.xml` - WildFly configuration with PostgreSQL datasource
- `javaee-api/src/main/java/com/waterresources/api/` - REST API services and application configuration
- `init-scripts/init-db.sql` - PostGIS database initialization with feature tables
- `styles/*.sld` - Custom SLD styling definitions

## 📝 Notes

- **CSP Configuration**: Custom Content Security Policy headers resolve form submission issues in GeoServer admin interface
- **Reverse Proxy**: Nginx serves as reverse proxy, routing `/geoserver` requests to GeoServer container
- **Docker Networks**: All containers communicate via `geo-network` bridge network
- **Data Persistence**: Database data persists in Docker volumes across container restarts
- **Port Mapping**: Only port 8080 is exposed to host, providing single entry point

## 🔧 Recent Improvements (v2.1.0)

### JavaEE API Deployment (NEW)
- ✅ **WildFly 26.1.3 Deployment**: Full Jakarta EE application server with PostgreSQL integration
- ✅ **REST API Endpoints**: Construction details, water quality reports, and maintenance activities APIs
- ✅ **PostgreSQL Array Handling**: Fixed JDBC type 2003 errors using `array_to_string()` for text[] columns
- ✅ **EntityManager Integration**: Proper JPA/Hibernate configuration with JNDI datasource
- ✅ **Docker Multi-stage Build**: Optimized Maven compilation with WildFly runtime
- ✅ **Health Monitoring**: Built-in health checks and service status endpoints
- ✅ **Nginx API Proxy**: CORS-enabled reverse proxy routing for `/api` endpoints

### Previous Improvements (v2.0.2)
- ✅ **API Cleanup**: Removed legacy `api.php` and `api.py` files and updated Dockerfile
- ✅ **Browser Cache Detection**: Added automatic detection of old cached API calls with user alerts
- ✅ **Layer Error Fixes**: Commented out non-existent `water_management_zones_detailed` layer to prevent XML parsing errors
- ✅ **Enhanced Sample Data**: Added wells and ponds at user-clicked coordinates for better testing
- ✅ **Strong Cache Busting**: Implemented fetch override and cache-busting headers
- ✅ **Improved Error Handling**: Better content-type checking and fallback mechanisms
- ✅ **Infinite Retry Loop Fix**: Fixed construction details API retry mechanism that was causing console spam
- ✅ **Feature Detection Mapping**: Corrected array mapping to show proper infrastructure labels

## 🔗 Integration Details

The application integrates three main components:

1. **PostGIS Database**: Stores spatial data with geographic coordinates
2. **GeoServer**: Provides OGC-compliant web services (WMS/WFS) with custom styling
3. **Web Interface**: OpenLayers-based interactive map consuming GeoServer services

This architecture enables scalable, standards-based geospatial data visualization and analysis.

## 📚 Complete CLI Command Reference

### Initial Setup Commands
```bash
# Build all services from Dockerfiles
docker compose build
# Purpose: Compiles custom images with application-specific configurations

# Start all services in background
docker compose up -d
# Purpose: Launches the complete stack (postgres, geoserver, webapp) with networking

# Monitor startup progress
docker compose logs -f geoserver
# Purpose: Track GeoServer initialization (takes 30-60 seconds to fully start)
```

### Service Status & Health Monitoring
```bash
# Check all container status
docker compose ps
# Purpose: View running status, ports, and health check results

# Monitor real-time logs for specific service
docker compose logs -f webapp
# Purpose: Debug issues, monitor HTTP requests, track application behavior

# View recent log entries
docker compose logs --tail=20 geoserver
# Purpose: Quick check for recent errors or startup messages
```

### Layer Publishing & Data Setup
```bash
# Publish PostGIS spatial data layers
docker exec webapp python3 /publish_postgis_layers.py
# Purpose: Creates 'sahel' workspace, PostGIS datastore, publishes wells/boreholes/ponds

# Copy and publish Chad administrative boundaries
docker cp /workspaces/test2/publish_chad_admin.py webapp:/publish_chad_admin.py
docker exec webapp python3 /publish_chad_admin.py
# Purpose: Creates 'chad' workspace, publishes 4-level administrative boundaries from shapefiles

# Apply custom styling to water infrastructure
docker cp /workspaces/test2/styles/ webapp:/styles/
docker cp /workspaces/test2/apply_styles.py webapp:/apply_styles.py
docker exec webapp python3 /apply_styles.py
# Purpose: Uploads SLD styles, applies distinct symbols (circles/squares/triangles) and colors
```

### GeoServer API Interactions
```bash
# List all published layers
curl -u admin:geoserver "http://localhost:8080/geoserver/rest/layers" | python3 -m json.tool
# Purpose: Verify all layers are properly published and accessible

# Check workspace datastores
curl -u admin:geoserver "http://localhost:8080/geoserver/rest/workspaces/sahel/datastores" | python3 -m json.tool
# Purpose: Confirm PostGIS connection and available feature types

# Verify layer styling configuration
curl -u admin:geoserver "http://localhost:8080/geoserver/rest/layers/sahel:wells" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(f'Layer: {data[\"layer\"][\"name\"]}')
print(f'Default Style: {data[\"layer\"][\"defaultStyle\"][\"name\"]}')
"
# Purpose: Confirm custom styles are applied as default layer styling

# List available styles in GeoServer
curl -u admin:geoserver "http://localhost:8080/geoserver/rest/styles" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print('Available Styles:')
for style in data['styles']['style']:
    print(f'  - {style[\"name\"]}')
"
# Purpose: Verify custom SLD styles (wells_style, boreholes_style, ponds_style) are uploaded
```

### WMS Service Testing & Validation
```bash
# Test individual layer rendering
curl -I "http://localhost:8080/geoserver/sahel/wms?service=WMS&version=1.1.0&request=GetMap&layers=sahel:wells&styles=wells_style&bbox=-30,-20,40,35&width=512&height=512&srs=EPSG:4326&format=image/png"
# Purpose: Validate WMS endpoint responds correctly with custom styling

# Test combined layer rendering
curl -I "http://localhost:8080/geoserver/sahel/wms?service=WMS&version=1.1.0&request=GetMap&layers=sahel:wells,sahel:boreholes,sahel:ponds&styles=wells_style,boreholes_style,ponds_style&bbox=10,8,25,18&width=800&height=600&srs=EPSG:4326&format=image/png"
# Purpose: Ensure multiple layers render together with correct styling

# Test Chad administrative boundaries
curl -I "http://localhost:8080/geoserver/chad/wms?service=WMS&version=1.1.0&request=GetMap&layers=chad:gadm41_TCD_0&bbox=-24,7,24,23&width=512&height=512&srs=EPSG:4326&format=image/png"
# Purpose: Confirm shapefile layers are accessible via WMS
```

### WFS Data Verification
```bash
# Check wells data content and structure
curl -u admin:geoserver "http://localhost:8080/geoserver/sahel/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=sahel:wells&maxFeatures=5&outputFormat=application/json" | python3 -c "
import sys, json
data = json.load(sys.stdin)
if 'features' in data:
    print(f'Wells layer has {len(data[\"features\"])} features')
    for i, feature in enumerate(data['features'][:3]):
        props = feature.get('properties', {})
        print(f'  {i+1}. {props.get(\"name\", \"Unknown\")} - {props.get(\"type\", \"Unknown\")}')
else:
    print('No features found')
"
# Purpose: Verify spatial data is accessible via WFS and contains expected attributes

# Test Chad country-level administrative data
curl -u admin:geoserver "http://localhost:8080/geoserver/chad/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=chad:gadm41_TCD_0&maxFeatures=1&outputFormat=application/json" | python3 -c "
import sys, json
data = json.load(sys.stdin)
if 'features' in data and len(data['features']) > 0:
    print('Chad country layer loaded successfully')
    print(f'Total features: {len(data[\"features\"])}')
else:
    print('No features found in Chad country layer')
"
# Purpose: Validate shapefile data is properly loaded and accessible
```

### Troubleshooting & Debugging Commands
```bash
# Restart specific service after configuration changes
docker compose restart geoserver
# Purpose: Apply configuration changes without full stack restart

# Rebuild and restart webapp after code changes
docker compose build webapp && docker compose up -d webapp
# Purpose: Deploy frontend changes (HTML, CSS, JavaScript)

# Test internal container networking
docker exec webapp ping geoserver
# Purpose: Verify containers can communicate via Docker network

# Check GeoServer accessibility from webapp container
docker exec webapp curl -I "http://geoserver:8080/geoserver/"
# Purpose: Confirm internal service discovery works correctly

# Test main application accessibility
curl -I "http://localhost:8080/"
# Purpose: Verify nginx reverse proxy is serving the web application

# Check GeoServer admin interface (CSP fix verification)
curl -v "http://localhost:8080/geoserver/web/" 2>&1 | grep -i "content-security-policy"
# Purpose: Confirm CSP headers allow form submissions (fixes login issues)

# Database connectivity test
docker exec postgres psql -U geouser -d geodb -c "SELECT count(*) FROM spatial_data WHERE type='well';"
# Purpose: Verify PostGIS database contains expected spatial data
```

### File Operations & Configuration
```bash
# Copy files to running containers
docker cp /workspaces/test2/publish_chad_admin.py webapp:/publish_chad_admin.py
# Purpose: Transfer scripts or configuration files to containers

# Copy styling test page for verification
docker cp /workspaces/test2/webapp/html/styling-test.html webapp:/usr/share/nginx/html/styling-test.html
# Purpose: Deploy additional web pages for testing layer styling

# View container file system
docker exec webapp ls -la /usr/share/nginx/html/
# Purpose: Verify files are correctly placed in web server document root
```

### Performance & Monitoring
```bash
# Monitor container resource usage
docker stats
# Purpose: Track CPU, memory usage of running containers

# Check Docker network configuration
docker network ls
docker network inspect test2_geo-network
# Purpose: Verify container networking setup and IP assignments

# View container environment variables
docker exec geoserver env | grep -E "(GEOSERVER|POSTGRES)"
# Purpose: Confirm environment configuration is correct
```

### Cleanup & Reset Commands
```bash
# Stop all services
docker compose down
# Purpose: Gracefully shut down all containers

# Remove containers and networks (keeps volumes)
docker compose down --volumes
# Purpose: Complete cleanup including data volumes (use with caution)

# Remove unused Docker resources
docker system prune -f
# Purpose: Clean up dangling images and containers to free disk space
```

Each command includes its specific purpose to help understand the development and troubleshooting workflow. This comprehensive reference enables quick problem resolution and system understanding.

