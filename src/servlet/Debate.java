package servlet;

import java.io.IOException;
import java.io.PrintWriter;
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

import util.CheckMobile;
import util.PageNavigator;
import dao.AelfDAO;
import model.AlarmInfoModel;
import model.ContentInfoModel;
import model.DebateInfoModel;
import model.LikeInfoModel;
import model.NewsInfoModel;
import model.NoticeInfoModel;
import model.ReplyModel;

/**
 * Servlet implementation class Debate
 */
@WebServlet(description = "��й�", urlPatterns = { "/debate.lf" })
public class Debate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Debate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		
		String mode = request.getParameter("mode");
		
		boolean bMobile = CheckMobile.isMobile(request.getHeader("user-agent"));
		
		if(mode==null || "".equals(mode))
			mode = "list";
		
		/// ��� ��ȸ
		if("list".equals(mode)) {
			String pageNum = request.getParameter("pageNum");			
			if(pageNum == null)
				pageNum = "1";
			
			String searchText = request.getParameter("searchText");
			if(searchText == null)
				searchText = "";
			
			DebateInfoModel di = new DebateInfoModel();
			di.setPageNum(pageNum);
			di.setDiContent(searchText);
			di.setListCount(10);
			di.setDiApprove("1");
			if(bMobile) {
				di.setPagePerBlock(5);
			}
			
			AelfDAO aDao = new AelfDAO();
			List<DebateInfoModel> listDI = aDao.selectListDebateInfo(di);
			int totalCount = aDao.selectCountDebateInfo(di);
			
			List<DebateInfoModel> listTop = aDao.selectDebateInfoForListTop();
			List<DebateInfoModel> listBest = aDao.selectDebateInfoForListBest();
			
			request.setAttribute("listTop", listTop);
			request.setAttribute("listBest", listBest);
			
			String addParam = "&menu=debate&mode=list&searchText="+URLEncoder.encode(searchText, "UTF-8");
			
			request.setAttribute("di", di);
			request.setAttribute("listDI", listDI);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("searchText", searchText);
			
			if(bMobile) {
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigatorMobile("debate.lf", totalCount, di.getListCount(), di.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/mobile/m_debate_list.jsp");
				dispatcher.forward(request, response);
			}
			else {
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("debate.lf", totalCount, di.getListCount(), di.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/debate/debate_list.jsp");
				dispatcher.forward(request, response);
			}
		}
		
		/// ��� ��ȸ
		else if("view".equals(mode)) {
			int diNo = Integer.parseInt(request.getParameter("di_no"));
			
			AelfDAO aDao = new AelfDAO();
			DebateInfoModel di = aDao.selectDebateInfo(diNo);
			
			String viewCheck = (String)session.getAttribute("di_"+diNo);
			if(viewCheck == null){
				aDao.updateDebateView(diNo, di.getDiView()+1);
				di.setDiView(di.getDiView()+1);
				session.setAttribute("di_"+diNo, "1");
			}
			
			NoticeInfoModel reNi = aDao.selectNoticeInfoRecently(-1);
			ContentInfoModel reCi = aDao.selectContentInfoRecently(-1);
			NewsInfoModel reNresInfo = aDao.selectNewsInfoRecently(-1);
			List<DebateInfoModel> listReDi = aDao.selectDebateInfoRecently(diNo);
			
			request.setAttribute("di", di);
			request.setAttribute("reNi", reNi);
			request.setAttribute("reCi", reCi);
			request.setAttribute("reNresInfo", reNresInfo);
			request.setAttribute("listReDi", listReDi);
			
			/// ���� �ο� �� ��ȸ
			//int replyCnt = aDao.getDebateReplyCount(diNo);			// ��� ��
			int partCnt = aDao.getDebatePartCount(diNo);			// ���� ��
			int likeCnt = aDao.getDebateLikeCount(diNo, "like");	// ���ƿ� ��
			int dislikeCnt = aDao.getDebateLikeCount(diNo, "dislike");	// ���ƿ� ��
			
			request.setAttribute("partCnt", partCnt);
			request.setAttribute("likeCnt", likeCnt);
			request.setAttribute("dislikeCnt", dislikeCnt);
			
			/// ��� ��ȸ
			String sortType = request.getParameter("sort_type");
			if(sortType == null || "".equals(sortType))
				sortType = "desc";
			
			ReplyModel reply = new ReplyModel();
			reply.setNiNo(diNo);
			reply.setSortType(sortType);
			
			List<ReplyModel> listReply = aDao.selectListDebateReply(reply);
			
			request.setAttribute("listReply", listReply);
			request.setAttribute("sortType", sortType);
			
			if(bMobile) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/mobile/m_debate_view.jsp");
				dispatcher.forward(request, response);
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/debate/debate_view.jsp");
				dispatcher.forward(request, response);
			}			
		}
		
		/// ��� ��û
		else if("write".equals(mode)) {
			session.setAttribute("filePathRoad", "upload/debate");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/debate/debate_write.jsp");
			dispatcher.forward(request, response);
		}
		
		/// ��� ��û �Ϸ�
		else if("success".equals(mode)) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/debate/debate_success.jsp");
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
		
		if("add_debate".equals(mode)) {
			String title = request.getParameter("di_title");
			String content = request.getParameter("content");
			String author = request.getParameter("di_author");
			int uiNo = Integer.parseInt(request.getParameter("ui_no"));
			
			DebateInfoModel debate = new DebateInfoModel();
			debate.setDiTitle(title);
			debate.setDiContent(content);
			debate.setDiAuthor(author);
			debate.setUiNo(uiNo);
			
			AelfDAO aDao = new AelfDAO();
			aDao.insertDebateInfo(debate);
			
			response.sendRedirect("debate.lf?menu=debate&mode=success");;
		}
		
		
		/// ������ ��� �ۼ�
		else if("add_reply".equals(mode)) {
			int niNo = Integer.parseInt(request.getParameter("ni_no"));
			int uiNo = Integer.parseInt(request.getParameter("ui_no"));
			String nrContent = request.getParameter("nr_content");
			
			ReplyModel reply = new ReplyModel();
			reply.setNiNo(niNo);
			reply.setUiNo(uiNo);
			reply.setNrContent(nrContent);
			
			AelfDAO aDao = new AelfDAO();
			aDao.insertDebateReply(reply);
			
			///// �˶� ��� ///////////////////////
			String uiName = request.getParameter("ui_name");
			int toUiNo = Integer.parseInt(request.getParameter("to_ui_no"));
			
			if(toUiNo>-1) {
				AlarmInfoModel alarm = new AlarmInfoModel();
				alarm.setBoardNo(niNo);
				alarm.setBoardType("debate_info");
				alarm.setUiNo(toUiNo);
				alarm.setFromUiNo(uiNo);
				alarm.setAiContent("<span style='font-weight: 400;'>"+uiName+"</span>���� <span style='font-weight: 400;'>ȸ������ �Խñ�</span>�� ����� �ۼ��Ͽ����ϴ�.");
				
				aDao.insertAlarmInfo(alarm);
			}
			////////////////////////////////////
		}
		
		/// ����� ��� �ۼ�
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
			aDao.insertDebateReply2(reply);
			
			///// �˶� ��� ///////////////////////
			String uiName = request.getParameter("ui_name");
			int toUiNo = Integer.parseInt(request.getParameter("to_ui_no"));
			
			if(toUiNo>-1) {
				AlarmInfoModel alarm = new AlarmInfoModel();
				alarm.setBoardNo(niNo);
				alarm.setBoardType("debate_info");
				alarm.setUiNo(toUiNo);
				alarm.setFromUiNo(uiNo);
				alarm.setAiContent("<span style='font-weight: 400;'>"+uiName+"</span>���� <span style='font-weight: 400;'>ȸ������ �Խñ�</span>�� ����� �ۼ��Ͽ����ϴ�.");
				
				aDao.insertAlarmInfo(alarm);
			}
			////////////////////////////////////
		}
		
		/// ��� ����
		else if("delete_reply".equals(mode)) {
			int nrNo = Integer.parseInt(request.getParameter("nr_no"));
			
			AelfDAO aDao = new AelfDAO();
			aDao.deleteDebateReply(nrNo);
		}
		
		/// ����/�ݴ� ó��
		else if("set_agree".equals(mode)) {
			int boardNo = Integer.parseInt(request.getParameter("board_no"));
			String boardType = request.getParameter("board_type");
			String liType = request.getParameter("li_type");
			int uiNo = Integer.parseInt(request.getParameter("ui_no"));
			
			LikeInfoModel likeInfo = new LikeInfoModel();
			likeInfo.setBoardNo(boardNo);
			likeInfo.setBoardType(boardType);
			likeInfo.setLiType(liType);
			likeInfo.setUiNo(uiNo);
			
			AelfDAO aDao = new AelfDAO();
			aDao.setLikeInfo(likeInfo);
			////////////////
			
			///// �˶� ��� ///////////////////////
			String uiName = request.getParameter("ui_name");
			int toUiNo = Integer.parseInt(request.getParameter("to_ui_no"));
			
			if(toUiNo > -1) {
				AlarmInfoModel alarm = new AlarmInfoModel();
				alarm.setBoardNo(boardNo);
				alarm.setBoardType("debate_info");
				alarm.setUiNo(toUiNo);
				alarm.setFromUiNo(uiNo);
				if("like".equals(liType))
					alarm.setAiContent("<span style='font-weight: 400;'>"+uiName+"</span>���� <span style='font-weight: 400;'>ȸ������ �Խñ�</span>�� �����մϴ�.");
				else
					alarm.setAiContent("<span style='font-weight: 400;'>"+uiName+"</span>���� <span style='font-weight: 400;'>ȸ������ �Խñ�</span>�� �ݴ��մϴ�.");
				
				aDao.insertAlarmInfo(alarm);	
			}
			////////////////////////////////////
			
			int likeCnt = aDao.getDebateLikeCount(boardNo, "like");
			int dislikeCnt = aDao.getDebateLikeCount(boardNo, "dislike");
			int partCnt = aDao.getDebatePartCount(boardNo);
			
			NumberFormat nf = NumberFormat.getInstance();
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(nf.format(likeCnt) + "|" + nf.format(dislikeCnt) + "|" + nf.format(partCnt));
		}
		
		/// ���ƿ� ��� ���� Ȯ��
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
		
		/// ���ƿ� ���
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
			
			///// �˶� ��� ///////////////////////
			String uiName = request.getParameter("ui_name");
			int toUiNo = Integer.parseInt(request.getParameter("to_ui_no"));
			int niNo = Integer.parseInt(request.getParameter("ni_no"));
			
			if(toUiNo > -1) {
				AlarmInfoModel alarm = new AlarmInfoModel();
				alarm.setBoardNo(niNo);
				alarm.setBoardType("debate_info");
				alarm.setUiNo(toUiNo);
				alarm.setFromUiNo(uiNo);
				alarm.setAiContent("<span style='font-weight: 400;'>"+uiName+"</span>���� <span style='font-weight: 400;'>ȸ������ �Խñ�</span>�� �����մϴ�.");
				
				aDao.insertAlarmInfo(alarm);	
			}
			////////////////////////////////////
			
			int likeCnt = aDao.getDebateLikeCount(boardNo, "like");
			int dislikeCnt = aDao.getDebateLikeCount(boardNo, "dislike");
			int partCnt = aDao.getDebatePartCount(boardNo);
			
			NumberFormat nf = NumberFormat.getInstance();
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(nf.format(likeCnt) + "|" + nf.format(dislikeCnt) + "|" + nf.format(partCnt));
		}
		
		/// ���ƿ� ����
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
			
			int likeCnt = aDao.getDebateLikeCount(boardNo, "like");
			int dislikeCnt = aDao.getDebateLikeCount(boardNo, "dislike");
			int partCnt = aDao.getDebatePartCount(boardNo);
			
			NumberFormat nf = NumberFormat.getInstance();
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(nf.format(likeCnt) + "|" + nf.format(dislikeCnt) + "|" + nf.format(partCnt));
		}
	}

}
