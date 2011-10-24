<!-- BEGIN {themeRoot}/jsp/pages/portal/partials/recentSubmissions.jsp -->
<%--
    TODO: Document
--%>
<%@include file="../../../includes/themeInitialization.jspf"%>

<%
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

