<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="html|body|tr|table">
    <xsl:copy>
        <xsl:apply-templates select="*"/>
    </xsl:copy>
</xsl:template>
<xsl:template match="td">
    <xsl:variable name="index" select="count(preceding-sibling::td)"/>
    <xsl:variable name="sideNeibourgs" select="./following-sibling::td[1]|./preceding-sibling::td[1]"/>
    <xsl:variable name="topNeigourgs" select="../preceding-sibling::tr[1]/*[count(preceding-sibling::td) >= $index - 1 and count(preceding-sibling::td) &lt;= $index + 1]"/>
    <xsl:variable name="bottomNeigourgs" select="../following-sibling::tr[1]/*[count(preceding-sibling::td) >= $index - 1 and count(preceding-sibling::td) &lt;= $index + 1]"/>
    <xsl:variable name="liveNeigbours" select="($sideNeibourgs | $topNeigourgs | $bottomNeigourgs)[@class='live']"/>
    <xsl:variable name="neibourgsCount" select="count($liveNeigbours)"/>
    <td>
        <xsl:choose>
            <xsl:when test="$neibourgsCount = 2 "><xsl:copy-of select="@class"/></xsl:when>
            <xsl:when test="$neibourgsCount = 3 "><xsl:attribute name="class">live</xsl:attribute></xsl:when>
            <xsl:otherwise><xsl:attribute name="class">dead</xsl:attribute></xsl:otherwise>
        </xsl:choose>
    </td>
</xsl:template>
</xsl:stylesheet>