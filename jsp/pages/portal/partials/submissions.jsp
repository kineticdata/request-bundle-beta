<%--
    Configure the theme.  This sets multiple theme attributes on the request.
    For more information, see the themeInitialization.jsp file.
--%>
<jsp:include page="../../../includes/themeInitialization.jsp"/>
<%--
    Include the theme configuration file.  This
--%>
<%@include file="../../../includes/themeLoader.jspf"%>
<%--
    Initialize the reference to the ThemeConfig (HashMap) bean.  This bean is
    initialized in the THEME_ROOT/config/config.jsp file and further attributes
    are added by the THEME_ROOT/jsp/includes/themeInitialization.jsp file.
--%>
<jsp:useBean id="ThemeConfig" scope="request" class="java.util.LinkedHashMap"/>
<%
    HelperContext context = (HelperContext)ThemeConfig.get("context");
%>
<%--
    Include the ?
--%>
<%@include file="../configuration/submissionGroups.jspf"%>
<%
    String groupName = request.getParameter("group");
    String subgroupName = request.getParameter("subgroup");

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

    SubmissionList submissionList = SubmissionGroupManager.getSubmissionList(groupName, subgroupName);
//    Submission[] submissions = submissionList.getSubmissions(context);
    Submission[] submissions = submissionList.getSubmissions(context, sortFields, pageSizeInteger, startIndexInteger, sortOrder);
%>
<%!
    private String formatSubmissions(Submission[] submissions) {
        java.lang.StringBuilder builder = new java.lang.StringBuilder();
        for(Submission submission : submissions) {
            String status = submission.getValiationStatus();
            if (status == null || status.length() == 0) {
                if ("Completed".equals(submission.getStatus())) {
                    status = "Processing";
                } else {
                    status = submission.getStatus();
                }
            }

            if (submission != submissions[0]) {
                builder.append(",");
                builder.append("\n");
            }
            builder.append("    {");
            builder.append("\"date\": \"").append(submission.getCreateDate()).append("\",");
            builder.append("\"name\": \"").append(submission.getTemplateName()).append("\",");
            builder.append("\"status\": \"").append(status).append("\",");
            builder.append("\"requestId\": \"").append(submission.getRequestId()).append("\"");
            builder.append("}");
        }
        return builder.toString();
    }
%>{
  "recordsReturned": <%= submissions.length %>,
  "totalRecords": <%= submissionList.getCount(context) %>,
  "startIndex": <%= startIndex %>,
  "sort": "<%= sort %>",
  "order": "<%= order %>",
  "pageSize": <%= pageSize %>,
  "records": [
<%= formatSubmissions(submissions) %>
  ]
}