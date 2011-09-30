<jsp:useBean id="UserContext" scope="session" class="com.kd.kineticSurvey.beans.UserContext"/>
<%@include file="../../../includes/theme.jspf"%>
<%@include file="../../../includes/models.jspf"%>
<%-- The following file specifies a map of submission "types" to their qualification. --%>
<%@include file="../submissionLists.jspf"%>
<%
    if (UserContext == null) {
        response.setStatus(response.SC_UNAUTHORIZED);
%>
Please log in.
<%
    } else {
        HelperContext context = UserContext.getArContext();
        String catalogName = request.getParameter("catalogName");
        String nameDigest = request.getParameter("nameDigest");
        SubmissionList submissionList = getSubmissionListByNameDigest(context, catalogName, nameDigest);
%>
<div>
    <% for (Submission submission : submissionList.getSubmissions(context)) { %>
    <div>
        <a href="<%= submission.getDisplayUrl() %>"><%= submission.getRequestId() %></a>
    </div>
    <% } %>
</div>
<% } %>