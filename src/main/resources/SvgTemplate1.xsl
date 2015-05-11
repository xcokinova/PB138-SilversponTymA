<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
                xmlns="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:beans="http://www.springframework.org/schema/beans" 
                xmlns:camel="http://camel.apache.org/schema/spring">
    <xsl:output method="xml" indent="yes" standalone="yes" media-type="image/svg" />
    <!-- Chars for translate to lowercase/uppercase -->
    <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />        
    
    <!-- Start positions -->
    <xsl:variable name="startX" select="300" />
    <xsl:variable name="startY" select="250" />
    
    <!-- Max x position -->
    <xsl:variable name="maxX" select="400" />
    
    <xsl:template match="/">
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xLink">

            <!-- GREEN BIG BOARD -->
            <rect x = "25" y = "25" rx = "35" ry = "35" width = "800" height = "500" fill = "green"/>

            <!-- BLACK SMALL BOARD -->
            <rect x = "100" y = "150" width = "525" height = "250" fill = "#282828"/>

            <!-- Route FROM -->
            <xsl:if test="//camel:camelContext/camel:route/camel:from">
                <xsl:analyze-string select="//camel:camelContext/camel:route/camel:from/@uri" regex="^[^:]+">
                    <xsl:matching-substring>
                        <rect x="125" y="{$startY}" width="125" height="50" fill="#CCFFFF" />
                        <text x="152" y="{$startY+32}" font-family="Verdana" style="fill: #000000; stroke: none; font-size: 32px;"><xsl:value-of select="."/></text>
                    </xsl:matching-substring>                
                </xsl:analyze-string>
            </xsl:if>
            
            <!-- Route TO -->
            <xsl:for-each select="//camel:camelContext/camel:route/camel:to">
                <xsl:variable name="i" select="position()-1" />
                <xsl:variable name="posX" select="($i*175)+$startX" />
                <xsl:variable name="posY" select="$startY" />
                
                <xsl:analyze-string select="./@uri" regex="^[^:]+">
                    <xsl:matching-substring>
                        <polyline points="{($posX)-50},{($posY)+25} {($posX)-14},{($posY)+25}" fill="none" stroke="white" stroke-width="4" marker-end="url(#markerArrow)" />
                        <rect x="{$posX}" y="{$posY}" width="125" height="50" fill="#CCFFFF" />                
                        <text x="{$posX+25}" y="{$posY+32}" font-family="Verdana" style="fill: #000000; stroke: none; font-size: 32px;"><xsl:value-of select="."/></text>                
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:for-each>

            <!-- CIRCLE LEFT TOP -->
            <circle cx="60" cy="60" r="20"
                    style="stroke:#999966;
                           stroke-width: 12;
                           fill:#CCCC99"/>
            <!-- CIRCLE RIGHT TOP -->
            <circle cx="605" cy="60" r="20"
                    style="stroke:#999966;
                           stroke-width: 12;
                           fill:#CCCC99"/>
            <!-- CIRCLE LEFT BOTTOM -->
            <circle cx="60" cy="490" r="20"
                    style="stroke:#999966;
                           stroke-width: 12;
                           fill:#CCCC99"/>
            <!-- CIRCLE RIGHT BOTTOM -->
            <circle cx="605" cy="490" r="20"
                    style="stroke:#999966;
                           stroke-width: 12;
                           fill:#CCCC99"/>

            <!-- 20 PROTS -->
            <rect x = "90" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "112" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "134" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "156" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "178" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "200" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "222" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "244" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "266" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "288" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "310" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "332" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "354" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "376" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "398" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "420" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "442" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "464" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "486" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "508" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "530" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <rect x = "552" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>

            
            <xsl:analyze-string select="//camel:camelContext/camel:route/camel:from/@uri" regex='(.*?)://(.*?)\?value=.*?'>
                <xsl:matching-substring>
                    <!--PH7 text-->
                    <text x="137" y="70" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 32px;"><xsl:value-of select="translate(regex-group(2), $smallcase, $uppercase)"/></text>
                    
                    <!--GPIO text-->
                    <text x="115" y="95" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 16px;"><xsl:value-of select="translate(regex-group(1), $smallcase, $uppercase)"/></text>
                </xsl:matching-substring>
            </xsl:analyze-string>

            <!--ETHERNET BOX -->
            <text x="700" y="320" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 16px;">ETHERNET</text>
            <rect x = "675" y = "325" width = "175" height = "125" fill = "#A0A0A0"/>

            <!-- marker for polylines-->
            <defs>
                <marker id="markerArrow"
                        viewBox="0 0 10 10" 
                        refX="1" refY="5"
                        markerWidth="4" 
                        markerHeight="4"
                        orient="auto"
                        stroke="white" fill="white">
                    <path d="M 0 0 L 10 5 L 0 10 z" />
                </marker>
            </defs>

            <!-- LINES -->
            <polyline points="167,80 167,{($startY)-12}"
                      fill="none" stroke="white" 
                      stroke-width="4"
                      stroke-dasharray="5 5"
                      marker-end="url(#markerArrow)" />

            <polyline points="600,275 640,275 640,400 660,400"
                      fill="none" stroke="white" 
                      stroke-width="4"
                      stroke-dasharray="5 5"
                      marker-end="url(#markerArrow)" />
        </svg>
    </xsl:template>
</xsl:stylesheet>