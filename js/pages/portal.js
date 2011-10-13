// Once the page has loaded
THEME.onPageLoad(function() {
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
            THEME.hide("allCategories");
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