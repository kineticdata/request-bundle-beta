<%--
    TODO: Document
--%>
<%@include file="../includes/themeInitialization.jspf"%>

<%-- The following file specifies a map of submission "types" to their qualification. --%>
<%@include file="../configuration/listConfiguration.jspf"%>
<%
    if (HelperContext == null) {
        UnauthorizedHelper.sendUnauthorizedResponse(response);
    } else {
        String catalogName = request.getParameter("catalogName");
        String nameDigest = request.getParameter("nameDigest");
        SubmissionList submissionList = getSubmissionListByNameDigest(context, catalogName, nameDigest);
%>
<div>
    <% for (Submission submission : submissionList.getSubmissions(context)) { %>
    <div>
        <%= submission.getTemplateName() %>: <a href="<%= submission.getDisplayUrl() %>"><%= submission.getRequestId() %></a>
    </div>
    <% } %>
</div>
<% } %>