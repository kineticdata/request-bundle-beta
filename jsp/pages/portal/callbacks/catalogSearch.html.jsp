<%--
    TODO: Description of file.
--%>

<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%--
    TODO: Document
--%>
<%@include file="../../../includes/themeInitialization.jspf"%>

<%@include file="catalogSearch/CatalogSearch.jspf"%>
<%
    /**
     * The following code accepts the HTTP parameter "query", breaks it into
     * querySegments (by splitting on the space character), and replaces
     */

    String catalogName = request.getParameter("catalogName");
    
    // Build the array of querySegments (query string separated by a space)
    String[] querySegments = request.getParameter("query").split(" ");

    // Display an error message if there are 0 querySegments or > 10 querySegments
    if (querySegments.length == 0 || querySegments[0].length() == 0) {
%>
<div>Error: Please enter a search term.</div>
<%
    } else if (querySegments.length > 10) {
%>
<div>Error: Search is limited to 10 search terms.</div>
<%
    } else {
        String[] searchableAttributes = (String[]) ThemeConfig.get("searchableAttributes");
        CatalogSearch catalogSearch = new CatalogSearch(context, catalogName, querySegments);
        Category[] matchingCategories = catalogSearch.getMatchingCategories();
        Template[] matchingTemplates = catalogSearch.getMatchingTemplates(searchableAttributes);
        Pattern combinedPattern = catalogSearch.getCombinedPattern();
%>
<div id="catalogSearchResults" class="searchResults activeHighlighting">
    <div class="title">
        Search Results:
        <% for (String segment : querySegments) { %>
        <span class="searchQuery highlighted secondaryColor" title="Click to toggle highlighting." onclick="THEME.toggleClass('catalogSearchResults', 'activeHighlighting');"><%= segment %></span>
        <% } %>
    </div>

    <%-- If there were any matching categories, display them. --%>
    <% if (matchingCategories.length > 0) { %>
        <div class="subtitle">Matching Service Categories</div>
        <% CycleHelper toggle = new CycleHelper(new String[] {"even", "odd"}); %>
        <% for(Category category : matchingCategories) { %>
        <div class="subcategory navigationLink <%= toggle.cycle() %>" data-id="<%=category.getId()%>" data-name="<%=category.getName()%>" onclick="THEME.navigateTo(this);">
            <div class="name"><%= ThemeHelper.replaceAll(combinedPattern, category.getName()) %></div>
            <div class="image"><img src="<%=ThemeConfig.get("root")%>/images/favorites32x32.png"/></div>
            <div class="description"><%= ThemeHelper.replaceAll(combinedPattern, category.getDescription()) %></div>
        </div>
        <% } %>
        <div class="clear"></div>
    <% } %>


    <%-- If there were no matching templates, display that there are no matching templates. --%>
    <% if (matchingTemplates.length == 0) { %>
        <div class="subtitle">There are no matching templates.</div>
    <%-- If there were any matching templates, display them. --%>
    <% } else { %>
        <div class="subtitle">Matching Service Items</div>
        <% for (Template template : matchingTemplates) { %>
        <div class="match">
            <div class="templateName">
                <a class="primaryColor" href="#">
                    <%= ThemeHelper.replaceAll(combinedPattern, template.getName()) %>
                </a>
            </div>
            <div class="matchingAttributes">
                <% if (catalogSearch.hasMatchingAttributes(template.getId())) { %>
                <b>Attributes: </b>
                <% for (String matchingAttributeName : catalogSearch.getMatchingAttributes(template.getId())) { %>
                <span class="highlighted"><%= matchingAttributeName %> </span>
                <% } %>
                <% } %>
            </div>
            <div class="templateDescription">
                <%= ThemeHelper.replaceAll(combinedPattern, template.getDescription()) %>
            </div>
        </div>
        <% } %>
        <div class="clear"></div>
    <% } %>
</div>
<% 
    }
%>