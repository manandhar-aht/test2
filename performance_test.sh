#!/bin/bash

echo "🚀 Water Infrastructure Performance Test"
echo "========================================"

# Test server-side styled layer performance
echo "📊 Testing Server-Side SLD Performance..."

start_time=$(date +%s.%N)
response=$(curl -s -w "HTTPCODE:%{http_code};TIME:%{time_total};SIZE:%{size_download}" \
"http://localhost:8080/geoserver/sahel/wms?REQUEST=GetMap&VERSION=1.1.1&SERVICE=WMS&LAYERS=sahel:v_water_infrastructure_comprehensive&STYLES=water_infrastructure_comprehensive&SRS=EPSG:3857&BBOX=1300000,1300000,1400000,1400000&WIDTH=256&HEIGHT=256&FORMAT=image/png8&TRANSPARENT=true&CQL_FILTER=feature_type%20%3D%20%27well%27%20OR%20feature_type%20%3D%20%27pond%27%20OR%20feature_type%20%3D%20%27borehole%27&FORMAT_OPTIONS=dpi:96;antialias:full;png_compression:9")
end_time=$(date +%s.%N)

# Parse response
http_code=$(echo "$response" | grep -o "HTTPCODE:[0-9]*" | cut -d: -f2)
time_total=$(echo "$response" | grep -o "TIME:[0-9.]*" | cut -d: -f2)
size_download=$(echo "$response" | grep -o "SIZE:[0-9]*" | cut -d: -f2)

echo "✅ HTTP Status: $http_code"
echo "⏱️  Response Time: ${time_total}s"
echo "📦 Image Size: $size_download bytes"

if [ "$http_code" = "200" ]; then
    echo "🎯 Server-side SLD styling working perfectly!"
else
    echo "❌ Error with server-side styling (HTTP $http_code)"
fi

echo ""
echo "🧪 Testing Multiple Tile Requests (Performance Load)..."

# Test multiple tile requests for performance
total_time=0
success_count=0
failed_count=0

for i in {1..5}; do
    bbox_x=$((1300000 + i * 50000))
    bbox_y=$((1300000 + i * 50000))
    bbox="${bbox_x},${bbox_y},$((bbox_x + 100000)),$((bbox_y + 100000))"
    
    start=$(date +%s.%N)
    response=$(curl -s -w "HTTPCODE:%{http_code}" \
    "http://localhost:8080/geoserver/sahel/wms?REQUEST=GetMap&VERSION=1.1.1&SERVICE=WMS&LAYERS=sahel:v_water_infrastructure_comprehensive&STYLES=water_infrastructure_comprehensive&SRS=EPSG:3857&BBOX=$bbox&WIDTH=256&HEIGHT=256&FORMAT=image/png8&TRANSPARENT=true&CQL_FILTER=feature_type%20%3D%20%27well%27%20OR%20feature_type%20%3D%20%27pond%27%20OR%20feature_type%20%3D%20%27borehole%27&FORMAT_OPTIONS=dpi:96;antialias:full;png_compression:9")
    end=$(date +%s.%N)
    
    duration=$(echo "$end - $start" | bc)
    total_time=$(echo "$total_time + $duration" | bc)
    
    http_code=$(echo "$response" | grep -o "HTTPCODE:[0-9]*" | cut -d: -f2)
    if [ "$http_code" = "200" ]; then
        success_count=$((success_count + 1))
        echo "  ✅ Tile $i: ${duration}s (Success)"
    else
        failed_count=$((failed_count + 1))
        echo "  ❌ Tile $i: ${duration}s (Failed: $http_code)"
    fi
done

avg_time=$(echo "scale=3; $total_time / 5" | bc)
echo ""
echo "📈 Performance Summary:"
echo "  • Average Response Time: ${avg_time}s"
echo "  • Success Rate: $success_count/5 ($(echo "scale=1; $success_count * 20" | bc)%)"
echo "  • Failed Requests: $failed_count"

# Test cache effectiveness
echo ""
echo "🗄️  Testing Cache Effectiveness..."

echo "First request (cache miss):"
start_time=$(date +%s.%N)
response1=$(curl -s -w "TIME:%{time_total}" \
"http://localhost:8080/geoserver/sahel/wms?REQUEST=GetMap&VERSION=1.1.1&SERVICE=WMS&LAYERS=sahel:v_water_infrastructure_comprehensive&STYLES=water_infrastructure_comprehensive&SRS=EPSG:3857&BBOX=1300000,1300000,1400000,1400000&WIDTH=256&HEIGHT=256&FORMAT=image/png8&TRANSPARENT=true&CQL_FILTER=feature_type%20%3D%20%27well%27%20OR%20feature_type%20%3D%20%27pond%27%20OR%20feature_type%20%3D%20%27borehole%27&FORMAT_OPTIONS=dpi:96;antialias:full;png_compression:9&cache_test=1")
time1=$(echo "$response1" | grep -o "TIME:[0-9.]*" | cut -d: -f2)

echo "Second request (potential cache hit):"
start_time=$(date +%s.%N)
response2=$(curl -s -w "TIME:%{time_total}" \
"http://localhost:8080/geoserver/sahel/wms?REQUEST=GetMap&VERSION=1.1.1&SERVICE=WMS&LAYERS=sahel:v_water_infrastructure_comprehensive&STYLES=water_infrastructure_comprehensive&SRS=EPSG:3857&BBOX=1300000,1300000,1400000,1400000&WIDTH=256&HEIGHT=256&FORMAT=image/png8&TRANSPARENT=true&CQL_FILTER=feature_type%20%3D%20%27well%27%20OR%20feature_type%20%3D%20%27pond%27%20OR%20feature_type%20%3D%20%27borehole%27&FORMAT_OPTIONS=dpi:96;antialias:full;png_compression:9&cache_test=2")
time2=$(echo "$response2" | grep -o "TIME:[0-9.]*" | cut -d: -f2)

echo "  • First request: ${time1}s"
echo "  • Second request: ${time2}s"

if (( $(echo "$time2 < $time1" | bc -l) )); then
    improvement=$(echo "scale=1; ($time1 - $time2) / $time1 * 100" | bc)
    echo "  • 🚀 Cache improvement: ${improvement}% faster"
else
    echo "  • ⚠️  No significant cache improvement detected"
fi

echo ""
echo "🎯 Performance Test Complete!"
echo "========================================"