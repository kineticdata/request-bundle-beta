// Once the page has loaded
THEME.onPageLoad(function() {
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
    
    THEME.activateNavigation({
        navigationSelector: '#catalogContent #catalogNavigation #categoryLinks .categoryLink a',
        contentSelector: '#catalogContent #catalogMain .categoryItem',
        contentSelectHandler: function(element) {
            itemElements = YAHOO.util.Selector.query('.catalogMainItem');
            THEME.addClass(itemElements, 'hidden');
            THEME.removeClass(element, 'hidden');
        }
    });

    YAHOO.util.Event.on('allCategoriesLink', 'click', function () {
        itemElements = YAHOO.util.Selector.query('.catalogMainItem');
        THEME.addClass(itemElements, 'hidden');
        categoriesElement = YAHOO.util.Selector.query('#allCategories');
        THEME.removeClass(categoriesElement, 'hidden');
    });

    YAHOO.util.Event.on("allServiceItemsLink", "click", function () {
        itemElements = YAHOO.util.Selector.query('.catalogMainItem');
        THEME.addClass(itemElements, 'hidden');
        serviceItemsElement = YAHOO.util.Selector.query('#allServiceItems');
        THEME.removeClass(serviceItemsElement, 'hidden');
    });
});