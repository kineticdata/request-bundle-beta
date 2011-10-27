<%--
    TODO: Description of file.
--%>

<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%--
    TODO: Document
--%>
<%@include file="../../../includes/themeInitialization.jspf"%>

<%
    if (context == null) {
        UnauthorizedHelper.sendUnauthorizedResponse(response);
    } else {
        String id = request.getParameter("id");
        String csrv = request.getParameter("csrv");
        Submission submission = Submission.findByInstanceId(context, csrv);

        if (submission == null) {
%>
    <div class="submissionDetails">
        <!-- Submission Title -->
        <div class="title">
            Submission Details
            <a href="javascript:void(0)" onclick="THEME.toggle(['portalRightColumnDefaultContent', 'portalRightColumnDynamicContent'])">
                <img class="control" src="<%=ThemeConfig.get("root")%>/images/close12x12-FFFFFF.png" alt="Close"/>
            </a>
            <div class="clear"></div>
        </div>

        <div class="info missing">
            Unable to locate the record <%=id%>.
        </div>
    </div>
    <%
        } else {
    %>
    <div class="submissionDetails">
        <!-- Submission Title -->
        <div class="title">
            Submission Details
            <a href="javascript:void(0)" onclick="THEME.toggle(['portalRightColumnDefaultContent', 'portalRightColumnDynamicContent'])">
                <img class="control" src="<%=ThemeConfig.get("root")%>/images/close12x12-FFFFFF.png" alt="Close"/>
            </a>
            <div class="clear"></div>
        </div>

        <!-- Submission Reference -->
        <div class="info">
            <div class="templateName"><%= submission.getTemplateName() %></div>
            <div class="submissionInfo">
                <div class="id">
                    <a class="primaryColor" href="<%= bundle.detailsUrl(submission.getId()) %>">
                        <%= submission.getRequestId() %>
                    </a>
                </div>
                <div class="auxiliaryColor status">
                    <%= submission.getStatus() %>
                </div>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>

        <!-- Submission Summary -->
        <div class="summary">
            <div class="subtitle">Summary</div>
            <div>
                <div class="label">Requested At</div>
                <div class="value"><%= DateHelper.formatDate(submission.getCreateDate(), request.getLocale()) %></div>
                <div class="clear"></div>
            </div>
            <div>
                <div class="label">Status</div>
                <div class="value"><%= submission.getValiationStatus() %></div>
                <div class="clear"></div>
            </div>
            <div class="notes"><%= submission.getNotes() %></div>
            <div class="clear"></div>
        </div>

        <!-- Task List -->
        <div class="tasks">
            <div class="subtitle">Tasks</div>
            <% CycleHelper cycle = new CycleHelper("first", CycleHelper.ONLY_FIRST_CYCLE); %>
            <% for(String treeName : submission.getTaskTreeExecutions(context).keySet()) { %>
                <div class="tree <%= cycle.cycle() %>">
                    <div class="name"><%= treeName %></div>
                </div>

                <% CycleHelper separator = new CycleHelper("<div class=\"separator\"></div>", CycleHelper.SKIP_FIRST_CYCLE); %>
                <% for(Task task : submission.getTaskTreeExecutions(context).get(treeName)) { %>
                <div class="task">
                    <%= separator.cycle() %>
                    <div class="name"><%= task.getName() %></div>
                    <div class="status"><%= task.getStatus() %></div>
                    <div class="date"><%= DateHelper.formatDate(task.getCreateDate(), request.getLocale()) %></div>
                    <ul class="messages">
                        <% for(TaskMessage message : task.getMessages(context)) { %>
                        <li><%= message.getMessage() %></li>
                        <% } %>
                    </ul>
                </div>
                <% } %>
            <% } %>
        </div>
    </div>
    <%
        }
    %>
<% } %>