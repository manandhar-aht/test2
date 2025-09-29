#!/usr/bin/env python3
"""
Publish Complex Water Resources Management Data to GeoServer
This script publishes the hierarchical water management data model with nested features
"""

import requests
import json
import time
import os
from requests.auth import HTTPBasicAuth

class WaterResourcesPublisher:
    def __init__(self, geoserver_url="http://localhost:8080/geoserver", 
                 username="admin", password="geoserver", workspace="water_management"):
        self.base_url = geoserver_url
        self.auth = HTTPBasicAuth(username, password)
        self.workspace = workspace
        self.datastore = "postgis_water"
        
        # Header for all requests
        self.headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }
        
        print(f"🌊 Water Resources Publisher initialized")
        print(f"   GeoServer: {self.base_url}")
        print(f"   Workspace: {self.workspace}")
        print(f"   Datastore: {self.datastore}")

    def create_workspace(self):
        """Create the water management workspace if it doesn't exist"""
        print(f"\n📁 Creating workspace: {self.workspace}")
        
        workspace_config = {
            "workspace": {
                "name": self.workspace,
                "isolated": False
            }
        }
        
        response = requests.post(
            f"{self.base_url}/rest/workspaces",
            auth=self.auth,
            headers=self.headers,
            data=json.dumps(workspace_config)
        )
        
        if response.status_code in [200, 201]:
            print(f"   ✅ Workspace '{self.workspace}' created successfully")
        elif response.status_code == 409:
            print(f"   ℹ️ Workspace '{self.workspace}' already exists")
        else:
            print(f"   ❌ Failed to create workspace: {response.status_code} - {response.text}")
            return False
        return True

    def create_datastore(self):
        """Create PostGIS datastore for water resources data"""
        print(f"\n🗄️ Creating PostGIS datastore: {self.datastore}")
        
        datastore_config = {
            "dataStore": {
                "name": self.datastore,
                "connectionParameters": {
                    "host": "postgres",
                    "port": "5432",
                    "database": "geoserver_db",
                    "user": "geoserver_user",
                    "passwd": "geoserver_pass",
                    "dbtype": "postgis",
                    "schema": "public",
                    "Loose bbox": True,
                    "Estimated extends": False,
                    "validate connections": True,
                    "Connection timeout": "20",
                    "preparedStatements": True
                }
            }
        }
        
        response = requests.post(
            f"{self.base_url}/rest/workspaces/{self.workspace}/datastores",
            auth=self.auth,
            headers=self.headers,
            data=json.dumps(datastore_config)
        )
        
        if response.status_code in [200, 201]:
            print(f"   ✅ Datastore '{self.datastore}' created successfully")
        elif response.status_code == 409:
            print(f"   ℹ️ Datastore '{self.datastore}' already exists")
        else:
            print(f"   ❌ Failed to create datastore: {response.status_code} - {response.text}")
            return False
        return True

    def publish_layer(self, layer_name, title=None, abstract=None, srs="EPSG:4326"):
        """Publish a single layer from the database table"""
        print(f"\n🗺️ Publishing layer: {layer_name}")
        
        if title is None:
            title = layer_name.replace('_', ' ').title()
        
        if abstract is None:
            abstract = f"Water resources data layer: {title}"
        
        feature_type_config = {
            "featureType": {
                "name": layer_name,
                "title": title,
                "abstract": abstract,
                "keywords": {
                    "string": ["water", "resources", "management", "gis", "spatial"]
                },
                "srs": srs,
                "enabled": True,
                "advertised": True,
                "metadata": [
                    {
                        "key": "time",
                        "value": "true",
                        "@type": "MetadataLinkInfo"
                    }
                ]
            }
        }
        
        response = requests.post(
            f"{self.base_url}/rest/workspaces/{self.workspace}/datastores/{self.datastore}/featuretypes",
            auth=self.auth,
            headers=self.headers,
            data=json.dumps(feature_type_config)
        )
        
        if response.status_code in [200, 201]:
            print(f"   ✅ Layer '{layer_name}' published successfully")
            return True
        elif response.status_code == 409:
            print(f"   ℹ️ Layer '{layer_name}' already exists")
            return True
        else:
            print(f"   ❌ Failed to publish layer '{layer_name}': {response.status_code} - {response.text}")
            return False

    def create_layer_style(self, layer_name, style_content, style_name=None):
        """Create a custom SLD style for a layer"""
        if style_name is None:
            style_name = f"{layer_name}_style"
        
        print(f"\n🎨 Creating style: {style_name}")
        
        # First create the style entry
        style_config = {
            "style": {
                "name": style_name,
                "workspace": {
                    "name": self.workspace
                },
                "format": "sld",
                "languageVersion": {
                    "version": "1.0.0"
                },
                "filename": f"{style_name}.sld"
            }
        }
        
        response = requests.post(
            f"{self.base_url}/rest/workspaces/{self.workspace}/styles",
            auth=self.auth,
            headers=self.headers,
            data=json.dumps(style_config)
        )
        
        if response.status_code not in [200, 201, 409]:
            print(f"   ❌ Failed to create style '{style_name}': {response.status_code}")
            return False
        
        # Upload the SLD content
        sld_headers = {'Content-Type': 'application/vnd.ogc.sld+xml'}
        response = requests.put(
            f"{self.base_url}/rest/workspaces/{self.workspace}/styles/{style_name}",
            auth=self.auth,
            headers=sld_headers,
            data=style_content
        )
        
        if response.status_code in [200, 201]:
            print(f"   ✅ Style '{style_name}' created successfully")
        else:
            print(f"   ❌ Failed to upload SLD content: {response.status_code}")
            return False
        
        # Apply style to layer
        if layer_name:
            return self.apply_style_to_layer(layer_name, style_name)
        
        return True

    def apply_style_to_layer(self, layer_name, style_name):
        """Apply a style to a layer"""
        print(f"   🎯 Applying style '{style_name}' to layer '{layer_name}'")
        
        layer_config = {
            "layer": {
                "defaultStyle": {
                    "name": style_name,
                    "workspace": self.workspace
                }
            }
        }
        
        response = requests.put(
            f"{self.base_url}/rest/layers/{self.workspace}:{layer_name}",
            auth=self.auth,
            headers=self.headers,
            data=json.dumps(layer_config)
        )
        
        if response.status_code in [200, 201]:
            print(f"   ✅ Style applied to layer successfully")
            return True
        else:
            print(f"   ❌ Failed to apply style: {response.status_code}")
            return False

    def create_layer_group(self, group_name, layer_list, title=None, abstract=None):
        """Create a layer group for related layers"""
        print(f"\n📦 Creating layer group: {group_name}")
        
        if title is None:
            title = group_name.replace('_', ' ').title()
        
        if abstract is None:
            abstract = f"Layer group containing: {', '.join(layer_list)}"
        
        # Build layers list for the group
        layers = []
        styles = []
        for layer in layer_list:
            layers.append({
                "name": f"{self.workspace}:{layer}"
            })
            styles.append({
                "name": f"{layer}_style"
            })
        
        group_config = {
            "layerGroup": {
                "name": group_name,
                "title": title,
                "abstract": abstract,
                "workspace": {
                    "name": self.workspace
                },
                "publishables": {
                    "published": layers
                },
                "styles": {
                    "style": styles
                },
                "bounds": {
                    "minx": -180,
                    "maxx": 180,
                    "miny": -90,
                    "maxy": 90,
                    "crs": "EPSG:4326"
                }
            }
        }
        
        response = requests.post(
            f"{self.base_url}/rest/workspaces/{self.workspace}/layergroups",
            auth=self.auth,
            headers=self.headers,
            data=json.dumps(group_config)
        )
        
        if response.status_code in [200, 201]:
            print(f"   ✅ Layer group '{group_name}' created successfully")
            return True
        elif response.status_code == 409:
            print(f"   ℹ️ Layer group '{group_name}' already exists")
            return True
        else:
            print(f"   ❌ Failed to create layer group: {response.status_code} - {response.text}")
            return False

def create_zone_style():
    """Create SLD style for Water Management Zones"""
    return """<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld">
  <NamedLayer>
    <Name>water_management_zones</Name>
    <UserStyle>
      <Title>Water Management Zones</Title>
      <FeatureTypeStyle>
        <Rule>
          <Title>Management Zones</Title>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#E6F3FF</CssParameter>
              <CssParameter name="fill-opacity">0.3</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#0066CC</CssParameter>
              <CssParameter name="stroke-width">2</CssParameter>
              <CssParameter name="stroke-dasharray">8 4</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
          <TextSymbolizer>
            <Label>
              <PropertyName>name</PropertyName>
            </Label>
            <Font>
              <CssParameter name="font-family">Arial</CssParameter>
              <CssParameter name="font-size">12</CssParameter>
              <CssParameter name="font-weight">bold</CssParameter>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill">#003366</CssParameter>
            </Fill>
            <Halo>
              <Radius>2</Radius>
              <Fill>
                <CssParameter name="fill">#FFFFFF</CssParameter>
                <CssParameter name="fill-opacity">0.8</CssParameter>
              </Fill>
            </Halo>
          </TextSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>"""

def create_pond_style():
    """Create SLD style for Ponds with size based on surface area"""
    return """<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld">
  <NamedLayer>
    <Name>ponds</Name>
    <UserStyle>
      <Title>Water Bodies (Ponds)</Title>
      <FeatureTypeStyle>
        <Rule>
          <Title>Small Ponds (&lt; 15,000 m²)</Title>
          <Filter>
            <PropertyIsLessThan>
              <PropertyName>surface_area</PropertyName>
              <Literal>15000</Literal>
            </PropertyIsLessThan>
          </Filter>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#66CCFF</CssParameter>
              <CssParameter name="fill-opacity">0.7</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#0099CC</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>
        <Rule>
          <Title>Medium Ponds (15,000 - 50,000 m²)</Title>
          <Filter>
            <And>
              <PropertyIsGreaterThanOrEqualTo>
                <PropertyName>surface_area</PropertyName>
                <Literal>15000</Literal>
              </PropertyIsGreaterThanOrEqualTo>
              <PropertyIsLessThan>
                <PropertyName>surface_area</PropertyName>
                <Literal>50000</Literal>
              </PropertyIsLessThan>
            </And>
          </Filter>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#3399FF</CssParameter>
              <CssParameter name="fill-opacity">0.7</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#0066CC</CssParameter>
              <CssParameter name="stroke-width">2</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>
        <Rule>
          <Title>Large Ponds (&gt; 50,000 m²)</Title>
          <Filter>
            <PropertyIsGreaterThanOrEqualTo>
              <PropertyName>surface_area</PropertyName>
              <Literal>50000</Literal>
            </PropertyIsGreaterThanOrEqualTo>
          </Filter>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#0066FF</CssParameter>
              <CssParameter name="fill-opacity">0.8</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#003399</CssParameter>
              <CssParameter name="stroke-width">3</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>"""

def create_well_style():
    """Create SLD style for Wells with different symbols based on pump type"""
    return """<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld">
  <NamedLayer>
    <Name>wells</Name>
    <UserStyle>
      <Title>Water Wells</Title>
      <FeatureTypeStyle>
        <Rule>
          <Title>Electric Pump Wells</Title>
          <Filter>
            <PropertyIsEqualTo>
              <PropertyName>construction_data.pump_type</PropertyName>
              <Literal>electric_pump</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#0066FF</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#003399</CssParameter>
                  <CssParameter name="stroke-width">2</CssParameter>
                </Stroke>
              </Mark>
              <Size>12</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
        <Rule>
          <Title>Solar Pump Wells</Title>
          <Filter>
            <PropertyIsEqualTo>
              <PropertyName>construction_data.pump_type</PropertyName>
              <Literal>solar_pump</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>triangle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#FFB366</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#CC6600</CssParameter>
                  <CssParameter name="stroke-width">2</CssParameter>
                </Stroke>
              </Mark>
              <Size>12</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
        <Rule>
          <Title>Hand Pump Wells</Title>
          <Filter>
            <PropertyIsEqualTo>
              <PropertyName>construction_data.pump_type</PropertyName>
              <Literal>hand_pump</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>square</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#66CC66</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#339933</CssParameter>
                  <CssParameter name="stroke-width">2</CssParameter>
                </Stroke>
              </Mark>
              <Size>10</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
        <Rule>
          <Title>Other Wells</Title>
          <ElseFilter/>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#666666</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#333333</CssParameter>
                  <CssParameter name="stroke-width">1</CssParameter>
                </Stroke>
              </Mark>
              <Size>8</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>"""

def create_borehole_style():
    """Create SLD style for Boreholes with depth-based sizing"""
    return """<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld">
  <NamedLayer>
    <Name>boreholes</Name>
    <UserStyle>
      <Title>Boreholes by Depth</Title>
      <FeatureTypeStyle>
        <Rule>
          <Title>Shallow (&lt; 50m)</Title>
          <Filter>
            <PropertyIsLessThan>
              <PropertyName>total_depth_m</PropertyName>
              <Literal>50</Literal>
            </PropertyIsLessThan>
          </Filter>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>square</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#FF6666</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#CC0000</CssParameter>
                  <CssParameter name="stroke-width">1</CssParameter>
                </Stroke>
              </Mark>
              <Size>8</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
        <Rule>
          <Title>Medium (50-100m)</Title>
          <Filter>
            <And>
              <PropertyIsGreaterThanOrEqualTo>
                <PropertyName>total_depth_m</PropertyName>
                <Literal>50</Literal>
              </PropertyIsGreaterThanOrEqualTo>
              <PropertyIsLessThan>
                <PropertyName>total_depth_m</PropertyName>
                <Literal>100</Literal>
              </PropertyIsLessThan>
            </And>
          </Filter>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>square</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#FF3333</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#990000</CssParameter>
                  <CssParameter name="stroke-width">2</CssParameter>
                </Stroke>
              </Mark>
              <Size>12</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
        <Rule>
          <Title>Deep (&gt; 100m)</Title>
          <Filter>
            <PropertyIsGreaterThanOrEqualTo>
              <PropertyName>total_depth_m</PropertyName>
              <Literal>100</Literal>
            </PropertyIsGreaterThanOrEqualTo>
          </Filter>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>square</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#CC0000</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#660000</CssParameter>
                  <CssParameter name="stroke-width">3</CssParameter>
                </Stroke>
              </Mark>
              <Size>16</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>"""

def main():
    print("🌊 Water Resources Management Data Publisher")
    print("=" * 50)
    
    # Initialize publisher
    publisher = WaterResourcesPublisher()
    
    # Step 1: Create workspace and datastore
    if not publisher.create_workspace():
        return
    
    if not publisher.create_datastore():
        return
    
    # Wait for GeoServer to process
    print("\n⏳ Waiting for GeoServer to process changes...")
    time.sleep(3)
    
    # Step 2: Define layers to publish
    layers_config = [
        {
            "name": "water_management_zones",
            "title": "Water Management Zones",
            "abstract": "Administrative boundaries for water resource management areas",
            "style": create_zone_style()
        },
        {
            "name": "ponds", 
            "title": "Water Bodies (Ponds)",
            "abstract": "Surface water bodies including lakes, ponds, and reservoirs",
            "style": create_pond_style()
        },
        {
            "name": "wells",
            "title": "Water Wells", 
            "abstract": "Groundwater extraction wells with construction details",
            "style": create_well_style()
        },
        {
            "name": "boreholes",
            "title": "Boreholes",
            "abstract": "Deep water boreholes with geological information", 
            "style": create_borehole_style()
        },
        {
            "name": "zone_summary_view",
            "title": "Zone Summary Statistics",
            "abstract": "Aggregated statistics for each water management zone",
            "style": None
        },
        {
            "name": "well_construction_view", 
            "title": "Wells with Construction Details",
            "abstract": "Comprehensive view of wells including construction information",
            "style": None
        },
        {
            "name": "feature_water_quality_view",
            "title": "Water Quality Overview",
            "abstract": "Latest water quality assessments for all features",
            "style": None
        }
    ]
    
    # Step 3: Publish layers
    published_layers = []
    for layer_config in layers_config:
        print(f"\n📊 Processing layer: {layer_config['name']}")
        
        # Publish the layer
        if publisher.publish_layer(
            layer_config["name"],
            layer_config["title"], 
            layer_config["abstract"]
        ):
            published_layers.append(layer_config["name"])
            
            # Create and apply custom style if provided
            if layer_config["style"]:
                publisher.create_layer_style(
                    layer_config["name"],
                    layer_config["style"]
                )
        
        # Brief pause between layers
        time.sleep(1)
    
    # Step 4: Create layer groups
    if len(published_layers) >= 4:
        print(f"\n📦 Creating layer groups...")
        
        # Core features group
        core_layers = ["water_management_zones", "ponds", "wells", "boreholes"]
        publisher.create_layer_group(
            "water_infrastructure",
            core_layers,
            "Water Infrastructure",
            "Core water management features: zones, ponds, wells, and boreholes"
        )
        
        # Analysis views group
        analysis_layers = [l for l in published_layers if "view" in l]
        if analysis_layers:
            publisher.create_layer_group(
                "water_analysis",
                analysis_layers,
                "Water Analysis Views", 
                "Analytical views and summary statistics for water resources"
            )
    
    # Step 5: Summary
    print(f"\n🎉 Publication Complete!")
    print(f"   ✅ Published {len(published_layers)} layers")
    print(f"   🌐 Workspace: {publisher.workspace}")
    print(f"   🗄️ Datastore: {publisher.datastore}")
    
    print(f"\n🔗 Access URLs:")
    print(f"   WMS Capabilities: {publisher.base_url}/{publisher.workspace}/wms?service=WMS&request=GetCapabilities")
    print(f"   WFS Capabilities: {publisher.base_url}/{publisher.workspace}/wfs?service=WFS&request=GetCapabilities")
    print(f"   Layer Preview: {publisher.base_url}/web/wicket/bookmarkable/org.geoserver.web.demo.MapPreviewPage")
    
    print(f"\n📊 Example WMS requests:")
    for layer in published_layers[:3]:  # Show first 3 as examples
        print(f"   {layer}: {publisher.base_url}/{publisher.workspace}/wms?service=WMS&version=1.1.0&request=GetMap&layers={publisher.workspace}:{layer}&styles=&bbox=-180,-90,180,90&width=768&height=384&srs=EPSG:4326&format=image/png")

if __name__ == "__main__":
    main()