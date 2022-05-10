<%-- 
    Document   : Cart
    Created on : May 10, 2022, 10:06:48 AM
    Author     : Michael Wu
--%>

<%@page import="DAO.DBManager"%>
<%@page import="Model.IoTBay.OrderLineItem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@page import="Model.IoTBay.Product"%>
<%@page import="Model.IoTBay.Person.User"%>
<%@page import="Model.IoTBay.Core.IoTWebpageBase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Cart</title>
		<link rel="stylesheet" href="IoTBayStyles.css">
	</head>
	<body>

		<%
			User active = (User) session.getAttribute("User");
			if (active != null) {
				IoTWebpageBase.uDB.injectOLI(active.getEmail());
			}
			else {
				IoTWebpageBase.uDB.injectOLIAnonymous();
			}

			session.setAttribute("Cart", IoTWebpageBase.uDB.cart);
		%>

		<div class="IndexDivMain">
			<!-- Top menu bar thing. -->
			<nav>
				<div>
					<div class="navLinks left"><a href="../index.jsp">Home</a></div>
					<%
						if (active != null) {
							out.println("<div class=\"navLinks right\"><a href=\"../Logout\">Logout</a></div>");
							out.println("<div class=\"navLinks right\"><a href=\"Profile.jsp\">Profile</a></div>");
						}
						else {
							out.println("<div class=\"navLinks right\"><a href=\"Register.jsp\">Register</a></div>");
							out.println("<div class=\"navLinks right\"><a href=\"Login.jsp\">Login</a></div>");
						}
					%>
				</div>
			</nav>
		</div>

		<h1>Your Cart</h1>

		<!-- Notification of a successful update. -->
		<%
			out.println("<p style=\"text-align:center;\">");

			String err = request.getParameter("err");
			if (err != null) {
				out.println("<span style=\"color:red\"><br>" + err + "</span>");
			}

			String upd = request.getParameter("upd");
			if (upd != null) {
				out.println("<span style=\"color:green\"><br>" + upd + "</span>");
			}

			out.println("</p>");
		%>

		<c:if test="${Cart != null}">
			<table>

				<tr>
					<th>Product Name</th>
					<th>Quantity</th>
					<th>Total Cost</th>
				</tr>

				<%
					ArrayList<OrderLineItem> items = (ArrayList<OrderLineItem>) session.getAttribute("Cart");
					for (int i = 0; i < items.size(); ++i) {
						out.println("<tr>");
						out.println("<form action=\"../UpdateOrder\" class=\"login\" method=\"POST\">");

						OrderLineItem OLI = items.get(i);
						Product p = OLI.getProduct();
						String pName = p.getName();
						int quan = OLI.getQuantity();
						float total = OLI.getTotalCost();

						out.println("<td>" + pName + "</td>");
						out.println("<td><div class=\"field\">");
						out.println("<input name=\"EditedQuantity\" type=\"number\" min=\"0\" max=\"100\" step=\"1\""
							+ "value=\"" + quan + "\"/></div></td>");

						out.println("<td>" + total + "</td>");

						out.println("<td><div class=\"field\"><input class=\"button\" type=\"submit\" value=\"Update\" name=\"Update\"></div></td>");
						out.println("<td><div class=\"field\"><input class=\"button\" type=\"submit\" value=\"Remove\" name=\"Remove\"></div></td>");

						if (OLI.getOwner() != null) {
							out.println("<input type=\"hidden\" name=\"owner\" value=\"" + OLI.getOwner().getEmail() + "\">");
						}
						else {
							out.println("<input type=\"hidden\" name=\"owner\" value=\"" + DBManager.AnonymousUserEmail + "\">");
						}

						int pid = IoTWebpageBase.uDB.findProductID(p);
						if (pid == -1) {
							throw new IllegalArgumentException(pName + " has no ID associated with it!");
						}

						out.println("<input type=\"hidden\" name=\"pid\" value=\"" + pid + "\">");

						out.println("</div>");
						out.println("</form>");
						out.println("</tr>");
					}
				%>
			</table>
		</c:if>
	</body>
</html>