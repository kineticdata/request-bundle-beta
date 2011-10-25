<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%--
    TODO: Document
--%>
<%@include file="../includes/themeInitialization.jspf"%>

<%-- Set the HTML DOCTYPE. --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%-- Define the page HTML. --%>
<html>
    <head>
        <%-- Document the HTTP Content-Type header value within the HTML. --%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%-- Specify that modern IE versions should render the page with their 
             own rendering engine (as opposed to falling back to compatibility
             mode. --%>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <%-- Set the title of the page. --%>
        <title><%= ThemeConfig.get("companyName")+" "+ThemeConfig.get("portalName") %> Login</title>

        <!-- Set the favicon for the page. -->
        <link rel="shortcut icon" href="<%=ThemeConfig.get("root")%>/images/logo-favicon.png" type="image/x-icon">

        <%--
            Include the application defaults header. This includes initializes
            the customerSurvey and UserContext beans, includes the javascript
            files that are required for Kinetic SR to function, and includes the
            content of any javascript and CSS files that have been attached to
            the service item from within the Service Catalog Console.

            Additionally, this file initializes the KD.utils.ClientManager
            object which initializes multiple Kinetic SR internals as well as
            executing the following:
              * If there is a success or error message associated with the
                current session, the client manager will look for an element
                with an id of 'message'.  If one exists, the innerHTML will be
                set to the message and the element will be made visible.
              * Remove the parent element of any form with an id of 'loginForm'
                from the DOM.
              * Replace the string "--loginName--" with the current user's name
                within the innerHTML of the element 'authenticatedName'.
              * Set the value of the input elements with ids 'originatingPage',
                'authenticationType', and 'loginSessionID' to their associated
                values.
        --%>

        <link rel="stylesheet" type="text/css" href="/ksr/resources/js/yui/build/calendar/assets/calendar.css">
        <link rel="stylesheet" type="text/css" href="/ksr/resources/js/yui/build/container/assets/container.css">
        <link rel="stylesheet" type="text/css" href="/ksr/resources/js/yui/build/container/assets/skins/sam/container.css">


        <script type="text/javascript" src="/ksr/resources/js/yui/build/utilities/utilities.js"></script>
        <script type="text/javascript" src="/ksr/resources/js/yui/build/container/container-min.js"></script>
        <script type="text/javascript" src="/ksr/resources/js/yui/build/button/button-min.js"></script>
        <script type="text/javascript" src="/ksr/resources/js/yui/build/event-simulate/event-simulate-min.js"></script>
        <script type="text/javascript" src="/ksr/resources/js/yui/build/datasource/datasource-min.js"></script>
        <script type="text/javascript" src="/ksr/resources/js/yui/build/datatable/datatable-min.js"></script>
        <script type="text/javascript" src="/ksr/resources/js/yui/build/paginator/paginator-min.js"></script>
        <script type="text/javascript" src="/ksr/resources/js/yui/build/json/json-min.js"></script>
        <script type="text/javascript" src="/ksr/resources/js/yui/build/calendar/calendar-min.js"></script>


        <jsp:include page="../includes/application/headerContent.jsp"/>


        
<!--        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/base/base-min.css">
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/reset/reset-min.css">-->
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/fonts/fonts-min.css">


        <!-- Core + Skin CSS -->
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/button/assets/skins/sam/button.css">

        <link rel="stylesheet" type="text/css" href="<%=ThemeConfig.get("root") + "/css/theme.css"%>" >
        <link rel="stylesheet" type="text/css" href="<%=ThemeConfig.get("root") + "/css/pages/login.css"%>" >
        <link rel="stylesheet" type="text/css" href="<%=ThemeConfig.get("root") + "/config/config.css"%>" >


        <!-- Dependencies -->
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/yahoo-dom-event/yahoo-dom-event.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/element/element-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/button/button-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/selector/selector-min.js"></script>

<!--        <script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/kd_complete.js"%>"></script>-->

        <!-- Include the Theme javascript file. -->
        <script src="<%=ThemeConfig.get("root")%>/js/theme.js" type="text/javascript"></script>
        <!-- Configure the Theme javascript. -->
        <script type="text/javascript">
            // Configure the rootPath of the THEME's configuration.  This value
            // is used to reference callbacks for methods such as THEME.replace.
            THEME.config.rootPath = '<%=ThemeConfig.get("root")%>';
        </script>

        <!-- Include the javascript for the page. -->
        <script src="<%=ThemeConfig.get("root")%>/js/pages/login.js" type="text/javascript"></script>
    </head>
    <body class="fadedBackground yui-skin-sam">
        <!-- Render the colored line at the top of the page -->
        <div class="topline primaryColorBackground"></div>

        <%-- Render the site logo, company name, and portal name. --%>
        <%@include file="../shared/siteReference.jspf" %>

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
                    <input class="formField" name="Authentication" type="text" id="Authentication">
                </div>

                <!-- Options -->
                <div id="loginFormFooter">
                    <!-- Log In Button (manipulated on DOMReady; see header) -->
                    <input id="logInButton" name="logInButton" type="submit" value="Log In">

                    <!-- Forgot Password -->
                    <a class="primaryColor" href="#" id="forgotPasswordLink">Forgot Password</a>

                    <!-- Logging In Spinner -->
                    <div class="hidden" id="loader">Authenticating... <img alt="Loading Indicator" src="resources/loading.gif"></div>
                </div>

                <!-- Specify the required hidden elements.  The value of these are set by kd_client.js on page load. -->
                <input type="hidden" name="originatingPage" id="originatingPage">
                <input type="hidden" name="sessionID" id="loginSessionID">
                <input type="hidden" name="authenticationType" id="authenticationType">

                <!-- Clear the floats -->
                <div class="clear"></div>
            </form>
        </div>

        <!-- Render the foot divider -->
        <div class="tertiaryColorBackground" id="footDivider">&nbsp;</div>

        <!-- Render the footer -->
        <div class="primaryColor" id="footer">
            <div id="helpDesk">Help Desk: <a class="primaryColor" href="tel:5555555555">555.555.5555</a></div>
            <div id="copyright"><%= ThemeConfig.get("companyName") %> &copy; <%= DateHelper.getCurrentYear() %></div>
            <!-- Clear the floats -->
            <div class="clear"></div>
        </div>

        <!-- Render the template contents and request information. -->
        <div id="request">
            <jsp:include page="../includes/application/templateContent.jsp"/>
        </div>
    </body>
</html>