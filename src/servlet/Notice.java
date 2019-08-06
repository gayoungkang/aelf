package servlet;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLEncoder;
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

import model.AlarmInfoModel;
import model.ContentInfoModel;
import model.DebateInfoModel;
import model.LikeInfoModel;
import model.NewsInfoModel;
import model.NoticeInfoModel;
import model.ReplyModel;
import model.UserLogModel;
import util.CheckMobile;
import util.PageNavigator;
import dao.AelfDAO;

/**
 * Servlet implementation class Notice
 */
@WebServlet(description = "공지사항", urlPatterns = { "/notice.lf" })
public class Notice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Notice() {
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
		
		
		boolean bMobile = CheckMobile.isMobile(request.getHeader("user-agent"));
		
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
		
		String mode = request.getParameter("mode");
		
		if(mode==null || "".equals(mode))
			mode = "list";
		
		/// 목록 조회
		if("list".equals(mode)) {
			String pageNum = request.getParameter("pageNum");			
			if(pageNum == null)
				pageNum = "1";
			
			String searchText = request.getParameter("searchText");
			if(searchText == null)
				searchText = "";
			
			NoticeInfoModel ni = new NoticeInfoModel();
			ni.setPageNum(pageNum);
			ni.setNiContent(searchText);
			ni.setListCount(10);
			if(bMobile) {
				ni.setPagePerBlock(5);
			}
			
			AelfDAO aDao = new AelfDAO();
			List<NoticeInfoModel> listNI = aDao.selectListNoticeInfo(ni);
			int totalCount = aDao.selectCountListNoticeInfo(ni);
			
			List<NoticeInfoModel> listTop = aDao.selectNoticeInfoForListTop();
			
			String addParam = "&menu=notice&mode=list&searchText="+URLEncoder.encode(searchText, "UTF-8");
			
			request.setAttribute("ni", ni);
			request.setAttribute("listTop", listTop);
			request.setAttribute("listNI", listNI);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("searchText", searchText);
			
			if(bMobile) {
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigatorMobile("notice.lf", totalCount, ni.getListCount(), ni.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/mobile/m_notice_list.jsp");
				dispatcher.forward(request, response);
			}
			else {
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("notice.lf", totalCount, ni.getListCount(), ni.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/notice/notice_list.jsp");
				dispatcher.forward(request, response);
			}
		}
		
		/// 내용 조회
		else if("view".equals(mode)) {
			int niNo = Integer.parseInt(request.getParameter("ni_no"));
			
			AelfDAO aDao = new AelfDAO();
			NoticeInfoModel ni = aDao.selectNoticeInfo(niNo);
			
			String viewCheck = (String)session.getAttribute("ni_"+niNo);
			if(viewCheck == null){
				aDao.updateNoticeView(niNo, ni.getNiView()+1);
				ni.setNiView(ni.getNiView()+1);
				session.setAttribute("ni_"+niNo, "1");
			}
			
			int reNiNo = niNo;
			int reCiNo = -1;
			int reNewsNo = -1;
			
			NoticeInfoModel reNi = aDao.selectNoticeInfoRecently(reNiNo);
			ContentInfoModel reCi = aDao.selectContentInfoRecently(reCiNo);
			NewsInfoModel reNresInfo = aDao.selectNewsInfoRecently(reNewsNo);
			List<DebateInfoModel> listReDi = aDao.selectDebateInfoRecently(-1);
			
			request.setAttribute("ni", ni);
			request.setAttribute("reNi", reNi);
			request.setAttribute("reCi", reCi);
			request.setAttribute("reNresInfo", reNresInfo);
			request.setAttribute("listReDi", listReDi);
			
			/// 참여 인원 수 조회
			//int replyCnt = aDao.getNoticeReplyCount(niNo);	// 답글 수
			int partCnt = aDao.getNoticePartCount(niNo);	// 참여 수
			int likeCnt = aDao.getNoticeLikeCount(niNo);	// 좋아요 수
			
			request.setAttribute("partCnt", partCnt);
			request.setAttribute("likeCnt", likeCnt);
			
			/// 답글 조회
			String sortType = request.getParameter("sort_type");
			if(sortType == null || "".equals(sortType))
				sortType = "desc";
			
			ReplyModel reply = new ReplyModel();
			reply.setNiNo(niNo);
			reply.setSortType(sortType);
			
			List<ReplyModel> listReply = aDao.selectListNoticeReply(reply);
			
			request.setAttribute("listReply", listReply);
			request.setAttribute("sortType", sortType);
			
			if(bMobile) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/mobile/m_notice_view.jsp");
				dispatcher.forward(request, response);
			}
			else {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/notice/notice_view.jsp");
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
		
		/// 공지의 답글 작성
		if("add_reply".equals(mode)) {
			int niNo = Integer.parseInt(request.getParameter("ni_no"));
			int uiNo = Integer.parseInt(request.getParameter("ui_no"));
			String nrContent = request.getParameter("nr_content");
			
			ReplyModel reply = new ReplyModel();
			reply.setNiNo(niNo);
			reply.setUiNo(uiNo);
			reply.setNrContent(nrContent);
			
			AelfDAO aDao = new AelfDAO();
			aDao.insertNoticeReply(reply);
		}
		
		/// 답글의 답글 작성
		else if("add_reply2".equals(mode)) {
			int niNo = Integer.parseInt(request.getParameter("ni_no"));
			int nrGroupNo = Integer.parseInt(request.getParameter("nr_group_no"));
			int nrGroupOrder = Integer.parseInt(request.getParameter("nr_group_order"));
			int nrGroupLayer = Integer.parseInt(request.getParameter("nr_group_layer"));
			int uiNo = Integer.parseInt(request.getParameter("ui_no"));
			String nrContent = request.getParameter("nr_content");
			
			ReplyModel reply = new ReplyModel();
			reply.setNiNo(niNo);
			reply.setNrGroupNo(nrGroupNo);
			reply.setNrGroupOrder(nrGroupOrder);
			reply.setNrGroupLayer(nrGroupLayer);
			reply.setUiNo(uiNo);
			reply.setNrContent(nrContent);
			
			AelfDAO aDao = new AelfDAO();
			aDao.insertNoticeReply2(reply);
			
			///// 알람 등록 ///////////////////////
			String uiName = request.getParameter("ui_name");
			int toUiNo = Integer.parseInt(request.getParameter("to_ui_no"));
			
			AlarmInfoModel alarm = new AlarmInfoModel();
			alarm.setBoardNo(niNo);
			alarm.setBoardType("notice_info");
			alarm.setUiNo(toUiNo);
			alarm.setFromUiNo(uiNo);
			alarm.setAiContent("<span style='font-weight: 400;'>"+uiName+"</span>님이 <span style='font-weight: 400;'>회원님의 게시글</span>에 답글을 작성하였습니다.");
			
			aDao.insertAlarmInfo(alarm);
			////////////////////////////////////
		}
		
		/// 답글 삭제
		else if("delete_reply".equals(mode)) {
			int nrNo = Integer.parseInt(request.getParameter("nr_no"));
			
			AelfDAO aDao = new AelfDAO();
			aDao.deleteNoticeReply(nrNo);
		}
		
		/// 좋아요 등록 상태 확인
		else if("check_like".equals(mode)) {
			int boardNo = Integer.parseInt(request.getParameter("board_no"));
			String boardType = request.getParameter("board_type");
			int uiNo = Integer.parseInt(request.getParameter("ui_no"));
			
			LikeInfoModel likeInfo = new LikeInfoModel();
			likeInfo.setBoardNo(boardNo);
			likeInfo.setBoardType(boardType);
			likeInfo.setUiNo(uiNo);
			
			AelfDAO aDao = new AelfDAO();
			if(aDao.checkLikeInfo(likeInfo)) {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.print("1");
			} else {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.print("0");
			}
		}
		
		/// 좋아요 등록
		else if("add_like".equals(mode)) {
			int boardNo = Integer.parseInt(request.getParameter("board_no"));
			String boardType = request.getParameter("board_type");
			int uiNo = Integer.parseInt(request.getParameter("ui_no"));
			
			LikeInfoModel likeInfo = new LikeInfoModel();
			likeInfo.setBoardNo(boardNo);
			likeInfo.setBoardType(boardType);
			likeInfo.setUiNo(uiNo);
			likeInfo.setLiType("like");
			
			AelfDAO aDao = new AelfDAO();
			aDao.insertLikeInfo(likeInfo);
			////////////////
			
			///// 알람 등록 ///////////////////////
			String uiName = request.getParameter("ui_name");
			int toUiNo = Integer.parseInt(request.getParameter("to_ui_no"));
			int niNo = Integer.parseInt(request.getParameter("ni_no"));
			
			if(toUiNo > -1) {
				AlarmInfoModel alarm = new AlarmInfoModel();
				alarm.setBoardNo(niNo);
				alarm.setBoardType("notice_info");
				alarm.setUiNo(toUiNo);
				alarm.setFromUiNo(uiNo);
				alarm.setAiContent("<span style='font-weight: 400;'>"+uiName+"</span>님이 <span style='font-weight: 400;'>회원님의 게시글</span>을 좋아합니다.");
				
				aDao.insertAlarmInfo(alarm);	
			}
			////////////////////////////////////
			
			int likeCnt = aDao.getNoticeLikeCount(boardNo);
			int partCnt = aDao.getNoticePartCount(boardNo);
			
			NumberFormat nf = NumberFormat.getInstance();
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(nf.format(likeCnt) + "|" + nf.format(partCnt));
		}
		
		/// 좋아요 삭제
		else if("delete_like".equals(mode)) {
			int boardNo = Integer.parseInt(request.getParameter("board_no"));
			String boardType = request.getParameter("board_type");
			int uiNo = Integer.parseInt(request.getParameter("ui_no"));
			
			LikeInfoModel likeInfo = new LikeInfoModel();
			likeInfo.setBoardNo(boardNo);
			likeInfo.setBoardType(boardType);
			likeInfo.setUiNo(uiNo);
			
			AelfDAO aDao = new AelfDAO();
			aDao.deleteLikeInfo(likeInfo);
			///////////////
			
			int likeCnt = aDao.getNoticeLikeCount(boardNo);
			int partCnt = aDao.getNoticePartCount(boardNo);
			
			NumberFormat nf = NumberFormat.getInstance();
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(nf.format(likeCnt) + "|" + nf.format(partCnt));
		}
	}

}
