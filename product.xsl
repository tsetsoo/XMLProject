<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet	version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:x="http://www.w3schools.com"
				exclude-result-prefixes="x">

	<xsl:param name="id">h1</xsl:param>


		<xsl:template match="/">
			<xsl:for-each select="*">
				<!-- <xsl:sort select="*[name(.)=$sortKey]|@*[name(.)=$sortKey]|x:price/*[name(.)=$sortKey]" order="{$sortOrder}" data-type="{$sortType}" /> -->
				<!-- <tr> -->
					<xsl:apply-templates select="." />
				<!-- </tr> -->
			</xsl:for-each>
		</xsl:template>

			<xsl:template match="x:processors | x:ram-sticks | x:video-cards | x:hard-drives | x:disks | x:motherboards">
				<xsl:for-each select="x:processor | x:ram-stick | x:video-card | x:hard-drive | x:disk | x:motherboard">
					<xsl:if test="@id=$id"><!-- <xsl:sort select="*[name(.)=$sortKey]|@*[name(.)=$sortKey]|x:price/*[name(.)=$sortKey]" order="{$sortOrder}" data-type="{$sortType}" /> -->
					<tr>
						<xsl:apply-templates select="." />
					</tr>
					</xsl:if>
				</xsl:for-each>
			</xsl:template>

			<xsl:template match="x:processor | x:ram-stick | x:video-card | x:hard-drive | x:disk | x:motherboard">
				<td>
					<xsl:variable name="request_id">
							<xsl:value-of select="@id"/>
					</xsl:variable>
					<a href="product.html?id={$request_id}">
			      		<xsl:value-of select="concat(x:manufacturer, ' ', x:family, ' ', x:model)" />
		 			</a>
			  		<!-- <br /> -->
		  	</td>
				<!-- Uppercase first latter of category -->
				<xsl:variable name="firstChar" select="substring(name(.),1,1)"/>
				<xsl:variable name="Category">
					<xsl:value-of select="translate($firstChar,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
					<xsl:value-of select="substring-after(name(.),$firstChar)"/>
				</xsl:variable>
				<td><xsl:value-of select="$Category"/></td>
				<td><xsl:value-of select="x:manufacturer" /></td>
				<!-- <td><xsl:value-of select="x:model" /></td> -->
				<td><xsl:value-of select="x:available" /></td>
				<td><xsl:value-of select="x:price" /></td>
				<!-- <td><xsl:value-of select="x:stock" /></td> -->

			</xsl:template>
</xsl:stylesheet>
