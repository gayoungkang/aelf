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
		String uploadPath = context.getRealPath("/upload/news");		// ���� ���� ���
		int maxSize = 50 * 1024 * 1024;									// ���� �ִ� ũ��(30MByte)
		
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
				/// ÷������ ó��
				if("".equals(newsThumbnail) == false && newsThumbnail != null) {
					
					//���� �ð����� ���ϸ� ����
					String[] fileTok = newsThumbnail.split("\\.");
					
					Calendar cal = Calendar.getInstance();
					newFilename = String.valueOf(cal.getTimeInMillis());
					if(fileTok.length > 0)
						newFilename += "." + fileTok[fileTok.length - 1];
				}
				
				newsInfo.setNewsThumbnail(newFilename);
				
				AelfDAO aDao = new AelfDAO();
				int newsNo = aDao.insertNewsInfo(newsInfo);
				
				/// ÷������ ó��
				if("".equals(newsThumbnail) == false && newsThumbnail != null) {
					
					File directory = new File(context.getRealPath("/upload/news")+"/"+newsNo);		// ���� ���� ���
					
					if(directory.exists() == false) {		
						if(directory.mkdir()) {				
							File orgFile = new File(context.getRealPath("/upload/news/"+newsThumbnail));
							File movFile = new File(context.getRealPath("/upload/news/"+newsNo)+"/"+newFilename);
							
							if(movFile.exists())	movFile.delete();			// �ش� ���丮�� ������ ���ϸ��� �ִٸ� ���� ����..
							if(orgFile.exists())	orgFile.renameTo(movFile);	// �ٱ� ���丮�� ������ �ش� ���� ��û ��ȣ�� ���丮�� �̵�.
						}
					}
					else {								
						File orgFile = new File(context.getRealPath("/upload/news/"+newsThumbnail));
						File movFile = new File(context.getRealPath("/upload/news/"+newsNo)+"/"+newFilename);
						
						if(movFile.exists())	movFile.delete();			// �ش� ���丮�� ������ ���ϸ��� �ִٸ� ���� ����..
						if(orgFile.exists())	orgFile.renameTo(movFile);	// �ٱ� ���丮�� ������ �ش� ���� ��û ��ȣ�� ���丮�� �̵�.
					}
				}
				
				/////////// �˶� �߰� ///////////////////////////
				AlarmInfoModel alarm = new AlarmInfoModel();
				alarm.setBoardNo(newsNo);
				alarm.setBoardType("news_info");
				alarm.setUiNo(-1);
				alarm.setFromUiNo(-1);
				alarm.setAiContent("<span style='font-weight: 400;'>AELF KOREA</span>���� <span style='font-weight: 400;'>����</span>�� �ۼ��Ͽ����ϴ�.");
				
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
				/// ÷������ ó��
				if("".equals(newsThumbnail) == false && newsThumbnail != null) {
					
					//���� �ð����� ���ϸ� ����
					String[] fileTok = newsThumbnail.split("\\.");
					
					Calendar cal = Calendar.getInstance();
					newFilename = String.valueOf(cal.getTimeInMillis());
					if(fileTok.length > 0)
						newFilename += "." + fileTok[fileTok.length - 1];
				}
				
				/// ÷������ ó��
				if("".equals(newsThumbnail) == false && newsThumbnail != null) {
					
					File directory = new File(context.getRealPath("/upload/news")+"/"+newsNo);		// ���� ���� ���
					
					if(directory.exists() == false) {		
						if(directory.mkdir()) {				
							File orgFile = new File(context.getRealPath("/upload/news/"+newsThumbnail));
							File movFile = new File(context.getRealPath("/upload/news/"+newsNo)+"/"+newFilename);
							File oldFile = new File(context.getRealPath("/upload/news/"+newsNo)+"/"+newsThumbnailOld);
							
							if(oldFile.exists())	oldFile.delete();
							if(movFile.exists())	movFile.delete();			// �ش� ���丮�� ������ ���ϸ��� �ִٸ� ���� ����..
							if(orgFile.exists())	orgFile.renameTo(movFile);	// �ٱ� ���丮�� ������ �ش� ���� ��û ��ȣ�� ���丮�� �̵�.
						}
					}
					else {								
						File orgFile = new File(context.getRealPath("/upload/news/"+newsThumbnail));
						File movFile = new File(context.getRealPath("/upload/news/"+newsNo)+"/"+newFilename);
						File oldFile = new File(context.getRealPath("/upload/news/"+newsNo)+"/"+newsThumbnailOld);
						
						if(oldFile.exists())	oldFile.delete();
						if(movFile.exists())	movFile.delete();			// �ش� ���丮�� ������ ���ϸ��� �ִٸ� ���� ����..
						if(orgFile.exists())	orgFile.renameTo(movFile);	// �ٱ� ���丮�� ������ �ش� ���� ��û ��ȣ�� ���丮�� �̵�.
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
			out.print("<script> alert('���� ũ�Ⱑ 50MByte�� �ʰ��߰ų� ��Ÿ ������ ������ ÷���� �� �����ϴ�.'); history.go(-1); </script>");
		}
	}

}
