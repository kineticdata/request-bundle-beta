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
    THEME.activateTabs({
        tabContainer: 'mainNavigation',
        tabSelectHandler: function(element) {
            THEME.addClass(element, 'navigationItemActive');
        },
        tabUnselectHandler: function(element) {
            THEME.removeClass(element, 'navigationItemActive');
        },
        contentContainer: 'portalBody',
        contentSelectHandler: function(element) {
            THEME.removeClass(element, 'hidden');
        },
        contentUnselectHandler: function(element) {
            THEME.addClass(element, 'hidden');
        }
    });
});