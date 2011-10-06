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
    HelperContext context = (HelperContext)ThemeConfig.get("context");
    String catalogName = (String)ThemeConfig.get("catalogName");
    Catalog catalog = Catalog.findByName(context, catalogName);
%>

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
        <title><%= ThemeConfig.get("companyName")+" "+ThemeConfig.get("portalName") %></title>

        <link rel="stylesheet" href="<%= ThemeConfig.get("root")%>/css/theme.css" type="text/css">

        <script src="http://yui.yahooapis.com/2.9.0/build/yahoo/yahoo-min.js"></script>
        <script src="http://yui.yahooapis.com/2.9.0/build/dom/dom-min.js"></script>
        <script src="http://yui.yahooapis.com/2.9.0/build/event/event-min.js" ></script>
        <script type="text/javascript">
            YAHOO.util.Event.onDOMReady(function (){
                var oElement = document.getElementById("catalogLink");
                function catalogClick(e) {
                    YAHOO.util.Dom.setStyle(["submissionContent", "approvalContent", "taskContent"], "display", "none");
                    YAHOO.util.Dom.removeClass(["submissionLink", "approvalLink", "taskLink"], "navigationItemActive");
                    YAHOO.util.Dom.setStyle("catalogContent", "display", "");
                    YAHOO.util.Dom.addClass("catalogLink", "navigationItemActive");
                }
                YAHOO.util.Event.addListener(oElement, "click", catalogClick);

                var oElement = document.getElementById("submissionLink");
                function submissionClick(e) {
                    YAHOO.util.Dom.setStyle(["catalogContent", "approvalContent", "taskContent"], "display", "none");
                    YAHOO.util.Dom.removeClass(["catalogLink", "approvalLink", "taskLink"], "navigationItemActive");
                    YAHOO.util.Dom.setStyle("submissionContent", "display", "");
                    YAHOO.util.Dom.addClass("submissionLink", "navigationItemActive");
                }
                YAHOO.util.Event.addListener(oElement, "click", submissionClick);

                var oElement = document.getElementById("approvalLink");
                function approvalClick(e) {
                    YAHOO.util.Dom.setStyle(["submissionContent", "catalogContent", "taskContent"], "display", "none");
                    YAHOO.util.Dom.removeClass(["submissionLink", "catalogLink", "taskLink"], "navigationItemActive");
                    YAHOO.util.Dom.setStyle("approvalContent", "display", "");
                    YAHOO.util.Dom.addClass("approvalLink", "navigationItemActive");
                }
                YAHOO.util.Event.addListener(oElement, "click", approvalClick);

                var oElement = document.getElementById("taskLink");
                function taskClick(e) {
                    YAHOO.util.Dom.setStyle(["submissionContent", "approvalContent", "catalogContent"], "display", "none");
                    YAHOO.util.Dom.removeClass(["submissionLink", "approvalLink", "catalogLink"], "navigationItemActive");
                    YAHOO.util.Dom.setStyle("taskContent", "display", "");
                    YAHOO.util.Dom.addClass("taskLink", "navigationItemActive");
                }
                YAHOO.util.Event.addListener(oElement, "click", taskClick);
            });
        </script>
    </head>
    <body>
        <div id="header">
            <div id="mainNavigation">
                <div id="catalogLink" class="navigationItem navigationItemActive">
                    <a href="javascript:void(0)"><%= ThemeConfig.get("portalName") %></a>
                </div>
                <div class="divider"></div>
                <div id="submissionLink" class="navigationItem">
                    <a href="javascript:void(0)">Submissions</a>
                </div>
                <div class="divider"></div>
                <div id="approvalLink" class="navigationItem">
                    <a href="javascript:void(0)">Approvals</a>
                </div>
                <div class="divider"></div>
                <div id="taskLink" class="navigationItem">
                    <a href="javascript:void(0)">Tasks</a>
                </div>
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
                    <a href="#">Logout</a>
                </div>
            </div>
        </div>
        <div id="body">
            <div id="catalogContent" style="display:none;">
                <%@include file="portal/catalog.jspf"%>
            </div>
            <div id="submissionContent">
                <%@include file="portal/submissions.jspf"%>
            </div>
            <div id="approvalContent" style="display:none;">
                <%@include file="portal/approvals.jspf"%>
            </div>
            <div id="taskContent" style="display:none;">
                <%@include file="portal/tasks.jspf"%>
            </div>
        </div>
        <div id="footer">
        </div>
    </body>
</html>