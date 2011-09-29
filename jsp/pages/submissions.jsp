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
            <% for (SubmissionList submissionList : submissionLists) { %>
            <div><%= submissionList.getName() %>  (<%= submissionList.getCount(context) %>)</div>
            <% if (submissionLists[0] == submissionList) { %>
            <div style="padding-left: 2em;">
                <% for (Submission submission : submissionList.getSubmissions(context)) { %>
                <div><%= submission.getRequestId() %></div>
                <% } %>
            </div>
            <% } %>
            <% } %>
        </div>
    </body>
</html>