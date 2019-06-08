package compte;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Connexion
 */
@WebServlet("/Connexion")
public class Connexion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Connexion() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String tel = req.getParameter("inputTel");
		String mdp = req.getParameter("inputPassword");
		String[] allUsers = null;
		boolean toutEstBon = true;
		System.out.println("Données récupérées.");
		
		if(tel == null || tel.equals(null) || tel == "" || tel.equals("") ) {
			toutEstBon = false;
		}		
		if(mdp == null || mdp.equals(null) || mdp == "" || mdp.equals("") ) {
			toutEstBon = false;
		}
		
		if(toutEstBon) {
			System.out.println("No data missing.");
			URL url = new URL("https://unow-api.herokuapp.com/user/");
			HttpURLConnection connection = null;
			connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");
			int responseRequest = connection.getResponseCode();
			System.out.println("Reponse code = " + responseRequest);
			if (responseRequest == HttpURLConnection.HTTP_OK) { // success
				BufferedReader in = new BufferedReader(new InputStreamReader(
						connection.getInputStream()));
				String inputLine;
				StringBuffer response = new StringBuffer();
				while ((inputLine = in.readLine()) != null) {
					response.append(inputLine);
				}
				in.close();
				allUsers = response.toString().split("[{}]");
				String nom = "";
				for(int i = 0; i < allUsers.length; i++) {
					if(i%2 != 0) {
						if(allUsers[i].contains(mdp) && allUsers[i].contains(tel)) {
							System.out.println("You are log in !");
							HttpSession session = req.getSession( true );
							nom = allUsers[i].split("\"")[5];
							System.out.println(nom);
							session.setAttribute("name", nom);
							res.sendRedirect("admin.jsp");
						}
					}
				}
				if(nom == "") {
					res.sendRedirect("index.jsp?error=co");
				}
			}
			else {
				System.out.println("GET request not worked");
			}

		}
	}
}
