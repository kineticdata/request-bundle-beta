<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%--
    TODO: Document
--%>
<%@include file="../includes/themeInitialization.jspf"%>

<%-- Retrieve the Catalog --%>
<%
    String catalogName = (String)ThemeConfig.get("catalogName");
    Catalog catalog = Catalog.findByName(context, catalogName);
    catalog.preload(context);
%>
<%@include file="portal/configuration/submissionLists.jspf"%>

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
        <script type="text/javascript" src="<%= ThemeConfig.get("root") %>/../../resources/js/yui/build/utilities/utilities.js"></script>
        <script type="text/javascript" src="<%= ThemeConfig.get("root") %>/../../resources/js/yui/build/container/container-min.js"></script>
        <script type="text/javascript" src="<%= ThemeConfig.get("root") %>/../../resources/js/yui/build/button/button-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/event/event.js" ></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/element/element.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/tabview/tabview-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/selector/selector-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/connection/connection-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/paginator/paginator.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/datasource/datasource.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/datatable/datatable.js"></script>
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
                <% for (SubmissionGroup group : submissionManager.getSubmissionGroups()) {%>
                <% if (group.getTotalSubmissionCount(context) > 0) { %>
                <div class="divider"></div>
                <div class="navigationItem submissionGroupNavigationItem" data-group="<%= group.getName() %>">
                    <a href="javascript:void(0)"><%= group.getName() %></a>
                </div>
                <% }%>
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

        <div id="portalRightColumn">
            <div id="portalRightColumnDefaultContent">
                <div>
                    <!-- Display the portal information section. -->
                    <div class="portalSection">
                        <%-- Render the site logo, company name, and portal name. --%>
                        <%@include file="../shared/siteReference.jspf" %>
                        <div class="catalogDescription"><%= catalog.getDescription()%></div>
                    </div>

                    <%-- Include the quick links section. --%>
                    <%@include file="portal/quickLinks.jspf" %>

                    <%-- Include the recent submissions section. --%>
                    <%@include file="portal/recentSubmissions.jspf" %>

                    <div class="clear"></div>
                </div>
            </div>

            <div class="hidden" id="portalRightColumnDynamicContent" >
                <%@include file="../shared/shadowBoxBegin.jspf"%>
                <div id="portalRightColumnDynamicContentResultsDisplay"></div>
                <%@include file="../shared/shadowBoxEnd.jspf"%>
            </div>
        </div>

        <%-- Define the portal main content. --%>
        <div id="portalBody">
            <%-- Home Screen --%>
            <div id="portalHomeContent" class="content">
                <%@include file="portal/home.jspf"%>
            </div>
            <%-- Catalog Screen --%>
            <div id="portalCatalogContent" class="content hidden">
                <%@include file="portal/catalog.jspf"%>
            </div>

            <%--
                Build and display the Submission Group screens.  A Submission
                Group screen corresponds to a grouping of submissions (such as
                "Requests", "Approvals", or "Work Orders").  Each Submission
                Group has one or more Submission Lists (such as "Parked",
                "Active", and "Closed" for a Requests group).  Submission Groups
                and their Lists are defined in the
                jsp/pages/portal/configuration/submissionLists.jspf file.
            --%>
            <% for (SubmissionGroup group : submissionManager.getSubmissionGroups()) { %>
            <% if (group.getTotalSubmissionCount(context) > 0) { %>
            <div class="submissionGroup content hidden" data-group="<%= group.getName() %>">
                <%-- Render the Submission Group Navigation/Search box --%>
                <%@include file="../shared/shadowBoxBegin.jspf"%>
                <div class="submissionGroupNavigationBox">
                    <div class="searchBoxContainer">
                        <div class="searchButton">
                            <img src="<%= ThemeConfig.get("root") %>/images/search16x16-FFFFFF.png" alt="Search">
                        </div>
                        <input id="submissionSearchBox" type="text" name="searchBox" />
                        <div class="clear"></div>
                    </div>

                    <% CycleHelper activeCycle = new CycleHelper("active", CycleHelper.ONLY_FIRST_CYCLE); %>
                    <% for (SubmissionList list : group.getSubmissionLists()) { %>
                    <div class="submissionListNavigation navigationButton noSelect <%=activeCycle.cycle()%>">
                        <%= list.getName() %> (<%= list.getCount(context) %>)
                    </div>
                    <% } %>

                    <div class="clear"></div>
                </div>
                <%@include file="../shared/shadowBoxEnd.jspf"%>

                <%-- Render the Submission Group content box --%>
                <%@include file="../shared/shadowBoxBegin.jspf"%>
                <div class="submissionGroupContentBox">
                    <% CycleHelper hiddenCycle = new CycleHelper("hidden", CycleHelper.SKIP_FIRST_CYCLE); %>
                    <% for (SubmissionList list : group.getSubmissionLists()) { %>
                    <div class="submissionList <%=hiddenCycle.cycle()%>" data-group="<%= group.getName()%>" data-list="<%= list.getName() %>">
                        <div class="title"><%= list.getName() %>&nbsp;<%= group.getName() %></div>
                        <div class="listControls">
                            <div class="" style="float:left;width:45%;margin-bottom:10px;">
                                <div class="controlButton noSelect" title="First" style="float:left;margin-right:2px;" onclick="PAGE.goToSubmissionListFirstPage('<%=group.getName()%>', '<%=list.getName()%>')">
                                    <img src="<%= ThemeConfig.get("root") %>/images/control_first_FFFFFF.png" alt="Refresh">
                                </div>
                                <div class="controlButton noSelect" title="Previous" style="float:left;" onclick="PAGE.goToSubmissionListPreviousPage('<%=group.getName()%>', '<%=list.getName()%>')">
                                    <img src="<%= ThemeConfig.get("root") %>/images/control_previous_FFFFFF.png" alt="Refresh">
                                </div>
                                <div class="auxiliaryTitleColor" style="float:left;margin: 0 0.5em;line-height: 26px;">
                                    <div class="pageReport">Loading...</div>
                                </div>
                                <div class="controlButton noSelect" title="Next" style="float:left;margin-right:2px;" onclick="PAGE.goToSubmissionListNextPage('<%=group.getName()%>', '<%=list.getName()%>')">
                                    <img src="<%= ThemeConfig.get("root") %>/images/control_next_FFFFFF.png" alt="Refresh">
                                </div>
                                <div class="controlButton noSelect" title="Last" style="float:left;" onclick="PAGE.goToSubmissionListLastPage('<%=group.getName()%>', '<%=list.getName()%>')">
                                    <img src="<%= ThemeConfig.get("root") %>/images/control_last_FFFFFF.png" alt="Refresh">
                                </div>
                                <div class="clear"></div>
                            </div>

                            <div style="float:left;text-align:center;width:10%;margin-bottom:10px;">
                                <img class="processingSpinner" src="<%= ThemeConfig.get("root") %>/images/spinner_00427E_FFFFFF.gif">
                            </div>

                            <div class="" style="float:left;width:45%;margin-bottom:10px;">
                                <div class="controlButton noSelect" title="Refresh" style="float:right;margin-left: 15px;" onclick="PAGE.refreshSubmissionList('<%=group.getName()%>', '<%=list.getName()%>')">
                                    <img src="<%= ThemeConfig.get("root") %>/images/refresh16x16_FFFFFF.png" alt="Refresh">
                                </div>
                                <div style="float:right; padding-left: 1em;">
                                    <div class="auxiliaryTitleColor" style="float:left;line-height:26px;margin-right: 0.5em;">
                                        Go to Page
                                    </div>
                                    <div style="float:left;margin-right: 0.5em;">
                                        <input class="pageNumberInput" type="text" style="width: 2.5em;-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;height: 26px;" onclick="this.select();">
                                    </div>
                                    <div class="controlButton noSelect" title="Go to Page" style="float:left;font-size: 16px;font-weight:bold;color:white;" onclick="PAGE.goToSubmissionListPageNumber('<%=group.getName()%>', '<%=list.getName()%>')">
                                        <img src="<%= ThemeConfig.get("root") %>/images/control_go_FFFFFF.png" alt="Refresh">
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="clear"></div>
                            </div>

                            <div class="clear"></div>
                        </div>

                        <div class="dataTable"></div>
                    </div>
                    <% } %>
                </div>
                <%@include file="../shared/shadowBoxEnd.jspf"%>
            </div>
            <% } %>
            <% } %>
        </div>
    </body>
</html>