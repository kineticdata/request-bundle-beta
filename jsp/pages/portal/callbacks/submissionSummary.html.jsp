<%--
    TODO: Description of file.
--%>

<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%--
    TODO: Document
--%>
<%@include file="../../../includes/themeInitialization.jspf"%>

<div class="title">
    Submission Details
    <a href="javascript:void(0)" onclick="THEME.toggle(['portalRightColumnDefaultContent', 'portalRightColumnDynamicContent'])">
        <img src="<%=ThemeConfig.get("root")%>/images/close12x12-FFFFFF.png" alt="Close" style="cursor:pointer;float:right;"/>
    </a>
    <div class="clear"></div>
</div>
<div style="color: #555;">
    <!-- Submission Reference -->
    <div style="">
        <div style="font-weight:bold;">Employee Onboarding</div>
        <div style="padding-left: 1em;">
            <a class="primaryColor" href="#" style="float: left;">KSR000000005556</a>
            <div class="auxiliaryColor submissionStatus" style="float: right;">Completed</div>
            <div class="clear"></div>
        </div>
        <div class="clear"></div>
    </div>

    <!-- Submission Summary -->
    <div class="subtitle" style="margin-top:1em;">Summary</div>
    <div class="primaryBorderColor">
        <div>
            <div style="float:left; font-weight: bold;width:100px">Requested At</div>
            <div style="float:left;">Oct 18, 2011 9:50:45 AM</div>
            <div class="clear"></div>
        </div>
        <div>
            <div style="float:left; font-weight: bold;width:100px">Status</div>
            <div style="float:left;">In progress for Joe Blow</div>
            <div class="clear"></div>
        </div>
        <div style="margin-top:0.5em;">
            The service center is presently observing Christmas holiday. Please allow an extra 2-3 days for processing due to backlog.
        </div>
        <div class="clear"></div>
    </div>

    <!-- Task List -->
    <div class="subtitle" style="margin-top:1em;">Tasks</div>
    <div class="task">
        <div style="font-weight:bold;">Register New Employee</div>
        <div style="float:left;">Status</div>
        <div style="float:right;">Modified Date</div>
        <div class="clear"></div>
        <ul class="messages" style="font-style: italic;margin-top:0.1em;padding-left:2em;list-style-type: square;">
            <li>Assigned to Mark Zeffer</li>
            <li>Re-assigned to Shayne Zeffer</li>
            <li>Approved by Shayne Zeffer</li>
        </ul>
    </div>
    <div style="padding-top: 0.5em;margin-bottom:0.5em;border-bottom: 1px dotted #A1A1A1;"></div>
    <div class="task">
        <div style="font-weight:bold;">Procure Laptop</div>
        <div style="float:left;">Status</div>
        <div style="float:right;">Modified Date</div>
        <div class="clear"></div>
    </div>
    <div style="padding-top: 0.5em;margin-bottom:0.5em;border-bottom: 1px dotted #A1A1A1;"></div>
    <div class="task">
        <div style="font-weight:bold;">Register Active Directory Account</div>
        <div style="float:left;">Status</div>
        <div style="float:right;">Modified Date</div>
        <div class="clear"></div>
        <ul class="messages" style="font-style: italic;margin-top:0.1em;padding-left:2em;list-style-type: square;">
            <li>Account name fubar.</li>
        </ul>
    </div>
</div>