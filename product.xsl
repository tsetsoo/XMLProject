<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:x="http://www.w3schools.com"
	exclude-result-prefixes="x">

	<xsl:param name="id">h1</xsl:param>


	<xsl:template match="/">
		<xsl:apply-templates select="*" />
	</xsl:template>

	<xsl:template match="x:processors | x:ram-sticks | x:video-cards | x:hard-drives | x:disks | x:motherboards">
		<xsl:for-each select="x:processor | x:ram-stick | x:video-card | x:hard-drive | x:disk | x:motherboard">
			<xsl:if test="@id=$id"><!-- <xsl:sort select="*[name(.)=$sortKey]|@*[name(.)=$sortKey]|x:price/*[name(.)=$sortKey]" order="{$sortOrder}" data-type="{$sortType}" /> -->
			<div class="part">
				<xsl:apply-templates select="." />
			</div>
		</xsl:if>
	</xsl:for-each>
</xsl:template>
<xsl:template match="x:part_image">
	<xsl:if test="@part_id=$id">
		<img class="product-image" alt="">
			<xsl:attribute name="src">
				<xsl:value-of select="."/>
			</xsl:attribute>
		</img>
	</xsl:if>
</xsl:template>

<xsl:template match="x:processor | x:ram-stick | x:video-card | x:hard-drive | x:disk | x:motherboard">
	<ul class="characteristics">
		<!-- Uppercase first latter of category -->
		<xsl:variable name="firstChar" select="substring(name(.),1,1)"/>
		<xsl:variable name="category">
			<xsl:value-of select="translate($firstChar,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
			<xsl:value-of select="substring-after(name(.),$firstChar)"/>
		</xsl:variable>
		<li class="product-name">
			<xsl:value-of select="$category"/>
			<b>
				<xsl:value-of
					select="concat(' ', x:manufacturer, ' ', x:family, ' ', x:model)" />
				</b>
			</li>

			<xsl:for-each select="*">
				<xsl:choose>
					<!-- count-childs -->
					<xsl:when test="count(./*) > 0">
						<ul>
							<li><b><xsl:value-of select="concat(name(.), ': ')"/></b>
							<xsl:for-each select="*">
									<xsl:value-of select="concat(name(.), ': ', ., ', ')"/>
							</xsl:for-each>
						</li>
						</ul>
					</xsl:when>
					<xsl:otherwise>
						<li>
							<xsl:value-of select="concat( name(.), ': ', .)"/>
						</li>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			</ul>
	</xsl:template>
</xsl:stylesheet>
