<%@page import="java.io.File"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<style>
		.rond {
			width: 170px;
			height: 150px;
			border-radius: 100%;
			background-color: #26a491;
			margin: 0 auto;
			box-shadow: 4px 4px 1px rgba(0,0,0,.2);
		}
		#map {
       	 	height: 430px;
       	 	width: 100%
      	}
		
	</style>
	<meta charset="ISO-8859-1">
	<meta charset="ISO-8859-1">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>uNow Administration</title>
	<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<%
	//if already connected
	HttpSession s = request.getSession(false);
	String id = (String) s.getAttribute("name");
	String tel = (String) s.getAttribute("telephone");
	boolean toutEstBon = true;
	if (id == null || id.equals(null) || id == "" || id.equals("")) {
		toutEstBon = false;
	}else {
		if(!id.equals("Jonathan") && !id.equals("Manon") && !id.equals("Arnaud")) {
			toutEstBon = false;
		}
	}
	if (tel == null || tel.equals(null) || tel == "" || tel.equals("")) {
		toutEstBon = false;
	}else {
		if(!tel.equals("0000000000") && !tel.equals("0605436459") && !tel.equals("0679065306")) {
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
			<nav class="navbar fixed-top navbar-light" style="background-color: #1b5873; color: #ecedf1; height: 60px; border-bottom: 3px solid rgba(0,0,0,.6);">
  				<p class="navbar-brand" style="color: #ecedf1;">Hello <%= id %>!</p>
  				<a style="color: #ecedf1;margin-top:-10px;" href="?deconnexion=ok">Sign out</a>
			</nav>
	<%
		String param = request.getParameter("deconnexion");
		if (param != null && !param.equals(null)) {
			if (param.equals("ok")) {
				s.invalidate();
				response.sendRedirect("index.jsp");
			}
		}
			
	%>
	<%
		String param2 = request.getParameter("mail");
		if (param2 != null && !param2.equals(null)) {
			if (param2.equals("sent")) {%>
				<script>alert('E-mail sent to users!');</script><%
			}
		}
		%>
				
			<%
				String[] allUsers = null;
				String[] allLocations = null;
				String cptUserRound = "";
				int cptUser = 0;
				URL url = new URL("https://unow-api.herokuapp.com/user/");
				HttpURLConnection connection = null;
				connection = (HttpURLConnection) url.openConnection();
				connection.setRequestMethod("GET");
				int responseRequest = connection.getResponseCode();
				System.out.println("Reponse code = " + responseRequest);
				if (responseRequest == HttpURLConnection.HTTP_OK) {
					BufferedReader in = new BufferedReader(new InputStreamReader(
							connection.getInputStream()));
					String inputLine;
					StringBuffer r = new StringBuffer();
					while ((inputLine = in.readLine()) != null) {
						r.append(inputLine);
					}
					in.close();
					allUsers = r.toString().split("[{}]");
					int j = 0;
					for(int i = 0; i < allUsers.length; i++) {
						if(i%2 != 0) {
							cptUser = cptUser + 1;
						}
					}
					allLocations = new String[cptUser];
					for(int i = 0; i < allUsers.length; i++) {
						if(i%2 != 0) {
							allLocations[j] = allUsers[i].split("\"")[21];
							j++;
						}
					}
					cptUserRound = String.format("%02d", cptUser);
				}
				String[] allResponse = null;
				String localisations = "";
				for(int i = 0; i < allLocations.length; i++) {
					URL url4 = new URL("https://maps.googleapis.com/maps/api/geocode/json?address="+allLocations[i].replace(' ', '+')+ "&key=AIzaSyA8SvAVaMT42kzUbjLTc2ReI8TIUAtmIzs");
					HttpURLConnection connection4 = null;
					connection4 = (HttpURLConnection) url4.openConnection();
					connection4.setRequestMethod("GET");
					int responseRequest4 = connection4.getResponseCode();
					System.out.println("Reponse code = " + responseRequest4);
					if (responseRequest4 == HttpURLConnection.HTTP_OK) {
						BufferedReader in = new BufferedReader(new InputStreamReader(
								connection4.getInputStream()));
						String inputLine;
						StringBuffer r = new StringBuffer();
						while ((inputLine = in.readLine()) != null) {
							r.append(inputLine);
						}
						in.close();
						allResponse = r.toString().split("[{}]");
						for(int j = 0; j < allResponse.length; j++) {
							if(allResponse[j].contains("lng") && allResponse[j].contains("lat")) {
								localisations = localisations + "{ lat:" + allResponse[j].split(",")[0].split(":")[1] + ", lng:" + allResponse[j].split(",")[1].split(":")[1] + "},";
								j = j + 15;
							}
						}
					}
				}
			%>
			
						<%
				String[] allActivities = null;
				String cptActivitiesRound = "";
				String[] allLikes = null;
				String cptLikesRound = "";
				int cptActivities = 0;
				int cptLikes = 0;
				URL url2 = new URL("https://unow-api.herokuapp.com/activity/");
				HttpURLConnection connection2 = null;
				connection2 = (HttpURLConnection) url2.openConnection();
				connection2.setRequestMethod("GET");
				int responseRequest2 = connection2.getResponseCode();
				System.out.println("Reponse code = " + responseRequest2);
				if (responseRequest2 == HttpURLConnection.HTTP_OK) {
					BufferedReader in = new BufferedReader(new InputStreamReader(
							connection2.getInputStream()));
					String inputLine;
					StringBuffer r = new StringBuffer();
					while ((inputLine = in.readLine()) != null) {
						r.append(inputLine);
					}
					in.close();
					allActivities = r.toString().split("[{}]");
					for(int i = 1; i < allActivities.length; i++) {
						if(i%4 == 0) {
							cptActivities = cptActivities + 1;
							String tmp = allActivities[i-1].split("\"")[14].replace(':', '0');
							cptLikes += Integer.parseInt(tmp.substring(0, tmp.length()-1));
						}
							
					}
					cptActivitiesRound = String.format("%02d", cptActivities);
					cptLikesRound = String.format("%02d", cptLikes);
				}
			%>
			
			<%
				String[] allFS = null;
				String cptFSRound = "";
				int cptFS = 0;
				URL url3 = new URL("https://unow-api.herokuapp.com/friendShip/");
				HttpURLConnection connection3 = null;
				connection3 = (HttpURLConnection) url3.openConnection();
				connection3.setRequestMethod("GET");
				int responseRequest3 = connection3.getResponseCode();
				System.out.println("Reponse code = " + responseRequest3);
				if (responseRequest3 == HttpURLConnection.HTTP_OK) {
					BufferedReader in = new BufferedReader(new InputStreamReader(
							connection3.getInputStream()));
					String inputLine;
					StringBuffer r = new StringBuffer();
					while ((inputLine = in.readLine()) != null) {
						r.append(inputLine);
					}
					in.close();
					allFS = r.toString().split("[{}]");
					for(int i = 1; i < allFS.length; i++) {
						if(i%6 == 0) {
							cptFS = cptFS + 1;
						}
					}
					cptFSRound = String.format("%02d", cptFS);
				}
			%>
	
			<div class="container-fluid" style="width: 100%; height: 200px; margin: 60px auto; margin-bottom: 0px; background-color: #e2f1fa;">
				<h1 style="color: #1b5873; margin-left: 160px; line-height: 120px; text-shadow: 1px 1px 1px rgba(0,0,0,.4); font-family: 'Calibri';">Welcome to your One-Page-Panel.</h1>
				<img style="height: 150px; width: auto; float: left; margin-top:-100px; margin-left: 60px;"src="img/logo2.png"/>
				<p style="font-style: italic; color: rgba(0,0,0,.7); font-family:'Calibri'; margin-top: -25px;margin-left: 165px; font-size: 20px;">Here you can manage a TODO List, view numbers about uNow, see where users are located in the world and send e-mail notifications to them.</p>
			</div>
			
			<div class="container-fluid" style="width: 100%; height: 400px; margin: 0px; margin-bottom: 0px; background-color: white;">
				<h1 style="color: #26a491; margin-left: 160px; line-height: 120px; text-shadow: 1px 1px 1px rgba(0,0,0,.4); font-family: 'Calibri';">Live statistics about...</h1>			
				<div class="row">
					<div class="col-lg-3">
						<h4 style="text-align: center;">Total of Users</h4>
						<div class="rond">
							<h2 style="font-size: 7rem; color: white; text-shadow: 3px 3px 2px rgba(0,0,0,.4);text-align: center;"><%= cptUserRound %></h2>
						</div>
					</div>
					<div class="col-lg-3">
						<h4 style="text-align: center;">Total of Activities</h4>
						<div class="rond">
							<h2 style="font-size: 7rem; color: white; text-shadow: 3px 3px 2px rgba(0,0,0,.4);text-align: center;"><%= cptActivitiesRound %></h2>
						</div>
					</div>
					<div class="col-lg-3">
						<h4 style="text-align: center;">Total of Likes</h4>
						<div class="rond">
							<h2 style="font-size: 7rem; color: white; text-shadow: 3px 3px 2px rgba(0,0,0,.4);text-align: center;"><%= cptLikes %></h2>
						</div>
					</div>
					<div class="col-lg-3">
						<h4 style="text-align: center;">Total of Friendships</h4>
						<div class="rond">
							<h2 style="font-size: 7rem; color: white; text-shadow: 3px 3px 2px rgba(0,0,0,.4);text-align: center;"><%= cptFSRound %></h2>
						</div>
					</div>
				</div>
				<h6 style="text-align: center; margin-top: 30px;">One user approximately has <span style="color:#26a491;"><%= Double.valueOf(cptActivities)/Double.valueOf(cptUser) %></span> activities, <span style="color:#26a491;"><%= Double.valueOf(cptLikes)/Double.valueOf(cptUser) %></span> likes and <span style="color:#26a491;"><%= Double.valueOf(cptFS)/Double.valueOf(cptUser) %></span> friendships.</h6>
			</div>
			
			<div class="container-fluid" style="width: 100%; height: 460px; margin: 0px; margin-bottom: 0px; background-color: #26a491;">
				<div id="map"></div>
    		<script>
     			var map;
      			function initMap() {
        		map = new google.maps.Map(document.getElementById('map'), {
          		center: {lat: 40.8246741, lng: 5.1308245},
          		zoom: 3
        		});

                var labels = 'UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU';

                var markers = locations.map(function(location, i) {
                  return new google.maps.Marker({
                    position: location,
                    label: labels[i % labels.length]
                  });
                });

                // Add a marker clusterer to manage the markers.
                var markerCluster = new MarkerClusterer(map, markers,
                    {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
              }
              var locations = [
            	<%= localisations %>
              ]
    			</script>
    			<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA8SvAVaMT42kzUbjLTc2ReI8TIUAtmIzs&callback=initMap"
    			async defer></script>
				<i style="color:white; margin-top: 10px;"><center>Users around the world ("U")</center></i>
			</div>

			<div class="container-fluid" style="width: 100%; height: auto,; margin: 0px; margin-bottom: 0px; background-color: #1b5873;">
				<h1 style="color: white; margin-left: 160px; line-height: 120px; text-shadow: 1px 1px 1px rgba(0,0,0,.4); font-family: 'Calibri';">E-mail notification</h1>
				 <form method=POST action=SendEmail style="width:75%;margin: 0 auto;">
				 	<div class="form-group">
    				<label for="mail" style="color: white;">What do you want to say?</label>
    				<textarea class="form-control" style="height: 250px;" name=mail id="exampleFormControlTextarea1" rows="3"></textarea>
  					</div>
  					<button type="submit" class="btn btn-light mb-2">Send e-mail to all</button>
				</form>
			</div>
			
			<div class="container-fluid" style="width: 100%; height: auto,; margin: 0px; margin-bottom: 0px; background-color: #34495e;">
				<h1 style="color: white; margin-left: 160px; line-height: 120px; text-shadow: 1px 1px 1px rgba(0,0,0,.4); font-family: 'Calibri';">ToDo List</h1>
				 <form method=POST action=ToDoList?addTask=ok style="width:75%;margin: 0 auto;">
				 	<div class="form-group">
    				<label for="mail" style="color: white;">Add a new task</label>
    				<input type=text class="form-control" name=task id="exampleFormControlTextarea1"/>
  					</div>
  					<button type="submit" class="btn btn-light mb-2">Add</button>
				</form>
				<div class="row" style="margin-left: 160px; margin-right: 100px;">
				<%
					BufferedReader br = new BufferedReader(new FileReader("C:\\Users\\Arnaud\\git\\repository\\uNowAdmin\\WebContent\\tasks.txt"));
					try {
				    	StringBuilder sb = new StringBuilder();
				    	String line = br.readLine();
						int i = 0;
				    	while (line != null) {
				    		i = i + 1;
				    		String sentence = "";
				    		sentence = line;
				        	sb.append(line);
				        	sb.append(System.lineSeparator());
				        	line = br.readLine();
				        	%>
				        	<div class="col-lg-4">
								<form method=POST action=ToDoList?remove=<%= i %> style="width:75%;margin: 0 auto;">
					 			<div class="form-group">
	    						<p style="color: white; font-size: 20px; font-family: 'Calibri'; text-align: center;"><%= sentence %></p>
	    						<input type=text class="form-control" name=<%= i %> id="exampleFormControlTextarea1" style="display: none;"/>
	  							</div>
	  							<center><button type="submit" class="btn btn-light mb-2">Done</button></center>
								</form>
							</div>
				        	<%
				    	}	
					} finally {
				    	br.close();
					}
				%>

				</div>
			</div>
		
		<%
	}
%>
</body>
</html>