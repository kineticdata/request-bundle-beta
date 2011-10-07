<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="customerSurvey" scope="request" class="com.kd.kineticSurvey.beans.CustomerSurvey"/>
<jsp:useBean id="UserContext" scope="session" class="com.kd.kineticSurvey.beans.UserContext"/>
<%@include file="../includes/models.jspf"%>
<%@include file="../includes/theme.jspf"%>
<%
    HelperContext context = UserContext.getArContext();
    Catalog catalog = Catalog.findByName(context, customerSurvey.getCategory());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title><%= catalog.getName()%> Portal</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <link rel="stylesheet" href="<%= request.getAttribute("com.kd.themes.root")%>/css/theme.css" type="text/css">
        <link rel="stylesheet" href="<%= request.getAttribute("com.kd.themes.root")%>/css/pages/portal.css" type="text/css">
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
        <div id="portalHeader">
            <div id="mainNavigation">
                <div id="catalogLink" class="navigationItem navigationItemActive">
                    <a href="javascript:void(0)"><%= catalog.getName()%></a>
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
        <div id="portalBody">
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
        <div id="portalFooter">
        </div>
    </body>
</html>