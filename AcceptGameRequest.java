package omok;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AcceptGameRequest
 */
@WebServlet("/acceptGameRequest")
public class AcceptGameRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opponentId = request.getParameter("opponentId");
		HttpSession session = request.getSession();
        String currentUserId = (String) session.getAttribute("currentUserId");
        
        // 사용자에게 돌 할당
        session.setAttribute("playerO", currentUserId);
        session.setAttribute("playerX", opponentId);
        session.setAttribute("gameStarted", true);
        
        response.sendRedirect("game.jsp");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
