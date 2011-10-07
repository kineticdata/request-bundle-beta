<%--
    Configuration setting that trims all of the whitespace that is created by
    using JSP comments (such as this one) and other JSP tags.
--%>
<%@page trimDirectiveWhitespaces="true"%>

<%--
    Load the theme configuration JSP file (this contains settings such as the
    company or site name).

    This file also initializes the ThemeConfig (HashMap) bean.
--%>
<%@include file="../../config/config.jsp" %>

<%-- Include the beans that will be referenced by this page. --%>
<jsp:useBean id="customerSurvey" scope="request" class="com.kd.kineticSurvey.beans.CustomerSurvey"/>
<jsp:useBean id="UserContext" scope="session" class="com.kd.kineticSurvey.beans.UserContext"/>

<%--
    Set the attributes necessary for the theme to function.  These are typically
    namespaced with the prefix "com.kd.themes" to avoid collisions with other
    session attributes.
--%>
<%
    /**
     * Define the root attribute.
     *
     * Note that the path string does not end with a '/'.  Paths that
     * concatenate values with this attribute should ensure the appended path
     * starts with a '/'.
     *
     * Example (assuming a default installation):
     *   /kinetic/themes/THEME_NAME
     * Example (assuming Kinetic SR was installed to an alternate location):
     *   /services/portfolio/themes/THEME_NAME
     */
    ThemeConfig.put("root", getThemeRoot(request));

    /** Set the name of the catalog that this page is using. */
    ThemeConfig.put("catalogName", customerSurvey.getCategory());
    /** Set the name of the catalog that this page is using. */
    ThemeConfig.put("templateName", customerSurvey.getSurveyTemplateName());

    /** Set the default helper context. */
    if (customerSurvey.getRemedyHandler() != null) {
        ThemeConfig.put("defaultContext", customerSurvey.getRemedyHandler().getDefaultHelperContext());
    }

    ThemeConfig.put("context", UserContext.getArContext());
%>


<%--
    Define the set of functions available to all JSP pages.
--%>
<%!
    /**
     * Returns a String representing the path to the root of the themes.
     *
     * Example (assuming a default installation):
     *   /kinetic/themes/THEME_NAME
     * Example (assuming Kinetic SR was installed to an alternate location):
     *   /services/portfolio/themes/THEME_NAME
     */
    public static String getThemeRoot(HttpServletRequest request) {
        String requestUri = request.getRequestURI();
        int startOfThemeName = requestUri.indexOf("/themes/")+"/themes/".length();
        int endOfThemeName = requestUri.indexOf("/", startOfThemeName);
        String themeRoot = requestUri.substring(0, endOfThemeName);

        return themeRoot;
    }
%>