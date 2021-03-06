<%-- 
	Document   : Login
	Created on : Mar 30, 2022, 6:37:43 PM
	Author     : Michael Wu

	Purpose    : Provides the interface for the user to log in to IoTBay.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="IoTBayStyles.css">
		<title>IoTBay | Login</title>
	</head>
	<body>
		<div class="IndexDivMain">
			<!-- Top menu bar thing. -->
			<nav>
				<div>
					<div class="navLinks left"><a href="../index.jsp">Home</a></div>
				</div>
			</nav>

			<div class="wrapper ForceCentreScreen">
				<div class="title-text">
					<div class="title login">Login</div>
				</div>

				<!-- If the user of email and password does not exist, show the message. -->
				<p style="text-align:center; color:red">
					<%
						String err = request.getParameter("err");
						if (err != null) {
							out.println("<br>" + err);
						}
					%>
				</p>

				<div class="form-container">
					<div class="form-inner">
						<form action="../Login" class="login" method="POST">

							<div class="field">
								<input type="email" placeholder="E-Mail Address" name="Email" <%String e = request.getParameter("Email");
								out.println(e == null ? "" : "value=" + e);%>required>
							</div>

							<div class="field">
								<input type="password" placeholder="Password" name="Password" required>
							</div>

							<div class="field">
								<input type="submit" value="Login">
							</div>

							<div class="signup-link">
								Not Registered? <a href="Register.jsp">Register Now!</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>