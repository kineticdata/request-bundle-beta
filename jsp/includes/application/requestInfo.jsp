<!-- BEGIN /shared/defaults/jsp/includes/shared/requestInfo.jspf -->
<jsp:useBean id="customerSurvey" scope="request" class="com.kd.kineticSurvey.beans.CustomerSurvey"/>
<div id="requestInfo">
    <!-- Unique identifier of the service item submission. -->
    <input type="hidden" name="submissionID" id="submissionID" value="<jsp:getProperty name="customerSurvey" property="customerSurveyInstanceID"/>">
    <!-- Unique identifier of the service item template. -->
    <input type="hidden" name="tamplateID" id="templateID" value="<jsp:getProperty name="customerSurvey" property="surveyTemplateInstanceID"/>">
    <!-- Unique identifier of the service item template. -->
    <input type="hidden" name="pageID" id="pageID" value="<jsp:getProperty name="customerSurvey" property="pageInstanceID"/>">
    <!-- Unique identifier of the service item template. -->
    <input type="hidden" name="sessionID" id="sessionID" value="<jsp:getProperty name="customerSurvey" property="customerSessionInstanceID"/>">
</div>
<!-- END /shared/defaults/jsp/includes/shared/requestInfo.jspf -->