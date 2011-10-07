// Once the page has loaded
YAHOO.util.Event.onDOMReady(function() {
    // Convert the submit button into a YUI button
    new YAHOO.widget.Button("logInButton");
    // Listen for the submit action
    YAHOO.util.Event.on("loginForm", "submit", function(event) {
        THEME.lock('UserName');
        THEME.lock('Password');
        THEME.hide('logInButton');
        THEME.show('loader');
    });
    // Set the focus to the UserName input
    THEME.focus('UserName');
});