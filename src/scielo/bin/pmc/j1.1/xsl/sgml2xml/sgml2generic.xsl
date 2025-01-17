<?xml version="1.0" encoding="UTF-8"?>
<!--  xmlns:doc="http://www.dcarlisle.demon.co.uk/xsldoc" 
xmlns:ie5="http://www.w3.org/TR/WD-xsl" 


-->
<xsl:stylesheet version="1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:util="http://dtd.nlm.nih.gov/xsl/util"
	xmlns:mml="http://www.w3.org/1998/Math/MathML" exclude-result-prefixes="util xsl">
	<xsl:import href="../../../j1.0/xsl/sgml2xml/sgml2generic.xsl"/>
    <xsl:template match="article|text|doc" mode="dtd-version">
        <xsl:attribute name="dtd-version">1.1</xsl:attribute>
    </xsl:template>
    
    <xsl:template match="aff/@city | aff/city | normaff/city ">
        <city>
            <xsl:value-of select="normalize-space(.)"/>
        </city>
    </xsl:template>

    <xsl:template match="aff/@state | aff/state | normaff/state ">
        <state>
            <xsl:value-of select="normalize-space(.)"/>
        </state>
    </xsl:template>

    <xsl:template match="aff/@zipcode | aff/zipcode | normaff/zipcode ">
        <postal-code>
            <xsl:value-of select="normalize-space(.)"/>
        </postal-code>
    </xsl:template>

    <xsl:template match="version">
        <version>
            <xsl:value-of select="normalize-space(.)"/>
        </version>
    </xsl:template>
    
    <xsl:template match="code">
        <xsl:param name="id"/>
        
        <xsl:element name="{name()}">
            <xsl:apply-templates select="@* | * | text()">
                <xsl:with-param name="id" select="$id"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="code/@itstype">
        <xsl:attribute name="code-type">
            <xsl:value-of select="normalize-space(.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="onbehalf[institid]">
        <institution-wrap>
            <xsl:apply-templates select="*|text()"></xsl:apply-templates>
        </institution-wrap>
    </xsl:template>
    
    <xsl:template match="institid/@itstype">
        <xsl:attribute name="institution-id-type">
            <xsl:value-of select="normalize-space(.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="institid">
        <xsl:element name="institution-id">
            <xsl:apply-templates select="@*|*|text()"></xsl:apply-templates>
        </xsl:element>
    </xsl:template>

    <xsl:template match="article|text|doc" mode="pub-date">
        <xsl:variable name="preprint_date">
            <xsl:choose>
                <xsl:when test="@rvpdate">
                    <xsl:value-of select="@rvpdate"/>
                </xsl:when>
                <xsl:when test="@artdate">
                    <xsl:value-of select="@artdate"/>
                </xsl:when>
                <xsl:when test="@ahpdate">
                    <xsl:value-of select="@ahpdate"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="string-length(normalize-space($preprint_date))&gt;0">
                <pub-date>
                    <xsl:choose>
                        <xsl:when test="number(@sps)&gt;1.8">scielo</xsl:when>
                        <xsl:otherwise>epub</xsl:otherwise>
                    </xsl:choose>
                    <xsl:call-template name="display_date">
                        <xsl:with-param name="dateiso">
                            <xsl:value-of select="$preprint_date"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </pub-date>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="issue_date_type">
                    <xsl:choose>
                        <xsl:when test="number(@sps)&gt;1.8">collection</xsl:when>
                        <xsl:when test="@issueno='ahead'"></xsl:when>
                        <xsl:when test="(number(@issueno)=0 or not(@issueno)) and (number(@volid)=0 or not(@volid))"></xsl:when>
                        <!--xsl:when test="@artdate">collection</xsl:when--><!-- rolling pass -->
                        <!--xsl:when test="@ahpdate">collection</xsl:when-->
                        <xsl:otherwise><xsl:value-of select="$pub_type"/></xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:if test="$issue_date_type!=''">
                    <pub-date pub-type="{$issue_date_type}">
                        <xsl:call-template name="display_date">
                            <xsl:with-param name="dateiso">
                                <xsl:value-of select="@dateiso"/>
                            </xsl:with-param>
                            <xsl:with-param name="date">
                                <xsl:choose>
                                    <xsl:when test="@season!=''">
                                        <xsl:value-of select="@season"/>
                                    </xsl:when>
                                    <xsl:when test="//extra-scielo//season">
                                        <xsl:value-of select="//extra-scielo//season"/>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:with-param>
                        </xsl:call-template>
                    </pub-date>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>

</xsl:stylesheet>
