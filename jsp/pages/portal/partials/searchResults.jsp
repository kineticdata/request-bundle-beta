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
    #searchResults h1 {
        padding-bottom: 0.5em;
    }
    #searchResults h2 {
        border-bottom: 1px dotted #A1A1A1;
        color: #777;
        font-size: 1.4em;
        font-weight: normal;
        padding: 5px 0px 5px 0px;
    }
    .highlighted {background: khaki;}

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
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.MatchResult"%>
<%@page import="java.util.regex.Pattern"%>
<%
    String catalogName = request.getParameter("catalogName");
    ThemeConfig.put("catalogName", catalogName);
    Catalog catalog = Catalog.findByName(context, catalogName, true);

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
        // Build a pattern for each of the segments
        Pattern[] patterns = new Pattern[segments.length];
        for (int i=0;i<segments.length;i++) {
            patterns[i] = Pattern.compile(".*"+Pattern.quote(segments[i])+".*", Pattern.CASE_INSENSITIVE);
        }

        // Define a list of templates that match the pattern
        List<Template> matchingTemplates = new ArrayList();

        // For each of the templates
        for(Template template : catalog.getTemplates(context)) {
            // Assume the template matches all segments until a pattern that
            // does not match is encountered.
            boolean matchesAllQueryItems = true;

            // For each of the patterns
            for(Pattern pattern : patterns) {
                // Build a matcher for each item that we are matching
                Matcher nameMatcher = pattern.matcher(template.getName());
                Matcher descriptionMatcher = pattern.matcher(template.getDescription());
                Matcher categoryMatcher = pattern.matcher(template.getCategorizationString());

                // If the template name, description, or category does not match
                // the current query Item
                if (!nameMatcher.matches() && !descriptionMatcher.matches() && !categoryMatcher.matches()) {
                    // Specify that the template does not match all query items
                    matchesAllQueryItems = false;
                    // Break out of the loop
                    break;
                }
            }

            // If the current template still matches all query items after iterating
            // over each of them
            if (matchesAllQueryItems) {
                matchingTemplates.add(template);
            }
        }

        // Build up a list of TemplateMatches if there were any matching templates
        List<TemplateMatch> templateMatches = new ArrayList();
        if (matchingTemplates.size() > 0) {
            // Build a Regex Pattern for matching any of the query segments
            StringBuilder patternBuilder = new StringBuilder();
            patternBuilder.append("(.*?)(");
            for (int i=0;i<segments.length;i++) {
                // If this is not the first segment, append a '|' (Regex OR) character
                if (i!=0) patternBuilder.append("|");
                patternBuilder.append(Pattern.quote(segments[i]));
            }
            patternBuilder.append(")(.*?)");
            Pattern combinedPattern = Pattern.compile(patternBuilder.toString(), Pattern.CASE_INSENSITIVE);

            // For each of the matching templates
            for(Template template : matchingTemplates) {
                String name = replaceAll(combinedPattern, template.getName());
                String description = replaceAll(combinedPattern, template.getDescription());

                templateMatches.add(new TemplateMatch(template.getId(), name, description));
            }
        }
%>
<h1>
    Search Results:
    <% for (String segment : segments) { %>
    <span class="highlighted"><%= segment %></span>
    <% } %>
</h1>
<div id="searchResults">
    <div class="resultType">
    <% if (matchingTemplates.size() == 0) { %>
        <h2>There are no matching templates.</h2>
    <% } else { %>
        <h2>Matching Service Items</h2>
        <% for (TemplateMatch match : templateMatches) { %>
        <div class="templateMatch">
            <div class="templateName"><a class="secondaryColor" href="#"><%= match.getName() %></a></div>
            <div class="matchingAttributes">&nbsp;</div>
            <div class="templateDescription"><%= match.getDescription() %></div>
        </div>
        <% } %>
    <% } %>
<!--
        <h2>Matching Service Names</h2>
        <div class="templateMatch">
            <div class="templateName"><a class="secondaryColor" href="#"><span class="highlighted">Lorem</span> Ipsum</a></div>
            <div class="matchingAttributes">&nbsp;</div>
            <div class="templateDescription">
                Mauris vel eros libero. Nullam et lacus nec neque auctor sodales. Nulla a mi orci, at tincidunt lorem.
            </div>
        </div>
        <div class="templateMatch">
            <div class="templateName"><a class="secondaryColor" href="#"><span class="highlighted">Lorem</span> ipsum dolor sit</a></div>
            <div class="matchingAttributes">&nbsp;</div>
            <div class="templateDescription">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam et lacus nec neque auctor sodales. Nulla a mi orci, at tincidunt lorem.
            </div>
        </div>
        <div class="templateMatch">
            <div class="templateName"><a class="secondaryColor" href="#"><span class="highlighted">Lorem</span> Template Name</a></div>
            <div class="matchingAttributes">&nbsp;</div>
            <div class="templateDescription">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vel eros libero.
            </div>
        </div>
        <div class="templateMatch">
            <div class="templateName"><a class="secondaryColor" href="#">Mauris <span class="highlighted">Lorem</span></a></div>
            <div class="matchingAttributes">&nbsp;</div>
            <div class="templateDescription">
                Mauris vel eros libero.
            </div>
        </div>
        <div class="templateMatch">
            <div class="templateName"><a class="secondaryColor" href="#"><span class="highlighted">Lorem</span> <span class="highlighted">Lorem</span> <span class="highlighted">Lorem</span></a></div>
            <div class="matchingAttributes">&nbsp;</div>
            <div class="templateDescription">
                Nulla a mi orci, consectetur adipiscing elit. Mauris vel eros libero.
            </div>
        </div>
        <div class="allMatchesLink"><a class="primaryColor" href="#">See 10 more...</a></div>
    </div>

    <div class="resultType">
        <h2>Matching Service Descriptions</h2>
        <div class="templateMatch">
            <div class="templateName"><a class="secondaryColor" href="#">Template Name</a></div>
            <div class="matchingAttributes">&nbsp;</div>
            <div class="templateDescription">
                Mauris vel eros libero. Nullam et lacus nec neque auctor sodales. Nulla a mi orci, at tincidunt <span class="highlighted">lorem</span>.
            </div>
        </div>
        <div class="templateMatch">
            <div class="templateName"><a class="secondaryColor" href="#">Template Name</a></div>
            <div class="matchingAttributes">&nbsp;</div>
            <div class="templateDescription">
                <span class="highlighted">Lorem</span> ipsum dolor sit amet, consectetur adipiscing elit. Nullam et lacus nec neque auctor sodales. Nulla a mi orci, at tincidunt <span class="highlighted">lorem</span>.
            </div>
        </div>
        <div class="templateMatch">
            <div class="templateName"><a class="secondaryColor" href="#">Template Name</a></div>
            <div class="matchingAttributes">&nbsp;</div>
            <div class="templateDescription">
                <span class="highlighted">Lorem</span> ipsum dolor sit amet, consectetur adipiscing elit. Mauris vel eros libero.
            </div>
        </div>

        <div class="allMatchesLink"><a class="primaryColor" href="#">See 25 more...</a></div>
    </div>
-->
    <div class="resultType">
        <h2>Matching Service Attributes</h2>
        <div class="templateMatch">
            <div class="templateName"><a class="secondaryColor" href="#">Template Name</a></div>
            <div class="matchingAttributes"><b>Attributes: </b><span class="highlighted">Keyword</span></div>
            <div class="templateDescription">
                Mauris vel eros libero. Nullam et lacus nec neque auctor sodales. Nulla a mi orci, at tincidunt lorem.
            </div>
        </div>
        <div class="templateMatch">
            <div class="templateName"><a class="secondaryColor" href="#">Template Name</a></div>
            <div class="matchingAttributes"><b>Attributes: </b><span class="highlighted">Category</span>, <span class="highlighted">Keyword</span></div>
            <div class="templateDescription">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam et lacus nec neque auctor sodales. Nulla a mi orci, at tincidunt lorem.
            </div>
        </div>
        <div class="templateMatch">
            <div class="templateName"><a class="secondaryColor" href="#">Template Name</a></div>
            <div class="matchingAttributes"><b>Attributes: </b><span class="highlighted">Category (2)</span></div>
            <div class="templateDescription">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vel eros libero.
            </div>
        </div>

        <div class="allMatchesLink"><a class="primaryColor" href="#">See 3 more...</a></div>

    </div>
</div>
<% 
    }
%>
<%!
    private static String replaceAll(Pattern pattern, String string) {
        StringBuffer buffer = new StringBuffer();
        Matcher matcher = pattern.matcher(string);
        while (matcher.find()) {
            matcher.appendReplacement(buffer, matcher.group(1)+"<span class=\"highlighted\">"+matcher.group(2)+"</span>"+matcher.group(3));
        }
        matcher.appendTail(buffer);
        return buffer.toString();
    }
    private static class TemplateMatch {
        private String id;
        private String name;
        private String description;

        public TemplateMatch(String id, String name, String description) {
            this.id = id;
            this.name = name;
            this.description = description;
        }

        public String getId() {return id;}
        public String getName() {return name;}
        public String getDescription() {return description;}
    }
%>