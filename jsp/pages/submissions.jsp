<%--
    Configure the theme.  This sets multiple theme attributes on the request.
    For more information, see the themeInitialization.jsp file.
--%>
<jsp:include page="../includes/themeInitialization.jsp"/>
<%--
    Include the theme configuration file.  This
--%>
<%@include file="../includes/themeLoader.jspf"%>
<%--
    Initialize the reference to the ThemeConfig (HashMap) bean.  This bean is
    initialized in the THEME_ROOT/config/config.jsp file and further attributes
    are added by the THEME_ROOT/jsp/includes/themeInitialization.jsp file.
--%>
<jsp:useBean id="ThemeConfig" scope="request" class="java.util.LinkedHashMap"/>

<%
    HelperContext context = (HelperContext)ThemeConfig.get("context");
    String catalogName = (String)ThemeConfig.get("catalogName");
    catalogName = request.getParameter("catalogName");
    SubmissionList[] submissionLists = getSubmissionLists(context, catalogName);
%>

<%-- The following file specifies a map of submission "types" to their qualification. --%>
<%@include file="submissions/configuration/listConfiguration.jspf"%>

<%-- Set the HTML DOCTYPE. --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%-- Define the page HTML. --%>
<html>
    <head>
        <%-- Document the HTTP Content-Type header value within the HTML. --%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%-- Specify that modern IE versions should render the page with their
             own rendering engine (as opposed to falling back to compatibility
             mode. --%>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <%-- Set the title of the page. --%>
        <title><%= ThemeConfig.get("companyName")+" "+ThemeConfig.get("portalName") %> Login</title>

        <!-- Set the favicon for the page. -->
        <link rel="shortcut icon" href="<%=ThemeConfig.get("root")%>/images/logo-favicon.png" type="image/x-icon">

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

        <script src="<%=ThemeConfig.get("root")%>/js/theme.js" type="text/javascript"></script>
        <script type="text/javascript">
            THEME.config.rootPath = '<%=ThemeConfig.get("root")%>';
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
                    <a href="javascript:void(0)" onclick="THEME.replaceIfEmpty('<%= submissionList.getNameDigest() %>', 'jsp/pages/submissions/callbacks/submissionList.jsp?catalogName=<%=catalogName%>&nameDigest=<%=submissionList.getNameDigest()%>')">
                        <%= submissionList.getName() %> (<%= submissionList.getCount(context) %>)
                    </a>
                </div>

                <%-- Render a list of submission ids that link to the request. --%>
                <div class="submissionList" id="<%= submissionList.getNameDigest() %>">
                    <%-- If this is the first list of submissions --%>
                    <% if (submissionLists[0] == submissionList) { %>
                        <% for (Submission submission : submissionList.getSubmissions(context)) { %>
                        <div>
                            <%= submission.getTemplateName() %>: <a href="<%= submission.getDisplayUrl() %>"><%= submission.getRequestId() %></a>
                        </div>
                        <% } %>
                    <% } %>
                </div>
            <% } %>
        </div>
    </body>
</html>