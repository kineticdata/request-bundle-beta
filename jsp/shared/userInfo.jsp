<%--
    This file defines the "User Info" section of the top navigation.  This
    includes both the value that is displayed in the
--%>

<!-- BEGIN {themeRoot}/jsp/includes/applicationHeaders.jsp -->
<%--
    TODO: Document
--%>
<%@include file="../includes/themeInitialization.jspf"%>
<%
    if (context != null) {
        User user = User.findByID(context, context.getUserName());
%>
<div id="userInfoHeaderDisplay" class="noSelect" style="vertical-align: top;font-weight:bold;padding-top:2px;cursor: pointer;">
    <%= context.getUserName()%>
    <img class="inactiveImage" src="<%=ThemeConfig.get("root")%>/images/arrow_down.png" alt="User Info"><img class="activeImage" src="<%=ThemeConfig.get("root")%>/images/arrow_up.png" alt="Close User Info">
</div>
<div id="userInfoContent" class="secondaryColorBackground" style="position:absolute;right:0;">
    <% if (user != null) {%>
        <div class="info">
            <div class="label">Name:</div>
            <div class="value"><%=user.getFirstName()%>&nbsp;<%=user.getLastName()%></div>
        </div>
        <div class="info">
            <div class="label">Email:</div>
            <div class="value"><%=user.getEmail()%></div>
        </div>
        <div class="info">
            <div class="label">Phone:</div>
            <div class="value"><%=user.getPhoneNumber()%></div>
        </div>
        <div class="info">
            <div class="label">Department:</div>
            <div class="value"><%=user.getDepartment()%></div>
        </div>
    <% } else {%>
        <div>You were not found in the Sample People form.</div>
    <% }%>
</div>
<%
    } else {
%>
<div class="">Login</div>
<%
    }
%>