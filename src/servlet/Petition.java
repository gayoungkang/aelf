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
import model.PetitionInfoModel;
import model.ReplyModel;

/**
 * Servlet implementation class Petition
 */
@WebServlet(description = "청원", urlPatterns = { "/petition.lf" })
public class Petition extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Petition() {
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
		
		/// 목록 조회
		if("list".equals(mode)) {
			String pageNum = request.getParameter("pageNum");			
			if(pageNum == null)
				pageNum = "1";
			
			String searchText = request.getParameter("searchText");
			if(searchText == null)
				searchText = "";
			
			String gubun = request.getParameter("gubun");
			if(gubun == null)
				gubun = "recent";
			
			PetitionInfoModel pi = new PetitionInfoModel();
			pi.setPageNum(pageNum);
			pi.setPiTitle(searchText);
			pi.setListCount(10);
			if("recent".equals(gubun)) {
				pi.setOrderType("date");
			} else if("recommend".equals(gubun)) {
				pi.setOrderType("recommend");
			} else if("complete".equals(gubun)) {
				pi.setPiReply("1");
				pi.setListCount(4);
			}
			if(bMobile) {
				pi.setPagePerBlock(5);
			}
			
			AelfDAO aDao = new AelfDAO();
			List<PetitionInfoModel> listPI = aDao.selectListPetitionInfo(pi);
			int totalCount = aDao.selectCountPetitionInfo(pi);
			
			List<PetitionInfoModel> listBest = aDao.selectPetitionInfoForListBest();
			
			request.setAttribute("listBest", listBest);
			
			String addParam = "&menu=petition&mode=list&searchText="+URLEncoder.encode(searchText, "UTF-8")+"&gubun="+gubun;
			
			request.setAttribute("pi", pi);
			request.setAttribute("listPI", listPI);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("searchText", searchText);
			request.setAttribute("gubun", gubun);
			
			if(bMobile) {
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigatorMobile("petition.lf", totalCount, pi.getListCount(), pi.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/mobile/m_petition_list.jsp");
				dispatcher.forward(request, response);
			}
			else {
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("petition.lf", totalCount, pi.getListCount(), pi.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/petition/petition_list.jsp");
				dispatcher.forward(request, response);
			}			
		}
		
		// 청원 조회
		else if("view".equals(mode)) {
			int piNo = Integer.parseInt(request.getParameter("pi_no"));
			
			AelfDAO aDao = new AelfDAO();
			PetitionInfoModel pi = aDao.selectPetitionInfo(piNo);
			
			String viewCheck = (String)session.getAttribute("pi_"+piNo);
			if(viewCheck == null){
				aDao.updatePetitionView(piNo, pi.getPiView()+1);
				pi.setPiView(pi.getPiView()+1);
				session.setAttribute("pi_"+piNo, "1");
			}
			
			NoticeInfoModel reNi = aDao.selectNoticeInfoRecently(-1);
			ContentInfoModel reCi = aDao.selectContentInfoRecently(-1);
			NewsInfoModel reNewsInfo = aDao.selectNewsInfoRecently(-1);
			List<DebateInfoModel> listReDi = aDao.selectDebateInfoRecently(-1);
			
			request.setAttribute("pi", pi);
			request.setAttribute("reNi", reNi);
			request.setAttribute("reCi", reCi);
			request.setAttribute("reNewsInfo", reNewsInfo);
			request.setAttribute("listReDi", listReDi);
			
			/// 참여 인원 수 조회
			//int replyCnt = aDao.getPetitionReplyCount(piNo);
			int partCnt = aDao.getPetitionPartCount(piNo);
			int likeCnt = aDao.getPetitionLikeCount(piNo);
			
			request.setAttribute("partCnt", partCnt);
			request.setAttribute("likeCnt", likeCnt);
			
			/// 답글 조회
			String sortType = request.getParameter("sort_type");
			if(sortType == null || "".equals(sortType))
				sortType = "desc";
			
			ReplyModel reply = new ReplyModel();
			reply.setNiNo(piNo);
			reply.setSortType(sortType);
			
			List<ReplyModel> listReply = aDao.selectListPetitionReply(reply);
			
			request.setAttribute("listReply", listReply);
			request.setAttribute("sortType", sortType);
			
			if(bMobile) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/mobile/m_petition_view.jsp");
				dispatcher.forward(request, response);
			}
			else {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/petition/petition_view.jsp");
				dispatcher.forward(request, response);
			}
		}
		
		/// 청원 신청
		else if("write".equals(mode)) {
			session.setAttribute("filePathRoad", "upload/petition");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/petition/petition_write.jsp");
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
		
		if("add_petition".equals(mode)) {
			String title = request.getParameter("pi_title");
			String content = request.getParameter("content");
			String author = request.getParameter("pi_author");
			int uiNo = Integer.parseInt(request.getParameter("ui_no"));
			String gubun = request.getParameter("gubun");
			
			PetitionInfoModel petition = new PetitionInfoModel();
			petition.setPiTitle(title);
			petition.setPiContent(content);
			petition.setPiAuthor(author);
			petition.setUiNo(uiNo);
			
			AelfDAO aDao = new AelfDAO();
			aDao.insertPetitionInfo(petition);
			
			response.sendRedirect("petition.lf?menu=petition&mode=list&gubun="+gubun);
		}
		
		/// 공지의 답글 작성
		else if("add_reply".equals(mode)) {
			int niNo = Integer.parseInt(request.getParameter("ni_no"));
			int uiNo = Integer.parseInt(request.getParameter("ui_no"));
			String nrContent = request.getParameter("nr_content");
			
			ReplyModel reply = new ReplyModel();
			reply.setNiNo(niNo);
			reply.setUiNo(uiNo);
			reply.setNrContent(nrContent);
			
			AelfDAO aDao = new AelfDAO();
			aDao.insertPetitionReply(reply);
			
			///// 알람 등록 ///////////////////////
			String uiName = request.getParameter("ui_name");
			int toUiNo = Integer.parseInt(request.getParameter("to_ui_no"));
			
			if(toUiNo>-1) {
				AlarmInfoModel alarm = new AlarmInfoModel();
				alarm.setBoardNo(niNo);
				alarm.setBoardType("petition_info");
				alarm.setUiNo(toUiNo);
				alarm.setFromUiNo(uiNo);
				alarm.setAiContent("<span style='font-weight: 400;'>"+uiName+"</span>님이 <span style='font-weight: 400;'>회원님의 게시글</span>에 답글을 작성하였습니다.");
				
				aDao.insertAlarmInfo(alarm);
			}
			////////////////////////////////////
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
			aDao.insertPetitionReply2(reply);
			
			///// 알람 등록 ///////////////////////
			String uiName = request.getParameter("ui_name");
			int toUiNo = Integer.parseInt(request.getParameter("to_ui_no"));
			
			if(toUiNo>-1) {
				AlarmInfoModel alarm = new AlarmInfoModel();
				alarm.setBoardNo(niNo);
				alarm.setBoardType("petition_info");
				alarm.setUiNo(toUiNo);
				alarm.setFromUiNo(uiNo);
				alarm.setAiContent("<span style='font-weight: 400;'>"+uiName+"</span>님이 <span style='font-weight: 400;'>회원님의 게시글</span>에 답글을 작성하였습니다.");
				
				aDao.insertAlarmInfo(alarm);
			}
			////////////////////////////////////
		}
		
		/// 답글 삭제
		else if("delete_reply".equals(mode)) {
			int nrNo = Integer.parseInt(request.getParameter("nr_no"));
			
			AelfDAO aDao = new AelfDAO();
			aDao.deletePetitionReply(nrNo);
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
				alarm.setBoardType("petition_info");
				alarm.setUiNo(toUiNo);
				alarm.setFromUiNo(uiNo);
				alarm.setAiContent("<span style='font-weight: 400;'>"+uiName+"</span>님이 <span style='font-weight: 400;'>회원님의 게시글</span>을 좋아합니다.");
				
				aDao.insertAlarmInfo(alarm);	
			}
			////////////////////////////////////
			
			int likeCnt = aDao.getPetitionLikeCount(boardNo);
			int partCnt = aDao.getPetitionPartCount(boardNo);
			
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
			
			int likeCnt = aDao.getPetitionLikeCount(boardNo);
			int partCnt = aDao.getPetitionPartCount(boardNo);
			
			NumberFormat nf = NumberFormat.getInstance();
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(nf.format(likeCnt) + "|" + nf.format(partCnt));
		}
	}

}
