package servlet;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.text.NumberFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import util.CheckMobile;
import util.PageNavigator;
import dao.AelfDAO;
import model.ContentInfoModel;
import model.NewsInfoModel;
import model.NoticeInfoModel;
import model.UserLogModel;

/**
 * Servlet implementation class Contents
 */
@WebServlet("/contents.lf")
public class Contents extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Contents() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();

		// IP 파악
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null || ip.length() == 0)
			ip = request.getHeader("Proxy-Client-IP");

		if (ip == null || ip.length() == 0)
			ip = request.getHeader("WL-Proxy-Client-IP");

		if (ip == null || ip.length() == 0)
			ip = request.getRemoteAddr();

		// 이전 유입 경로 null 이면 URL 직접 입력
		String prevLink = request.getHeader("REFERER");

		boolean bMobile = CheckMobile.isMobile(request.getHeader("user-agent"));

		if ("0:0:0:0:0:0:0:1".equals(ip))
			ip = "61.74.211.1";

		UserLogModel ul = (UserLogModel) session.getAttribute("user_log");
		if (ul == null) {
			UserLogModel userLog = new UserLogModel();
			userLog.setUlIp(ip);
			userLog.setUlPrevLink(prevLink);

			if (bMobile)
				userLog.setUlDevice("모바일");
			else
				userLog.setUlDevice("웹");
			try {
				URL url = new URL("http://ip-api.com/json/" + ip);

				InputStreamReader isr = new InputStreamReader(url
						.openConnection().getInputStream(), "UTF-8");

				JSONObject obj = null;

				obj = (JSONObject) JSONValue.parseWithException(isr);
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

		String mode = request.getParameter("mode");

		if (mode == null || "".equals(mode))
			mode = "list";

		if ("list".equals(mode)) {
			String gubun = request.getParameter("gubun");
			String pageNum = request.getParameter("pageNum");
			
			if (gubun == null)
				gubun = "total";
			
			if(pageNum == null)
				pageNum = "1";
			
			ContentInfoModel ci = new ContentInfoModel();
			ci.setCcName(gubun);
			ci.setPageNum(pageNum);
			
			AelfDAO aDao = new AelfDAO();
			List<ContentInfoModel> listCI = aDao
					.selectListContentInfoForMobile(ci);
			
			String addParam = "&menu=contents&gubun=" + gubun;
			int totalCount = aDao.selectCountContent(ci);
			
			
			request.setAttribute("gubun", gubun);
			request.setAttribute("listCI", listCI);

			if (bMobile) {
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigatorMobile("contents.lf", totalCount, ci.getListCount(), ci.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("/WEB-INF/jsps/mobile/m_contents_list.jsp");
				dispatcher.forward(request, response);
			} else {
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("contents.lf", totalCount, ci.getListCount(), ci.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("/WEB-INF/jsps/contents/contents_list.jsp");
				dispatcher.forward(request, response);
			}
		} else if ("view".equals(mode)) {
			int ciNo = Integer.parseInt(request.getParameter("ci_no"));

			AelfDAO aDao = new AelfDAO();
			ContentInfoModel ci = aDao.selectContentInfo(ciNo);

			String viewCheck = (String) session.getAttribute("ci_" + ciNo);

			if (viewCheck == null) {
				aDao.updateContentView(ciNo, ci.getCiView() + 1);
				ci.setCiView(ci.getCiView() + 1);
				session.setAttribute("ci_" + ciNo, "1");
			}

			int reNiNo = -1;
			int reCiNo = ciNo;
			int reNewsNo = -1;

			NoticeInfoModel reNi = aDao.selectNoticeInfoRecently(reNiNo);
			ContentInfoModel reCi = aDao.selectContentInfoRecently(reCiNo);
			NewsInfoModel reNewsInfo = aDao.selectNewsInfoRecently(reNewsNo);

			request.setAttribute("reNi", reNi);
			request.setAttribute("reCi", reCi);
			request.setAttribute("reNewsInfo", reNewsInfo);
			request.setAttribute("ci", ci);

			if (bMobile) {
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("/WEB-INF/jsps/mobile/m_contents_view.jsp");
				dispatcher.forward(request, response);
			} else {
				RequestDispatcher dispatcher = request
						.getRequestDispatcher("/WEB-INF/jsps/contents/contents_view.jsp");
				dispatcher.forward(request, response);
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();

		int ciNo = Integer.parseInt(request.getParameter("ci_no"));
		String videoCheck = request.getParameter("video_check");

		AelfDAO aDao = new AelfDAO();
		ContentInfoModel ci = aDao.selectContentInfo(ciNo);

		String viewCheck = (String) session.getAttribute("ci_" + ciNo);
		if (viewCheck == null) {
			aDao.updateContentView(ciNo, ci.getCiView() + 1);
			ci.setCiView(ci.getCiView() + 1);
			session.setAttribute("ci_" + ciNo, "1");
		}

		NumberFormat nf = NumberFormat.getInstance();

		JSONObject obj = new JSONObject();
		obj.put("ciTitle", ci.getCiTitle());
		obj.put("ciDate", ci.getCiDate().substring(2, 4) + "."
				+ ci.getCiDate().substring(5, 7) + "."
				+ ci.getCiDate().substring(8, 10));
		obj.put("ciView", nf.format(ci.getCiView()));
		obj.put("ciContent", ci.getCiContent());

		if (videoCheck != null) {
			obj.put("ciVideo",
					"http://youtube.com/embed/"
							+ ci.getCiLink().substring(
									ci.getCiLink().indexOf("v=") + 2,
									ci.getCiLink().indexOf("v=") + 13));
			obj.put("ciLink", ci.getCiLink());
		}

		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
	}

}
