<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:x="http://www.w3schools.com"
	exclude-result-prefixes="x">

	<xsl:param name="sortKey">available</xsl:param>
	<xsl:param name="sortOrder">ascending</xsl:param>
	<xsl:param name="sortType">number</xsl:param>

	<xsl:param name="sortKey-processor">available</xsl:param>
	<xsl:param name="sortOrder-processor">ascending</xsl:param>
	<xsl:param name="sortType-processor">number</xsl:param>

	<xsl:param name="sortKey-ram-stick">available</xsl:param>
	<xsl:param name="sortOrder-ram-stick">ascending</xsl:param>
	<xsl:param name="sortType-ram-stick">number</xsl:param>

	<xsl:param name="sortKey-video-card">available</xsl:param>
	<xsl:param name="sortOrder-video-card">ascending</xsl:param>
	<xsl:param name="sortType-video-card">number</xsl:param>

	<xsl:param name="sortKey-disk">available</xsl:param>
	<xsl:param name="sortOrder-disk">ascending</xsl:param>
	<xsl:param name="sortType-disk">number</xsl:param>

	<xsl:param name="sortKey-motherboard">available</xsl:param>
	<xsl:param name="sortOrder-motherboard">ascending</xsl:param>
	<xsl:param name="sortType-motherboard">number</xsl:param>

	<!--
	https://msdn.microsoft.com/en-us/library/ms950787.aspx
	<first_name><xsl:value-of select="$first_name"/></first_name>
	<last_name><xsl:value-of select="$last_name"/></last_name>
	<vocation><xsl:value-of select="$vocation"/></vocation> -->
	<xsl:param name="sortData">
		<processors>

			<sortKey>available</sortKey>
			<sortOrder>ascending</sortOrder>
			<sortType>number</sortType>
		</processors>
		<video-cards>
			<sortKey>available</sortKey>
			<sortOrder>ascending</sortOrder>
			<sortType>number</sortType>
		</video-cards>

	</xsl:param>

	<xsl:template match="/">
		<table border="0" class="sortable">
			<thead>
				<!-- <xsl:call-template name="create_header" /> -->
			</thead>
			<!-- <xsl:apply-templates select="*" /> -->
			<xsl:for-each select="*">
				<!--  TODO how to get $sortData/processors/sortKey?-->
				<!-- <p> <xsl:value-of select="$sortData/processors/sortKey"/></p> -->
				<!-- <xsl:sort select="*[name(.)=$sortKey]|@*[name(.)=$sortKey]|x:price/*[name(.)=$sortKey]" order="{$sortOrder}" data-type="{$sortType}" /> -->
				<!-- <tr> -->
				<!-- <xsl:value-of select="$sortData"/> -->
				<xsl:apply-templates select="." />
				<!-- </tr> -->
			</xsl:for-each>
		</table>
	</xsl:template>

	<xsl:template name="create_header">
		<xsl:param name="category" />
		<tr>
			<th>
				<a href="javascript:sort('manufacturer', '{$category}')">Name</a>
				<xsl:call-template name="show_sorting">
					<xsl:with-param name="header" select="'manufacturer'" />
				</xsl:call-template>
			</th>
			<th>
				<a href="javascript:sort('manufacturer', '{$category}')">Manufacturer</a>
				<xsl:call-template name="show_sorting">
					<xsl:with-param name="header" select="'manufacturer'" />
				</xsl:call-template>
			</th>
			<th>
				<a href="javascript:sort('available', '{$category}')">Available</a>
				<xsl:call-template name="show_sorting">
					<xsl:with-param name="header" select="'available'" />
				</xsl:call-template>
			</th>
			<th>
				<a href="javascript:sort('price', '{$category}')">Price</a>
				<xsl:call-template name="show_sorting">
					<xsl:with-param name="header" select="'price'" />
				</xsl:call-template>
			</th>
		</tr>
	</xsl:template>

	<xsl:template name="show_sorting">
		<xsl:param name="header" />
		<xsl:if test="$sortKey = $header">
			<xsl:if test="$sortOrder = 'ascending'">&#x25B4;</xsl:if>
			<xsl:if test="$sortOrder = 'descending'">&#x25BE;</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="x:processors | x:ram-sticks | x:video-cards | x:hard-drives | x:disks | x:motherboards">
		<tr class="dark">
			<!-- Category name  -->
			<xsl:variable name="firstChar" select="substring(name(.),1,1)"/>
			<xsl:variable name="Category">
				<xsl:value-of select="translate($firstChar,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
				<xsl:value-of select="substring-after(name(.),$firstChar)"/>
			</xsl:variable>
			<td><xsl:value-of select="$Category"/></td>
			<td></td><td></td><td></td>
		</tr>
		<thead>
			<xsl:call-template name="create_header">
				<xsl:with-param name="category" select="name(.)"/>
			</xsl:call-template>
		</thead>
		<xsl:choose>
			<xsl:when test="name(.) = 'processors'">

				<xsl:for-each select="x:processor | x:ram-stick | x:video-card | x:hard-drive | x:disk | x:motherboard">
					<xsl:sort select="*[name(.)=$sortKey-processor]|@*[name(.)=$sortKey-processor]" order="{$sortOrder-processor}" data-type="{$sortType-processor}" />

					<tr>
						<xsl:apply-templates select="." />
					</tr>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="name(.) = 'ram-sticks'">

				<xsl:for-each select="x:processor | x:ram-stick | x:video-card | x:hard-drive | x:disk | x:motherboard">
					<xsl:sort select="*[name(.)=$sortKey-ram-stick]|@*[name(.)=$sortKey-ram-stick]" order="{$sortOrder-ram-stick}" data-type="{$sortType-ram-stick}" />


					<tr>
						<xsl:apply-templates select="." />
					</tr>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="name(.) = 'video-cards'">

				<xsl:for-each select="x:processor | x:ram-stick | x:video-card | x:hard-drive | x:disk | x:motherboard">
					<xsl:sort select="*[name(.)=$sortKey-video-card]|@*[name(.)=$sortKey-video-card]" order="{$sortOrder-video-card}" data-type="{$sortType-video-card}" />

					<tr>
						<xsl:apply-templates select="." />
					</tr>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="name(.) = 'disks'">

				<xsl:for-each select="x:processor | x:ram-stick | x:video-card | x:hard-drive | x:disk | x:motherboard">
					<xsl:sort select="*[name(.)=$sortKey-disk]|@*[name(.)=$sortKey-disk]" order="{$sortOrder-disk}" data-type="{$sortType-disk}" />

					<tr>
						<xsl:apply-templates select="." />
					</tr>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="name(.) = 'motherboards'">

				<xsl:for-each select="x:processor | x:ram-stick | x:video-card | x:hard-drive | x:disk | x:motherboard">
					<xsl:sort select="*[name(.)=$sortKey-motherboard]|@*[name(.)=$sortKey-motherboard]" order="{$sortOrder-motherboard}" data-type="{$sortType-motherboard}"/>

					<tr>
						<xsl:apply-templates select="." />
					</tr>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>

				<xsl:for-each select="x:processor | x:ram-stick | x:video-card | x:hard-drive | x:disk | x:motherboard">
					<xsl:sort select="*[name(.)=$sortKey]|@*[name(.)=$sortKey]" order="{$sortOrder}" data-type="{$sortType}" />

					<tr>
						<xsl:apply-templates select="." />
					</tr>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
	<xsl:template match="x:part_image"/>

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
		<td><xsl:value-of select="x:manufacturer" /></td>
		<!-- <td><xsl:value-of select="x:model" /></td> -->
		<td><xsl:value-of select="x:available" /></td>
		<td><xsl:value-of select="x:price" /> лв.</td>
		<!-- <td><xsl:value-of select="x:stock" /></td> -->
	</xsl:template>



</xsl:stylesheet>
