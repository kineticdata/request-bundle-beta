<%--
    This file prepares the Javascript and CSS content and references necessary
    for the Kinetic SR application to function properly.
--%>

<!-- BEGIN {themeRoot}/jsp/includes/applicationHeaders.jsp -->
<%-- Define the beans that are used for this page. --%>
<jsp:useBean id="customerSurvey" scope="request" class="com.kd.kineticSurvey.beans.CustomerSurvey"/>
<jsp:useBean id="UserContext" scope="session" class="com.kd.kineticSurvey.beans.UserContext"/>

<%-- Initialize the theme configuration bean used for this request. --%>
<jsp:useBean id="ThemeConfig" scope="request" class="java.util.LinkedHashMap"/>

<%-- Include the ThemeHelper class. --%>
<%@include file="../../helpers/themeHelper.jspf" %>

<%--
  CSS
    Include the custom stylesheet if one has been uploaded an an attachment on
    the Advanced Tab of the Service Catalog Console.
--%>
<% if(!ThemeHelper.isBlank(customerSurvey.getStylesheetFileName())) { %>
<!-- Include the CSS file attached to the Template. -->
<link rel="stylesheet" type="text/css" href="<%= customerSurvey.getStylesheetFileName() %>" />
<% } %>

<%--
  Javascript
    If the request includes a parameter with the name "debugjs" include the
    uncompressed files, otherwise include the compressed complete file.
--%>
<% if (request.getParameter("debugjs") != null) { %>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/kd_actions.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/kd_utils.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/kd_client.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/kd_catalogUtils.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/kd_review.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/kd_date.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/extensions/kd_panel.js"%>"></script>
<% } else { %>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/kd_complete.js"%>"></script>
<% } %>

<%--
  Javascript
    Include the custom javascript file if one has been uploaded as an attachment
    on the Advanced Tab of the Service Catalog Console.
--%>
<% if(!ThemeHelper.isBlank(customerSurvey.getJavascriptFileName())) { %>
<!-- Include the Javascript attached to the Template. -->
<script type="text/javascript" src="<%= customerSurvey.getJavascriptFileName() %>"></script>
<% } %>

<%--
  Javascript
    Include the code necessary to interact wtih the Kinetic Request system.
--%>
<script type="text/javascript">
    // Alias the KD.utils.ClientManager class to the clientManager variable for easier access.
    var clientManager = KD.utils.ClientManager;

    // Define the function used by the KD.utils.ClientManager (clientManager) to
    // initialize the configuration of the Kinetic Request interaction interface.
    function ks_initSessionVars(){
        clientManager.themesDirectory = '<%= ThemeConfig.get("root") %>';
        clientManager.successMessage = '<jsp:getProperty name="customerSurvey" property="successMessage"/><jsp:getProperty name="UserContext" property="successMessage"/>';
        clientManager.errorMessage = '<jsp:getProperty name="customerSurvey" property="errorMessage"/><jsp:getProperty name="UserContext" property="errorMessage"/>';
        clientManager.sessionId = '<jsp:getProperty name="customerSurvey" property="customerSessionInstanceID"/>';
        clientManager.customerSurveyId = '<jsp:getProperty name="customerSurvey" property="customerSurveyInstanceID"/>';
        clientManager.authenticated = <%= UserContext.isAuthenticated()%>;
        clientManager.userName = '<%= UserContext.getUserName()%>';
        clientManager.templateId = '<jsp:getProperty name="customerSurvey" property="surveyTemplateInstanceID"/>';
        clientManager.submitType = '<jsp:getProperty name="customerSurvey" property="submitType"/>'
        clientManager.customerSurveyId = '<jsp:getProperty name="customerSurvey" property="customerSurveyInstanceID"/>';
        clientManager.originatingPage = '<%= UserContext.getOriginatingPage()%>';
        clientManager.authenticationType = '<%= UserContext.getAuthenticationType()%>';
        clientManager.isAuthenticationRequired = '<%= customerSurvey.isAuthenticationRequired()%>';
        clientManager.isNewPage = <jsp:getProperty name="customerSurvey" property="isNewPage"/>;
    }

    // Configure an event to initialize the client manager after the window is loaded
    KD.utils.Action.addListener(window, "load", function() {clientManager.init()});
</script>
<!-- END {themeRoot}/jsp/includes/applicationHeaders.jsp -->