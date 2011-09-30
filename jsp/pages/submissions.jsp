<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="customerSurvey" scope="request" class="com.kd.kineticSurvey.beans.CustomerSurvey"/>
<jsp:useBean id="UserContext" scope="session" class="com.kd.kineticSurvey.beans.UserContext"/>

<%@include file="../includes/theme.jspf"%>
<%@include file="../includes/models.jspf"%>
<%-- The following file specifies a map of submission "types" to their qualification. --%>
<%@include file="submissions/submissionLists.jspf"%>
<%
    Base.setDefaultHelperContext(customerSurvey.getRemedyHandler().getDefaultHelperContext());
    String catalogName = customerSurvey.getCategory();
    HelperContext context = UserContext.getArContext();
    SubmissionList[] submissionLists = getSubmissionLists(context, catalogName);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title><%= catalogName %> Submissions</title>
        <!-- Dependency -->
        <script src="http://yui.yahooapis.com/2.9.0/build/yahoo/yahoo-min.js"></script>

        <!-- Used for Custom Events and event listener bindings -->
        <script src="http://yui.yahooapis.com/2.9.0/build/event/event-min.js"></script>

        <!-- Source file -->
        <!--
                If you require only basic HTTP transaction support, use the
                connection_core.js file.
        -->
        <script src="http://yui.yahooapis.com/2.9.0/build/connection/connection_core-min.js"></script>
        <style type="text/css">
            .submissionList {padding-left: 2em;}
        </style>
        <script type="text/javascript">
            function replace(elementId, path, arguments) {
                var callback = {
                    success: buildHandleReplaceSuccess(elementId),
                    failure: buildHandleReplaceFailure(elementId),
                    arguments: arguments
                };

                path = '<%=request.getAttribute("com.kd.themes.root")%>/'+path;

                var request = YAHOO.util.Connect.asyncRequest('GET', path, callback);
            }
            function replaceIfEmpty(elementId, path, arguments) {
                var element = document.getElementById(elementId);
                if (element.children.length == 0) {
                    replace(elementId, path, arguments);
                }
            }
            function buildHandleReplaceSuccess(elementId) {
                return function(response) {
                    var element = document.getElementById(elementId);
                    element.innerHTML = response.responseText;
                }
            }
            function buildHandleReplaceFailure(elementId) {
                return function(response) {
                    alert('Unable to replace the contents of '+elementId+
                        ': ('+response.status+') '+response.statusText);
                }
            }
        </script>
    </head>
    <body>
        <h3>Submissions</h3>
        <div>
            <%-- For each of the submission lists defined in
                 submissions/submissionLists.jspf --%>
            <% for (SubmissionList submissionList : submissionLists) { %>
                <%-- Render the submission list name and count. --%>
                <div>
                    <a href="javascript:void(0)" onclick="replaceIfEmpty('<%= submissionList.getNameDigest() %>', 'jsp/pages/submissions/callbacks/submissionList.jsp?catalogName=<%=catalogName%>&nameDigest=<%=submissionList.getNameDigest()%>')">
                        <%= submissionList.getName() %> (<%= submissionList.getCount(context) %>)
                    </a>
                </div>

                <%-- Render a list of submission ids that link to the request. --%>
                <div class="submissionList" id="<%= submissionList.getNameDigest() %>">
                    <%-- If this is the first list of submissions --%>
                    <% if (submissionLists[0] == submissionList) { %>
                        <% for (Submission submission : submissionList.getSubmissions(context)) { %>
                        <div>
                            <a href="<%= submission.getDisplayUrl() %>"><%= submission.getRequestId() %></a>
                        </div>
                        <% } %>
                    <% } %>
                </div>
            <% } %>
        </div>
    </body>
</html>