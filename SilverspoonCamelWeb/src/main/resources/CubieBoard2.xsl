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
    <xsl:variable name="startY" select="130" />
    
    <xsl:template match="/">
        <svg xmlns="http://www.w3.org/2000/svg"
             xmlns:xlink="http://www.w3.org/1999/xlink">
            <!---->
            <defs>  
                <polygon points="0,0 50,7 50,30 0,38 0,34 40,25 40,13 0,4" 
                         id="polygon"
                         style="fill:#E0E0E0;" 
                         transform="rotate(90)"/>
              
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
        
                <!-- PORTS -->       
                <g id="twoverticalports">
                    <circle cx="0" cy="0" r="5"
                            style="stroke:#C0C0C0;
                   stroke-width: 5;
                   fill:#989898"/>
                    <circle cx="0" cy="20" r="5"
                            style="stroke:#C0C0C0;
                   stroke-width: 5;
                   fill:#989898"/>
                </g>
            </defs>

            <!-- BOARD -->
            <xsl:call-template name="board"/>  
            
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
                <xsl:with-param name="x" select="190"/>
                <xsl:with-param name="y" select="57"/>
            </xsl:call-template>    
            <!-- CIRCLE RIGHT TOP -->
            <xsl:call-template name="circles">
                <xsl:with-param name="x" select="893"/>
                <xsl:with-param name="y" select="57"/>
            </xsl:call-template>    
            <!-- CIRCLE LEFT BOTTOM -->
            <xsl:call-template name="circles">
                <xsl:with-param name="x" select="190"/>
                <xsl:with-param name="y" select="493"/>
            </xsl:call-template>   
            <!-- CIRCLE RIGHT BOTTOM -->
            <xsl:call-template name="circles">
                <xsl:with-param name="x" select="893"/>
                <xsl:with-param name="y" select="493"/>
            </xsl:call-template>
    
            <!--SUPER COMPLICATED POLYGON-->
            <xsl:call-template name="polygon"/>
            
            <!--TOP 48 PORTS-->
            <rect x = "375" y = "30"  width = "490" height = "55" style="fill:#101010;stroke:silver;stroke-width:3"/>
            <xsl:call-template name="ports">
                <xsl:with-param name="pTimes" select="23"/>
                <xsl:with-param name="x" select="390"/>
                <xsl:with-param name="y" select="47"/>
                <xsl:with-param name="portId" select="twoverticalports"/>
            </xsl:call-template>
            <!--BOT 48 PORTS-->
            <rect x = "375" y = "465"  width = "490" height = "55" style="fill:#101010;stroke:silver;stroke-width:3"/>
            <xsl:call-template name="ports">
                <xsl:with-param name="pTimes" select="23"/>
                <xsl:with-param name="x" select="390"/>
                <xsl:with-param name="y" select="483"/>
                <xsl:with-param name="portId" select="twoverticalports"/>
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
            
            <!--TOP 1 11 21 31 41-->
            <text x="378" y="84" font-family = "sans-serif" style="fill: #FFFFFF; stroke: none; font-size: 14px;">1</text>
            <text x="472" y="84" font-family = "sans-serif" style="fill: #FFFFFF; stroke: none; font-size: 14px;">11</text>
            <text x="573" y="84" font-family = "sans-serif" style="fill: #FFFFFF; stroke: none; font-size: 14px;">21</text>
            <text x="672" y="84" font-family = "sans-serif" style="fill: #FFFFFF; stroke: none; font-size: 14px;">31</text>
            <text x="770" y="84" font-family = "sans-serif" style="fill: #FFFFFF; stroke: none; font-size: 14px;">41</text>
   
            <!--BOT 1 11 21 31 41-->
            <text x="432" y="477" font-family = "sans-serif" style="fill: #FFFFFF; stroke: none; font-size: 14px;">41</text>
            <text x="533" y="477" font-family = "sans-serif" style="fill: #FFFFFF; stroke: none; font-size: 14px;">31</text>
            <text x="632" y="477" font-family = "sans-serif" style="fill: #FFFFFF; stroke: none; font-size: 14px;">21</text>
            <text x="730" y="477" font-family = "sans-serif" style="fill: #FFFFFF; stroke: none; font-size: 14px;">11</text>
            <text x="835" y="477" font-family = "sans-serif" style="fill: #FFFFFF; stroke: none; font-size: 14px;">1</text>    
    
            <!--LEFT METAL/BLACK BOX with some extra STUFF -->
            <xsl:call-template name="leftBox"/>
    
            <!--LEFT METAL BOX -->
            <xsl:call-template name="leftMetalBox"/>
    
            <!--BOT METAL BOX -->
            <xsl:call-template name="botMetalBox"/>
    
            <!--ETHERNET METAL BOX -->
            <xsl:call-template name="ethernetBox"/> 
        </svg>
    </xsl:template>
    
    <!--SUPER COMPLICATED POLYGON-->
    <xsl:template name="board">
        <!-- BLACK BIG BOARD -->
        <rect x = "25" y = "25" rx = "15" ry = "15" width = "900" height = "500" fill = "#101010"/>    
        <!-- BLACK SMALL BOARD -->
        <rect x = "225" y = "110" width = "525" height = "250" fill = "#282828"/>
    </xsl:template>
    
    <!--SUPER COMPLICATED POLYGON-->
    <xsl:template name="polygon">
        <rect x = "225" y = "30"  width = "145" height = "55" style="fill:#404040"/>
        <polygon points="240,40 355,40 355,45 360,45 360,65 355,65 355,70 350,70 350,75 245,75 245,70 240,70 240,65 235,65 235,45 240,45" 
                 style="fill:#101010" />
        <polygon points="247,54 337,54 337,47 347,47 347,62 247,62"
                 style="fill:#404040" />
    </xsl:template>
    
    <!--LEFT METAL/BLACK BOX with some extra STUFF -->
    <xsl:template name="leftBox">
        <rect x="20" y="70" rx="2" ry="2" width="120" height="70"
              style="fill:#303030"/>
        <rect x="50" y="70" rx="2" ry="2" width="30" height="70"
              style="fill:url(#gradMetal)"/>
        <rect x="110" y="110" rx="2" ry="2" width="20" height="20"
              style="fill:#202020"/>
        <rect x="120" y="80" rx="2" ry="2" width="8" height="2"
              style="fill:#FFFF99"/>
        <rect x="120" y="90" rx="2" ry="2" width="8" height="2"
              style="fill:#FFFF99"/>
    </xsl:template>
    

    <!--LEFT METAL BOX TEMPLATE -->
    <xsl:template name="leftMetalBox">
        <rect x="20" y="225" rx="4" ry="4" width="100" height="150"
              style="fill:url(#gradMetal)"/>
    </xsl:template>
    

    <!--BOT METAL BOX TEMPLATE -->
    <xsl:template name="botMetalBox">
        <rect x="230" y="385" rx="2" ry="2" width="134" height="150"
              style="fill:url(#gradMetal)"/>
        <use xlink:href="#polygon" x="290" y="470"/>
        <use xlink:href="#polygon" x="340" y="470"/>
    </xsl:template>
    
    <!--ETHERNAL BOX TEMPLATE -->
    <xsl:template name="ethernetBox">
        <text x="790" y="330" font-family = "sans-serif" style="fill: #FFFFFF; stroke: none; font-size: 14px;">ETHERNET</text>
        <rect x = "775" y = "335" rx="2" ry="2" width = "175" height = "125" style="fill:url(#gradMetal)"/>
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
        <polyline points="{390 +($pinRow)*20},{47+($pinColumn)*25} {390 +($pinRow)*20},{100} {($startX)+50},{100} {($startX)+50},{($startY)-12}"
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
        <circle cx="{$x}" cy="{$y}" r="32"
                style="fill:silver"/>
        <circle cx="{$x}" cy="{$y}" r="20"
                style="stroke:#FFCC66;
                           stroke-width: 8;
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
                <xsl:with-param name="x" select="$x + 20"/>
                <xsl:with-param name="y" select="$y"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>   
</xsl:stylesheet>