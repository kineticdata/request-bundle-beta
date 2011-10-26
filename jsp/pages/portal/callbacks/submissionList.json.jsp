<%--
    TODO: Description
--%>

<%-- TODO: Document --%>
<%@page contentType="application/json; charset=UTF-8"%>
<%-- TODO: Document --%>
<%@include file="../../../includes/themeInitialization.jspf"%>

<%
    // If there is not a HelperContext that is attached to the session, send an
    // unauthorized response.
    if (context == null) {
        UnauthorizedHelper.sendUnauthorizedResponse(response);
    }
    // If there is a HelperContext that is attached to the session,
    else {
        ThemeConfig.put("catalogName", request.getParameter("catalog"));
%>
    <%--
        Include the ?
    --%>
    <%@include file="../configuration/submissionLists.jspf"%>
    <%
        String groupName = request.getParameter("group");
        String listName = request.getParameter("list");

        String pageSize = request.getParameter("pageSize");
        if (pageSize == null) {pageSize = "10";}
        String startIndex = request.getParameter("startIndex");
        if (startIndex == null) {startIndex = "0";}
        String sort = request.getParameter("sort");
        if (sort == null) {sort = "requestId";}
        String order = request.getParameter("order");
        if (order == null) {order = "desc";}

        Integer sortOrder = 1;
        if ("desc".equals(order)) {
            sortOrder = 2;
        }

        String[] sortFields = new String[0];
        if ("date".equals(sort)) {
            sortFields = new String[] {Submission.FIELD_CREATE_DATE};
        } else if ("name".equals(sort)) {
            sortFields = new String[] {Submission.FIELD_TEMPLATE_NAME};
        } else if ("status".equals(sort)) {
            sortFields = new String[] {Submission.FIELD_STATUS};
        } else if ("requestId".equals(sort)) {
            sortFields = new String[] {Submission.FIELD_REQUEST_ID};
        }

        Integer pageSizeInteger = Integer.valueOf(pageSize);
        Integer startIndexInteger = Integer.valueOf(startIndex);

        SubmissionList submissionList = submissionManager.getSubmissionList(groupName, listName);
        System.out.println(groupName+" "+listName);
        System.out.println(submissionList);

        Submission[] submissions = submissionList.getSubmissions(context, sortFields, pageSizeInteger, startIndexInteger, sortOrder);
    %>
{
  "recordsReturned": <%= submissions.length %>,
  "totalRecords": <%= submissionList.getCount(context) %>,
  "startIndex": <%= startIndex %>,
  "sort": "<%= sort %>",
  "order": "<%= order %>",
  "pageSize": <%= pageSize %>,
  "records": [<%= SubmissionList.formatSubmissionsJson(submissions)%>]
}
<% } %>