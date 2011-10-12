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
        <title><%= ThemeConfig.get("companyName")+" "+ThemeConfig.get("portalName") %></title>

        <!-- Set the favicon for the page. -->
        <link rel="shortcut icon" href="<%=ThemeConfig.get("root")%>/images/logo-favicon.png" type="image/x-icon">

        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/fonts/fonts-min.css">
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/tabview/assets/skins/sam/tabview.css">
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/paginator/assets/skins/sam/paginator.css" />
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/datatable/assets/skins/sam/datatable.css" />

        <link rel="stylesheet" href="<%= ThemeConfig.get("root")%>/css/theme.css" type="text/css">
        <link rel="stylesheet" type="text/css" href="<%=ThemeConfig.get("root") + "/config/config.css"%>" >

        <script src="http://yui.yahooapis.com/2.9.0/build/yahoo/yahoo-min.js"></script>
        <script src="http://yui.yahooapis.com/2.9.0/build/dom/dom-min.js"></script>
        <script src="http://yui.yahooapis.com/2.9.0/build/event/event-min.js" ></script>
        <script src="http://yui.yahooapis.com/2.9.0/build/element/element-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/connection/connection-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/json/json-min.js"></script>
        <script src="http://yui.yahooapis.com/2.9.0/build/tabview/tabview-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/event-delegate/event-delegate-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/paginator/paginator-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/datasource/datasource-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/datatable/datatable-min.js"></script>

        <!-- Include the Theme javascript file. -->
        <script src="<%=ThemeConfig.get("root")%>/js/theme.js" type="text/javascript"></script>
        <!-- Configure the Theme javascript. -->
        <script type="text/javascript">
            // Configure the rootPath of the THEME's configuration.  This value
            // is used to reference callbacks for methods such as THEME.replace.
            THEME.config.rootPath = '<%=ThemeConfig.get("root")%>';
        </script>
    </head>

<%
    HelperContext context = (HelperContext) ThemeConfig.get("context");
    String catalogName = (String) ThemeConfig.get("catalogName");
    Catalog catalog = Catalog.findByName(context, "Klean", true);
%>

    <body class="yui-skin-sam">
        <h2>Service Names</h2>
        
        <h2>Service Descriptions</h2>

        <h2>Service Attributes</h2>
    </body>
</html>