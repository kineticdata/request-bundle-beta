<%-- Initialize the theme configuration bean used for this request. --%>
<jsp:useBean id="ThemeConfig" scope="request" class="java.util.LinkedHashMap"/>

<%-- Set the values of the themes configurable settings. --%>
<%
    ThemeConfig.put("companyName", "ACME");
    ThemeConfig.put("portalName", "Service Portal");
%>