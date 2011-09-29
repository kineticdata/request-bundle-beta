<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/models.jspf"%>

<jsp:useBean id="customerSurvey" scope="request" class="com.kd.kineticSurvey.beans.CustomerSurvey"/>
<jsp:useBean id="UserContext" scope="session" class="com.kd.kineticSurvey.beans.UserContext"/>
<%
    HelperContext context = UserContext.getArContext();
    Catalog catalog = Catalog.findByName(context, customerSurvey.getCategory());
    Template[] templates = catalog.getTemplates(context);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Kore Service Portal: <%= catalog.getName() %></h1>
        <div>
            <div>User</div>
            <div>Logout</div>
        </div>

        <div>
            <div>Search: </div>
        </div>

        <h3>Catalog</h3>
        <div>
            <%= catalog.toJson() %>
        </div>

        <h3>Templates</h3>
        <div>
            <% for (Template template : templates) { %>
            <div><%= template.toJson() %></div>
            <% } %>
        </div>
    </body>
</html>
