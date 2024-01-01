<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:template match="/">
<html>
<head>
<title>Naveen's Test Automation Results </title>
<style>
<!--  body { font-family: Arial, sans-serif; text-align: center; }
                   h1 { text-decoration: underline; }
                   .info-table, .main-table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
                   .info-table th, .main-table th { background-color: #4169e1; color: white; font-weight: bold; }
                   .info-table td, .main-table td { border: 2px solid #ddd; padding: 8px; font-size: 0.9em;}
                   .info-table tr:nth-child(even), .main-table tr:nth-child(even) { background-color: #f2f2f2; }
                   .info-table tr:nth-child(odd), .main-table tr:nth-child(odd) { background-color: white; }
                   .success { background-color: #32cd32; }
                   .failure { background-color: #ff0000; }
                   .data-cell { font-weight: bold; }
           .info-container {display: flex; justify-content: space-between; align-items: flex-start;}
           .info-table{width:auto;}
           .left-table-container {width: 50%; text-align: left;}
           .right-table-container{width:50%; padding-left:20px;} /*Adjust padding to align with the left table */
           .data-cell {font-weight: bold;}-->

<!--body { font-family: Arial, sans-serif; text-align: center; }
           h1 { text-decoration: underline; }
                   .info-table { border-collapse: collapse; margin-bottom: 20px; }
                   .info-table th, .info-table td { border: 2px solid #333; padding: 8px; }
                   .info-table th { background-color: #4169e1; color: white; }
                   .main-table { border-collapse: collapse; width: 100%; margin-top: 20px; }
                   th, td { border: 2px solid #333; padding: 8px; }
                   th { background-color: #4169e1; color: white; }
                   .success { background-color: #d4edda; }
                   .failure { background-color: #f8d7da; }
                   .info-container { display: flex; justify-content: space-between; align-items: flex-start; }
                   .info-table { width: auto; }
                   .left-table-container { width: 70%; text-align: left; }
                   .right-table-container { width: 40%; }
                   .left-table-container > .info-table { margin-right: 100; }-->

<!-- Version 1: Detailed Layout -->
<style>
    body { font-family: Arial, sans-serif; text-align: center; }
    h1 { text-decoration: underline; }
    .main-table { border-collapse: collapse; width: 100%; margin-top: 20px; }
    th, td { border: 2px solid #333; padding: 8px; }
    th { background-color: #4169e1; color: white; }
    .success { background-color: #32cd32; }
    .failure { background-color: #ff0000; }
    .info-container { display: flex; justify-content: space-between; align-items: flex-start; }
    .info-table { width: auto; }
    .left-table-container { width: 70%; text-align: left; }
    .right-table-container { width: 30%; padding-left: 20px; }
</style>

</style>
</head>
<body>
<h1>REST API Test Execution Summary Report</h1>
<div class="info-container">
<div class="left-table-container">
<table class="info-table">
<tr><th colspan="2">Test Environment</th></tr>
<xsl:for-each select="//environment">
<tr><td>Platform</td><td><xsl:value-of select="@platform"/></td></tr>
<tr><td>OS Version</td><td><xsl:value-of select="@os-version"/></td></tr>
<tr><td>User Domain</td><td><xsl:value-of select="@user-domain"/></td></tr>
<tr><td>Machine Name</td><td><xsl:value-of select="@machine-name"/></td></tr>
<tr><td>User</td><td><xsl:value-of select="@user"/></td></tr>
<tr><td>Nunit-Version</td><td><xsl:value-of select="@nunit-version"/></td></tr>
</xsl:for-each>
</table>
</div>
<div class="right-table-container">
<table class="info-table">
<tr><th colspan="2">Test Execution Status</th></tr>
<tr><td>Total Number of Test Cases</td><td><xsl:value-of select="count(//test-case[@executed='True'])"/></td></tr>
<tr><td>Total Executed</td><td><xsl:value-of select="count(//test-case[@executed='True'])"/></td></tr>
<tr><td>Total Number of Test Cases Passed</td><td><xsl:value-of select="count(//test-case[@result='Success'])"/></td></tr>
<tr><td>Total Number of Test Cases Failed</td><td><xsl:value-of select="count(//test-case[@result='Failure'])"/></td></tr>
<tr><td>Total Number of Test Cases Skipped</td><td><xsl:value-of select="count(//test-case[@executed='False'])"/></td></tr>
<tr><td>Test Execution Date</td><td><xsl:value-of select="/test-results/@date"/></td></tr>
</table>
</div>
</div>
<table class="main-table">
<tr>
<th>Test Name</th>
<th>Status</th>
<th>Description</th>
</tr>
<xsl:for-each select="//test-case">
<tr>
<td><xsl:value-of select="@name"/></td>
<td>
<xsl:choose>
<xsl:when test="@result='Success'">
<span class="success">Passed</span>
</xsl:when>
<xsl:otherwise>
<span class="failure">Failed</span>
</xsl:otherwise>
</xsl:choose>
</td>
<td><xsl:value-of select="@description"/></td>
</tr>
<xsl:if test="failure">
<tr>
<td colspan="3">
<strong>Failure Details:</strong><br/>
 Message: <xsl:value-of select="failure/message"/><br/>
                                   Stack Trace: <xsl:value-of select="failure/stack-trace"/>
</td>
</tr>
</xsl:if>
</xsl:for-each>
</table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>

