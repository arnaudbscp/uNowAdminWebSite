<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>uNow Administration</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	
    <style>
		html,
		body {
		  height: 100%;
		}
		
		body {
		  display: -ms-flexbox;
		  display: flex;
		  -ms-flex-align: center;
		  align-items: center;
		  padding-top: 40px;
		  padding-bottom: 40px;
		  background-color: #f5f5f5;
		}
		
		.form-signin {
		  width: 100%;
		  max-width: 330px;
		  padding: 15px;
		  margin: auto;
		}
		.form-signin .checkbox {
		  font-weight: 400;
		}
		.form-signin .form-control {
		  position: relative;
		  box-sizing: border-box;
		  height: auto;
		  padding: 10px;
		  font-size: 16px;
		}
		.form-signin .form-control:focus {
		  z-index: 2;
		}
		.form-signin input[type="email"] {
		  margin-bottom: -1px;
		  border-bottom-right-radius: 0;
		  border-bottom-left-radius: 0;
		}
		.form-signin input[type="password"] {
		  margin-bottom: 10px;
		  border-top-left-radius: 0;
		  border-top-right-radius: 0;
		}
    </style>
</head>
<%
	//if already connected
	HttpSession s = request.getSession(false);
	String id = (String) s.getAttribute("name");
	boolean toutEstBon = true;
	if (id == null || id.equals(null) || id == "" || id.equals("")) {
		toutEstBon = false;
	}
	if (toutEstBon) {
		response.sendRedirect("admin.jsp");
	}
%>
<body>

	<form class="form-signin" method="POST" action="Connexion">
	  <center><img class="mb-4" src="img/logo.png" alt="" width="auto" height="72"></center>
	  	<%
		String param = request.getParameter("error");
		if (param != null && !param.equals(null)) {
			if (param.equals("co")) {%>
				<div class="alert alert-danger">
				<strong>Wrong IDs!</strong>
				</div><%
			}
		}
		%>
	  <h1 class="h3 mb-3 font-weight-normal"><span style="color:#1b5873;">Hi super user, please sign in:</span></h1>
	  <label for="inputTel" class="sr-only">PhoneNumber</label>
	  <input type="tel" id="inputTel" name=inputTel class="form-control" placeholder="PhoneNumber" required autofocus>
	  <label for="inputPassword" class="sr-only">Password</label>
	  <input type="password" id="inputPassword" name=inputPassword class="form-control" placeholder="Password" required>
	  <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
	</form>
</body>
</html>