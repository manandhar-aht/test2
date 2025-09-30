<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>water_zones_style</Name>
    <UserStyle>
      <Title>Water Management Zones Style</Title>
      <Abstract>Styled water management zones with stress level coloring</Abstract>
      <FeatureTypeStyle>
        <!-- Extreme Water Stress - Red -->
        <Rule>
          <Name>Extreme Water Stress</Name>
          <Title>Extreme Water Stress</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>water_stress_level</ogc:PropertyName>
              <ogc:Literal>extreme</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#e74c3c</CssParameter>
              <CssParameter name="fill-opacity">0.3</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#c0392b</CssParameter>
              <CssParameter name="stroke-width">2</CssParameter>
              <CssParameter name="stroke-opacity">0.8</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
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
              <CssParameter name="fill">#2c3e50</CssParameter>
            </Fill>
            <Halo>
              <Radius>2</Radius>
              <Fill>
                <CssParameter name="fill">#ffffff</CssParameter>
                <CssParameter name="fill-opacity">0.8</CssParameter>
              </Fill>
            </Halo>
          </TextSymbolizer>
        </Rule>
        
        <!-- High Water Stress - Orange -->
        <Rule>
          <Name>High Water Stress</Name>
          <Title>High Water Stress</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>water_stress_level</ogc:PropertyName>
              <ogc:Literal>high</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#f39c12</CssParameter>
              <CssParameter name="fill-opacity">0.3</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#e67e22</CssParameter>
              <CssParameter name="stroke-width">2</CssParameter>
              <CssParameter name="stroke-opacity">0.8</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
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
              <CssParameter name="fill">#2c3e50</CssParameter>
            </Fill>
            <Halo>
              <Radius>2</Radius>
              <Fill>
                <CssParameter name="fill">#ffffff</CssParameter>
                <CssParameter name="fill-opacity">0.8</CssParameter>
              </Fill>
            </Halo>
          </TextSymbolizer>
        </Rule>
        
        <!-- Moderate Water Stress - Yellow -->
        <Rule>
          <Name>Moderate Water Stress</Name>
          <Title>Moderate Water Stress</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>water_stress_level</ogc:PropertyName>
              <ogc:Literal>moderate</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#f1c40f</CssParameter>
              <CssParameter name="fill-opacity">0.3</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#f39c12</CssParameter>
              <CssParameter name="stroke-width">2</CssParameter>
              <CssParameter name="stroke-opacity">0.8</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
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
              <CssParameter name="fill">#2c3e50</CssParameter>
            </Fill>
            <Halo>
              <Radius>2</Radius>
              <Fill>
                <CssParameter name="fill">#ffffff</CssParameter>
                <CssParameter name="fill-opacity">0.8</CssParameter>
              </Fill>
            </Halo>
          </TextSymbolizer>
        </Rule>
        
        <!-- Low Water Stress - Green -->
        <Rule>
          <Name>Low Water Stress</Name>
          <Title>Low Water Stress</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>water_stress_level</ogc:PropertyName>
              <ogc:Literal>low</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#27ae60</CssParameter>
              <CssParameter name="fill-opacity">0.3</CssParameter>
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#229954</CssParameter>
              <CssParameter name="stroke-width">2</CssParameter>
              <CssParameter name="stroke-opacity">0.8</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
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
              <CssParameter name="fill">#2c3e50</CssParameter>
            </Fill>
            <Halo>
              <Radius>2</Radius>
              <Fill>
                <CssParameter name="fill">#ffffff</CssParameter>
                <CssParameter name="fill-opacity">0.8</CssParameter>
              </Fill>
            </Halo>
          </TextSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>