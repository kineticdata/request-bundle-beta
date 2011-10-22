<!-- BEGIN {themeRoot}/jsp/includes/application/templateContent.jspf -->
<jsp:useBean id="customerSurvey" scope="request" class="com.kd.kineticSurvey.beans.CustomerSurvey"/>
<div id="templateContent">
    <form name='pageQuestionsForm' id='pageQuestionsForm' class='pageQuestionsForm' method='post' action='SubmitPage'>
        <!-- Service Item Questions -->
        <jsp:getProperty name="customerSurvey" property="questions" />

        <!-- Request reference values -->
        <% if (request.getParameter("csrv")!= null) {%>
        <input type="hidden" name="csrv" value="<%=request.getParameter("csrv")%>"/>
        <%}%>
        <% if (request.getParameter("srv")!= null) {%>
        <input type="hidden" name="srv" value="<%=request.getParameter("srv")%>"/>
        <%}%>

        <!-- Request state values -->
        <input type="hidden" name="pageID" id="pageID" value="<jsp:getProperty name="customerSurvey" property="pageInstanceID"/>">
        <input type="hidden" name="sessionID" id="sessionID" value="<jsp:getProperty name="customerSurvey" property="customerSessionInstanceID"/>">
        <input type="hidden" name="submissionID" id="submissionID" value="<jsp:getProperty name="customerSurvey" property="customerSurveyInstanceID"/>">
        <input type="hidden" name="templateID" id="templateID" value="<jsp:getProperty name="customerSurvey" property="surveyTemplateInstanceID"/>">
    </form>
</div>
<!-- END /shared/defaults/jsp/includes/shared/questions.jspf -->