package omok;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class waitingRoom
 */
@WebServlet("/waitingRoom")
public class waitingRoom extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset-utf-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		// servlet에서 구현 : 클릭한 상대방에게 요청하여 요청 받은 상대방이 요청 수락시 상대방과 game.jsp로 리다이렉트
		// 요청 거절시 다시 waitingRoom.jsp로 포워딩
	}

}
