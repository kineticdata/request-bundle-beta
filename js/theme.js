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

        THEME.bind = function bind(variables, method) {
            if (!(variables instanceof Array)) {
                variables = [variables];
            }
            return function() {
                return method.apply(this, variables);
            }();
        };

        THEME.displayError = function(message) {
            alert(message);
        };

        THEME.requestLogin = function() {
            alert('Please log in.');
        };

        THEME.activateNavigation = function(config) {
            var navigationElements = YAHOO.util.Selector.query(config['navigationSelector'], config['navigationRootElement']);
            var contentElements = YAHOO.util.Selector.query(config['contentSelector'], config['contentRootElement']);

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
        
        THEME.getData = function (element, dataName) {
            return YAHOO.util.Dom.get(element).getAttribute('data-'+dataName);
        }

        THEME.addClass = function(element, className) {
            YAHOO.util.Dom.addClass(element, className);
        }
        THEME.hasClass = function(element, className) {
            return YAHOO.util.Dom.hasClass(element, className);
        }
        THEME.removeClass = function(element, className) {
            YAHOO.util.Dom.removeClass(element, className);
        }

        THEME.get = function(element) {
            return YAHOO.util.Dom.get(element);
        }
        THEME.getValue = function(element) {
            element = YAHOO.util.Dom.get(element) || element;
            if (element && element.value) {
                return element.value;
            } else {
                THEME.displayError('The element '+element+' does not have a value.');
                throw 'ERROR: The element '+element+' does not have a value.';
            }
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
            YAHOO.util.Dom.batch(element, THEME._toggle);
        }
        THEME._toggle = function(element) {
            if (YAHOO.util.Dom.hasClass(element, 'hidden')) {
                THEME.show(element);
            } else {
                THEME.hide(element);
            }
        }
        THEME.toggleClass = function(element, className, toggledClassName) {
            if (YAHOO.util.Dom.hasClass(element, className)) {
                if (toggledClassName) {
                    THEME.addClass(element, toggledClassName);
                }
                THEME.removeClass(element, className);
            } else {
                if (toggledClassName) {
                    THEME.removeClass(element, toggledClassName);
                }
                THEME.addClass(element, className);
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

                    path = THEME.config.rootPath+path;

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


        THEME.activateInputHelptext = function(elementReference) {
            /* Upon activation retrieve the specified input element.  Set the value
             * of the input element to the data-default attribute of the element
             * and set the data-defaulted attribute to 'true' to indicated that
             * it is currently defaulted and add the inactiveInput class to the
             * element.
             */
            var element = document.getElementById(elementReference);
            element.value = element.getAttribute('data-default');
            element.setAttribute('data-defaulted', 'true');
            THEME.addClass(element, 'inactiveInput');
            /* Bind a function to the input element that triggers on focus in. When
             * triggered, if the value of the element is set to the default value
             * we clear the value and remove the inactiveInput class from the element.
             */
            YAHOO.util.Event.on(element, 'focusin', function() {
                if (this.getAttribute('data-defaulted')=='true') {
                    this.value = '';
                    THEME.removeClass(this, 'inactiveInput');
                }
            });
            /* Bind a function to the input element that triggers on focus out(blur).
             * When triggered, if the value of the element is blank we set the value
             * to the default value and add the inactiveInput class to the element.
             */
            YAHOO.util.Event.on(element, 'focusout', function() {
                if (this.value == '') {
                    this.value = this.getAttribute('data-default');
                    this.setAttribute('data-defaulted', 'true');
                    THEME.addClass(this, 'inactiveInput');
                } else {
                    this.setAttribute('data-defaulted', 'false');
                }
            });
        }
    }
}
