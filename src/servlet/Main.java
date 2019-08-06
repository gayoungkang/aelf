package servlet;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ContentInfoModel;
import model.NewsInfoModel;
import model.NoticeInfoModel;
import model.UserLogModel;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import dao.AelfDAO;
import util.CheckMobile;

/**
 * Servlet implementation class Main
 */
@WebServlet("/main.lf")
public class Main extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Main() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		
		// IP 파악
		String ip = request.getHeader("X-FORWARDED-FOR");
		if(ip == null || ip.length() == 0)
			ip = request.getHeader("Proxy-Client-IP");
		
		if(ip == null || ip.length() == 0)
			ip = request.getHeader("WL-Proxy-Client-IP");
		
		if(ip == null || ip.length() == 0)
			ip = request.getRemoteAddr();
		
		// 이전 유입 경로 null 이면 URL 직접 입력
		String prevLink = request.getHeader("REFERER");
		
		
		boolean bMobile = //true; 
				CheckMobile.isMobile(request.getHeader("user-agent"));
		
		
		if("0:0:0:0:0:0:0:1".equals(ip))
			ip = "61.74.211.1";
		
		UserLogModel ul = (UserLogModel) session.getAttribute("user_log");
		if(ul == null){
			UserLogModel userLog = new UserLogModel();
			userLog.setUlIp(ip);
			userLog.setUlPrevLink(prevLink);
			
			if(bMobile)
				userLog.setUlDevice("모바일");
			else
				userLog.setUlDevice("웹");
			
			try {
				URL url = new URL("http://ip-api.com/json/"+ip);
				
				InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
				
				JSONObject obj = null;
			
				obj = (JSONObject)JSONValue.parseWithException(isr);
				userLog.setUlCountry(obj.get("country").toString());
				userLog.setUlCity(obj.get("city").toString());
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			AelfDAO aDao = new AelfDAO();
			aDao.insertUserLog(userLog);
			session.setAttribute("user_log", userLog);
			
		}
		
		
		AelfDAO aDao = new AelfDAO();
		
		if(bMobile) {
			List<NoticeInfoModel> listNI = aDao.selectListNoticeInfoForMain(4);
			List<ContentInfoModel> listCI = aDao.selectListContentInfoForMain(4);
			List<NewsInfoModel> listNews = aDao.selectListNewsInfoForMain(3);
			
			request.setAttribute("listNI", listNI);
			request.setAttribute("listCI", listCI);
			request.setAttribute("listNews", listNews);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/mobile/m_main.jsp");
			dispatcher.forward(request, response);
		}
		else {
			List<NoticeInfoModel> listNI = aDao.selectListNoticeInfoForMain(12);
			List<ContentInfoModel> listCI = aDao.selectListContentInfoForMain(12);
			List<NewsInfoModel> listNews = aDao.selectListNewsInfoForMain(12);
			
			request.setAttribute("listNI", listNI);
			request.setAttribute("listCI", listCI);
			request.setAttribute("listNews", listNews);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/main.jsp");
			dispatcher.forward(request, response);			
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		
		String mode = request.getParameter("mode");
		
		if("alarm_read".equals(mode)) {
			int aiNo = Integer.parseInt(request.getParameter("ai_no"));
			int uiNo = Integer.parseInt(request.getParameter("ui_no"));
			
			AelfDAO aDao = new AelfDAO();
			aDao.insertAlarmRead(aiNo, uiNo);
		}
	}

}
