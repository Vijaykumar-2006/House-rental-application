import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class VisitCounterServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get or create session
        HttpSession session = request.getSession(true);

        // Get visit count
        Integer visitCount = (Integer) session.getAttribute("visitCount");

        if (visitCount == null) {
            visitCount = 1;
        } else {
            visitCount++;
        }

        // Save count back to session
        session.setAttribute("visitCount", visitCount);

        // Display result
        out.println("<html><body>");
        out.println("<h2>Welcome to the site!</h2>");
        out.println("<p>You have visited this page <strong>" + visitCount + "</strong> times in this session.</p>");
        out.println("</body></html>");
    }
}
