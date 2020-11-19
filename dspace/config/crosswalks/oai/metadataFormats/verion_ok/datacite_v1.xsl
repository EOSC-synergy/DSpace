<?xml version="1.0" encoding="UTF-8" ?>
<!--  http://www.openarchives.org/OAI/2.0/oai_dc.xsl-->
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://www.lyncode.com/xoai"
	version="1.0">
	<xsl:output omit-xml-declaration="yes" method="xml" indent="yes" />
	
	<xsl:template match="/">
		<resource xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" 
			xmlns="http://datacite.org/schema/kernel-3" 
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
			xsi:schemaLocation="http://datacite.org/schema/kernel-3 http://schema.datacite.org/meta/kernel-3/metadata.xsd">
			<!-- dc.title -->
			<titles>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element/doc:field[@name='value']">
				<title><xsl:value-of select="." /></title>
			</xsl:for-each>
			<!-- dc.title.* -->
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element/doc:element/doc:field[@name='value']">
				<title><xsl:value-of select="." /></title>
			</xsl:for-each>
		</titles>
		<creators>
			<!-- dc.creator -->
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='creator']/doc:element/doc:field[@name='value']">
				<creator><xsl:value-of select="." /></creator>
			</xsl:for-each>
		</creators>
		<!-- dc.subject -->
		<subjects>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element/doc:field[@name='value']">
				<subject><xsl:value-of select="." /></subject>
			</xsl:for-each>
			<!-- dc.subject.* -->
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element/doc:element/doc:field[@name='value']">
				<subject><xsl:value-of select="." /></subject>
			</xsl:for-each>
		</subjects>
		<descriptions>
			<!-- dc.description -->
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element/doc:field[@name='value']">
				<description><xsl:value-of select="." /></description>
			</xsl:for-each>
			<!-- dc.description.* (not provenance)-->
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name!='provenance']/doc:element/doc:field[@name='value']">
				<description><xsl:value-of select="." /></description>
			</xsl:for-each>
		</descriptions>
		</resource>
	</xsl:template>
</xsl:stylesheet>
