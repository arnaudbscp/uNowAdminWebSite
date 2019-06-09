package traitement;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ToDoList
 */
@WebServlet("/ToDoList")
public class ToDoList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String FILE_PATH = "C:\\Users\\Arnaud\\git\\repository\\uNowAdmin\\WebContent\\tasks.txt";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ToDoList() {
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
    		if(req.getParameter("addTask") != null && req.getParameter("addTask").equals("ok")) {
    			try(PrintWriter output = new PrintWriter(new FileWriter(FILE_PATH,true))) 
    			{
    			    output.printf(System.lineSeparator(), req.getParameter("task"));
    			} 
    			catch (Exception e) {}	
    		}else {
    			if(req.getParameter("remove") != null && req.getParameter("remove").matches("[0-9]+")) {
    			int numberLine = Integer.parseInt(req.getParameter("remove"));
    			BufferedReader br = new BufferedReader(new FileReader(FILE_PATH));
    			String line = br.readLine();
    			StringBuilder sb = new StringBuilder();
    			try {
			    	while (line != null) {
				        sb.append(line);
				        sb.append(System.lineSeparator());
				        line = br.readLine();
			    	}
				} finally {
			    	br.close();
				}
    			String text = sb.toString();
    			String[] lines = text.split(System.lineSeparator());
    			for(int i = 1; i <= lines.length; i++) {
    			    if(i == numberLine){
    			        lines[i-1]="";
    			    }
    			}
    			StringBuilder finalStringBuilder= new StringBuilder("");
    			for(String t :lines){
    			   if(!t.equals("")){
    			       finalStringBuilder.append(t).append(System.getProperty("line.separator"));
    			    }
    			}
    			String finalString = finalStringBuilder.toString();
    			try {
    				System.out.println(sb.toString());
    				FileWriter fw = new FileWriter(FILE_PATH, false);
    				fw.write(finalString);
    				fw.close();
    			} catch (IOException e) {
    				e.printStackTrace();
    			} 
    			}
    		}
    		res.sendRedirect("admin.jsp");
    	}
    }

}
