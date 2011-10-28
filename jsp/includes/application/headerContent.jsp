<%--
    This file prepares the Javascript and CSS content and references necessary
    for the Kinetic SR application to function properly.
--%>

<%--
    TODO: Document
--%>
<%@include file="../themeInitialization.jspf"%>

<%
    // Declare a CustomerSurveyReview object
    CustomerSurveyReview review = null;
    // Retrieve the list of review pages if one exists
    Vector<CustomerSurveyReview> reviewPages = (Vector)request.getAttribute("RequestPages");

    // If there were no reviewable pages
    if (reviewPages != null && reviewPages.size() != 0) {
        // Overwrite the default customer survey values
        review = reviewPages.firstElement();
        customerSurvey.setSurveyTemplateName(review.getSurveyTemplateName());
        customerSurvey.setSuccessMessage(review.getSuccessMessage());
        customerSurvey.setErrorMessage(review.getErrorMessage());
        customerSurvey.setCustomerSessionInstanceID(review.getCustomerSessionInstanceID());
        customerSurvey.setCustomerSurveyInstanceID(review.getCustomerSurveyInstanceID());
        customerSurvey.setSurveyTemplateInstanceID(review.getSurveyTemplateInstanceID());
        customerSurvey.setSubmitType("ReviewRequest");
    }
%>

<!-- BEGIN {themeRoot}/jsp/includes/application/headerContent.jsp -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/resources/js/yui/build/calendar/assets/calendar.css"%>"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/resources/js/yui/build/container/assets/container.css"%>"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/resources/css/ks_basic.css"%>"/>
<% if (review != null) { %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/resources/css/kd_review.css"%>"/>
<% } %>

<%--
  CSS - Attached Stylesheet File
    Include the custom stylesheet, if one has been uploaded an an attachment on
    the Advanced Tab of the Service Catalog Console.
--%>
<% if (!ThemeHelper.isBlank(customerSurvey.getStylesheetFileName())) { %>
    <!-- Include the CSS file attached to the Template. -->
    <link rel="stylesheet" type="text/css" href="<%= customerSurvey.getStylesheetFileName() %>" />
<% } %>

<%--
  CSS - Custom Header Content
    Include the custom header content, if any is specified on the Advanced Tab
    of the Service Catalog Console.
--%>
<% if (!ThemeHelper.isBlank(customerSurvey.getCustomHeaderContent())) { %>
    <!-- Include the custom header content of the Template. -->
    <%= customerSurvey.getCustomHeaderContent()%>
<% } %>

<%--
  CSS - Page Styles
    Include the page style information (or all page styles if the content is
    being displayed as a Review page).
--%>
<% if (reviewPages != null) { %>
    <% for (CustomerSurveyReview reviewPage : reviewPages) { %>
    <%= reviewPage.getStyleInfo() %>
    <% } %>
<% } else if (!ThemeHelper.isBlank(customerSurvey.getStyleInfo())) { %>
    <!-- Include the page style information. -->
    <%= customerSurvey.getStyleInfo() %>
<% } %>

<%--
  Javascript - Core Application Scripts
    If the request includes a parameter with the name "debugjs" include the
    uncompressed files, otherwise include the compressed complete file.
--%>
<script type="text/javascript" src="<%=bundle.context() +  "/resources/js/yui/build/utilities/utilities.js"%>"></script>
<script type="text/javascript" src="<%=bundle.context() +  "/resources/js/yui/build/calendar/calendar-min.js"%>"></script>
<script type="text/javascript" src="<%=bundle.context() +  "/resources/js/yui/build/button/button-min.js"%>"></script>
<script type="text/javascript" src="<%=bundle.context() +  "/resources/js/yui/build/container/container-min.js"%>"></script>
<% if (request.getParameter("debugjs") != null) { %>
<script type="text/javascript" src="<%=bundle.context() +  "/resources/js/kd_actions.js"%>"></script>
<script type="text/javascript" src="<%=bundle.context() +  "/resources/js/kd_utils.js"%>"></script>
<script type="text/javascript" src="<%=bundle.context() +  "/resources/js/kd_client.js"%>"></script>
<% } else { %>
<script type="text/javascript" src="<%=bundle.context() +  "/resources/js/kd_complete.js"%>"></script>
<% } %>
<script type="text/javascript" src="<%=bundle.context() +  "/resources/js/kd_date.js"%>"></script>
<script type="text/javascript" src="<%=bundle.context() +  "/resources/js/extensions/kd_panel.js"%>"></script>
<% if (review != null) { %>
<script type="text/javascript" src="<%=bundle.context() +  "/resources/js/kd_review.js"%>"></script>
<% } %>

<%--
  Javascript - Attached Javascript File
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
        clientManager.themesDirectory = '<%= bundle.path() %>';
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

<%--
  Javascript - Review Request Javascript
    Include the page style information (or all page styles if the content is
    being displayed as a Review page).
--%>
<% if (review != null) { %>
    <script type="text/javascript">
        var pageIds = [];
        <% for (CustomerSurveyReview reviewPage : reviewPages) { %>
        pageIds.push("<%= reviewPage.getSanitizedPageId() %>");
        <% } %>
        var reviewObj = { clientManager: clientManager, loadAllPages: <%= review.getLoadAllPages() %>, pageIds: pageIds };
        KD.utils.Action.addListener(window, "load", KD.utils.Review.init, reviewObj, true);
    </script>
<% } %>
<!-- END {themeRoot}/jsp/includes/application/headerContent.jsp -->