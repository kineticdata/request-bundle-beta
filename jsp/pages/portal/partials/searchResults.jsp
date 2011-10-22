<%--
    Configure the theme.  This sets multiple theme attributes on the request.
    For more information, see the themeInitialization.jsp file.
--%>
<jsp:include page="../../../includes/themeInitialization.jsp"/>
<%--
    Include the theme configuration file.  This
--%>
<%@include file="../../../includes/themeLoader.jspf"%>
<%--
    Initialize the reference to the ThemeConfig (HashMap) bean.  This bean is
    initialized in the THEME_ROOT/config/config.jsp file and further attributes
    are added by the THEME_ROOT/jsp/includes/themeInitialization.jsp file.
--%>
<jsp:useBean id="ThemeConfig" scope="request" class="java.util.LinkedHashMap"/>
<%
    HelperContext context = (HelperContext)ThemeConfig.get("context");
%>
<style>
    #searchResults #searchQuery {
        cursor: pointer;
    }
    #searchResults .title {
        margin-bottom: 0.5em;
    }
    #searchResults.activeHighlighting .highlighted {background: khaki;}

    .allMatchesLink {float: right;padding-right: 2em;}
    .resultType {clear: right;padding-bottom: 2em;position: relative;}
    .templateMatch {padding-top: 0.5em;}
    .matchingAttributes {
        float: right;
        text-align: left;
        width: 40%;
    }
    .templateName {float: right; position: absolute; left: 0;}
    .templateDescription {clear: right;}
</style>

<%
    String catalogName = request.getParameter("catalogName");
    ThemeConfig.put("catalogName", catalogName);
    Catalog catalog = Catalog.findByName(context, catalogName);
    catalog.preload(context);
    
    /**
     * The following code accepts the HTTP parameter "query", breaks it into
     * segments (by splitting on the space character), and replaces 
     */

    // Build the array of segments (query string separated by a space)
    String[] segments = request.getParameter("query").split(" ");

    // Display an error message if there are 0 segments or > 10 segments
    if (segments.length == 0 || segments[0].length() == 0) {
%>
<div>Error: Please enter a search term.</div>
<%
    } else if (segments.length > 10) {
%>
<div>Error: Search is limited to 10 search terms.</div>
<%
    } else {
        // Build a pattern for each of the segments.  These segments are used to
        // determine which of the models being searched matches ALL of the
        // query segments that were passed.
        Pattern[] patterns = new Pattern[segments.length];
        for (int i=0;i<segments.length;i++) {
            patterns[i] = Pattern.compile(".*"+Pattern.quote(segments[i])+".*", Pattern.CASE_INSENSITIVE);
        }

        // Build a Regex Pattern for matching any of the query segments.  This
        // is used after the models results have been found to highlight the
        // matching query segments.
        StringBuilder patternBuilder = new StringBuilder();
        patternBuilder.append("(.*?)(");
        for (int i=0;i<segments.length;i++) {
            // If this is not the first segment, append a '|' (Regex OR) character
            if (i!=0) patternBuilder.append("|");
            patternBuilder.append(Pattern.quote(segments[i]));
        }
        patternBuilder.append(")(.*?)");
        Pattern combinedPattern = Pattern.compile(patternBuilder.toString(), Pattern.CASE_INSENSITIVE);


        /***********************************************************************
         * BUILD LIST OF MATCHING CATEGORIES
         **********************************************************************/

        // Define a list of categories that match the pattern
        List<Category> matchingCategories = new ArrayList();

        // For each of the categories
        for(Category category : catalog.getAllCategories(context)) {
            // If the category has any templates viewable by the searcher (if it
            // does not have any templates, it doesn't make sense to display it
            // in the search results).
            if (category.hasTemplates()) {
                // Assume the category matches all segments until a pattern that
                // does not match is encountered.
                boolean matchesAllQueryItems = true;

                // For each of the patterns
                for(Pattern pattern : patterns) {
                    // Build a matcher for each item that we are matching
                    Matcher nameMatcher = pattern.matcher(category.getName());
                    Matcher descriptionMatcher = pattern.matcher(category.getDescription());

                    // If the templacategoryte name, description, or category
                    // does not match the current query Item
                    if (!nameMatcher.matches() && !descriptionMatcher.matches()) {
                        // Specify that the category does not match all query items
                        matchesAllQueryItems = false;
                        // Break out of the loop
                        break;
                    }
                }

                // If the current category still matches all query items after
                // iterating over each of them
                if (matchesAllQueryItems) {
                    matchingCategories.add(category);
                }
            }
        }

        /***********************************************************************
         * BUILD LIST OF MATCHING TEMPLATES
         **********************************************************************/

        // Define a list of templates that match the pattern
        List<Template> matchingTemplates = new ArrayList();

        // Define a mapping of search state information
        Map<String,Set<String>> matchingTemplateAttributes = new LinkedHashMap();

        // For each of the templates
        for(Template template : catalog.getTemplates(context)) {
            // If the template is categorized
            if (template.hasCategories()) {
                // Assume the template matches all segments until a pattern that
                // does not match is encountered.
                boolean matchesAllQueryItems = true;

                // Retrieve the configured searchable attributes
                String[] searchableAttributes = (String[])ThemeConfig.get("searchableAttributes");
                // If the searchable attributes configuration value is null, assume all attributes are searchable
                if (searchableAttributes == null) {
                    searchableAttributes = template.getTemplateAttributeNames();
                }

                matchingTemplateAttributes.put(template.getId(), new LinkedHashSet());

                // For each of the patterns
                for(Pattern pattern : patterns) {
                    // Build a matcher for each item that we are matching
                    Matcher nameMatcher = pattern.matcher(template.getName());
                    Matcher descriptionMatcher = pattern.matcher(template.getDescription());
                    Matcher categoryMatcher = pattern.matcher(template.getCategorizationString());

                    // Initialize the set of matching attributes and add it to the
                    // matchingAttributes map for use in the search results
                    Set<String> matchingAttributes = new LinkedHashSet();
                    // For each of the attributes configured to be searchable
                    for (String attributeName : searchableAttributes) {
                        // Retrieve the attribute values for the attribute
                        String[] attributeValues = template.getTemplateAttributeValues(attributeName);
                        System.out.println(template.getName() + ": "+attributeName +" ("+attributeValues.length+")");

                        // For each of the attribute values
                        for (String attributeValue : attributeValues) {
                            System.out.println("  "+attributeValue);
                            // Add the attribute to the matchingAttributes set if it
                            // matches.
                            Matcher attributeValueMatcher = pattern.matcher(attributeValue);
                            if (attributeValueMatcher.matches()) {
                                matchingAttributes.add(attributeName);
                                break;
                            }
                        }
                    }

                    // If there are no attributes matching the current query item,
                    // and the template name, description, or category does not
                    // match the current query item either
                    if (matchingAttributes.size() == 0 && !nameMatcher.matches() && !descriptionMatcher.matches() && !categoryMatcher.matches()) {
                        // Specify that the template does not match all query items
                        matchesAllQueryItems = false;
                        // Break out of the loop
                        break;
                    }
                    // If one of the matchable items matches the current query item
                    else {
                        // Add the set of attributes that match the current query
                        // item to the list of attributes that match any query item.
                        matchingTemplateAttributes.get(template.getId()).addAll(matchingAttributes);
                    }
                }

                // If the current template still matches all query items after iterating
                // over each of them
                if (matchesAllQueryItems) {
                    matchingTemplates.add(template);
                }
            }
        }
%>
<div id="searchResults" class="activeHighlighting">
    <div class="title">
        Search Results:
        <% for (String segment : segments) { %>
        <span id="searchQuery" class="highlighted secondaryColor" title="Click to toggle highlighting." onclick="THEME.toggleClass('searchResults', 'activeHighlighting');"><%= segment %></span>
        <% } %>
    </div>

    <div>
    <%-- If there were any matching categories, display them. --%>
    <% if (matchingCategories.size() > 0) { %>
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
    <% if (matchingTemplates.size() == 0) { %>
        <div class="subtitle">There are no matching templates.</div>
    <%-- If there were any matching templates, display them. --%>
    <% } else { %>
        <div class="subtitle">Matching Service Items</div>
        <% for (Template template : matchingTemplates) { %>
        <div class="templateMatch">
            <div class="templateName">
                <a class="primaryColor" href="#">
                    <%= ThemeHelper.replaceAll(combinedPattern, template.getName()) %>
                </a>
            </div>
            <div class="matchingAttributes">
                <% if (matchingTemplateAttributes.get(template.getId()).size() > 0) { %>
                <b>Attributes: </b>
                <% for (String matchingAttributeName : matchingTemplateAttributes.get(template.getId())) { %>
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