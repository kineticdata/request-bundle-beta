<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/models.jspf"%>
<%-- The following file specifies a map of submission "types" to their qualification. --%>
<%@include file="submissions/submissionLists.jspf"%>

<jsp:useBean id="customerSurvey" scope="request" class="com.kd.kineticSurvey.beans.CustomerSurvey"/>
<jsp:useBean id="UserContext" scope="session" class="com.kd.kineticSurvey.beans.UserContext"/>
<%
    HelperContext context = UserContext.getArContext();
    SubmissionList[] submissionLists = getSubmissionLists(context, customerSurvey.getCategory());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>JSP Page</title>
    </head>
    <body>
        <h3>Submissions</h3>
        <div>
            <%-- For each of the submission lists defined in
                 submissions/submissionLists.jspf --%>
            <% for (SubmissionList submissionList : submissionLists) { %>
                <%-- Render the submission list name and count. --%>
                <div><%= submissionList.getName() %>  (<%= submissionList.getCount(context) %>)</div>

                <%-- If this is the first list of submissions --%>
                <% if (submissionLists[0] == submissionList) { %>
                <%-- Render a list of submission ids that link to the request. --%>
                <div style="padding-left: 2em;">
                    <% for (Submission submission : submissionList.getSubmissions(context)) { %>
                    <div>
                        <a href="<%= submission.getDisplayUrl() %>"><%= submission.getRequestId() %></a>
                    </div>
                    <% } %>
                </div>
                <% } %>
            <% } %>
        </div>
    </body>
</html>