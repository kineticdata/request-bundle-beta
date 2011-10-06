<!-- BEGIN /shared/defaults/jsp/includes/shared/questions.jspf -->
<jsp:useBean id="customerSurvey" scope="request" class="com.kd.kineticSurvey.beans.CustomerSurvey"/>
<div id="requestContent">
    <% if (customerSurvey.getQuestions() != null) { %>
    <!-- Service Item Questions -->
    <jsp:getProperty name="customerSurvey" property="questions" />
    <% } %>
</div>
<!-- END /shared/defaults/jsp/includes/shared/questions.jspf -->