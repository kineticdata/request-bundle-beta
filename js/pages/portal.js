if (typeof THEME == "undefined") {THEME = {};}
if (typeof THEME.portal == "undefined") {THEME.portal = {};}

// Map of tabNavigationIds to tabContentIds
THEME.portal.tabs = {};

THEME.portal.selectTab = function() {
    for (var tabNavigationId in THEME.portal.tabs) {
        YAHOO.util.Dom.removeClass(tabNavigationId, "navigationItemActive");
        YAHOO.util.Dom.addClass(THEME.portal.tabs[tabNavigationId], "hidden");
    }
    YAHOO.util.Dom.addClass(this, "navigationItemActive");
    YAHOO.util.Dom.removeClass(this.id+'Content', "hidden");
}

// Once the page has loaded
YAHOO.util.Event.onDOMReady(function() {
    THEME.portal.tabs['portalTab'] = 'portalTabContent';
    YAHOO.util.Event.addListener('portalTab', "click", THEME.portal.selectTab);
})