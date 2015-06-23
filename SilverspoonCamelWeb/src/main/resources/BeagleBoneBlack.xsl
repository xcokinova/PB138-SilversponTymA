<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
                xmlns="http://www.w3.org/2000/svg"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xlink="http://www.w3.org/1999/xlink">
    <xsl:output method="xml" indent="yes" standalone="yes" media-type="image/svg" />
    <!-- Chars for translate to lowercase/uppercase -->
    <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />        
    
    <!-- Start positions -->
    <xsl:variable name="startX" select="250" />
    <xsl:variable name="startY" select="167" />
     
    <xsl:template match="/">
        <svg xmlns="http://www.w3.org/2000/svg"
             xmlns:xlink="http://www.w3.org/1999/xlink">
            
            <!-- BLACK BIG BOARD -->
            <xsl:call-template name="blackBigBoard"/>
    
            <!-- BLACK SMALL BOARD -->
            <rect x = "225" y = "150" width = "525" height = "250" fill = "#282828"/>
            
            <!-- Route FROM -->
            <xsl:apply-templates select="//camelContext/route/from"/>
            
            
            
            <!-- Route TO -->
            <xsl:for-each select="//camelContext/route/to">
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
                <xsl:with-param name="x" select="160"/>
                <xsl:with-param name="y" select="60"/>
            </xsl:call-template>    
            <!-- CIRCLE RIGHT TOP -->
            <xsl:call-template name="circles">
                <xsl:with-param name="x" select="845"/>
                <xsl:with-param name="y" select="80"/>
            </xsl:call-template>    
            <!-- CIRCLE LEFT BOTTOM -->
            <xsl:call-template name="circles">
                <xsl:with-param name="x" select="165"/>
                <xsl:with-param name="y" select="490"/>
            </xsl:call-template>   
            <!-- CIRCLE RIGHT BOTTOM -->
            <xsl:call-template name="circles">
                <xsl:with-param name="x" select="845"/>
                <xsl:with-param name="y" select="470"/>
            </xsl:call-template>

            
            <!--TOP 46 PORTS-->
            <rect x = "205" y = "35"  width = "597" height = "51" fill = "#383838"/>
            <xsl:call-template name="ports">
                <xsl:with-param name="pTimes" select="22"/>
                <xsl:with-param name="x" select="205"/>
                <xsl:with-param name="y" select="35"/>
                <xsl:with-param name="portId" select="twoverticalports"/>
            </xsl:call-template>
            <!--BOT 46 PORTS-->
            <rect x = "205" y = "465"  width = "597" height = "51" fill = "#383838"/>
            <xsl:call-template name="ports">
                <xsl:with-param name="pTimes" select="22"/>
                <xsl:with-param name="x" select="205"/>
                <xsl:with-param name="y" select="465"/>
                <xsl:with-param name="portId" select="twoverticalports"/>
            </xsl:call-template>            
            <!--6 SERIAL DEBUG PORTS-->
            <xsl:call-template name="portss">
                <xsl:with-param name="pTimes" select="6"/>
                <xsl:with-param name="x" select="439"/>
                <xsl:with-param name="y" select="439"/>
                <xsl:with-param name="portId" select="serialdebugport"/>
            </xsl:call-template>
            
            <xsl:analyze-string select="//camelContext/route/from/@uri" regex='(.*?)://(.*?)_(.*?)\?value=.*?'>
                <xsl:matching-substring>>
                    <xsl:variable name="pinNumber" select="translate(regex-group(3), $smallcase, $uppercase)"/>
                    <xsl:variable name="pin" select="translate(regex-group(2), $smallcase, $uppercase)"/>
                    <xsl:call-template name="fromArrow">
                        <xsl:with-param name="pinNum" select="$pinNumber"/>
                        <xsl:with-param name="pin" select="$pin"/>
                    </xsl:call-template>
                </xsl:matching-substring>
            </xsl:analyze-string> 
            <!-- P8 -->
            <text x="204" y="107" font-family="Verdana" style="fill: #585858; stroke: none; font-size: 24px;">
                P8
            </text>
            <!-- P9 -->
            <text x="204" y="460" font-family="Verdana" style="fill: #585858; stroke: none; font-size: 24px;">
                P9
            </text>
        
            <!--NUMBERS 1 2 45 46-->
            <!-- 1 TOP -->
            <text x="192" y="80" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 12px;">
                1
            </text>
            <!-- 1 BOT -->
            <text x="192" y="510" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 12px;">
                1
            </text>
            <!-- 2 TOP -->
            <text x="192" y="52" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 12px;">
                2
            </text>
            <!-- 2 BOT -->
            <text x="192" y="482" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 12px;">
                2
            </text>
            <!-- 45 TOP -->
            <text x="805" y="80" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 12px;">
                45
            </text>
            <!-- 45 BOT -->
            <text x="805" y="510" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 12px;">
                45
            </text>
            <!-- 46 TOP -->
            <text x="805" y="52" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 12px;">
                46
            </text>
            <!-- 46 BOT -->
            <text x="805" y="482" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 12px;">
                46
            </text>
            <!-- END OF NUMBERS 1 2 45 46-->                                    
    
            <!--LEFT METAL BOX -->
            <xsl:call-template name="leftMetalBox"/> 
    
            <!--ETHERNET METAL BOX -->
            <xsl:call-template name="ethernetBox"/>   
    
            <!--BLACK CONNECTOR BOX with GRADIENT-->
            <xsl:call-template name="connectorBox"/>   
            
            <!-- DEFS -->
            <defs>  
                <polygon points="0,0 50,7 50,30 0,38 0,34 40,25 40,13 0,4" 
                         id="polygon"
                         style="fill:#E0E0E0;" />
              
                <marker id="markerArrow"
                        viewBox="0 0 10 10" 
                        refX="1" refY="5"
                        markerWidth="4" 
                        markerHeight="4"
                        orient="auto"
                        stroke="white" fill="white">
                    <path d="M 0 0 L 10 5 L 0 10 z" />
                </marker>
        
                <linearGradient y2="1" x2="1" id="gradMetal" spreadMethod="reflect"  gradientTransform="rotate(90)">
                    <stop stop-color="#D0D0D0" offset="0"/>
                    <stop stop-color="#707070" offset="0.5"/>
                    <stop stop-color="#D0D0D0" offset="1"/>
                </linearGradient>
        
                <linearGradient y2="0.5067" x2="0.505" id="gradPort" x1="0.4817" y1="0.4833">
                    <stop stop-color="#383838" offset="0"/>
                    <stop stop-color="#888888" offset="1" stop-opacity="1"/>
                </linearGradient>
        
                <linearGradient y2="0.95" x2="0.5" id="gradBlack" spreadMethod="reflect" x1="0.5" y1="0.05">
                    <stop stop-color="#383838 " offset="0"/>
                    <stop stop-color="#909090" offset="0.5"/>
                    <stop stop-color="#383838 " offset="1"/>
                </linearGradient>
        
                <!-- PORTS -->       
                <g id="twoverticalports">
                    <rect  x = "0" y = "0"  width = "25" height = "25" style="fill:#282828"/>
                    <rect  x = "3.25" y = "3.25"  width = "18.5" height = "18.5" style="fill:url(#gradPort)"/>
                    <rect  x = "6.25" y = "6.25"  width = "12.5" height = "12.5" style="fill:#101010"/>
                    <rect  x = "0" y = "26"  width = "25" height = "25" style="fill:#282828"/> 
                    <rect  x = "3.25" y = "29.25"  width = "18.5" height = "18.5" style="fill:url(#gradPort)"/>
                    <rect  x = "6.25" y = "32.25"  width = "12.5" height = "12.5" style="fill:#101010"/>
                </g>
                <!-- SERIAL DEBUG PORT-->
                <g id="serialdebugport">
                    <rect  x = "0" y = "0" rx="3" ry="3" width = "25" height = "25" style="fill:#282828"/>
                    <rect  x = "8" y = "8" rx="2" ry="2" width = "9.75" height = "9.75" style="fill:#FFCC66"/>
                </g>
            </defs>
        </svg>
    </xsl:template>
    
    <!--BLACK BIG BOARD TEMPLATE -->
    <xsl:template name="blackBigBoard">
        <rect x = "25" y = "25" rx = "55" ry = "55" width = "825" height = "500" fill = "#101010"/>
        <rect x = "775" y = "125" width = "125" height = "300" fill = "#101010"/>
        <circle cx="800" cy="125" r="100"
                    style="fill:#101010"/>
        <circle cx="800" cy="425" r="100"
                    style="fill:#101010"/>
    </xsl:template>
    
    <!--ETHERNAL BOX TEMPLATE -->
    <xsl:template name="ethernetBox">
        <rect x = "775" y = "300" rx="2" ry="2" width = "125" height = "125" style="fill:url(#gradMetal)"/>
        <use xlink:href="#polygon" x="840" y="315"/>
        <use xlink:href="#polygon" x="840" y="370"/>
    </xsl:template>
    
    <!--LEFT METAL BOX TEMPLATE -->
    <xsl:template name="leftMetalBox">
        <rect x="4" y="175" rx="4" ry="4" width="191" height="150"
              style="fill:url(#gradMetal)"/>
    </xsl:template>
    
    <!--CONNECTOR BOX TEMPLATE -->
    <xsl:template name="connectorBox">
        <rect x="25" y="380"  width="100" height="80"
              style="fill:url(#gradBlack)"/>
        <rect x="5" y="380"  width="7" height="80"
              fill="#282828"/>
        <rect x="19" y="380"  width="7" height="80"
              fill="#282828"/>
        <rect x="12" y="380"  width="7" height="11"
              fill="#000000"/>
        <rect x="12" y="449"  width="7" height="11"
              fill="#000000"/>
        <rect x="12" y="391"  width="7" height="58"
              fill="#101010"/>
    </xsl:template>
    
    <!--FROM TEMPLATE-->
    <xsl:template name="routeFrom" match="//camelContext/route/from">
        <!-- route rectangle -->
        <rect x="{$startX}" y="{$startY}" width="125" height="50" fill="#FFFFFF" />
        <!-- route rectangle text -->
        <xsl:analyze-string select="//camelContext/route/from/@uri" regex="^[^:]+">
            <xsl:matching-substring>
                <text x="{$startX+25}" y="{$startY+32}" font-family="Verdana" style="fill: #000000; stroke: none; font-size: 32px;">
                    <xsl:value-of select="."/>
                </text>
            </xsl:matching-substring>    
        </xsl:analyze-string>

    </xsl:template>
    
    <!-- FROM ARROW TEMPLATE -->
    <xsl:template name="fromArrow">
        <xsl:param name="pinNum" />  
        <xsl:param name="pin"/> 
        <text x="237" y="70" font-family="Verdana" style="fill: #FFFFFF; stroke: none; font-size: 32px;">
            <xsl:value-of select="concat($pin, '_', $pinNum)"/>
        </text> 
        <xsl:variable name="pinColumn" select="(number($pinNum)) mod 2"/>
        <xsl:variable name="pinRow" select="(((number($pinNum)) - 1) div 2) + ((((number($pinNum))  mod 2) -1) div 2)"/>
        <!-- line -->
        <polyline points="{($startX - 10)+(($pinRow)-1)*26},{50+($pinColumn)*25} {($startX - 10)+(($pinRow)-1)*26},{100} {($startX)+50},{100} {($startX)+50},{($startY)-12}"
                  fill="none" stroke="white" 
                  stroke-width="4"
                  stroke-dasharray="5 5"
                  marker-end="url(#markerArrow)" /> 
    </xsl:template>
    
    <!-- TO TEMPLATE -->
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
            <xsl:when test="$i mod 3 = 0"> <!-- if last in row make arrow-->
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
            <polyline points="{$posX+125},{$posY+32} 757,{$posY+32} 758,400 762,400"
                      fill="none" stroke="white" 
                      stroke-width="4"
                      stroke-dasharray="5 5"
                      marker-end="url(#markerArrow)" />
        </xsl:if>      
    </xsl:template>
    
    <!--CIRCLES TEMPLATE-->
    <xsl:template name="circles">
        <xsl:param name="x"/>
        <xsl:param name="y"/>
        <circle cx="{$x}" cy="{$y}" r="20"
                style="stroke:#FFCC66;
                           stroke-width: 6;
                           fill:#FFFFCC"/>
    </xsl:template>

    <!--PORTS TEMPLATE -->
    <xsl:template name="ports">
        <xsl:param name="pTimes"/>
        <xsl:param name="x"/>
        <xsl:param name="y"/>
        <xsl:param name="portId"/>        

        <xsl:if test="$pTimes >= 0">
            <use xlink:href="#twoverticalports" x="{$x}" y="{$y}"/>
            <xsl:call-template name="ports">
                <xsl:with-param name="pTimes" select="$pTimes -1"/>
                <xsl:with-param name="x" select="$x + 26"/>
                <xsl:with-param name="y" select="$y"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
  
    <xsl:template name="portss" >
        <xsl:param name="pTimes"/>
        <xsl:param name="x"/>
        <xsl:param name="y"/>
        <xsl:param name="portId"/>        

        <xsl:if test="$pTimes >= 0">
            <use xlink:href="#serialdebugport" x="{$x}" y="{$y}"/>
            <xsl:call-template name="portss">
                <xsl:with-param name="pTimes" select="$pTimes -1"/>
                <xsl:with-param name="x" select="$x + 26"/>
                <xsl:with-param name="y" select="$y"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
 
</xsl:stylesheet>