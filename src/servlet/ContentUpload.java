package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.AlarmInfoModel;
import model.ContentInfoModel;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.AelfDAO;

/**
 * Servlet implementation class ContentUpload
 */
@WebServlet(name = "contentupload.lf", urlPatterns = { "/contentupload.lf" })
public class ContentUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ContentUpload() {
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
		String uploadPath = context.getRealPath("/upload/content");		// 파일 저장 경로
		int maxSize = 50 * 1024 * 1024;									// 파일 최대 크기(30MByte)
		
		try {
			MultipartRequest multi = null;
			multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
			
			String mode = multi.getParameter("mode");
			
			if("add_content".equals(mode)){
				int ccNo = Integer.parseInt(multi.getParameter("cc_no"));
				String ciTitle = multi.getParameter("ci_title");
				String ciLink = multi.getParameter("ci_link");
				String ciThumbnail = multi.getFilesystemName("ci_thumbnail");
				String ciAuthor = multi.getParameter("ci_author");
				String ciContent = multi.getParameter("content");
				
				ContentInfoModel ci = new ContentInfoModel();
				ci.setCcNo(ccNo);
				ci.setCiTitle(ciTitle);
				ci.setCiLink(ciLink);
				ci.setCiAuthor(ciAuthor);
				ci.setCiContent(ciContent);
				
				String newFilename = "";
				/// 첨부파일 처리
				if("".equals(ciThumbnail) == false && ciThumbnail != null) {
					
					//현재 시간으로 파일명 변경
					String[] fileTok = ciThumbnail.split("\\.");
					
					Calendar cal = Calendar.getInstance();
					newFilename = String.valueOf(cal.getTimeInMillis());
					if(fileTok.length > 0)
						newFilename += "." + fileTok[fileTok.length - 1];
				}
				
				ci.setCiThumbnail(newFilename);
				
				AelfDAO aDao = new AelfDAO();
				int ciNo = aDao.insertContentInfo(ci);
				
				/// 첨부파일 처리
				if("".equals(ciThumbnail) == false && ciThumbnail != null) {
					
					File directory = new File(context.getRealPath("/upload/content")+"/"+ciNo);		// 파일 저장 경로
					
					if(directory.exists() == false) {		
						if(directory.mkdir()) {				
							File orgFile = new File(context.getRealPath("/upload/content/"+ciThumbnail));
							File movFile = new File(context.getRealPath("/upload/content/"+ciNo)+"/"+newFilename);
							
							if(movFile.exists())	movFile.delete();			// 해당 디렉토리에 동일한 파일명이 있다면 먼저 삭제..
							if(orgFile.exists())	orgFile.renameTo(movFile);	// 바깥 디렉토리의 파일을 해당 구매 신청 번호의 디렉토리로 이동.
						}
					}
					else {								
						File orgFile = new File(context.getRealPath("/upload/content/"+ciThumbnail));
						File movFile = new File(context.getRealPath("/upload/content/"+ciNo)+"/"+newFilename);
						
						if(movFile.exists())	movFile.delete();			// 해당 디렉토리에 동일한 파일명이 있다면 먼저 삭제..
						if(orgFile.exists())	orgFile.renameTo(movFile);	// 바깥 디렉토리의 파일을 해당 구매 신청 번호의 디렉토리로 이동.
					}
				}
				/*
				/////////// 알람 추가 ///////////////////////////
				AlarmInfoModel alarm = new AlarmInfoModel();
				alarm.setBoardNo(ciNo);
				alarm.setBoardType("contents_info");
				alarm.setUiNo(-1);
				alarm.setFromUiNo(-1);
				alarm.setAiContent("<span style='font-weight: 400;'>AELF KOREA</span>님이 <span style='font-weight: 400;'>컨텐츠</span>를<br>작성하였습니다.");
				
				aDao.insertAlarmInfo(alarm);
				//////////////////////////////////////////////
				*/
				response.sendRedirect("admin.lf?menu=admin_content");
				
			}
			
			else if("modify_content".equals(mode)){
				int ciNo = Integer.parseInt(multi.getParameter("ci_no"));
				int ccNo = Integer.parseInt(multi.getParameter("cc_no"));
				String ciTitle = multi.getParameter("ci_title");
				String ciThumbnail = multi.getFilesystemName("ci_thumbnail");
				String ciThumbnailOld = multi.getParameter("ci_thumbnail_old");
				String ciAuthor = multi.getParameter("ci_author");
				String ciContent = multi.getParameter("content");
				String ciLink = multi.getParameter("ci_link");
				
				ContentInfoModel ci = new ContentInfoModel();
				ci.setCiNo(ciNo);
				ci.setCcNo(ccNo);
				ci.setCiTitle(ciTitle);
				ci.setCiThumbnail(ciThumbnailOld);
				ci.setCiAuthor(ciAuthor);
				ci.setCiContent(ciContent);
				ci.setCiLink(ciLink);
				
				String newFilename = "";
				/// 첨부파일 처리
				if("".equals(ciThumbnail) == false && ciThumbnail != null) {
					
					//현재 시간으로 파일명 변경
					String[] fileTok = ciThumbnail.split("\\.");
					
					Calendar cal = Calendar.getInstance();
					newFilename = String.valueOf(cal.getTimeInMillis());
					if(fileTok.length > 0)
						newFilename += "." + fileTok[fileTok.length - 1];
				}
				
				/// 첨부파일 처리
				if("".equals(ciThumbnail) == false && ciThumbnail != null) {
					
					File directory = new File(context.getRealPath("/upload/content")+"/"+ciNo);		// 파일 저장 경로
					
					if(directory.exists() == false) {		
						if(directory.mkdir()) {				
							File orgFile = new File(context.getRealPath("/upload/content/"+ciThumbnail));
							File movFile = new File(context.getRealPath("/upload/content/"+ciNo)+"/"+newFilename);
							File oldFile = new File(context.getRealPath("/upload/content/"+ciNo)+"/"+ciThumbnailOld);
							
							if(oldFile.exists())	oldFile.delete();
							if(movFile.exists())	movFile.delete();			// 해당 디렉토리에 동일한 파일명이 있다면 먼저 삭제..
							if(orgFile.exists())	orgFile.renameTo(movFile);	// 바깥 디렉토리의 파일을 해당 구매 신청 번호의 디렉토리로 이동.
						}
					}
					else {								
						File orgFile = new File(context.getRealPath("/upload/content/"+ciThumbnail));
						File movFile = new File(context.getRealPath("/upload/content/"+ciNo)+"/"+newFilename);
						File oldFile = new File(context.getRealPath("/upload/content/"+ciNo)+"/"+ciThumbnailOld);
						
						if(oldFile.exists())	oldFile.delete();
						if(movFile.exists())	movFile.delete();			// 해당 디렉토리에 동일한 파일명이 있다면 먼저 삭제..
						if(orgFile.exists())	orgFile.renameTo(movFile);	// 바깥 디렉토리의 파일을 해당 구매 신청 번호의 디렉토리로 이동.
					}
					
					ci.setCiThumbnail(newFilename);
				}
				
				AelfDAO aDao = new AelfDAO();
				aDao.updateContentInfo(ci);
				
				response.sendRedirect("admin.lf?menu=admin_content_view&ci_no="+ciNo);
			}
			
			
			
			
		} catch(Exception e) {
			e.printStackTrace();
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script> alert('파일 크기가 50MByte를 초과했거나 기타 이유로 파일을 첨부할 수 없습니다.'); history.go(-1); </script>");
		}
	}

}
