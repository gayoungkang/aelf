package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Calendar;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.AlarmInfoModel;
import model.NewsInfoModel;
import model.NoticeInfoModel;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.AelfDAO;

/**
 * Servlet implementation class NewsUpload
 */
@WebServlet(name = "newsupload.lf", urlPatterns = { "/newsupload.lf" })
public class NewsUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewsUpload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("UTF-8");
		
		ServletContext context = getServletContext();
		String uploadPath = context.getRealPath("/upload/news");		// 파일 저장 경로
		int maxSize = 50 * 1024 * 1024;									// 파일 최대 크기(30MByte)
		
		try {
			MultipartRequest multi = null;
			multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
			
			String mode = multi.getParameter("mode");
			
			if("add_news".equals(mode)){
				String newsTitle = multi.getParameter("news_title");
				String newsThumbnail = multi.getFilesystemName("news_thumbnail");
				String newsAuthor = multi.getParameter("news_author");
				String newsContent = multi.getParameter("content");
				
				NewsInfoModel newsInfo = new NewsInfoModel();
				newsInfo.setNewsTitle(newsTitle);
				newsInfo.setNewsAuthor(newsAuthor);
				newsInfo.setNewsContent(newsContent);
				
				String newFilename = "";
				/// 첨부파일 처리
				if("".equals(newsThumbnail) == false && newsThumbnail != null) {
					
					//현재 시간으로 파일명 변경
					String[] fileTok = newsThumbnail.split("\\.");
					
					Calendar cal = Calendar.getInstance();
					newFilename = String.valueOf(cal.getTimeInMillis());
					if(fileTok.length > 0)
						newFilename += "." + fileTok[fileTok.length - 1];
				}
				
				newsInfo.setNewsThumbnail(newFilename);
				
				AelfDAO aDao = new AelfDAO();
				int newsNo = aDao.insertNewsInfo(newsInfo);
				
				/// 첨부파일 처리
				if("".equals(newsThumbnail) == false && newsThumbnail != null) {
					
					File directory = new File(context.getRealPath("/upload/news")+"/"+newsNo);		// 파일 저장 경로
					
					if(directory.exists() == false) {		
						if(directory.mkdir()) {				
							File orgFile = new File(context.getRealPath("/upload/news/"+newsThumbnail));
							File movFile = new File(context.getRealPath("/upload/news/"+newsNo)+"/"+newFilename);
							
							if(movFile.exists())	movFile.delete();			// 해당 디렉토리에 동일한 파일명이 있다면 먼저 삭제..
							if(orgFile.exists())	orgFile.renameTo(movFile);	// 바깥 디렉토리의 파일을 해당 구매 신청 번호의 디렉토리로 이동.
						}
					}
					else {								
						File orgFile = new File(context.getRealPath("/upload/news/"+newsThumbnail));
						File movFile = new File(context.getRealPath("/upload/news/"+newsNo)+"/"+newFilename);
						
						if(movFile.exists())	movFile.delete();			// 해당 디렉토리에 동일한 파일명이 있다면 먼저 삭제..
						if(orgFile.exists())	orgFile.renameTo(movFile);	// 바깥 디렉토리의 파일을 해당 구매 신청 번호의 디렉토리로 이동.
					}
				}
				
				/////////// 알람 추가 ///////////////////////////
				AlarmInfoModel alarm = new AlarmInfoModel();
				alarm.setBoardNo(newsNo);
				alarm.setBoardType("news_info");
				alarm.setUiNo(-1);
				alarm.setFromUiNo(-1);
				alarm.setAiContent("<span style='font-weight: 400;'>AELF KOREA</span>님이 <span style='font-weight: 400;'>뉴스</span>를 작성하였습니다.");
				
				aDao.insertAlarmInfo(alarm);
				//////////////////////////////////////////////
				
				response.sendRedirect("admin.lf?menu=admin_news");
				
			}
			
			else if("modify_news".equals(mode)){
				int newsNo = Integer.parseInt(multi.getParameter("news_no"));
				String newsTitle = multi.getParameter("news_title");
				String newsThumbnail = multi.getFilesystemName("news_thumbnail");
				String newsThumbnailOld = multi.getParameter("news_thumbnail_old");
				String newsAuthor = multi.getParameter("news_author");
				String newsContent = multi.getParameter("content");
				
				NewsInfoModel newsInfo = new NewsInfoModel();
				newsInfo.setNewsNo(newsNo);
				newsInfo.setNewsTitle(newsTitle);
				newsInfo.setNewsThumbnail(newsThumbnailOld);
				newsInfo.setNewsAuthor(newsAuthor);
				newsInfo.setNewsContent(newsContent);
				
				String newFilename = "";
				/// 첨부파일 처리
				if("".equals(newsThumbnail) == false && newsThumbnail != null) {
					
					//현재 시간으로 파일명 변경
					String[] fileTok = newsThumbnail.split("\\.");
					
					Calendar cal = Calendar.getInstance();
					newFilename = String.valueOf(cal.getTimeInMillis());
					if(fileTok.length > 0)
						newFilename += "." + fileTok[fileTok.length - 1];
				}
				
				/// 첨부파일 처리
				if("".equals(newsThumbnail) == false && newsThumbnail != null) {
					
					File directory = new File(context.getRealPath("/upload/news")+"/"+newsNo);		// 파일 저장 경로
					
					if(directory.exists() == false) {		
						if(directory.mkdir()) {				
							File orgFile = new File(context.getRealPath("/upload/news/"+newsThumbnail));
							File movFile = new File(context.getRealPath("/upload/news/"+newsNo)+"/"+newFilename);
							File oldFile = new File(context.getRealPath("/upload/news/"+newsNo)+"/"+newsThumbnailOld);
							
							if(oldFile.exists())	oldFile.delete();
							if(movFile.exists())	movFile.delete();			// 해당 디렉토리에 동일한 파일명이 있다면 먼저 삭제..
							if(orgFile.exists())	orgFile.renameTo(movFile);	// 바깥 디렉토리의 파일을 해당 구매 신청 번호의 디렉토리로 이동.
						}
					}
					else {								
						File orgFile = new File(context.getRealPath("/upload/news/"+newsThumbnail));
						File movFile = new File(context.getRealPath("/upload/news/"+newsNo)+"/"+newFilename);
						File oldFile = new File(context.getRealPath("/upload/news/"+newsNo)+"/"+newsThumbnailOld);
						
						if(oldFile.exists())	oldFile.delete();
						if(movFile.exists())	movFile.delete();			// 해당 디렉토리에 동일한 파일명이 있다면 먼저 삭제..
						if(orgFile.exists())	orgFile.renameTo(movFile);	// 바깥 디렉토리의 파일을 해당 구매 신청 번호의 디렉토리로 이동.
					}
					
					newsInfo.setNewsThumbnail(newFilename);
				}
				
				AelfDAO aDao = new AelfDAO();
				aDao.updateNewsInfo(newsInfo);
				
				response.sendRedirect("admin.lf?menu=admin_news_view&news_no="+newsNo);
			}
			
			
			
			
		} catch(Exception e) {
			e.printStackTrace();
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script> alert('파일 크기가 50MByte를 초과했거나 기타 이유로 파일을 첨부할 수 없습니다.'); history.go(-1); </script>");
		}
	}

}
