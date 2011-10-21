var PAGE = {};
PAGE.paginators = {};

THEME.onPageLoad(function() {
    var config = {
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

    // Response Schema
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


    // Retrieve the list of subgroups
    var subgroupElements = THEME.select('.submissionGroup .submissionSubgroup');
    for (var index in subgroupElements) {
        var subgroupElement = subgroupElements[index];
        var subgroupNameDigest = subgroupElement.id;

        var dataTableElementId = subgroupNameDigest+'-DataTable';

        var groupNameElement = THEME.get(subgroupNameDigest+'-Group');
        var groupName = groupNameElement.innerHTML;
        
        var subgroupNameElement = THEME.get(subgroupNameDigest+'-Subgroup');
        var subgroupName = subgroupNameElement.innerHTML;

        var initialDataElement = THEME.get(subgroupNameDigest+'-InitialData');
        var initialDataString = initialDataElement.innerHTML;
        var initialData = YAHOO.lang.JSON.parse(initialDataString);

        // Initialize the initial data source (generated server side)
        var initialDataSource = new YAHOO.util.DataSource(initialData);
        initialDataSource.responseType = YAHOO.util.DataSource.TYPE_JSON;
        initialDataSource.responseSchema = responseSchema;

        // Initialize the data source (which will be used for future XHR calls).
        var dataSource = new YAHOO.util.DataSource(config.path);
        dataSource.responseType = YAHOO.util.DataSource.TYPE_JSON;
        dataSource.responseSchema = responseSchema;

        // Customize request sent to server to be able to set total # of records
        var generateRequest = buildGenerateRequestFunction(groupName, subgroupName, config.pageSize);

        // Build the paginator
        var paginator = new YAHOO.widget.Paginator({
            containers: [subgroupNameDigest+'-Paginator'],
            rowsPerPage: config.pageSize,
            firstPageLinkLabel: '<<',
            previousPageLinkLabel: 'Previous',
            nextPageLinkLabel: 'Next',
            lastPageLinkLabel: '>>',
            template: '{PreviousPageLink} {CurrentPageReport} {NextPageLink}'
        });
        paginator.goTo = function(pageNumber) {
            if (!YAHOO.widget.Paginator.isNumeric(pageNumber)) {
                THEME.displayError("Page number '"+pageNumber+"' is not a number.");
            }
            pageNumber = YAHOO.widget.Paginator.toNumber(pageNumber);
            if (pageNumber < 1) {
                THEME.displayError("Page number '"+pageNumber+"' is not valid.");
            } else if (pageNumber > this.getTotalPages()) {
                THEME.displayError("Page number '"+pageNumber+"' is not valid.  Please select a number between 1 and "+this.getTotalPages());
            } else if (pageNumber != this.getCurrentPage()) {
                this.setPage(pageNumber);
            }
        }
        // Add the paginator to our page configuration
        PAGE.paginators[subgroupNameDigest] = paginator;

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
                groupName: groupName,
                subgroupName: subgroupName,
                key:config.defaultSortColumn,
                dir: config.defaultSortOrder == "desc" ?
                    YAHOO.widget.DataTable.CLASS_DESC :
                    YAHOO.widget.DataTable.CLASS_ASC
            },
            // Confgure the pagination
            paginator: paginator
        };

        // Initialize the DataTable instance with the configuration objects.
        var dataTable = new YAHOO.widget.DataTable(
            dataTableElementId,
            dataTableColumns,
            dataSource,
            dataTableConfiguration);

        // Subscribe to events for row selection
        dataTable.subscribe("rowMouseoverEvent", dataTable.onEventHighlightRow);
        dataTable.subscribe("rowMouseoutEvent", dataTable.onEventUnhighlightRow);
        dataTable.subscribe("rowClickEvent", function(event) {
            var data = this.getRecord(event.target).getData();
            alert(data.requestId);
        });

        dataTable.doBeforePaginatorChange = THEME.bind(subgroupNameDigest,
            function(subgroupNameDigest) {
                return function(oPaginatorState) {
                    console.log(subgroupNameDigest);
                    return true;
                };
            });

        // Update totalRecords on the fly with values from server
        dataTable.doBeforeLoadData = THEME.bind(subgroupNameDigest,
            function(subgroupNameDigest) {
                return function(oRequest, oResponse, oPayload) {
                    if (oResponse.status == 401) {
                        THEME.requestLogin();
                        dataTable.load({datasource: dataSource});
                        return false;
                    }
                    console.log(subgroupNameDigest);
                    oPayload.totalRecords = oResponse.meta.totalRecords;
                    oPayload.pagination.recordOffset = oResponse.meta.startIndex;
                    return oPayload;
                };
            });

        // Manually load the data table with the initial data
        dataTable.load({datasource: initialDataSource});
    }

//    // Create a listener to manually refresh the table
//    YAHOO.util.Event.addListener("update", "click", function() {
//        dataSource.sendRequest(generateRequest(), {
//            success : dataTable.onDataReturnSetRows,
//            failure : dataTable.onDataReturnSetRows,
//            scope : dataTable,
//            argument: dataTable.getState() // data payload that will be returned to the callback function
//        });
//    });
});


function buildGenerateRequestFunction(groupName, subgroupName, pageSize) {
    return function(oState) {
        //
        oState = oState || {pagination: null, sortedBy: null};
        var sort = (oState.sortedBy) ? oState.sortedBy.key : config.defaultSortColumn;
        var order = (oState.sortedBy && oState.sortedBy.dir === YAHOO.widget.DataTable.CLASS_DESC) ? "desc" : "asc";
        var recordOffset = (oState.pagination) ? oState.pagination.recordOffset : 0;

        // Build custom request
        return  "group=" + groupName +
                "&subgroup=" + subgroupName +
                "&sort=" + sort +
                "&order=" + order +
                "&startIndex=" + recordOffset +
                "&pageSize=" + pageSize;
    };
}