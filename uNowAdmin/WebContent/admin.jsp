<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta charset="ISO-8859-1">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>uNow Administration</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<%
	//if already connected
	HttpSession s = request.getSession(false);
	String id = (String) s.getAttribute("name");
	boolean toutEstBon = true;
	if (id == null || id.equals(null) || id == "" || id.equals("")) {
		toutEstBon = false;
	}else {
		if(!id.equals("Jonathan")) {
			toutEstBon = false;
		}
	}
	if (!toutEstBon) {
		%>
		<div class="alert alert-danger">
		<strong>You are not a super user, <%= id %>!</strong>
	</div><%
	}else {
		%>
		
		
			<p>Bienvenue administrateur !</p>
		
		
		
		<%
	}
%>
</body>
</html>