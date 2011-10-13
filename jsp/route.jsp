<%@page trimDirectiveWhitespaces="true"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="javax.servlet.RequestDispatcher"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@include file="includes/themeLoader.jspf" %>
<%
    /**
     * This is a simple routing JSP that allows for package specific URL
     * rewriting.  In order to "enable" this JSP, you need to add a Servlet
     * configuration and mapping element to your web.xml file (such as shown
     * below).
     *
     * Assuming the sample configuration below, accessing the following URL will
     * render the Service Item from the "Klean" catalog that has a display name
     * of DISPLAY_NAME.
     *   - http://SERVER:PORT/kinetic/Klean/DISPLAY_NAME
     *
     * <servlet>
     *     <servlet-name>RouteJSP</servlet-name>
     *     <display-name>RouteJSP</display-name>
     *     <jsp-file>/themes/klean/jsp/route.jsp</jsp-file>
     * </servlet>
     * <servlet-mapping>
     *     <servlet-name>RouteJSP</servlet-name>
     *     <url-pattern>/Klean/*</url-pattern>
     * </servlet-mapping>
    */

    String contextPath = request.getContextPath();
    String routePath = request.getRequestURI().substring(contextPath.length());
    String[] routeItems = routePath.substring(1).split("/");
    
    if (routeItems.length != 2) {
        throw new RuntimeException("Unable to process routing request.  Expected 2 routing items, got "+routeItems.length+".");
    }
    String catalog = routeItems[0];
    catalog = "Klean";
    String templateDisplayName = routeItems[1];

    HelperContext context = new HelperContext("Demo", "", "matrix.kineticmatrix.com", 0, 0);
    // Locate the Template
    Template template = Template.findByDisplayName(context, catalog, templateDisplayName);
    
    if (template != null) {
        String destination = "/DisplayPage?srv="+template.getId();
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(destination);
        dispatcher.forward(request, response);
    } else {
        response.setContentType("text/plain");
        PrintWriter output = response.getWriter();
        output.println("Unable to locate the '"+catalog+"' service item with "+
            "a display name of '"+templateDisplayName+"'.");
        output.println("Context Path: " + request.getContextPath());
        output.println("Request URI: " + request.getRequestURI());
        output.println("Route Path: " + routePath);
    }
%>