<%--
    Configure the theme.  This sets multiple theme attributes on the request.
    For more information, see the themeInitialization.jsp file.
--%>
<jsp:include page="../includes/themeInitialization.jsp"/>
<%--
    Include the theme configuration file.  This
--%>
<%@include file="../includes/themeLoader.jspf"%>

<%--
    Initialize the reference to the ThemeConfig (HashMap) bean.  This bean is
    initialized in the THEME_ROOT/config/config.jsp file and further attributes
    are added by the THEME_ROOT/jsp/includes/themeInitialization.jsp file.
--%>
<jsp:useBean id="ThemeConfig" scope="request" class="java.util.LinkedHashMap"/>

<%-- Retrieve the Catalog --%>
<%
    HelperContext context = (HelperContext) ThemeConfig.get("context");
    String catalogName = (String) ThemeConfig.get("catalogName");
    Catalog catalog = Catalog.findByName(context, catalogName);
%>
<%@include file="portal/configuration/submissionGroups.jspf"%>
<% String[] submissionGroups = SubmissionGroupManager.getGroups();%>

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
        <title><%= ThemeConfig.get("companyName") + " " + ThemeConfig.get("portalName")%></title>

        <!-- Set the favicon for the page. -->
        <link rel="shortcut icon" href="<%=ThemeConfig.get("root")%>/images/logo-favicon.png" type="image/x-icon">

        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/fonts/fonts-min.css">
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/tabview/assets/skins/sam/tabview.css">


        <link rel="stylesheet" href="<%= ThemeConfig.get("root")%>/css/theme.css" type="text/css">
        <link rel="stylesheet" href="<%= ThemeConfig.get("root")%>/css/pages/portal.css" type="text/css">
        <link rel="stylesheet" type="text/css" href="<%=ThemeConfig.get("root") + "/config/config.css"%>" >

        <link rel="stylesheet" type="text/css" href="<%=ThemeConfig.get("root") + "/js/pages/portal.js"%>">

        <script src="http://yui.yahooapis.com/2.9.0/build/yahoo/yahoo-min.js"></script>
        <script src="http://yui.yahooapis.com/2.9.0/build/dom/dom-min.js"></script>
        <script src="http://yui.yahooapis.com/2.9.0/build/event/event-min.js" ></script>
        <script src="http://yui.yahooapis.com/2.9.0/build/element/element-min.js"></script>
        <script src="http://yui.yahooapis.com/2.9.0/build/tabview/tabview-min.js"></script>
        <script src="http://yui.yahooapis.com/2.9.0/build/selector/selector-min.js"></script>

        <!-- Include the Theme javascript file. -->
        <script src="<%=ThemeConfig.get("root")%>/js/theme.js" type="text/javascript"></script>
        <!-- Configure the Theme javascript. -->
        <script type="text/javascript">
            // Configure the rootPath of the THEME's configuration.  This value
            // is used to reference callbacks for methods such as THEME.replace.
            THEME.config.rootPath = '<%=ThemeConfig.get("root")%>';
        </script>

        <!-- Include the javascript for the page. -->
        <script src="<%=ThemeConfig.get("root")%>/js/pages/portal.js" type="text/javascript"></script>
    </head>
    <body class="yui-skin-sam">
        <div id="portalHeader">
            <div id="mainNavigation">
                <div id="portalTab" class="navigationItem navigationItemActive">
                    <a href="javascript:void(0)"><%= ThemeConfig.get("portalName")%></a>
                </div>
                <% for (String submissionGroup : submissionGroups) {%>
                <div class="divider"></div>
                <div class="navigationItem">
                    <a href="javascript:void(0)"><%= submissionGroup%></a>
                </div>
                <% }%>
            </div>
            <div id="accountNavigation">
                <div class="navigationItem">
                    <a href="#">Settings</a>
                </div>
                <div class="divider"></div>
                <div class="navigationItem">
                    Logged in as Some User
                </div>
                <div class="divider"></div>
                <div class="navigationItem">
                    <a href="KSAuthenticationServlet?Logout=true">Logout</a>
                </div>
            </div>
        </div>

        <div class="" id="portalRightColumn">
            <div class="portalSection auxiliaryColorBackground tertiaryColorBorder">
                <!-- Render the logo and site name -->
                <div id="siteReference">
                    <div id="siteLogo" class="logo"></div>
                    <h1 id="siteName" class="primaryColor"><%= ThemeConfig.get("companyName")%><br><%= ThemeConfig.get("portalName")%></h1>
                    <div class="clear"></div>
                </div>

                <div><%= catalog.getDescription()%></div>
            </div>

            <div id="quickLinks" class="contentSection auxiliaryTitleColor">
                <hr>
                <h2>Quick Links</h2>
                <div>
                    <ul>
                        <li>
                            <div class="name">Kinetic Data Homepage</div>
                            <div class="link"><a href="http://www.kineticdata.com" class="primaryColor">http://www.kineticdata.com</a></div>
                        </li>
                        <li>
                            <div class="name">Kinetic Community Homepage</div>
                            <div class="link""><a href="http://community.kineticdata.com" class="primaryColor">http://community.kineticdata.com</a></div>
                        </li>
                    </ul>
                </div>
            </div>

            <div id="recentSubmissions" class="contentSection auxiliaryTitleColor">
                <hr>
                <h2>Recent Submissions</h2>
                <div>
                    <ul>
                        <li>
                            <div class="name">Submission 1:</div>
                            <div class="link"><a href="#" class="primaryColor">KSR000000000000</a></div>
                        </li>
                        <li>
                            <div class="name">Submission 2 With A Long Template Name:</div>
                            <div class="link"><a href="#" class="primaryColor">KSR000000000000</a></div>
                        </li>
                        <li>
                            <div class="name">Submission 3:</div>
                            <div class="link"><a href="#" class="primaryColor">KSR000000000000</a></div>
                        </li>
                        <li>
                            <div class="name">Submission 4 With A Really Long Template:</div>
                            <div class="link"><a href="#" class="primaryColor">KSR000000000000</a></div>
                        </li>
                        <li>
                            <div class="name">Submission 5:</div>
                            <div class="link"><a href="#" class="primaryColor">KSR000000000000</a></div>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="clear"></div>
        </div>

        <div id="portalBody">
            <div id="portalTabContent" class="content">
                <%@include file="portal/catalog.jspf"%>
            </div>
            <%
                for (int i = 0; i < submissionGroups.length; i++) {
                    SubmissionList[] subgroups = SubmissionGroupManager.getSubmissionLists(submissionGroups[i]);
            %>
            <div class="content hidden">
                <%@include file="portal/tableHeader.jspf"%>
                <h1><%= submissionGroups[i]%></h1>
                <div class="yui-navset" id="submissionGroupTab<%=i%>Content">
                    <ul class="yui-nav">
                        <% for (SubmissionList list : subgroups) {%>
                        <% if (subgroups[0] == list) {%>
                        <li class="selected"><a href="javascript:void(0)"><em><%= list.getName()%> (<%= list.getCount(context)%>)</em></a></li>
                        <% } else {%>
                        <li><a href="javascript:void(0)"><em><%= list.getName()%> (<%= list.getCount(context)%>)</em></a></li>
                        <% }%>
                        <% }%>
                    </ul>
                    <div class="yui-content">
                        <% for (SubmissionList list : subgroups) {%>
                        <div><%= list.getNameDigest()%></div>
                        <% }%>
                    </div>
                </div>
                <script type="text/javascript">new YAHOO.widget.TabView("submissionGroupTab<%= i%>Content");</script>
                <%@include file="portal/tableFooter.jspf"%>
            </div>
            <% }%>
        </div>
        <div id="portalFooter">

        </div>
    </body>
</html>