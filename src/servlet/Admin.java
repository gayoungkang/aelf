package servlet;


import java.io.IOException;


import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import util.PageNavigator;
import dao.AelfDAO;
import model.AlarmInfoModel;
import model.CalendarInfoModel;
import model.ContentCodeModel;
import model.ContentInfoModel;
import model.DebateInfoModel;
import model.NewsInfoModel;
import model.NoticeInfoModel;
import model.PetitionInfoModel;
import model.UserLogModel;

/**
 * Servlet implementation class Admin
 */
@WebServlet(name = "admin.lf", urlPatterns = { "/admin.lf" })
public class Admin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String menu = request.getParameter("menu");
		if(menu == null) {
			menu = "admin_log";
		}
		
		HttpSession session = request.getSession();
		String adminLogin = (String) session.getAttribute("admin");
		
		if(adminLogin == null) {
			menu = "login";
		}
		
		if("login".equals(menu)) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_login.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_log".equals(menu)){
			String date = request.getParameter("date");
			String pageNum = request.getParameter("pageNum");
			
			if(date == null){
				Calendar cal = Calendar.getInstance();
				date = String.format("%04d-%02d-%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1, cal.get(Calendar.DAY_OF_MONTH));
			}
			
			if(pageNum == null)
				pageNum = "1";
			
			UserLogModel ul = new UserLogModel();
			ul.setPageNum(pageNum);
			ul.setUlDate(date);
			
			AelfDAO aDao = new AelfDAO();
			
			List<UserLogModel> listUL = aDao.selectListUserLog(ul);
			int totalCount = aDao.selectCountListUserLog(ul);
			
			String addParam = "&date="+date;
			
			request.setAttribute("ul", ul);
			request.setAttribute("listUL", listUL);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("date", date);
			request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin.lf", totalCount, ul.getListCount(), ul.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_log.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_notice".equals(menu)){
			String pageNum = request.getParameter("pageNum");
			
			if(pageNum == null)
				pageNum = "1";
			
			NoticeInfoModel ni = new NoticeInfoModel();
			ni.setPageNum(pageNum);
			
			AelfDAO aDao = new AelfDAO();
			List<NoticeInfoModel> listNI = aDao.selectListNoticeInfo(ni);
			int totalCount = aDao.selectCountListNoticeInfo(ni);
			
			String addParam = "&menu=admin_notice";
			
			request.setAttribute("ni", ni);
			request.setAttribute("listNI", listNI);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin.lf", totalCount, ni.getListCount(), ni.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_notice.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_notice_write".equals(menu)){
			
			// 업로드 경로 설정
			//HttpSession session = request.getSession();
			session.setAttribute("filePathRoad", "upload/notice");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_notice_write.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_notice_view".equals(menu)){
			int niNo = Integer.parseInt(request.getParameter("ni_no"));
			
			AelfDAO aDao = new AelfDAO();
			NoticeInfoModel ni = aDao.selectNoticeInfo(niNo);
			
			request.setAttribute("ni", ni);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_notice_view.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_notice_modify".equals(menu)){
			int niNo = Integer.parseInt(request.getParameter("ni_no"));
			
			AelfDAO aDao = new AelfDAO();
			NoticeInfoModel ni = aDao.selectNoticeInfo(niNo);
			
			request.setAttribute("ni", ni);
			
			// 업로드 경로 설정
			//HttpSession session = request.getSession();
			session.setAttribute("filePathRoad", "upload/notice");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_notice_modify.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_news".equals(menu)){
			String pageNum = request.getParameter("pageNum");
			
			if(pageNum == null)
				pageNum = "1";
			
			NewsInfoModel newsInfo = new NewsInfoModel();
			newsInfo.setPageNum(pageNum);
			
			AelfDAO aDao = new AelfDAO();
			List<NewsInfoModel> listNews = aDao.selectListNewsInfo(newsInfo);
			int totalCount = aDao.selectCountListNewsInfo(newsInfo);
			
			String addParam = "&menu=admin_news";
			
			request.setAttribute("newsInfo", newsInfo);
			request.setAttribute("listNews", listNews);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin.lf", totalCount, newsInfo.getListCount(), newsInfo.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_news.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_news_write".equals(menu)){
			
			// 업로드 경로 설정
			//HttpSession session = request.getSession();
			session.setAttribute("filePathRoad", "upload/news");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_news_write.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_news_view".equals(menu)){
			int newsNo = Integer.parseInt(request.getParameter("news_no"));
			
			AelfDAO aDao = new AelfDAO();
			NewsInfoModel newsinfo = aDao.selectNewsInfo(newsNo);
			
			request.setAttribute("newsInfo", newsinfo);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_news_view.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_news_modify".equals(menu)){
			// 업로드 경로 설정
			//HttpSession session = request.getSession();
			session.setAttribute("filePathRoad", "upload/news");
			
			int newsNo = Integer.parseInt(request.getParameter("news_no"));
			
			AelfDAO aDao = new AelfDAO();
			NewsInfoModel newsInfo = aDao.selectNewsInfo(newsNo);
			
			request.setAttribute("newsInfo", newsInfo);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_news_modify.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_content".equals(menu)){
			String pageNum = request.getParameter("pageNum");
			if(pageNum == null)
				pageNum = "1";
			
			AelfDAO aDao = new AelfDAO();
			List<ContentCodeModel> listCC = aDao.selectListContentCode();
			
			String ccNo = request.getParameter("cc_no");
			if(ccNo == null){
				if(listCC.size()>0)
					ccNo = listCC.get(0).getCcNo()+"";
				else
					ccNo = "1";
			}
			
			ContentInfoModel ci = new ContentInfoModel();
			ci.setPageNum(pageNum);
			ci.setCcNo(Integer.parseInt(ccNo));
			
			
			List<ContentInfoModel> listCI = aDao.selectListContentInfo(ci);
			int totalCount = aDao.selectCountListContentInfo(ci);
			
			String addParam = "&menu=admin_content&cc_no="+ccNo;
			
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("ccNo", Integer.parseInt(ccNo));
			request.setAttribute("listCC", listCC);
			request.setAttribute("ci", ci);
			request.setAttribute("listCI", listCI);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin.lf", totalCount, ci.getListCount(), ci.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_content.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_content_write".equals(menu)){
			// 업로드 경로 설정
			//HttpSession session = request.getSession();
			session.setAttribute("filePathRoad", "upload/content");
			
			AelfDAO aDao = new AelfDAO();
			List<ContentCodeModel> listCC = aDao.selectListContentCode();
			
			request.setAttribute("listCC", listCC);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_content_write.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_content_view".equals(menu)){
			int ciNo = Integer.parseInt(request.getParameter("ci_no"));
			
			AelfDAO aDao = new AelfDAO();
			ContentInfoModel ci = aDao.selectContentInfo(ciNo);
			
			request.setAttribute("ci", ci);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_content_view.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_content_modify".equals(menu)){
			int ciNo = Integer.parseInt(request.getParameter("ci_no"));
			
			// 업로드 경로 설정
			//HttpSession session = request.getSession();
			session.setAttribute("filePathRoad", "upload/content");
			
			AelfDAO aDao = new AelfDAO();
			List<ContentCodeModel> listCC = aDao.selectListContentCode();
			ContentInfoModel ci = aDao.selectContentInfo(ciNo);
			
			request.setAttribute("listCC", listCC);
			request.setAttribute("ci", ci);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_content_modify.jsp");
			dispatcher.forward(request, response);
		}
		
		
		else if("admin_debate".equals(menu)){
			String pageNum = request.getParameter("pageNum");			
			if(pageNum == null)
				pageNum = "1";
			
			String approve = request.getParameter("approve");
			if(approve == null)
				approve = "all";
			
			DebateInfoModel debateInfo = new DebateInfoModel();
			debateInfo.setPageNum(pageNum);
			debateInfo.setDiApprove(approve);
			
			AelfDAO aDao = new AelfDAO();
			List<DebateInfoModel> listDebate = aDao.selectListDebateInfo(debateInfo);
			int totalCount = aDao.selectCountDebateInfo(debateInfo);
			
			String addParam = "&menu=admin_debate&approve="+approve;
			
			request.setAttribute("debateInfo", debateInfo);
			request.setAttribute("listDebate", listDebate);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin.lf", totalCount, debateInfo.getListCount(), debateInfo.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_debate.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_debate_write".equals(menu)){
			
			// 업로드 경로 설정
			//HttpSession session = request.getSession();
			session.setAttribute("filePathRoad", "upload/debate");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_debate_write.jsp");
			dispatcher.forward(request, response);
		}
				
		else if("admin_debate_view".equals(menu)){
			int diNo = Integer.parseInt(request.getParameter("di_no"));
			
			AelfDAO aDao = new AelfDAO();
			DebateInfoModel di = aDao.selectDebateInfo(diNo);
			
			request.setAttribute("di", di);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_debate_view.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_debate_modify".equals(menu)){
			int diNo = Integer.parseInt(request.getParameter("di_no"));
			
			AelfDAO aDao = new AelfDAO();
			DebateInfoModel di = aDao.selectDebateInfo(diNo);
			
			request.setAttribute("di", di);
			
			// 업로드 경로 설정
			//HttpSession session = request.getSession();
			session.setAttribute("filePathRoad", "upload/debate");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_debate_modify.jsp");
			dispatcher.forward(request, response);
		}
		
		
		else if("admin_petition".equals(menu)) {
			String pageNum = request.getParameter("pageNum");			
			if(pageNum == null)
				pageNum = "1";
			
			String approve = request.getParameter("approve");
			if(approve == null)
				approve = "all";
			
			PetitionInfoModel petitionInfo = new PetitionInfoModel();
			petitionInfo.setPageNum(pageNum);
			petitionInfo.setPiReply(approve);
			
			AelfDAO aDao = new AelfDAO();
			List<PetitionInfoModel> listPetition = aDao.selectListPetitionInfo(petitionInfo);
			int totalCount = aDao.selectCountPetitionInfo(petitionInfo);
			
			String addParam = "&menu=admin_petition&approve="+approve;
			
			request.setAttribute("petitionInfo", petitionInfo);
			request.setAttribute("listPetition", listPetition);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin.lf", totalCount, petitionInfo.getListCount(), petitionInfo.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_petition.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_petition_view".equals(menu)){
			int piNo = Integer.parseInt(request.getParameter("pi_no"));
			
			AelfDAO aDao = new AelfDAO();
			PetitionInfoModel pi = aDao.selectPetitionInfo(piNo);
			
			request.setAttribute("pi", pi);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_petition_view.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_petition_modify".equals(menu)){
			int piNo = Integer.parseInt(request.getParameter("pi_no"));
			
			AelfDAO aDao = new AelfDAO();
			PetitionInfoModel pi = aDao.selectPetitionInfo(piNo);
			
			request.setAttribute("pi", pi);
			
			// 업로드 경로 설정
			//HttpSession session = request.getSession();
			session.setAttribute("filePathRoad", "upload/petition");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_petition_modify.jsp");
			dispatcher.forward(request, response);
		}
		
		
		else if("admin_calendar".equals(menu)) {
			String pageNum = request.getParameter("pageNum");			
			if(pageNum == null)
				pageNum = "1";
			
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			
			if(year==null || month==null) {
				Calendar cal = Calendar.getInstance();
				year = String.format("%04d", cal.get(Calendar.YEAR));
				month = String.format("%02d", cal.get(Calendar.MONTH)+1);
			}
			
			CalendarInfoModel cal = new CalendarInfoModel();
			cal.setCalStartDate(year+"-"+month);
			
			AelfDAO aDao = new AelfDAO();
			List<CalendarInfoModel> listCal = aDao.selectListCalendarInfo(cal);
			int totalCount = aDao.selectCountCalendarInfo(cal);
			
			String addParam = "&menu=admin_calendar&year="+year+"&month="+month;
			
			request.setAttribute("cal", cal);
			request.setAttribute("listCal", listCal);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("year", year);
			request.setAttribute("month", month);
			request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin.lf", totalCount, cal.getListCount(), cal.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_calendar.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_calendar_write".equals(menu)){
			
			// 업로드 경로 설정
			//HttpSession session = request.getSession();
			session.setAttribute("filePathRoad", "upload/calendar");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_calendar_write.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_calendar_view".equals(menu)){
			int calNo = Integer.parseInt(request.getParameter("cal_no"));
			
			AelfDAO aDao = new AelfDAO();
			CalendarInfoModel cal = aDao.selectCalendarInfo(calNo);
			
			request.setAttribute("cal", cal);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_calendar_view.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("admin_calendar_modify".equals(menu)){
			int calNo = Integer.parseInt(request.getParameter("cal_no"));
			
			AelfDAO aDao = new AelfDAO();
			CalendarInfoModel cal = aDao.selectCalendarInfo(calNo);
			
			request.setAttribute("cal", cal);
			
			// 업로드 경로 설정
			//HttpSession session = request.getSession();
			session.setAttribute("filePathRoad", "upload/calendar");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_calendar_modify.jsp");
			dispatcher.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("UTF-8");
		
		String mode = request.getParameter("mode");
		
		if("admin_login".equals(mode)){
			String id = request.getParameter("id");
			String passwd = request.getParameter("passwd");
			
			if("aelfkorea".equals(id) && "aelf2018".equals(passwd)){
				HttpSession session = request.getSession();
				session.setAttribute("admin", "admin");
				
				response.sendRedirect("admin.lf?menu=admin_log");
			}
			else{
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.print("<script> window.alert('로그인할 수 없습니다. 아이디와 비밀번호를 확인해 주세요.'); history.go(-1); </script>");
			}
		}
		
		else if("delete_notice".equals(mode)){
			int niNo = Integer.parseInt(request.getParameter("ni_no"));
			AelfDAO aDao = new AelfDAO();
			aDao.deleteNoticeInfo(niNo);
		}
		
		else if("fix_notice".equals(mode)){
			int niNo = Integer.parseInt(request.getParameter("ni_no"));
			AelfDAO aDao = new AelfDAO();
			aDao.updateNoticeTopFix(niNo);
		}
		
		else if("delete_news".equals(mode)){
			int newsNo = Integer.parseInt(request.getParameter("news_no"));
			AelfDAO aDao = new AelfDAO();
			aDao.deleteNewsInfo(newsNo);
		}
		
		else if("delete_content".equals(mode)){
			int ciNo = Integer.parseInt(request.getParameter("ci_no"));
			AelfDAO aDao = new AelfDAO();
			aDao.deleteContentInfo(ciNo);
		}
		
		else if("delete_debate".equals(mode)){
			int diNo = Integer.parseInt(request.getParameter("di_no"));
			AelfDAO aDao = new AelfDAO();
			aDao.deleteDebateInfo(diNo);
		}
		
		else if("fix_debate".equals(mode)){
			int diNo = Integer.parseInt(request.getParameter("di_no"));
			AelfDAO aDao = new AelfDAO();
			aDao.updateDebateTopFix(diNo);
		}
		
		else if("approve_debate".equals(mode)) {
			int diNo = Integer.parseInt(request.getParameter("di_no"));
			AelfDAO aDao = new AelfDAO();
			aDao.setDebateApprove(diNo);
			
			///// 알람 등록 ///////////////////////
			int uiNo = Integer.parseInt(request.getParameter("ui_no"));
			
			if(uiNo > -1) {
				AlarmInfoModel alarm = new AlarmInfoModel();
				alarm.setBoardNo(diNo);
				alarm.setBoardType("debate_info");
				alarm.setUiNo(uiNo);
				alarm.setFromUiNo(-1);
				alarm.setAiContent("<span style='font-weight: 400;'>AELF KOREA</span>님이 <span style='font-weight: 400;'>회원님의 토론 신청</span>을 승인하였습니다.");
				
				aDao.insertAlarmInfo(alarm);	
			}
			////////////////////////////////////
		}
		
		else if("delete_petition".equals(mode)){
			int piNo = Integer.parseInt(request.getParameter("pi_no"));
			AelfDAO aDao = new AelfDAO();
			aDao.deletePetitionInfo(piNo);
		}
		
		else if("delete_calendar".equals(mode)){
			int calNo = Integer.parseInt(request.getParameter("cal_no"));
			AelfDAO aDao = new AelfDAO();
			aDao.deleteCalendarInfo(calNo);
		}
		///////////////////////////////////////////////
		
		else if("notice_sort_up".equals(mode)){
			int niNo = Integer.parseInt(request.getParameter("ni_no"));
			int niSort = Integer.parseInt(request.getParameter("ni_sort"));
			
			NoticeInfoModel ni = new NoticeInfoModel();
			ni.setNiNo(niNo);
			ni.setNiSort(niSort);
			
			AelfDAO aDao = new AelfDAO();
			aDao.noticeSortUp(ni);
		}
		
		else if("notice_sort_down".equals(mode)){
			int niNo = Integer.parseInt(request.getParameter("ni_no"));
			int niSort = Integer.parseInt(request.getParameter("ni_sort"));
			
			NoticeInfoModel ni = new NoticeInfoModel();
			ni.setNiNo(niNo);
			ni.setNiSort(niSort);
			
			AelfDAO aDao = new AelfDAO();
			aDao.noticeSortDown(ni);
		}
		
		else if("notice_list".equals(mode)){
			String pageNum = request.getParameter("pageNum");
			
			NoticeInfoModel ni = new NoticeInfoModel();
			ni.setPageNum(pageNum);
			
			AelfDAO aDao = new AelfDAO();
			List<NoticeInfoModel> listNI = aDao.selectListNoticeInfo(ni);
			int totalCount = aDao.selectCountListNoticeInfo(ni);
			
			NumberFormat nf = NumberFormat.getInstance();
			
			JSONArray arr = new JSONArray();
			for(int i=0; i<listNI.size(); i++){
				NoticeInfoModel list = listNI.get(i);
				JSONObject obj = new JSONObject();
				
				int idx = totalCount - i - (Integer.parseInt(ni.getPageNum()) - 1) * ni.getListCount();
				
				obj.put("niNo", list.getNiNo());
				obj.put("niThumbnail", list.getNiThumbnail());
				obj.put("niContent", list.getNiContent());
				obj.put("niTitle", list.getNiTitle());
				obj.put("niAuthor", list.getNiAuthor());
				obj.put("niDate", list.getNiDate());
				obj.put("niView", nf.format(list.getNiView()));
				obj.put("niTopFix", list.getNiTopFix());
				obj.put("niSort", list.getNiSort());
				obj.put("idx", idx);
				
				arr.add(obj);
			}
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(arr);
		}
		/////////////////////////////////////////////////////////////////
		
		else if("news_sort_up".equals(mode)){
			int newsNo = Integer.parseInt(request.getParameter("news_no"));
			int newsSort = Integer.parseInt(request.getParameter("news_sort"));
			
			NewsInfoModel newsInfo = new NewsInfoModel();
			newsInfo.setNewsNo(newsNo);
			newsInfo.setNewsSort(newsSort);
			
			AelfDAO aDao = new AelfDAO();
			aDao.newsSortUp(newsInfo);
		}
		
		else if("news_sort_down".equals(mode)){
			int newsNo = Integer.parseInt(request.getParameter("news_no"));
			int newsSort = Integer.parseInt(request.getParameter("news_sort"));
			
			NewsInfoModel newsInfo = new NewsInfoModel();
			newsInfo.setNewsNo(newsNo);
			newsInfo.setNewsSort(newsSort);
			
			AelfDAO aDao = new AelfDAO();
			aDao.newsSortDown(newsInfo);
		}
		
		else if("news_list".equals(mode)){
			String pageNum = request.getParameter("pageNum");
			
			NewsInfoModel newsInfo = new NewsInfoModel();
			newsInfo.setPageNum(pageNum);
			
			AelfDAO aDao = new AelfDAO();
			List<NewsInfoModel> listNI = aDao.selectListNewsInfo(newsInfo);
			int totalCount = aDao.selectCountListNewsInfo(newsInfo);
			
			NumberFormat nf = NumberFormat.getInstance();
			
			JSONArray arr = new JSONArray();
			
			for(int i=0; i<listNI.size(); i++){
				NewsInfoModel list = listNI.get(i);
				
				JSONObject obj = new JSONObject();
				
				int idx = totalCount - i - (Integer.parseInt(newsInfo.getPageNum()) - 1) * newsInfo.getListCount();
				
				obj.put("newsNo", list.getNewsNo());
				obj.put("newsThumbnail", list.getNewsThumbnail());
				obj.put("newsContent", list.getNewsContent());
				obj.put("newsTitle", list.getNewsTitle());
				obj.put("newsAuthor", list.getNewsAuthor());
				obj.put("newsDate", list.getNewsDate());
				obj.put("newsView", nf.format(list.getNewsView()));
				obj.put("newsSort", list.getNewsSort());
				obj.put("idx", idx);
				
				arr.add(obj);
			}
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(arr);
		}
		//////////////////////////////////////////////////////////////////
		
		else if("content_sort_up".equals(mode)){
			int ciNo = Integer.parseInt(request.getParameter("ci_no"));
			int ciSort = Integer.parseInt(request.getParameter("ci_sort"));
			int ccNo = Integer.parseInt(request.getParameter("cc_no"));
			
			ContentInfoModel ci = new ContentInfoModel();
			ci.setCiNo(ciNo);
			ci.setCiSort(ciSort);
			ci.setCcNo(ccNo);
			
			AelfDAO aDao = new AelfDAO();
			aDao.contentSortUp(ci);
		}
		
		else if("content_sort_down".equals(mode)){
			int ciNo = Integer.parseInt(request.getParameter("ci_no"));
			int ciSort = Integer.parseInt(request.getParameter("ci_sort"));
			int ccNo = Integer.parseInt(request.getParameter("cc_no"));
			
			ContentInfoModel ci = new ContentInfoModel();
			ci.setCiNo(ciNo);
			ci.setCiSort(ciSort);
			ci.setCcNo(ccNo);
			
			AelfDAO aDao = new AelfDAO();
			aDao.contentSortDown(ci);
		}
		
		else if("content_list".equals(mode)){
			String pageNum = request.getParameter("pageNum");
			String ccNo = request.getParameter("cc_no");
			
			ContentInfoModel ci = new ContentInfoModel();
			ci.setPageNum(pageNum);
			ci.setCcNo(Integer.parseInt(ccNo));
			
			AelfDAO aDao = new AelfDAO();
			
			List<ContentInfoModel> listCI = aDao.selectListContentInfo(ci);
			int totalCount = aDao.selectCountListContentInfo(ci);
			
			JSONArray arr = new JSONArray();
			
			NumberFormat nf = NumberFormat.getInstance();
			
			for(int i=0; i<listCI.size(); i++){
				ContentInfoModel list = listCI.get(i);
				JSONObject obj = new JSONObject();
				
				int idx = totalCount - i - (Integer.parseInt(ci.getPageNum()) - 1) * ci.getListCount();
				
				obj.put("ciNo", list.getCiNo());
				obj.put("ccNo", list.getCcNo());
				obj.put("ciThumbnail", list.getCiThumbnail());
				obj.put("ciContent", list.getCiContent());
				obj.put("ciTitle", list.getCiTitle());
				obj.put("ciAuthor", list.getCiAuthor());
				obj.put("ciDate", list.getCiDate());
				obj.put("ciView", nf.format(list.getCiView()));
				obj.put("ciLink", list.getCiLink());
				obj.put("ccName", list.getCcName().toUpperCase());
				obj.put("ciSort", list.getCiSort());
				obj.put("idx", idx);
				
				arr.add(obj);
				
			}
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(arr);
		}
		/////////////////////////////////////////////////////////////////////////////
		
		else if("debate_sort_up".equals(mode)){
			int diNo = Integer.parseInt(request.getParameter("di_no"));
			int diSort = Integer.parseInt(request.getParameter("di_sort"));
			
			DebateInfoModel di = new DebateInfoModel();
			di.setDiNo(diNo);
			di.setDiSort(diSort);
			
			AelfDAO aDao = new AelfDAO();
			aDao.debateSortUp(di);
		}
		
		else if("debate_sort_down".equals(mode)){
			int diNo = Integer.parseInt(request.getParameter("di_no"));
			int diSort = Integer.parseInt(request.getParameter("di_sort"));
			
			DebateInfoModel di = new DebateInfoModel();
			di.setDiNo(diNo);
			di.setDiSort(diSort);
			
			AelfDAO aDao = new AelfDAO();
			aDao.debateSortDown(di);
		}
		
		else if("debate_list".equals(mode)){
			String pageNum = request.getParameter("pageNum");
			String approve = request.getParameter("approve");
			
			DebateInfoModel di = new DebateInfoModel();
			di.setPageNum(pageNum);
			di.setDiApprove(approve);
			
			AelfDAO aDao = new AelfDAO();
			List<DebateInfoModel> listDI = aDao.selectListDebateInfo(di);
			int totalCount = aDao.selectCountDebateInfo(di);
			
			NumberFormat nf = NumberFormat.getInstance();
			
			JSONArray arr = new JSONArray();
			for(int i=0; i<listDI.size(); i++){
				DebateInfoModel list = listDI.get(i);
				JSONObject obj = new JSONObject();
				
				int idx = totalCount - i - (Integer.parseInt(di.getPageNum()) - 1) * di.getListCount();
				
				String gubun = "신청";
				if("1".equals(list.getDiApprove()))
					gubun = "승인";
				
				obj.put("diNo", list.getDiNo());
				obj.put("diContent", list.getDiContent());
				obj.put("diTitle", list.getDiTitle());
				obj.put("diAuthor", list.getDiAuthor());
				obj.put("diDate", list.getDiDate());
				obj.put("diView", nf.format(list.getDiView()));
				obj.put("diTopFix", list.getDiTopFix());
				obj.put("diSort", list.getDiSort());
				obj.put("diGubun", gubun);
				obj.put("idx", idx);
				
				arr.add(obj);
			}
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(arr);
		}
		
		else if("add_debate".equals(mode)) {
			String title = request.getParameter("di_title");
			String content = request.getParameter("content");
			String author = request.getParameter("di_author");
			
			DebateInfoModel debate = new DebateInfoModel();
			debate.setDiTitle(title);
			debate.setDiContent(content);
			debate.setDiAuthor(author);
			
			AelfDAO aDao = new AelfDAO();
			aDao.insertDebateInfo(debate);
			
			response.sendRedirect("admin.lf?menu=admin_debate");
		}
		
		else if("modify_debate".equals(mode)) {
			String title = request.getParameter("di_title");
			String content = request.getParameter("content");
			int diNo = Integer.parseInt(request.getParameter("di_no"));
			
			DebateInfoModel debate = new DebateInfoModel();
			debate.setDiTitle(title);
			debate.setDiContent(content);
			debate.setDiNo(diNo);
			
			AelfDAO aDao = new AelfDAO();
			aDao.updateDebateInfo(debate);
			
			response.sendRedirect("admin.lf?menu=admin_debate_view&di_no="+diNo);
		}
		/////////////////////////////////////////////////////////////////
		
		
		else if("modify_petition".equals(mode)) {
			String title = request.getParameter("pi_title");
			String content = request.getParameter("content");
			int piNo = Integer.parseInt(request.getParameter("pi_no"));
			
			PetitionInfoModel petition = new PetitionInfoModel();
			petition.setPiTitle(title);
			petition.setPiContent(content);
			petition.setPiNo(piNo);
			
			AelfDAO aDao = new AelfDAO();
			aDao.updatePetitionInfo(petition);
			
			response.sendRedirect("admin.lf?menu=admin_petition_view&pi_no="+piNo);
		}
		
		else if("reply_petition".equals(mode)) {
			String reply = request.getParameter("pi_reply");
			int piNo = Integer.parseInt(request.getParameter("pi_no"));
						
			PetitionInfoModel petition = new PetitionInfoModel();
			petition.setPiReply(reply);
			petition.setPiNo(piNo);
			
			AelfDAO aDao = new AelfDAO();
			aDao.updatePetitionReply(petition);
		}
		/////////////////////////////////////////////////////////////////
		
		
		else if("add_calendar".equals(mode)) {
			String startDate = request.getParameter("cal_start_date");
			String endDate = request.getParameter("cal_end_date");
			String tag = request.getParameter("cal_tag");
			String title = request.getParameter("cal_title");
			String comment = request.getParameter("cal_comment");
			String time = request.getParameter("cal_time");
			String place = request.getParameter("cal_place");
			String content = request.getParameter("content");
			
			CalendarInfoModel cal = new CalendarInfoModel();
			cal.setCalStartDate(startDate);
			cal.setCalEndDate(endDate);
			cal.setCalTag(tag);
			cal.setCalTitle(title);
			cal.setCalComment(comment);
			cal.setCalTime(time);
			cal.setCalPlace(place);
			cal.setCalContent(content);
			
			AelfDAO aDao = new AelfDAO();
			aDao.insertCalendarInfo(cal);
			
			response.sendRedirect("admin.lf?menu=admin_calendar");
		}
		
		else if("modify_calendar".equals(mode)) {
			String startDate = request.getParameter("cal_start_date");
			String endDate = request.getParameter("cal_end_date");
			String tag = request.getParameter("cal_tag");
			String title = request.getParameter("cal_title");
			String comment = request.getParameter("cal_comment");
			String time = request.getParameter("cal_time");
			String place = request.getParameter("cal_place");
			String content = request.getParameter("content");
			int calNo = Integer.parseInt(request.getParameter("cal_no"));
			
			CalendarInfoModel cal = new CalendarInfoModel();
			cal.setCalStartDate(startDate);
			cal.setCalEndDate(endDate);
			cal.setCalTag(tag);
			cal.setCalTitle(title);
			cal.setCalComment(comment);
			cal.setCalTime(time);
			cal.setCalPlace(place);
			cal.setCalContent(content);
			cal.setCalNo(calNo);
			
			AelfDAO aDao = new AelfDAO();
			aDao.updateCalendarInfo(cal);
			
			response.sendRedirect("admin.lf?menu=admin_calendar_view&cal_no="+calNo);
		}
		/////////////////////////////////////////////////////////////////
		
	}

}
