<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld">
  <NamedLayer>
    <Name>sahel:v_water_infrastructure_comprehensive</Name>
    <UserStyle>
      <Name>Water Infrastructure Style</Name>
      <Title>Water Infrastructure Styling</Title>
      <FeatureTypeStyle>
        <!-- Wells styling -->
        <Rule>
          <Name>Wells</Name>
          <Title>Water Wells</Title>
          <Filter>
            <PropertyIsEqualTo>
              <PropertyName>feature_type</PropertyName>
              <Literal>well</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#2980b9</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#1f541f</CssParameter>
                  <CssParameter name="stroke-width">2</CssParameter>
                </Stroke>
              </Mark>
              <Size>12</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
        <!-- Ponds styling -->
        <Rule>
          <Name>Ponds</Name>
          <Title>Water Ponds</Title>
          <Filter>
            <PropertyIsEqualTo>
              <PropertyName>feature_type</PropertyName>
              <Literal>pond</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>square</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#3498db</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#2c3e50</CssParameter>
                  <CssParameter name="stroke-width">1</CssParameter>
                </Stroke>
              </Mark>
              <Size>14</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
        <!-- Boreholes styling -->
        <Rule>
          <Name>Boreholes</Name>
          <Title>Water Boreholes</Title>
          <Filter>
            <PropertyIsEqualTo>
              <PropertyName>feature_type</PropertyName>
              <Literal>borehole</Literal>
            </PropertyIsEqualTo>
          </Filter>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>triangle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#8841da</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#6b46c1</CssParameter>
                  <CssParameter name="stroke-width">2</CssParameter>
                </Stroke>
              </Mark>
              <Size>10</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
        <!-- Default fallback for other types -->
        <Rule>
          <Name>Other</Name>
          <Title>Other Infrastructure</Title>
          <ElseFilter/>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#95a5a6</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#34495e</CssParameter>
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
</StyledLayerDescriptor>