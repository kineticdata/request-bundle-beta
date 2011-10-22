// Once the page has loaded
THEME.onPageLoad(function() {
    // Retrieve the userInfo item
    YAHOO.util.Event.addListener(THEME.get('userInfoHeaderDisplay'), "click", function(event) {
        THEME.toggleClass(THEME.get('userInfo'), 'active', 'inactive');
    });

    var searchBox = THEME.get("searchBox");
    
    var searchListener = new YAHOO.util.KeyListener(
        searchBox,
        { keys: [YAHOO.util.KeyListener.KEY.ENTER] },
        function() {
            var searchContent = THEME.get("searchContent");
            var searchLoadDisplay = THEME.get("searchLoadDisplay");
            var searchLoadDisplayQuery = THEME.get("searchLoadDisplayQuery");
            var searchResultsDisplay = THEME.get("searchResultsDisplay");

            // Set the Search Load Display content
            searchLoadDisplayQuery.innerHTML = searchBox.value;

            // Hide the presently displayed content tab
            THEME.hide("categories");
            THEME.hide(searchContent);

            // Ensure the proper Search Result display is visible
            THEME.hide(searchResultsDisplay);
            THEME.show(searchLoadDisplay);
            // Show the search content pane
            THEME.show(searchContent);

            // Replace the search results content
            THEME.replace(
                searchResultsDisplay,
                "/jsp/pages/portal/partials/searchResults.jsp?catalogName="+THEME.config.catalogName+"&query="+searchBox.value,
                {callback: function() {
                    THEME.hide(searchLoadDisplay);
                    THEME.show(searchResultsDisplay);
                }}
            );
                
            searchBox.value = '';
        }
    );
    searchListener.enable();

    /**
     * Configure the page tabs:
     *  - Link the children of the +tabContainer+ element (tabs) to the children
     *     of the +contentContainer+ element (content panes).
     *  - When a tab is clicked:
     *    - Execute the +tabSelectHandler+ on the selected tab element.
     *    - Execute the +tabUnselectHandler+ on each of the other tab elements.
     *    - Execute the +contentSelectHandler+ on the content pane element 
     *      linked to the selected tab element.
     *    - Execute the +contentUnselectHandler+ on each of the content pane
     *      elements not linked to the selected tab element.
     */
    THEME.activateNavigation({
        navigationSelector: '#mainNavigation .navigationItem',
        navigationSelectHandler: function(element) {
            THEME.addClass(element, 'navigationItemActive');
            if (element.id == 'homeTab') {
                THEME.addClass(document.body, 'home');
            } else {
                THEME.removeClass(document.body, 'home');
            }
        },
        navigationUnselectHandler: function(element) {
            THEME.removeClass(element, 'navigationItemActive');
        },
        contentSelector: '#portalBody .content',
        contentSelectHandler: function(element) {
            THEME.removeClass(element, 'hidden');
        },
        contentUnselectHandler: function(element) {
            THEME.addClass(element, 'hidden');
        }
    });
});


THEME.breadcrumbs = [{
        name: 'Catalog Home',
        id: 'rootCategories'
    }];

THEME.lastBreadcrumb = function() {
    return THEME.breadcrumbs[THEME.breadcrumbs.length - 1];
}

THEME.refreshBreadcrumbHTML = function() {
    // Build the new breadcrumb HTML
    var HTML = '';
    for(var i=0; i<THEME.breadcrumbs.length; i++) {
        var name = THEME.breadcrumbs[i]['name'];
        var id = THEME.breadcrumbs[i]['id'];
        if (i>0) {
            HTML += '<span class="breadcrumbDivider">></span>';
        }
        HTML += '<span class="breadcrumb">';
        HTML += '<a class="breadcrumbLink secondaryColor" ';
        HTML += 'data-id="' + id + '" ';
        HTML += 'href="javascript:void(0)">';
        HTML += name;
        HTML += '</a></span>';
    }

    // Set the HTML to the correct div element
    var breadcrumbElement = document.getElementById('catalogBreadcrumbs');
    breadcrumbElement.innerHTML = HTML;

    // Bind a click function to each of the breadcrumbLink elements that shows
    // the specified element and refreshes the breadcrumb html.
    var breadcrumbLinks = YAHOO.util.Selector.query('#catalogBreadcrumbs .breadcrumbLink');
    for(var i=0; i<breadcrumbLinks.length; i++) {
        YAHOO.util.Event.on(breadcrumbLinks[i], 'click', function() {
            // Hide the currently displayed element.  The id of the currently
            // displayed element should be stored in the most recent entry in
            // the breadcrumb stack.
            var displayedElement = document.getElementById(THEME.lastBreadcrumb()['id']);
            THEME.addClass(displayedElement, 'hidden');

            // Get the target id stored in the link that triggers this function.
            // Then retrieve and show the element.
            var targetId = this.getAttribute('data-id');
            var targetElement = document.getElementById(targetId);
            THEME.removeClass(targetElement, 'hidden');

            // Rebuild the breadcrumbs.
            // First remove elements from the breadcrumbs stack until we reach
            // the element that was clicked.
            while(THEME.lastBreadcrumb()['id'] != targetId) {
                THEME.breadcrumbs.pop();
            }

            THEME.refreshBreadcrumbHTML();
        });
    }
};


THEME.onPageLoad(function() {
    var navigationLinks = YAHOO.util.Selector.query('#catalog .navigationLink');
    for(var i=0; i<navigationLinks.length; i++) {
        YAHOO.util.Event.on(navigationLinks[i], 'click', function() {
            // Hide the currently displayed element.
            var displayedElement = document.getElementById(THEME.lastBreadcrumb()['id']);
            THEME.addClass(displayedElement, 'hidden');

            // Show the element specified by the link that triggered this function.
            var targetId = this.getAttribute('data-id');
            var targetName = this.getAttribute('data-name');
            if(targetName == undefined) {
                targetName = this.innerHTML;
            }
            var targetElement = document.getElementById(targetId);
            THEME.removeClass(targetElement, 'hidden');

            // Add this navigation action to the breadcrumb stack by pushing
            // the id and name of the link that triggered this function.
            THEME.breadcrumbs.push({
                id: targetId,
                name: targetName
            });

            // Rebuild the breadcrumb HTML and insert it into the #breadcrumb
            // div element.
            THEME.refreshBreadcrumbHTML();
        });
    }
});