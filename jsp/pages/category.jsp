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

        <script type="text/javascript">
        THEME.onPageLoad(function() {
            var config = {
                containerId: "submissions",
                defaultSortColumn: "date",
                defaultSortOrder: "desc",
                pageSize: 2,
                path: THEME.config.rootPath+"/jsp/pages/portal/partials/submissions.jsp?"
            };

            // Column definitions
            var dataTableColumns = [ // sortable:true enables sorting
                {key:"date", label:"Date", sortable:true},
                {key:"name", label:"Name", sortable:true},
                {key:"status", label:"Status", sortable:true},
                {key:"requestId", label:"Request Id", sortable:true}
            ];

            var responseSchema = {
                resultsList: "records",
                fields: [
                    {key:"date"},{key:"name"},{key:"status"},{key:"requestId"}
                ],
                // Access to values in the server response
                metaFields: {
                    startIndex: "startIndex",
                    totalRecords: "totalRecords"
                }
            };



            // Initialize the initial data source (generated server side)
            var initialData = <jsp:include page="portal/partials/submissions.jsp"/>;
            var initialDataSource = new YAHOO.util.DataSource(initialData);
            initialDataSource.responseType = YAHOO.util.DataSource.TYPE_JSON;
            initialDataSource.responseSchema = responseSchema;

            // Initialize the data source (which will be used for future XHR calls).
            var dataSource = new YAHOO.util.DataSource(config.path);
            dataSource.responseType = YAHOO.util.DataSource.TYPE_JSON;
            dataSource.responseSchema = responseSchema;

            // Customize request sent to server to be able to set total # of records
            var generateRequest = function(oState) {
                //
                oState = oState || { pagination: null, sortedBy: null };
                var sort = (oState.sortedBy) ? oState.sortedBy.key : config.defaultSortColumn;
                var order = (oState.sortedBy && oState.sortedBy.dir === YAHOO.widget.DataTable.CLASS_DESC) ? "desc" : "asc";
                var recordOffset = (oState.pagination) ? oState.pagination.recordOffset : 0;

                // Build custom request
                return  "sort=" + sort +
                        "&order=" + order +
                        "&startIndex=" + recordOffset +
                        "&pageSize=" + config.pageSize;
            };

            // DataTable configuration
            var dataTableConfiguration = {
                // Specify
                generateRequest: generateRequest,
                // Initial request for first page of data
                initialLoad: false,
                // Enables dynamic server-driven data
                dynamicData: true,
                // Configure the default sorting
                sortedBy: {
                    key:config.defaultSortColumn,
                    dir: config.defaultSortOrder == "desc" ?
                        YAHOO.widget.DataTable.CLASS_DESC :
                        YAHOO.widget.DataTable.CLASS_ASC
                },
                // Confgure the pagination
                paginator: new YAHOO.widget.Paginator({
                    rowsPerPage: config.pageSize
                })
            };

            // Initialize the DataTable instance with the configuration objects.
            var dataTable = new YAHOO.widget.DataTable(
                config.containerId,
                dataTableColumns,
                dataSource,
                dataTableConfiguration);

            // Update totalRecords on the fly with values from server
            dataTable.doBeforeLoadData = function(oRequest, oResponse, oPayload) {
                oPayload.totalRecords = oResponse.meta.totalRecords;
                oPayload.pagination.recordOffset = oResponse.meta.startIndex;
                return oPayload;
            };

            // Manually load the data table with the initial data
            dataTable.load({datasource: initialDataSource});

            // Create a listener to manually refresh the table
            YAHOO.util.Event.addListener("update", "click", function() {
                dataSource.sendRequest(generateRequest(), {
                    success : dataTable.onDataReturnSetRows,
                    failure : dataTable.onDataReturnSetRows,
                    scope : dataTable,
                    argument: dataTable.getState() // data payload that will be returned to the callback function
                });
            });
        });
        </script>
    </head>
    <body class="yui-skin-sam">
        <p><input type="button" id="update" value="Update"></p>
        <div id="submissions"></div>
    </body>
</html>