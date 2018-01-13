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
			<div class="part container">
				<xsl:apply-templates select="." />
			</div>
		</xsl:if>
	</xsl:for-each>
</xsl:template>

<xsl:template match="x:processor | x:ram-stick | x:video-card | x:hard-drive | x:disk | x:motherboard">
	<ul class="characteristics center">
		<img src="https://www.pro-bg.com/resize_image_max/800/600/INTEL/CPU-INTEL-BX80684I78700SR3QS.jpg" style="max-height: 200px"/>
			<!-- Uppercase first latter of category -->
		<xsl:variable name="firstChar" select="substring(name(.),1,1)"/>
		<xsl:variable name="category">
			<xsl:value-of select="translate($firstChar,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
			<xsl:value-of select="substring-after(name(.),$firstChar)"/>
		</xsl:variable>
		<li>
			<xsl:value-of select="$category"/>
			<b>
				<xsl:value-of select="concat(' ', x:manufacturer, ' ', x:family, ' ', x:model)" />
			</b>
		</li>

		<li>Manufacturer: <xsl:value-of select="x:manufacturer" /></li>
		<li>Price:<xsl:value-of select="x:price" /></li>
		<li>Available:<xsl:value-of select="x:available" /></li>
	</ul>
</xsl:template>
</xsl:stylesheet>
