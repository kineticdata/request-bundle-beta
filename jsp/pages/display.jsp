<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/theme.jspf"%>
<%@include file="../../config/config.jsp"%>

<jsp:useBean id="customerSurvey" scope="request" class="com.kd.kineticSurvey.beans.CustomerSurvey"/>
<jsp:useBean id="UserContext" scope="session" class="com.kd.kineticSurvey.beans.UserContext"/>
<%@include file="../includes/models.jspf"%>
<%
    HelperContext context = UserContext.getArContext();
    if (context == null) {
        context = customerSurvey.getRemedyHandler().getDefaultHelperContext();
    }
    Catalog catalog = Catalog.findByName(context, customerSurvey.getCategory());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title><%= catalog.getName() %> - <%= customerSurvey.getSurveyTemplateName() %></title>
        <link rel="stylesheet" type="text/css" href="<%=request.getAttribute("com.kd.themes.root") + "/css/theme.css"%>" />
        <link rel="stylesheet" type="text/css" href="<%=request.getAttribute("com.kd.themes.root") + "/config/config.css"%>" />
    </head>
    <body class="fadedBackground">
        <div class="topline primaryColorBackground">a</div>
        <%= request.getAttribute("com.kd.themes.root") + "/css/theme.css"%></br>
        <%= request.getAttribute("com.kd.themes.companyName") %>
    </body>
</html>