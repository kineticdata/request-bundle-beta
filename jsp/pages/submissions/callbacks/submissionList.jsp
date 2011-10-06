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

<%-- The following file specifies a map of submission "types" to their qualification. --%>
<%@include file="../configuration/listConfiguration.jspf"%>
<%
    if (ThemeConfig.get("context") == null) {
        response.setStatus(response.SC_UNAUTHORIZED);
        response.getWriter().write("Please log in.");
    } else {
        HelperContext context = (HelperContext)ThemeConfig.get("context");
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