package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.CheckMobile;
import model.UserInfoModel;
import dao.AelfDAO;

/**
 * Servlet implementation class Login
 */
@WebServlet(description = "로그인 및 회원가입", urlPatterns = { "/login.lf" })
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String menu = request.getParameter("menu");
		
		boolean bMobile = CheckMobile.isMobile(request.getHeader("user-agent"));
		
		/// 로그인 화면
		if("login".equals(menu)) {
			if(bMobile) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/mobile/m_login.jsp");
				dispatcher.forward(request, response);	
			}
			else {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/login/login.jsp");
				dispatcher.forward(request, response);				
			}
		}
		
		/// 가입 화면
		else if("signup".equals(menu)) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/login/signup.jsp");
			dispatcher.forward(request, response);
		}
		
		/// 가입 성공 화면
		else if("success".equals(menu)) {
			if(bMobile) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/mobile/m_success.jsp");
				dispatcher.forward(request, response);	
			}
			else {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/login/success.jsp");
				dispatcher.forward(request, response);
			}
		}
		
		//// 가입후 로그인 처리
		else if("success_login".equals(menu)) {
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			
			AelfDAO aDao = new AelfDAO();
			
			UserInfoModel userInfo = new UserInfoModel();
			userInfo.setUiId(id);
			userInfo.setUiName(name);
			
			userInfo = aDao.selectUserInfo(userInfo);
			
			if(userInfo.getUiNo()>0) {
				HttpSession session = request.getSession();
				session.setAttribute("userInfo", userInfo);
				
				response.sendRedirect("main.lf");
			}
			else {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.print("<script> window.alert('로그인할 수 없습니다. 아이디와 비밀번호를 확인해 주세요.'); history.go(-1); </script>");
			}
		}
		
		/// 로그아웃 처리
		else if("logout".equals(menu)) {
			String url = request.getParameter("url");
			
			HttpSession session = request.getSession();
			session.invalidate();
			
			response.sendRedirect(url);
		}
		
		/// 모바일 알람 화면
		else if("alarm".equals(menu)) {
			if(bMobile) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/mobile/m_alarm.jsp");
				dispatcher.forward(request, response);	
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		
		String mode = request.getParameter("mode");
		
		/// 로그인 처리
		/*
		if("login".equals(mode)) {
			String url = request.getParameter("url");		// 로그인 성공 시 넘길 URL
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			if("aelf".equals(id) && "12345".equals(pw)) {
				HttpSession session = request.getSession();
				session.setAttribute("user_name", "김성재");
				
				response.sendRedirect(url);
			}
			else {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.print("<script> window.alert('로그인할 수 없습니다. 아이디와 비밀번호를 확인해 주세요.'); history.go(-1); </script>");
			}			
		}
		*/
		if("login".equals(mode)) {
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			
			AelfDAO aDao = new AelfDAO();
			
			UserInfoModel userInfo = new UserInfoModel();
			userInfo.setUiId(id);
			userInfo.setUiName(name);
			
			userInfo = aDao.selectUserInfo(userInfo);
			
			if(userInfo.getUiNo()>0) {
				HttpSession session = request.getSession();
				session.setAttribute("userInfo", userInfo);
				
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.print("[true]");
			}
			else {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.print("[false]");
			}
		}
		
		else if("signup".equals(mode)) {
			String id = request.getParameter("u_id");
			String name = request.getParameter("u_name");
			String profile = request.getParameter("u_profile");
			String bt1 = request.getParameter("bt1");
			String bt2 = request.getParameter("bt2");
			String bt3 = request.getParameter("bt3");
			String bt4 = request.getParameter("bt4");
			String bt5 = request.getParameter("bt5");
			String bt6 = request.getParameter("bt6");
			String bt7 = request.getParameter("bt7");
			String bt8 = request.getParameter("bt8");
			
			String infollow = "";
			if("1".equals(bt1))			infollow = "facebook";
			else if("1".equals(bt2))	infollow = "instagram";
			else if("1".equals(bt3))	infollow = "naver";
			else if("1".equals(bt4))	infollow = "search";
			else if("1".equals(bt5))	infollow = "youtube";
			else if("1".equals(bt6))	infollow = "twitter";
			else if("1".equals(bt7))	infollow = "news";
			else if("1".equals(bt8))	infollow = "recommend";
			
			UserInfoModel userInfo = new UserInfoModel();
			userInfo.setUiId(id);;
			userInfo.setUiName(name);
			userInfo.setUiInfollow(infollow);
			userInfo.setUiProfile(profile);
			
			AelfDAO aDao = new AelfDAO();
			aDao.insertUserInfo(userInfo);
			
			response.sendRedirect("login.lf?menu=success&id="+id+"&name="+URLEncoder.encode(name, "UTF-8"));
		}
		
	}

}
