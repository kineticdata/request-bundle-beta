<%--
  Configure the HTTP Content-Type header value to specify UTF-8
--%>
<%@page contentType="text/html; charset=UTF-8"%>

<%--
  Configuration setting that trims all of the whitespace that is created by
  using JSP comments (such as this one) and other JSP tags.
--%>
<%@page trimDirectiveWhitespaces="true"%>


<%@include file="../../config/config.jsp"%>

<%@include file="../helpers/currentDate.jspf"%>

<%@include file="../includes/theme.jspf"%>
<%@include file="../includes/models.jspf"%>

<jsp:useBean id="customerSurvey" scope="request" class="com.kd.kineticSurvey.beans.CustomerSurvey"/>
<jsp:useBean id="UserContext" scope="session" class="com.kd.kineticSurvey.beans.UserContext"/>

<%
    HelperContext context = UserContext.getArContext();
    if (context == null) {
        context = customerSurvey.getRemedyHandler().getDefaultHelperContext();
    }
    Catalog catalog = Catalog.findByName(context, customerSurvey.getCategory());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title><%= catalog.getName() %> - <%= customerSurvey.getSurveyTemplateName() %></title>
        
<!--        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/base/base-min.css">
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/reset/reset-min.css">-->
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/fonts/fonts-min.css">


        <!-- Core + Skin CSS -->
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/button/assets/skins/sam/button.css">

        <link rel="stylesheet" type="text/css" href="<%=request.getAttribute("com.kd.themes.root") + "/css/theme.css"%>" />
        <link rel="stylesheet" type="text/css" href="<%=request.getAttribute("com.kd.themes.root") + "/css/pages/login.css"%>" />
        <link rel="stylesheet" type="text/css" href="<%=request.getAttribute("com.kd.themes.root") + "/config/config.css"%>" />


        <!-- Dependencies -->
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/yahoo-dom-event/yahoo-dom-event.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/element/element-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/button/button-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/selector/selector-min.js"></script>

<!--        <script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/kd_complete.js"%>"></script>-->

        <script src="<%=request.getAttribute("com.kd.themes.root")%>/js/theme.js" type="text/javascript"></script>
        <script type="text/javascript">
            THEME.config.rootPath = '<%=request.getAttribute("com.kd.themes.root")%>';
        </script>

        <script type="text/javascript">
            //
            function onSubmit(event) {
                THEME.hide('logInButton');
                THEME.show('loader');
            }
            // Once the page has loaded
            YAHOO.util.Event.onDOMReady(function() {
                // Convert the submit button into a YUI button
                new YAHOO.widget.Button("logInButton");
                // Listen for the submit action
                YAHOO.util.Event.on("loginForm", "submit", onSubmit);
                // Set the focus to the UserName input
                THEME.focus('UserName');
            });
        </script>

<!--        <script type="text/javascript">
            var clientManager = KD.utils.ClientManager;

            function ks_initSessionVars(){
                    clientManager.themesDirectory = 'themes/acme/';
                    clientManager.successMessage = "<jsp:getProperty name="customerSurvey"  property="successMessage" /><jsp:getProperty name="UserContext" property="successMessage" />";
                    clientManager.errorMessage = "<jsp:getProperty name="customerSurvey"  property="errorMessage" /><jsp:getProperty name="UserContext" property="errorMessage" />";
                    clientManager.sessionId='<jsp:getProperty name="customerSurvey" property="customerSessionInstanceID"/>';
                    clientManager.authenticated=<%= UserContext.isAuthenticated()%>;
                    clientManager.userName='<%= UserContext.getUserName()%>';
                    clientManager.templateId='<jsp:getProperty name="customerSurvey" property="surveyTemplateInstanceID"/>';
                    clientManager.customerSurveyId='<jsp:getProperty name="customerSurvey" property="customerSurveyInstanceID"/>';
                    clientManager.originatingPage='<%= UserContext.getOriginatingPage()%>';
                    clientManager.authenticationType='<%= UserContext.getAuthenticationType()%>';
                    clientManager.isAuthenticationRequired='<%= customerSurvey.isAuthenticationRequired()%>';
            }

            KD.utils.Action.addListener(window, "load", clientManager.init);
        </script>-->
    </head>
    <body class="fadedBackground yui-skin-sam">
        <!-- Render the colored line at the top of the page -->
        <div class="topline primaryColorBackground"></div>

        <!-- Render the logo and site name -->
        <div id="siteReference">
            <div id="siteLogo" class="logo"></div>
            <h1 id="siteName" class="primaryColor"><%= request.getAttribute("com.kd.themes.siteName") %></h1>
        </div>

        <!-- Render the log in box -->
        <div class="tertiaryColorBorder" id="loginBox">
            <!-- Header -->
            <h2 class="auxiliaryTitleColor">Please Log In</h2>
            
            <!-- Empty message div (this is automatically populated with Kinetic
                 Request messages; such as when a user logs out or enters an
                 incorrect password). -->
            <div id="message"></div>

            <!-- Login Form -->
            <form name="Login" id="loginForm" method="post" action="KSAuthenticationServlet">
                <!-- User Name -->
                <div class="field" id="usernameField">
                    <label for="UserName">User:</label>
                    <input id="UserName" class="formField" name="UserName" type="text" autocomplete="off" >
                </div>
                <!-- Password -->
                <div class="field" id="passwordField">
                    <label for="Password">Password:</label>
                    <input id="Password" class="formField" name="Password" type="password" autocomplete="off" >
                </div>
                <!-- Authentication -->
                <div class="field" id="authenticationField">
                    <label for="Authentication">Authentication:</label>
                    <input class="formField" name="Authentication" type="text" id="Authentication"/>
                </div>

                <!-- Log In Button (manipulated on DOMReady; see header) -->
                <input id="logInButton" name="logInButton" type="submit" value="Log In"/>

                <!-- Forgot Password -->
                <a class="primaryColor" href="#" id="forgotPasswordLink">Forgot Password</a>

                <div class="clear"></div>

                <!-- Logging In Spinner -->
                <span class="hidden" id="loader">Authenticating... <img src="resources/loading.gif"></span>

                <!-- Specify the required hidden elements -->
                <input type="hidden" name="originatingPage" id="originatingPage" value="<%= UserContext.getOriginatingPage()%>" />
                <input type="hidden" name="sessionID" id="loginSessionID" value="<jsp:getProperty name="customerSurvey" property="customerSessionInstanceID"/>" />
                <input type="hidden" name="authenticationType" id="authenticationType" value="<%= UserContext.getAuthenticationType()%>" />
            </form>
        </div>

        <!-- Render the foot divider -->
        <div class="tertiaryColorBackground" id="footDivider">&nbsp;</div>

        <!-- Render the footer -->
        <div class="primaryColor" id="footer">
            <div style="float:left;padding-left: 0.7em;">Help Desk: <a class="primaryColor" href="tel:5555555555">555.555.5555</a></div>
            <div style="float:right;padding-right: 0.7em;"><%= request.getAttribute("com.kd.themes.companyName") %> &copy; <%= CurrentDate.getYear() %></div>
            <div class="clear"/>
        </div>
    </body>
</html>