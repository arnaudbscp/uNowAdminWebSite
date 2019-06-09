package traitement;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sendgrid.Content;
import com.sendgrid.Email;
import com.sendgrid.Mail;
import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.Response;
import com.sendgrid.SendGrid;

/**
 * Servlet implementation class SendEmail
 */
@WebServlet("/SendEmail")
public class SendEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static String SENDGRID_API_KEY = "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";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendEmail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    	HttpSession s = req.getSession(false);
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
    	if(toutEstBon) {
    		this.sendAnEmail(req.getParameter("mail"));
    		res.sendRedirect("admin.jsp?mail=sent");
    	}
    }
	
	public void sendAnEmail(String email) throws IOException {
		String[] allUsers = null;
		String[] allEmails = null;
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
			allEmails = new String[cptUser];
			for(int i = 0; i < allUsers.length; i++) {
				if(i%2 != 0) {
					allEmails[j] = allUsers[i].split("\"")[13];
					j++;
				}
			}
		}
		for(int i = 0; i < allEmails.length; i++) {
			 Email from = new Email(allEmails[i]);
			 String subject = "There are some news on uNow !!";
			 Email to = new Email("arnaudbcp@gmail.com");
			 Content content = new Content("text/plain", email);
			 Mail mail = new Mail(from, subject, to, content);
	
			 SendGrid sg = new SendGrid(SENDGRID_API_KEY);
			 Request request = new Request();
			 try {
			      request.setMethod(Method.POST);
			      request.setEndpoint("mail/send");
			      request.setBody(mail.build());
			      Response response = sg.api(request);
			      System.out.println(response.getStatusCode());
			      System.out.println(response.getBody());
			      System.out.println(response.getHeaders());
			 } catch (IOException ex) {
			    	try {
			    		throw ex;
			    	} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
			    	}	
			 }
		}
	}

}
