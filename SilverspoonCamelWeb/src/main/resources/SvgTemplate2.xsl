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
    <xsl:variable name="startX" select="125" />
    <xsl:variable name="startY" select="167" />
    
    <!-- Max x position -->
    <xsl:variable name="maxX" select="400" />
     
    <xsl:template match="/">
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xLink">

            <!-- GREEN BIG BOARD -->
            <rect x = "25" y = "25" rx = "35" ry = "35" width = "800" height = "500" fill = "green"/>

            <!-- BLACK SMALL BOARD -->
            <rect x = "100" y = "150" width = "525" height = "250" fill = "#282828"/>
            
            <!-- Route FROM -->
            <xsl:apply-templates select="//camel:camelContext/camel:route/camel:from"/>
            
            <!-- Route TO -->
            <xsl:for-each select="//camel:camelContext/camel:route/camel:to">
                <xsl:variable name="row" select="((position() div 3)-((position() mod 3) div 3))"/>
                <xsl:variable name="column" select="position() mod 3"/>
                <xsl:choose>  
                    <xsl:when test="$row mod 2 = 0"> <!-- from RIGHT to LEFT -->                                      
                        <xsl:call-template name="routeTo">
                            <xsl:with-param name="posX" select="$column*175 + $startX"/>
                            <xsl:with-param name="posY" select="$row*83 + $startY"/>
                            <xsl:with-param name="i" select="position()"/>
                            <xsl:with-param name="last" select="last()"/>
                        </xsl:call-template>                
                    </xsl:when>
                    <xsl:otherwise> <!-- from LEFT to RIGHT -->                                
                        <xsl:call-template name="routeTo">
                            <xsl:with-param name="posX" select="(2-$column)*175 + $startX"/>
                            <xsl:with-param name="posY" select="$row*83 + $startY"/>
                            <xsl:with-param name="i" select="position()"/>
                            <xsl:with-param name="last" select="last()"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>

            <!-- CIRCLE LEFT TOP -->
            <xsl:call-template name="circles">
                <xsl:with-param name="x" select="60"/>
                <xsl:with-param name="y" select="60"/>
            </xsl:call-template>
            <!-- CIRCLE RIGHT TOP -->
            <xsl:call-template name="circles">
                <xsl:with-param name="x" select="605"/>
                <xsl:with-param name="y" select="60"/>
            </xsl:call-template>
            <!-- CIRCLE LEFT BOTTOM -->
            <xsl:call-template name="circles">
                <xsl:with-param name="x" select="60"/>
                <xsl:with-param name="y" select="490"/>
            </xsl:call-template>
            <!-- CIRCLE RIGHT BOTTOM -->
            <xsl:call-template name="circles">
                <xsl:with-param name="x" select="605"/>
                <xsl:with-param name="y" select="490"/>
            </xsl:call-template>

            <!-- 20 PROTS -->
            <xsl:call-template name="ports">
                <xsl:with-param name="pTimes" select="20"/>
                <xsl:with-param name="x" select="90"/>
            </xsl:call-template>

            <xsl:analyze-string select="//camel:camelContext/camel:route/camel:from/@uri" regex='(.*?)://(.*?)\?value=.*?'>
                <xsl:matching-substring>
                    <!--PH7 text-->
                    <text x="137" y="70" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 32px;">
                        <xsl:value-of select="translate(regex-group(2), $smallcase, $uppercase)"/>
                    </text>
                    
                    <!--GPIO text-->
                    <text x="115" y="95" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 16px;">
                        <xsl:value-of select="translate(regex-group(1), $smallcase, $uppercase)"/>
                    </text>
                </xsl:matching-substring>
            </xsl:analyze-string>

            <!--ETHERNET BOX -->
            <xsl:call-template name="ethernetBox"/>

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
        </svg>
    </xsl:template>
    
    <xsl:template name="routeFrom" match="//camel:camelContext/camel:route/camel:from">
        <!-- route rectangle -->
        <rect x="{$startX}" y="{$startY}" width="125" height="50" fill="#CCFFFF" />
        <!-- route rectangle text -->
        <xsl:analyze-string select="//camel:camelContext/camel:route/camel:from/@uri" regex="^[^:]+">
            <xsl:matching-substring>
                <text x="{$startX+25}" y="{$startY+32}" font-family="Verdana" style="fill: #000000; stroke: none; font-size: 32px;">
                    <xsl:value-of select="."/>
                </text>
            </xsl:matching-substring>    
        </xsl:analyze-string>
        <!-- line -->
        <polyline points="167,80 167,{($startY)-12}"
                  fill="none" stroke="white" 
                  stroke-width="4"
                  stroke-dasharray="5 5"
                  marker-end="url(#markerArrow)" />   
    </xsl:template>
    
    <xsl:template name="routeTo">
        <xsl:param name="posX" />  
        <xsl:param name="posY" /> 
        <xsl:param name="i" /> 
        <xsl:param name="last" /> 

        <xsl:variable name="row" select="(($i div 3)-(($i mod 3) div 3))"/>
        
        <!-- route rectangle -->
        <rect x="{$posX}" y="{$posY}" width="125" height="50" fill="#CCFFFF" /> 
        
        <!-- route rectangle text -->
        <xsl:analyze-string select="./@uri" regex="^[^:]+">
            <xsl:matching-substring>
                <text x="{$posX+25}" y="{$posY+32}" font-family="Verdana" style="fill: #000000; stroke: none; font-size: 32px;">
                    <xsl:value-of select="."/>
                </text>  
            </xsl:matching-substring>
        </xsl:analyze-string>
        
        <xsl:choose> 
            <xsl:when test="$i mod 3 = 0"> <!-- if last in row -->
                <polyline points="{($posX+62)},{($posY)-32} {($posX+62)},{($posY)-12}" fill="none" stroke="white" stroke-width="4" marker-end="url(#markerArrow)" />
            </xsl:when>
            <xsl:otherwise>  <!-- if NOT last in row -->
                <xsl:choose>  
                    <xsl:when test="$row mod 2 = 0">                                   
                        <polyline points="{($posX)-50},{($posY)+25} {($posX)-14},{($posY)+25}" fill="none" stroke="white" stroke-width="4" marker-end="url(#markerArrow)" />                          
                    </xsl:when>
                    <xsl:otherwise>                                 
                        <polyline points="{($posX)+125+50},{($posY)+25} {($posX)+125+14},{($posY)+25}" fill="none" stroke="white" stroke-width="4" marker-end="url(#markerArrow)" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        <!-- line to Ethernet box -->
        <xsl:if test="$i = $last">
            <polyline points="{$posX+125},{$posY+32} 640,{$posY+32} 640,400 660,400"
                      fill="none" stroke="white" 
                      stroke-width="4"
                      stroke-dasharray="5 5"
                      marker-end="url(#markerArrow)" />
        </xsl:if>      
    </xsl:template>
    
    <xsl:template name="circles">
        <xsl:param name="x"/>
        <xsl:param name="y"/>
        
        <circle cx="{$x}" cy="{$y}" r="20"
                style="stroke:#999966;
                           stroke-width: 12;
                           fill:#CCCC99"/>
    </xsl:template>
    
    <xsl:template name="ports">
        <xsl:param name="pTimes"/>
        <xsl:param name="x"/>
        <xsl:if test="$pTimes > 0">
            <rect x = "{$x}" y = "35" rx = "10" ry = "10" width = "22" height = "45" fill = "#282828"/>
            <xsl:call-template name="ports">
                <xsl:with-param name="pTimes" select="$pTimes -1"/>
                <xsl:with-param name="x" select="$x + 22"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="ethernetBox">
        <text x="700" y="320" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 16px;">ETHERNET</text>
        <rect x = "675" y = "325" width = "175" height = "125" fill = "#A0A0A0"/>
    </xsl:template>
 
</xsl:stylesheet>