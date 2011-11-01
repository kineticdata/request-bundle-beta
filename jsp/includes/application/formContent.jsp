<%--
    TODO: Description
--%>

<%--
    TODO: Document
--%>
<%@include file="../themeInitialization.jspf"%>

<%--
    TODO: Document
--%>
<%@include file="../../../../../resources/partials/reviewFunctions.jsp"%>

<!-- BEGIN {themeRoot}/jsp/includes/application/formContent.jspf -->
<%
    // Retrieve the list of review pages if one exists
    Vector<CustomerSurveyReview> reviewPages = (Vector)request.getAttribute("RequestPages");

    // If this is a normal (non-review) request
    if (reviewPages == null) {
%>
    <div id="formContent">
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
<%
    }
    // If this is a review request
    else {
        // If there were no reviewable pages
        if (reviewPages.size() == 0) {
%>
    This request could either not be found, or it did not have any valid content pages.
<%
        } else {
            // Overwrite the default customer survey values
            CustomerSurveyReview review = reviewPages.firstElement();
            customerSurvey.setSurveyTemplateName(review.getSurveyTemplateName());
            customerSurvey.setSuccessMessage(review.getSuccessMessage());
            customerSurvey.setErrorMessage(review.getErrorMessage());
            customerSurvey.setCustomerSessionInstanceID(review.getCustomerSessionInstanceID());
            customerSurvey.setCustomerSurveyInstanceID(review.getCustomerSurveyInstanceID());
            customerSurvey.setSurveyTemplateInstanceID(review.getSurveyTemplateInstanceID());
            customerSurvey.setSubmitType("ReviewRequest");

            //
            String reviewId = "";
            if (review.getCustomerSurveyBase() != null) {
                SimpleEntry entry = review.getCustomerSurveyBase();
                String originatingId = entry.getEntryFieldValue("700088607");
                if (ThemeHelper.isBlank(originatingId)) {
                    reviewId = entry.getEntryFieldValue("1");
                } else {
                    reviewId = originatingId;
                }
            }
%>
    <div id="reviewContent">
        <% if ("TRUE".equals(request.getParameter("FullReviewDisplay"))) { %>
        <div id="contentPageSection" class="contentPageSection ">
            <div id="headerSection" class="headerSection">
                <div class="KSR_Number"><%=reviewId%></div>
            </div>
        </div>
        <% }%>

        <% if (review.getLoadAllPages()) {%>
            <%= renderPages(reviewPages, "frame")%>
        <% } else {%>
            <%= renderPageTabs(reviewPages, "frame")%>
        <% }%>
        <input type="hidden" name="templateID" id= "templateID" value="<%=review.getSurveyTemplateInstanceID()%>"/>
        <input type="hidden" name="pageID" id="pageID" value=""/>
    </div>
<% 
        }
    }
%>
<!-- END {themeRoot}/jsp/includes/application/formContent.jspf -->