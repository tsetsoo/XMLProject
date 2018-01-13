<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:x="http://www.w3schools.com"
	exclude-result-prefixes="x">

	<xsl:key name="image-urls" match="image" use="@id"/>

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
 <li>
  <xsl:for-each select="key('image-urls', 'i2' )">
		<p>he</p>
		<img src="@href" style="max-height: 200px"/>
		<xsl:value-of select="@href"/>
  </xsl:for-each>
</li>
			<!-- Uppercase first latter of category -->
		<xsl:variable name="firstChar" select="substring(name(.),1,1)"/>
		<xsl:variable name="category">
			<xsl:value-of select="translate($firstChar,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
			<xsl:value-of select="substring-after(name(.),$firstChar)"/>
		</xsl:variable>
		<li>
			<xsl:value-of select="$category"/>
			<b>
				<xsl:value-of
					select="concat(' ', x:manufacturer, ' ', x:family, ' ', x:model)" />
			</b>
		</li>

			<xsl:for-each select="*">
				<li>
					<xsl:value-of select="concat( name(.), ': ', .)"/>
				</li>
			</xsl:for-each>
			<!--  Bad IDEA -->
		<!-- <li>Manufacturer: <xsl:value-of select="x:manufacturer" /></li>
		<li>Price:<xsl:value-of select="x:price" /></li>
		<li>Available:<xsl:value-of select="x:available" /></li>
		<xsl:apply-templates select="." mode="other"/> -->
	</ul>
</xsl:template>
<!-- BAD IDEA -->
<!-- HERE are templates with mode other - for different info about each kind of product -->
<!-- <xsl:template match="x:processor" mode="other">
	<li>architecture: <xsl:value-of select="x:architecture" /></li>
	<li>Model: <xsl:value-of select="x:model" /></li>
</xsl:template>
<xsl:template match="x:ram-stick" mode="other">
	<li>architecture: <xsl:value-of select="x:architecture" /></li>
	<li>socket:<xsl:value-of select="x:socket" /></li>
</xsl:template>
<xsl:template match="x:video-card" mode="other">
	<li>architecture: <xsl:value-of select="x:architecture" /></li>
	<li>socket:<xsl:value-of select="x:socket" /></li>
</xsl:template>
<xsl:template match="x:disk" mode="other">
	<li>interface: <xsl:value-of select="x:interface" /></li>
	<li>Memory:<xsl:value-of select="concat(x:memory/type, x:memory/size, x:memory/speed)" /></li>
	<li>Size:<xsl:value-of select="x:size" /></li>
</xsl:template>
<xsl:template match="x:motherboard" mode="other">
	<li>Model: <xsl:value-of select="x:model" /></li>
	<li>socket:<xsl:value-of select="x:socket" /></li>
</xsl:template> -->

</xsl:stylesheet>
