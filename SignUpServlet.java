package omok;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 * Servlet implementation class signUp
 */
@WebServlet("/signUp")
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset-utf-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String user_id = request.getParameter("user_id");
		String user_pwd = request.getParameter("user_pwd");
		String user_nickname = request.getParameter("user_nickname");
		
		MemberVO memberVO = new MemberVO();
		MemberDAO dao = new MemberDAO();
		memberVO.setId(user_id);
		memberVO.setPwd(user_pwd);
		memberVO.setNickname(user_nickname);
	
		boolean result = dao.isExisted(memberVO);
		
		if(!result){
			dao.signUpMember(memberVO);
			HttpSession session = request.getSession();
			session.setAttribute("user_id", user_id);
			session.setAttribute("user_pwd", user_pwd);
			session.setAttribute("user_nickname", user_nickname);
			response.sendRedirect("main1.jsp");
		} else{
            request.setAttribute("errorMessage", "이미 존재하는 계정입니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("signUp.jsp");
            dispatcher.forward(request, response);
        }	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
