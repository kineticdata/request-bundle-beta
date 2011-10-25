<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%--
    TODO: Document
--%>
<%@include file="../includes/themeInitialization.jspf"%>

<%-- Retrieve the Catalog --%>
<%
    String catalogName = (String) ThemeConfig.get("catalogName");
    Catalog catalog = Catalog.findByName(context, catalogName);
    catalog.preload(context);
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
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/button/assets/skins/sam/button.css">
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/tabview/assets/skins/sam/tabview.css">
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/paginator/assets/skins/sam/paginator.css" >
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/datatable/assets/skins/sam/datatable.css" >


        <link rel="stylesheet" href="<%= ThemeConfig.get("root")%>/css/theme.css" type="text/css">
        <link rel="stylesheet" href="<%= ThemeConfig.get("root")%>/css/pages/portal.css" type="text/css">
        <link rel="stylesheet" type="text/css" href="<%=ThemeConfig.get("root") + "/config/config.css"%>" >

        <link rel="stylesheet" type="text/css" href="<%=ThemeConfig.get("root") + "/js/pages/portal.js"%>">

        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/yahoo/yahoo-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/dom/dom-min.js"></script>
        <script type="text/javascript" src="/ksr/resources/js/yui/build/utilities/utilities.js"></script>
        <script type="text/javascript" src="/ksr/resources/js/yui/build/container/container-min.js"></script>
        <script type="text/javascript" src="/ksr/resources/js/yui/build/button/button-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/event/event.js" ></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/element/element.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/tabview/tabview-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/selector/selector-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/connection/connection-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/paginator/paginator-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/datasource/datasource-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/datatable/datatable-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/json/json-min.js"></script> 

        <!-- Include the Theme javascript file. -->
        <script src="<%=ThemeConfig.get("root")%>/js/theme.js" type="text/javascript"></script>
        <!-- Configure the Theme javascript. -->
        <script type="text/javascript">
            // Configure the rootPath of the THEME's configuration.  This value
            // is used to reference callbacks for methods such as THEME.replace.
            THEME.config.rootPath = '<%=ThemeConfig.get("root")%>';
            THEME.config.catalogName = '<%=ThemeConfig.get("catalogName")%>';
        </script>

        <!-- Include the javascript for the page. -->
        <script src="<%=ThemeConfig.get("root")%>/js/pages/portal.js" type="text/javascript"></script>
        <script src="<%=ThemeConfig.get("root")%>/js/pages/portal-submissions.js" type="text/javascript"></script>
    </head>
    <body class="yui-skin-sam home fadedBackground2">
        <div id="portalHeader">
            <div id="mainNavigation">
                <div id="homeTab" class="navigationItem navigationItemActive" title="<%= ThemeConfig.get("portalName")%> Home">
                    <a href="javascript:void(0)"><img src="<%= ThemeConfig.get("root")%>/images/home.png" /></a>
                </div>
                <div class="divider"></div>
                <div id="portalTab" class="navigationItem">
                    <a href="javascript:void(0)">Catalog</a>
                </div>
                <% for (String submissionGroup : submissionGroups) {%>
                <div class="divider"></div>
                <div class="navigationItem">
                    <a href="javascript:void(0)"><%= submissionGroup%></a>
                </div>
                <% }%>
                <div class="divider"></div>
            </div>
            <div id="accountNavigation">
                <div class="divider"></div>
                <div class="inactive navigationItem" id="userInfo" style="position:relative;">
                    <jsp:include page="../shared/userInfo.jsp"/>
                </div>
                <div class="divider"></div>
                <div class="navigationItem" title="Logout">
                    <a href="KSAuthenticationServlet?Logout=true">
                        <img src="<%=ThemeConfig.get("root")%>/images/logout.png" alt="Logout">
                    </a>
                </div>
            </div>
        </div>

        <div class="" id="portalRightColumn">
            <div class="portalSection">
                <%-- Render the site logo, company name, and portal name. --%>
                <%@include file="../shared/siteReference.jspf" %>

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
                            <div class="link"><a href="http://community.kineticdata.com" class="primaryColor">http://community.kineticdata.com</a></div>
                        </li>
                    </ul>
                </div>
            </div>

            <%@include file="portal/recentSubmissions.jspf" %>

            <div class="clear"></div>
        </div>

        <%-- Define the portal main content. --%>
        <div id="portalBody">
            <%-- Home Screen --%>
            <div class="content">
                <%@include file="portal/home.jspf"%>
            </div>
            <%-- Catalog Screen --%>
            <div class="content hidden">
                <%@include file="portal/catalog.jspf"%>
            </div>
            <%
                for (int i = 0; i < submissionGroups.length; i++) {
                    SubmissionList[] subgroups = SubmissionGroupManager.getSubmissionLists(submissionGroups[i]);
            %>
            <div class="content hidden">
                <%@include file="../shared/shadowBoxBegin.jspf"%>
                <div>
                    <div class="searchBoxContainer">
                        <div class="searchButton">
                            <img src="<%= ThemeConfig.get("root") %>/images/search16x16-FFFFFF.png" alt="Search">
                        </div>
                        <input id="submissionSearchBox" type="text" name="searchBox" />
                        <div class="clear"></div>
                    </div>
                    <div id="catalogBreadcrumbs">
                        <span><a class="breadcrumbLink secondaryColor" data-id="rootCategories" href="javascript:void(0)">Catalog Home</a></span>
                    </div>
                    <div class="clear"></div>
                </div>
                <%@include file="../shared/shadowBoxEnd.jspf"%>

                <%@include file="../shared/shadowBoxBegin.jspf"%>
                <div class="primaryColor title"><%= submissionGroups[i]%></div>
                <%@include file="portal/pageFragments/submissionGroup.jspf"%>
                <%@include file="../shared/shadowBoxEnd.jspf"%>
            </div>
            <% }%>
        </div>
        <div id="portalFooter">

        </div>
    </body>
</html>