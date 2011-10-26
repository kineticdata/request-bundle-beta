// Decloare a page variable to hold our special page functions
var PAGE = {};

PAGE.config = {
    // Confgure the behavior of the submission lists
    settings: {
        defaultSortColumn: "date",
        defaultSortOrder: "desc",
        pageSize: 2,
        path: THEME.config.rootPath+"/jsp/pages/portal/callbacks/submissionList.json.jsp?"
    },
    // Column definitions
    dataTableColumns: [ // sortable:true enables sorting
        {key:"date", label:"Date", sortable:true},
        {key:"name", label:"Name", sortable:true},
        {key:"status", label:"Status", sortable:true},
        {key:"requestId", label:"Request Id", sortable:true}
    ],
    // Response Schema
    responseSchema: {
        resultsList: "records",
        fields: [
            {key:"date"},{key:"name"},{key:"status"},{key:"requestId"}
        ],
        // Access to values in the server response
        metaFields: {
            startIndex: "startIndex",
            totalRecords: "totalRecords"
        }
    }
}

// On page load
THEME.onPageLoad(function() {
    /* Initialize a hash of submission group configurations.  A submission group
     * represents a grouping of submission lists (IE the "Requests" group may
     * have "Incomplete", "Active", and "Closed" lists).
     *
     * Each submission group is a complex object (Hash) with the following
     * properties:
     *   (Element) contentElement
     *     This is the child of #portalBody that contains the list navigation
     *     box and the list content box.  This property is used primarily as the
     *     root element for css selection of child elements.
     *   (Element) navigationElement
     *     This is the element that is displayed in the top portal navigation
     *     header.
     *   (String) activeList
     *     This is the name of the active submission list for the submission
     *     group.  This will initialize to the first list of the group and will
     *     automatically be updated when other submission lists are selected.
     *   (Object) lists
     *     This is a hash of submission list names to complex objects.  These
     *     object have the following properties:
     *       (Element) contentElement
     *         This is the element that contains the submission list content,
     *         which includes title, dataTable, and paginator elements.
     *       (Element) navigationElement
     *         This is the element that is used to navigate between submission
     *         lists in a given submission group.
     *       (DataSource) dataSource
     *         This is the YAHOO.widget.DataSource that is responsible for
     *         retriving the data for the list table.
     *       (DataTable) dataTable
     *         This is the YAHOO.widget.DataTable that is responsible for
     *         rendering the submission list table.
     *       (Paginator) paginator
     *         This is the YAHOO.widget.Paginator that is responsible for
     *         managing the pagination of the list.
     */
    PAGE.submissionGroups = {}

    // Retrieve the portal main navigation element
    var portalNavigationElement = THEME.get('mainNavigation');
    // Retrieve the navigation elements
    var groupNavigationElements = THEME.select('>.submissionGroupNavigationItem', portalNavigationElement);
    // Retrieve the portal body element
    var portalBodyElement = THEME.get('portalBody');
    // Retrieve the group content
    var groupElements = THEME.select('>.submissionGroup', portalBodyElement);

    // If the number of content and navigation elements don't match.
    if (groupNavigationElements.length != groupElements.length) {
        // Display an error
        THEME.displayError("Unable to initialize submission groups.  The "+
            "number of navigation elements ("+groupNavigationElements.length+
            ") is different than the number of content elements ("+
            groupElements.length+").");
        // Return to prevent further processing
        return;
    }

    // For each of the groups
    for (var groupIndex in groupElements) {
        var groupElement = groupElements[groupIndex];
        var groupNavigationElement = groupNavigationElements[groupIndex];
        var groupName = groupElement.getAttribute('data-group');

        // Retrieve the list elements
        var listElements = THEME.select('.submissionList', groupElement);
        // Retrieve the list navigation elements
        var listNavigationElements = THEME.select('.submissionListNavigation', groupElement);

        // If the number of content and navigation elements don't match.
        if (listElements.length != listNavigationElements.length) {
            // Display an error
            THEME.displayError('Unable to initialize submission lists for the '+
                groupName+' group.  The number of navigation elements ('+
                listNavigationElements.length+') is different than the number '+
                'of content elements ('+listElements.length+').');
            // Return to prevent further processing
            return;
        }

        // Determine the name of the active (first) list
        var activeListName = listElements[0].getAttribute('data-list');

        // Initialize the group lists hash
        var lists = {};

        // For each of the list elements
        for (var listIndex in listElements) {
            var listElement = listElements[listIndex];
            var listNavigationElement = listNavigationElements[listIndex];
            var listName = listElement.getAttribute('data-list');
            
            lists[listName] = {
                contentElement: listElement,
                navigationElement: listNavigationElement,
                dataTable: null,
                paginator: null
            }
        }

        // Add the current submission group object to the PAGE submissionGroups
        PAGE.submissionGroups[groupName] = {
            contentElement: groupElement,
            navigationElement: groupNavigationElement,
            activeList: activeListName,
            lists: lists
        };
    }


    // For each of the groups
    for (groupName in PAGE.submissionGroups) {
        PAGE.initializeSubmissionGroup(groupName);

    }
});

PAGE.initializeSubmissionGroup = function(groupName) {
    var groupObject = PAGE.submissionGroups[groupName];

    // Add a listener to the portal navigation element to refresh the active list
    YAHOO.util.Event.addListener(groupObject.navigationElement, "click", function() {
        // Retrieve the active list
        var listObject = groupObject.lists[groupObject.activeList];
        // If the list is empty
        if (!listObject.dataTable) {
            // Initialize the list
            PAGE.initializeListData(groupName, groupObject.activeList);
        }
    });

    // For each of the lists
    for (var listName in groupObject.lists) {
        // Initialize the list
        PAGE.initializeSubmissionList(groupName, listName);
    }
}

PAGE.initializeSubmissionList = function(groupName, listName) {
    var groupObject = PAGE.submissionGroups[groupName];
    var listObject = groupObject.lists[listName];

    // Add an event listener to the navigation element
    YAHOO.util.Event.addListener(listObject.navigationElement, "click", function() {
        // If this list is already the active list
        if (listName == groupObject.activeList) {
            // Refresh the data table
            PAGE.loadListData(groupName, listName);
        }
        // If this list is not the active list
        else {
            // Hide the active list
            THEME.hide(groupObject.lists[groupObject.activeList].contentElement);
            // Show this list
            THEME.show(listObject.contentElement);
            // Set the name of the active list
            groupObject.activeList = listName;

            // If the list is empty
            if (!listObject.dataTable) {
                PAGE.initializeListData(groupName, listName);
            }
        }
    });
}

PAGE.initializeListData = function(groupName, listName) {
    // Retrieve the group and list objects
    var groupObject = PAGE.submissionGroups[groupName];
    var listObject = groupObject.lists[listName];

    var dataTableElement = THEME.retrieve('.dataTable', listObject.contentElement);
    var paginatorElement = THEME.retrieve('.paginator', listObject.contentElement);

    // Initialize the data source (which will be used for future XHR calls).
    listObject.dataSource = new YAHOO.util.DataSource(PAGE.config.settings.path);
    listObject.dataSource.responseType = YAHOO.util.DataSource.TYPE_JSON;
    listObject.dataSource.responseSchema = PAGE.config.responseSchema;

    // Initialize the paginator
    listObject.paginator = new YAHOO.widget.Paginator({
        containers: [paginatorElement],
        rowsPerPage: PAGE.config.settings.pageSize,
        firstPageLinkLabel: '<<',
        previousPageLinkLabel: 'Previous',
        nextPageLinkLabel: 'Next',
        lastPageLinkLabel: '>>',
        template: '{PreviousPageLink} {CurrentPageReport} {NextPageLink}'
    });
    // Add a custom function to the paginator
    listObject.paginator.goTo = function(pageNumber) {
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

    var generateRequest = function(oState) {
        oState = oState || {pagination: null, sortedBy: {
            key: PAGE.config.settings.defaultSortColumn,
            dir: PAGE.config.settings.defaultSortOrder}
        };
        var recordOffset = (oState.pagination) ? oState.pagination.recordOffset : 0;

        // Build custom request
        var params = "catalog=" + THEME.config.catalogName +
            "&group=" + groupName +
            "&list=" + listName +
            "&sort=" + oState.sortedBy.key +
            "&order=" + oState.sortedBy.dir +
            "&startIndex=" + recordOffset +
            "&pageSize=" + PAGE.config.settings.pageSize;
        return params;
    };

    // Initialize the DataTable configuration
    var dataTableConfiguration = {
        // Specify
        generateRequest: generateRequest,
        // Initial request for first page of data
        initialLoad: true,
        //
        initialRequest: generateRequest(),
        // Enables dynamic server-driven data
        dynamicData: true,
        // Configure the default sorting
        sortedBy: {
            key: PAGE.config.settings.defaultSortColumn,
            dir: PAGE.config.settings.defaultSortOrder == "desc" ?
                YAHOO.widget.DataTable.CLASS_DESC :
                YAHOO.widget.DataTable.CLASS_ASC
        },
        // Confgure the pagination
        paginator: listObject.paginator
    };

    // Initialize the DataTable instance with the configuration objects.
    listObject.dataTable = new YAHOO.widget.DataTable(
        dataTableElement,
        PAGE.config.dataTableColumns,
        listObject.dataSource,
        dataTableConfiguration);

    listObject.dataTable.doBeforePaginatorChange = function() {
        alert("Chaingin!");
        return true;
    }

    listObject.dataTable.doBeforeLoadData = function(oRequest, oResponse, oPayload) {
        if (oResponse.status == 401) {
            THEME.requestLogin();
            listObject.dataTable.load({datasource: listObject.dataSource});
            return false;
        }
        oPayload.totalRecords = oResponse.meta.totalRecords;
        oPayload.pagination.recordOffset = oResponse.meta.startIndex;
        return oPayload;
    };

    // Subscribe to events for row selection
    listObject.dataTable.subscribe("rowMouseoverEvent", listObject.dataTable.onEventHighlightRow);
    listObject.dataTable.subscribe("rowMouseoutEvent", listObject.dataTable.onEventUnhighlightRow);
    listObject.dataTable.subscribe("rowClickEvent", function(event) {
        var data = this.getRecord(event.target).getData();
        alert(data.requestId);
    });

    PAGE.loadListData(groupName, listName);
}

PAGE.loadListData = function(groupName, listName) {
    // Retrieve the group and list objects
    var groupObject = PAGE.submissionGroups[groupName];
    var listObject = groupObject.lists[listName];

    listObject.dataTable.load({datasource: listObject.dataSource});
}



//
//        dataTable.doBeforePaginatorChange = THEME.bind(subgroupNameDigest,
//            function(subgroupNameDigest) {
//                return function(oPaginatorState) {
//                    console.log(subgroupNameDigest);
//                    return true;
//                };
//            });
//
//        // Update totalRecords on the fly with values from server
        
//
//        // Manually load the data table with the initial data
//        dataTable.load({datasource: initialDataSource});
//    }