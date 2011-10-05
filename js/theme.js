if (typeof THEME == "undefined") {THEME = {};}
THEME.config = {};

THEME.focus = function(element) {
    try {
        var element = YAHOO.util.Dom.get(element);
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
    var element = YAHOO.util.Dom.get(element);
    if (element.hasClass('hidden')) {
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

//function replaceIfEmpty(elementId, path, arguments) {
//    var element = document.getElementById(elementId);
//    if (element.children.length == 0) {
//        replace(elementId, path, arguments);
//    }
//}
THEME.buildHandleReplaceSuccess = function(element) {
    var element = YAHOO.util.Dom.get(element);
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
            elementReference+': ('+response.status+') '+response.statusText);
    }
}