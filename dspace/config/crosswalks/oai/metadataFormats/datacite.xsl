<?xml version="1.0" encoding="UTF-8"?>
<!--  http://www.openarchives.org/OAI/2.0/oai_dc.xsl-->
<xsl:stylesheet xmlns="http://datacite.org/schema/kernel-4" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:doc="http://www.lyncode.com/xoai" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0">
	<xsl:output omit-xml-declaration="no" method="xml" indent="yes" />
	<xsl:template match="/">
		<resource xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://datacite.org/schema/kernel-4">			
<!-- datacite identifier -->
			<xsl:variable name="numIdentifier" as="xs:integer" select="count(doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='uri'])" />
			<xsl:if test="$numIdentifier &gt; 0">
				<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='uri']/doc:element/doc:field[@name='value']">
					<identifier>
						<xsl:value-of select="." />
					</identifier>
				</xsl:for-each>
				<!-- datacite identifier.* -->
				<alternateIdentifiers>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='doi']/doc:element/doc:field[@name='value']">
						<alternateIdentifier>
							<xsl:attribute name="identifierType">DOI</xsl:attribute>
							<xsl:value-of select="." />
						</alternateIdentifier>
					</xsl:for-each>
					<alternateIdentifier>
						<xsl:attribute name="alternateIdentifierType">DCSIC</xsl:attribute>
						<xsl:value-of select="doc:metadata/doc:element[@name='others']/doc:field[@name='idDc']" />
					</alternateIdentifier>
				</alternateIdentifiers>
			</xsl:if>
			<xsl:if test="$numIdentifier &lt; 1">
				<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='doi']/doc:element/doc:field[@name='value']">
					<identifier>
						<xsl:attribute name="identifierType">DOI</xsl:attribute>
						<xsl:value-of select="." />
					</identifier>
				</xsl:for-each>
				<alternateIdentifiers>
					<alternateIdentifier>
						<xsl:attribute name="alternateIdentifierType">DCSIC</xsl:attribute>
						<xsl:value-of select="doc:metadata/doc:element[@name='others']/doc:field[@name='idDc']" />
					</alternateIdentifier>
				</alternateIdentifiers>
			</xsl:if>
			<!--  datacite title -->
			<xsl:variable name="numTitles" as="xs:integer" select="count(doc:metadata/doc:element[@name='dc']/doc:element[@name='title'])" />
			<xsl:if test="$numTitles &gt; 0">
				<titles>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element/doc:field[@name='value']">
						<title>
							<xsl:if test="../@name">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name" /></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</title>
					</xsl:for-each>
					<!-- datacite title.* -->
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element/doc:element/doc:field[@name='value']">
						<title>
							<xsl:if test="../@name">
								<xsl:attribute name="xml:lang"><xsl:value-of select="../@name" /></xsl:attribute>
							</xsl:if>
							<xsl:value-of select="." />
						</title>
					</xsl:for-each>
				</titles>
			</xsl:if>
			<!-- Datacite publisher -->
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='publisher']/doc:element/doc:field[@name='value']">
				<publisher>
					<xsl:value-of select="." />
				</publisher>
			</xsl:for-each>
			<!-- Datacite publicationYear TODO TEST-->
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='issued']/doc:element/doc:field[@name='value']">
				<publicationYear>
					<xsl:value-of select="substring(.,1,4)" />
				</publicationYear>
			</xsl:for-each>
			<!-- Datacite resourceType TODO TEST-->
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']">
				<resourceType>
					<xsl:attribute name="resourceTypeGeneral">
						<xsl:value-of select="." />
					</xsl:attribute>
				</resourceType>
			</xsl:for-each>
			<xsl:variable name="numAuthor" as="xs:integer" select="count(doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='author'])" />
			<xsl:if test="$numAuthor &gt; 0">
				<creators>
					<!-- dc.creator -->
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='author']/doc:element/doc:field">
						<xsl:if test="./@name = 'value'">
							<creator>
								<creatorName>
									<xsl:value-of select="." />
								</creatorName>
								<xsl:if test="./following-sibling::*[1]/@name = 'authority'">
									<nameIdentifier nameIdentifierScheme="DSPACE_CRIS_RP"><xsl:value-of select="./following-sibling::*[1]" /></nameIdentifier>
								</xsl:if>
							</creator>
						</xsl:if>
					</xsl:for-each>
				</creators>
			</xsl:if>
			<xsl:variable name="numContributor" as="xs:integer" select="count(doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor'])" />
			<xsl:if test="$numContributor &gt; 0">
				<contributors>
					<!-- dc.creator -->
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element/doc:field[@name='value']">
						<contributor>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='orcid']/doc:element/doc:field[@name='value']">
						<contributor>
							<nameIdentifier schemeURI="http://orcid.org/" nameIdentifierScheme="ORCID">
								<xsl:value-of select="." />
							</nameIdentifier>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='projectManager']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">ProjectManager</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='projectMember']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">ProjectMember</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='registrationAuthority']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">RegistrationAuthority</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='researcher']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">Researcher</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='rightsHolder']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">RightsHolder</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='dataCollector']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">DataCollector</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='distributor']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">Distributor</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='hostingInstitution']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">HostingInstitution</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='producer']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">Producer</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='projectLeader']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">ProjectLeader</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='registrationAgency']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">RegistrationAgency</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='relatedPerson']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">RelatedPerson</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='researchGroup']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">ResearchGroup</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='supervisor']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">Supervisor</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='workPackageLeader']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">WorkPackageLeader</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='contactPerson']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">ContactPerson</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='dataCurator']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">DataCurator</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='dataManager']/doc:element/doc:field[@name='value']">
						<contributor>
							<xsl:attribute name="contributorType">DataManager</xsl:attribute>
							<contributorName>
								<xsl:value-of select="." />
							</contributorName>
						</contributor>
					</xsl:for-each>
				</contributors>
			</xsl:if>
			<!-- dc.subject -->
			<xsl:variable name="numSubjects" as="xs:integer" select="count(doc:metadata/doc:element[@name='dc']/doc:element[@name='subject'])" />
			<xsl:if test="$numSubjects &gt; 0">
				<subjects>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element/doc:field[@name='value']">
						<subject>
							<xsl:value-of select="." />
						</subject>
					</xsl:for-each>
					<!-- dc.subject.* -->
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element/doc:element/doc:field[@name='value']">
						<subject>
							<xsl:value-of select="." />
						</subject>
					</xsl:for-each>
				</subjects>
			</xsl:if>
			<!-- dates -->
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='issued']/doc:element/doc:field[@name='value']">
				<dates>
					<date dateType="Issued"><xsl:value-of select="." /></date>
				</dates>
			</xsl:for-each>
			<!-- dc.coverage -->
			<xsl:variable name="numGeo" as="xs:integer" select="count(doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='spatial'])" />
			<xsl:if test="$numGeo &gt; 0">
				<geoLocations>
					<geoLocation>
						<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='spatial']/doc:element/doc:field[@name='value']">
							<geoLocationPlace>
								<xsl:value-of select="." />
							</geoLocationPlace>
						</xsl:for-each>
					</geoLocation>
				</geoLocations>
			</xsl:if>
			<xsl:variable name="numDesc" as="xs:integer" select="count(doc:metadata/doc:element[@name='dc']/doc:element[@name='description'])" />
			<xsl:if test="$numDesc &gt; 0">
				<descriptions>
					<!-- dc.description -->
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element/doc:field[@name='value']">
						<description>
							<xsl:attribute name="descriptionType">Description</xsl:attribute>
							<xsl:value-of select="." />
						</description>
					</xsl:for-each>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='abstract']/doc:element/doc:field[@name='value']">
						<description>
							<xsl:attribute name="descriptionType">Abstract</xsl:attribute>
							<xsl:if test="substring(.,1,4) = '[EN]'">
								<xsl:attribute name="xml:lang">en_US</xsl:attribute>
								<xsl:value-of select="substring(.,5)" />
							</xsl:if>
							<xsl:if test="substring(.,1,4) = '[ES]'">
								<xsl:attribute name="xml:lang">es_ES</xsl:attribute>
								<xsl:value-of select="substring(.,5)" />
							</xsl:if>
							<xsl:if test="not(substring(.,1,4) = '[ES]') and not(substring(.,1,4) = '[EN]')">
								<xsl:value-of select="." />
							</xsl:if>
						</description>
					</xsl:for-each>
				</descriptions>
			</xsl:if>
			<xsl:variable name="numFund" as="xs:integer" select="count(doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='funder'])" />
			<xsl:if test="$numFund &gt; 0">
				<fundingReferences>
					<!-- dc.description -->
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='funder']/doc:element/doc:field[@name='value']">
						<fundingReference>
							<funderName>
								<xsl:value-of select="." />
							</funderName>
							<xsl:variable name="idFund" as="xs:integer" select="count(doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='funder'])" />
							<xsl:if test="$idFund &gt; 0">
								<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='funder']/doc:element/doc:field[@name='value']">
									<funderIdentifier>
										<xsl:attribute name="funderIdentifierType">DOI</xsl:attribute>
										<xsl:value-of select="." />
									</funderIdentifier>
								</xsl:for-each>
							</xsl:if>
						</fundingReference>
					</xsl:for-each>
				</fundingReferences>
			</xsl:if>
			<xsl:variable name="numRel" as="xs:integer" select="count(doc:metadata/doc:element[@name='dc']/doc:element[@name='relation'])" />
			<xsl:if test="$numRel &gt; 0">
				<relatedIdentifiers>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='isreferencedby']/doc:element/doc:field[@name='value']">
						<xsl:variable name="altId" select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='isreferencedby']/doc:element/doc:field[@name='value']" />
						<xsl:variable name="altId_url" select="substring-after($altId, 'http://')" />
						<xsl:if test="(contains(altId_url,'doi.org'))">
							<relatedIdentifier relationType="isreferencedby" relatedIdentifierType="DOI">
								<xsl:value-of select="substring-after($altId_url, 'doi.org/')" />
							</relatedIdentifier>
						</xsl:if>
						<xsl:if test="contains(altId_url,'handle')">
							<relatedIdentifier relationType="isreferencedby" relatedIdentifierType="URL">
								<xsl:value-of select="substring-after($altId_url, 'handle.net/')" />
							</relatedIdentifier>
						</xsl:if>
					</xsl:for-each>
				</relatedIdentifiers>
			</xsl:if>
			<xsl:variable name="numRights" as="xs:integer" select="count(doc:metadata/doc:element[@name='dc']/doc:element[@name='rights'])" />
			<xsl:if test="$numRights &gt; 0">
				<rightsList>
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='rights']">      
						<rights>
							<xsl:if test="./doc:element[@name='license']/doc:element/doc:field[@name='value'] != ''">
								<xsl:attribute name="rightsURI">
									<xsl:value-of select="./doc:element[@name='license']/doc:element/doc:field[@name='value']" />
								</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="./doc:element[@name='en_US']/doc:field[@name='value']" />
						</rights>
					</xsl:for-each>
				</rightsList>
			</xsl:if>
		</resource>
	</xsl:template>
</xsl:stylesheet>
