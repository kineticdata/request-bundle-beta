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
    if (typeof YAHOO == "undefined" || typeof YAHOO.lang.JSON == "undefined") {
        missingDependencies.push('json.js (json-min.js)');
    }
    if (typeof YAHOO == "undefined" || typeof YAHOO.util.Selector == "undefined") {
        missingDependencies.push('selector.js (selector-min.js)');
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

        THEME.activateNavigation = function(config) {
            var navigationElements = YAHOO.util.Selector.query(config['navigationSelector']);
            var contentElements = YAHOO.util.Selector.query(config['contentSelector']);

            // Validate the configuration passed to this function
            if (navigationElements.length == 0) {
                THEME.displayError("Unable to activate navigation, the navigation " +
                    "selector query '" + config['navigationSelector'] + "' returns " +
                    "zero results.");
            } else if (contentElements.length == 0) {
                THEME.displayError("Unable to activate navigation, the content container " +
                    "querry '" + config['contentSelector'] + "' returns zero results.");
            } else if (navigationElements.length != contentElements.length) {
                THEME.displayError("Unable to configure navigation, the navigation " +
                    "selector query '" + config['navigationSelector'] + "' (" +
                    navigationElements.length + ") returns a different number of " +
                    "elements than the content selector query '" + config['contentSelector'] +
                    "' (" + contentElements.length + ").");
            } else {
                // For each of the associated elements
                for (var index=0; index<navigationElements.length; index++) {
                    // Configure an event listener on click of the navigation element
                    YAHOO.util.Event.on(navigationElements[index], "click", function () {
                        // For each of the content elements
                        for (var eventIndex=0; eventIndex<contentElements.length; eventIndex++) {
                            var navigationElement = navigationElements[eventIndex];
                            var contentElement = contentElements[eventIndex];
                            if (this == navigationElement) {
                                if (config['navigationSelectHandler'] != undefined) {
                                    config['navigationSelectHandler'](navigationElement);
                                }
                                if (config['contentSelectHandler'] != undefined) {
                                    config['contentSelectHandler'](contentElement);
                                }
                            } else {
                                if (config['navigationUnselectHandler'] != undefined) {
                                    config['navigationUnselectHandler'](navigationElement);
                                }
                                if (config['contentUnselectHandler'] != undefined) {
                                    config['contentUnselectHandler'](contentElement);
                                }
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

        THEME.get = function(element) {
            return YAHOO.util.Dom.get(element);
        }

        THEME.retrieve = function(selector, root) {
            return YAHOO.util.Selector.query(selector, root, true);
        }

        THEME.select = function(selector, root) {
            return YAHOO.util.Selector.query(selector, root);
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


        THEME.replace = function(elementReference, path, options) {
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
                        success: THEME.buildHandleReplaceSuccess(element, options),
                        failure: THEME.buildHandleReplaceFailure(elementReference)
                    };

                    path = THEME.config.rootPath+'/'+path;

                    YAHOO.util.Connect.asyncRequest('GET', path, callback);
                }
            }
        }

        THEME.replaceIfEmpty = function (elementReference, path, options) {
            var element = YAHOO.util.Dom.get(elementReference);
            if (element.children.length == 0) {
                THEME.replace(elementReference, path, options);
            }
        }

        THEME.buildHandleReplaceSuccess = function(elementReference, options) {
            var element = YAHOO.util.Dom.get(elementReference);
            return function(response) {
                if (element == null) {
                    THEME.showErrorMessage("Unable to process the javascript "+
                        "THEME.replace call.  Target element was not found.");
                } else {
                    element.innerHTML = response.responseText;
                    if (options.callback) {
                        options.callback();
                    }
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
