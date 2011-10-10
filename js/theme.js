/**
 *
 */

// If the Javascript THEME class has not yet been defined
if (typeof THEME == "undefined") {
    // Initialize an array to store the list of missing dependencies.
    var missingDependencies = [];

    // Add any missing dependencies to the the missingDependencies array
    if (typeof YAHOO == "undefined") {
        missingDependencies.push('yahoo.js (yahoo-min.js)');
    }
    if (typeof YAHOO == "undefined" || typeof YAHOO.util.Dom == "undefined") {
        missingDependencies.push('dom.js (dom-min.js)');
    }
    if (typeof YAHOO == "undefined" || typeof YAHOO.util.Event == "undefined") {
        missingDependencies.push('event.js (event-min.js)');
    }

    // If there were any missing dependencies
    if (missingDependencies.length > 0) {
        // Initialize the error message
        var message = 'There was a problem initializing the THEME Javascript '+
            'object.    Please ensure the following libraries are loaded by '+
            'the current page:\n';
        // For each of the missing dependencies
        for (var index in missingDependencies) {
            // Add the missing dependency to the error message.
            message = message + '\n * ' + missingDependencies[index];
        }
        // Use the Javascript alert function to display the missing dependencies
        alert(message);
    }
    // If there were no missing dependencies
    else {
        // Configure YUI to re-throw Errors (by default they are muffled).
        YAHOO.util.Event.throwErrors = true;

        // Initialize the THEME class.
        var THEME = {};

        // Initialize the THEME configuration hash.
        THEME.config = {};

        THEME.displayError = function(message) {
            alert(message);
        }

        THEME.activateTabs = function(configuration) {
            var tabElement = YAHOO.util.Dom.get(configuration['tabContainer']);
            var contentElement = YAHOO.util.Dom.get(configuration['contentContainer']);

            if (!tabElement) {
                THEME.displayError("Unable to activate tabs, the tab "+
                    "container '"+configuration['tabContainer']+"' does not "+
                    "exist.");
            } else if (!contentElement) {
                THEME.displayError("Unable to activate tabs, the tab content "+
                    "container '"+configuration['contentContainer']+"' does "+
                    "not exist.");
            } else if (tabElement.children.length != contentElement.children.length) {
                THEME.displayError("Unable to configure tabs, the tab "+
                    "container '"+configuration['tabContainer']+"' ("+
                    tabElement.children.length+") has a different number of "+
                    "children than the content container '"+
                    configuration['contentContainer']+"' ("+
                    contentElement.children.length+").");
            } else {
                var tabElements = tabElement.children;
                var contentElements = contentElement.children;

                // For each of the tab elements
                for(var eventIndex=0;eventIndex<tabElements.length;eventIndex++) {
                    // Set an event to
                    YAHOO.util.Event.on(tabElements[eventIndex], "click", function (e) {
                        // Call the unselect handler on each of the tabs
                        for(var tabIndex=0;tabIndex<tabElements.length;tabIndex++) {
                            //alert(tabElements[tabIndex].id + ' : ' + this.id);
                            if (tabElements[tabIndex] == this) {
                                // Call the select handler on the selected element
                                configuration['tabSelectHandler'](tabElements[tabIndex]);
                                configuration['contentSelectHandler'](contentElements[tabIndex]);
                            } else {
                                configuration['tabUnselectHandler'](tabElements[tabIndex]);
                                configuration['contentUnselectHandler'](contentElements[tabIndex]);
                            }
                        }
                    });
                }
            }
        }

        THEME.addClass = function(element, className) {
            YAHOO.util.Dom.addClass(element, className);
        }
        THEME.removeClass = function(element, className) {
            YAHOO.util.Dom.removeClass(element, className);
        }

        THEME.onPageLoad = function(method) {
            YAHOO.util.Event.onDOMReady(method);
        }

        THEME.disable = function(element) {
            YAHOO.util.Dom.setAttribute(element, 'disabled', 'diabled');
        }
        THEME.enable = function(element) {
            YAHOO.util.Dom.setAttribute(element, 'disabled', 'false');
        }

        THEME.lock = function(element) {
            YAHOO.util.Dom.setAttribute(element, 'readonly', 'readonly');
            YAHOO.util.Dom.addClass(element, 'readonly');
        }
        THEME.unlock = function(element) {
            YAHOO.util.Dom.setAttribute(element, 'readonly', 'false');
            YAHOO.util.Dom.removeClass(element, 'readonly');
        }

        THEME.focus = function(element) {
            try {
                element = YAHOO.util.Dom.get(element);
                element.select();
                element.focus();
            } catch (e) {
                // something failed, just ignore and let the user click
            }
        }

        THEME.hide = function(element) {
            YAHOO.util.Dom.addClass(element, 'hidden');
        }
        THEME.show = function(element) {
            YAHOO.util.Dom.removeClass(element, 'hidden');
        }
        THEME.toggle = function(element) {
            if (YAHOO.util.Dom.hasClass(element, 'hidden')) {
                THEME.show(element);
            } else {
                THEME.hide(element);
            }
        }


        /** TODO */
        THEME.showErrorMessage = function(message) {
            alert(message);
        }


        THEME.replace = function(elementReference, path, arguments) {
            if (THEME.config.rootPath == undefined) {
                THEME.showErrorMessage("Error configuring THEME.replace AJAX " +
                    "request. Unable to determine the theme's root path.  Please "+
                    "ensure the THEME.config.rootPath javascript configuration "+
                    "variable is set.");
            } else {
                var element = YAHOO.util.Dom.get(elementReference);

                if (element == null) {
                    THEME.showErrorMessage("Error configuring THEME.replace AJAX" +
                        "request.  Target element '"+elementReference+"' was not " +
                        "found.");
                } else {
                    var callback = {
                        success: THEME.buildHandleReplaceSuccess(element),
                        failure: THEME.buildHandleReplaceFailure(elementReference),
                        arguments: arguments
                    };

                    path = THEME.config.rootPath+'/'+path;

                    YAHOO.util.Connect.asyncRequest('GET', path, callback);
                }
            }
        }

        THEME.replaceIfEmpty = function (elementReference, path, arguments) {
            var element = YAHOO.util.Dom.get(elementReference);
            if (element.children.length == 0) {
                THEME.replace(elementReference, path, arguments);
            }
        }

        THEME.buildHandleReplaceSuccess = function(elementReference) {
            var element = YAHOO.util.Dom.get(elementReference);
            return function(response) {
                if (element == null) {
                    THEME.showErrorMessage("Unable to process the javascript "+
                        "THEME.replace call.  Target element was not found.");
                } else {
                    element.innerHTML = response.responseText;
                }
            }
        }
        THEME.buildHandleReplaceFailure = function(elementReference) {
            return function(response) {
                THEME.showErrorMessage('Unable to replace the contents of '+
                    elementReference+': ('+response.status+') '+response.statusText+
                    '\n\n'+response.responseText);
            }
        }
    }
}
