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
        <!-- Dependencies -->
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/yahoo-dom-event/yahoo-dom-event.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/element/element-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/button/button-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/selector/selector-min.js"></script>

        <!-- Source file -->
        <!--
                If you require only basic HTTP transaction support, use the
                connection_core.js file.
        -->
        <script src="http://yui.yahooapis.com/2.9.0/build/connection/connection_core-min.js"></script>
        <style type="text/css">
            .submissionList {padding-left: 2em;}
        </style>

        <script src="<%=request.getAttribute("com.kd.themes.root")%>/js/theme.js" type="text/javascript"></script>
        <script type="text/javascript">
            THEME.config.rootPath = '<%=request.getAttribute("com.kd.themes.root")%>';
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
                    <a href="javascript:void(0)" onclick="THEME.replace('<%= submissionList.getNameDigest() %>a', 'jsp/pages/submissions/callbacks/submissionList.jsp?catalogName=<%=catalogName%>&nameDigest=<%=submissionList.getNameDigest()%>')">
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