<!-- BEGIN {themeRoot}/jsp/pages/portal/partials/recentSubmissions.jsp -->

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
    String catalogName = (String)ThemeConfig.get("catalogName");
    Submission[] submissions = Submission.findRecentByCatalogName(context, catalogName, 5);
%>


<div id="recentSubmissions" class="contentSection auxiliaryTitleColor">
    <hr>
    <h2>Recent Submissions</h2>
    <div>
        <ul>
            <% for (Submission submission : submissions) { %>
            <li>
                <div class="name">
                    <% if (!ThemeHelper.isBlank(submission.getSubmitType())) { %>
                        (<%= submission.getSubmitType() %>)
                    <% } %>
                    <%= submission.getTemplateName() %>
                </div>
                <div class="link">
                    <a href="#" class="primaryColor"><%= submission.getRequestId() %></a>
                    <div class="auxiliaryColor submissionStatus"><%= submission.getStatus() %></div>
                    <div class="clear"></div>
                </div>
            </li>
            <% } %>
        </ul>
    </div>
</div>
<!-- END {themeRoot}/jsp/pages/portal/partials/recentSubmissions.jsp -->

