<%-- Initialize the theme configuration bean used for this request. --%>
<jsp:useBean id="ThemeConfig" scope="request" class="java.util.LinkedHashMap"/>

<%-- Set the values of the themes configurable settings. --%>
<%
    ThemeConfig.put("companyName", "ACME");
    ThemeConfig.put("portalName", "Service Portal");

    // If null, will use the catalog's default logout action
    ThemeConfig.put("defaultLoginAction", null);
    // If null, the forgot password link on the login page will not be displayed
    ThemeConfig.put("forgotPasswordAction", "http://www.kineticdata.com");

    ThemeConfig.put("searchableAttributes", new String[] {"Keyword"});
%>