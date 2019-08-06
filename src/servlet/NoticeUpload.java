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
import model.NoticeInfoModel;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.AelfDAO;


/**
 * Servlet implementation class NoticeUpload
 */
@WebServlet(name = "noticeupload.lf", urlPatterns = { "/noticeupload.lf" })
public class NoticeUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeUpload() {
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
		String uploadPath = context.getRealPath("/upload/notice");		// ���� ���� ���
		int maxSize = 50 * 1024 * 1024;									// ���� �ִ� ũ��(30MByte)
		
		try {
			MultipartRequest multi = null;
			multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
			
			String mode = multi.getParameter("mode");
			
			if("add_notice".equals(mode)){
				String niTitle = multi.getParameter("ni_title");
				String niThumbnail = multi.getFilesystemName("ni_thumbnail");
				String niAuthor = multi.getParameter("ni_author");
				String niContent = multi.getParameter("content");
				
				NoticeInfoModel ni = new NoticeInfoModel();
				ni.setNiTitle(niTitle);
				ni.setNiAuthor(niAuthor);
				ni.setNiContent(niContent);
				
				String newFilename = "";
				/// ÷������ ó��
				if("".equals(niThumbnail) == false && niThumbnail != null) {
					
					//���� �ð����� ���ϸ� ����
					String[] fileTok = niThumbnail.split("\\.");
					
					Calendar cal = Calendar.getInstance();
					newFilename = String.valueOf(cal.getTimeInMillis());
					if(fileTok.length > 0)
						newFilename += "." + fileTok[fileTok.length - 1];
				}
				
				ni.setNiThumbnail(newFilename);
				
				AelfDAO aDao = new AelfDAO();
				int niNo = aDao.insertNoticeInfo(ni);
				
				/// ÷������ ó��
				if("".equals(niThumbnail) == false && niThumbnail != null) {
					
					File directory = new File(context.getRealPath("/upload/notice")+"/"+niNo);		// ���� ���� ���
					
					if(directory.exists() == false) {		
						if(directory.mkdir()) {				
							File orgFile = new File(context.getRealPath("/upload/notice/"+niThumbnail));
							File movFile = new File(context.getRealPath("/upload/notice/"+niNo)+"/"+newFilename);
							
							if(movFile.exists())	movFile.delete();			// �ش� ���丮�� ������ ���ϸ��� �ִٸ� ���� ����..
							if(orgFile.exists())	orgFile.renameTo(movFile);	// �ٱ� ���丮�� ������ �ش� ���� ��û ��ȣ�� ���丮�� �̵�.
						}
					}
					else {								
						File orgFile = new File(context.getRealPath("/upload/notice/"+niThumbnail));
						File movFile = new File(context.getRealPath("/upload/notice/"+niNo)+"/"+newFilename);
						
						if(movFile.exists())	movFile.delete();			// �ش� ���丮�� ������ ���ϸ��� �ִٸ� ���� ����..
						if(orgFile.exists())	orgFile.renameTo(movFile);	// �ٱ� ���丮�� ������ �ش� ���� ��û ��ȣ�� ���丮�� �̵�.
					}
				}
				
				/////////// �˶� �߰� ///////////////////////////
				AlarmInfoModel alarm = new AlarmInfoModel();
				alarm.setBoardNo(niNo);
				alarm.setBoardType("notice_info");
				alarm.setUiNo(-1);
				alarm.setFromUiNo(-1);
				alarm.setAiContent("<span style='font-weight: 400;'>AELF KOREA</span>���� <span style='font-weight: 400;'>��������</span>�� �ۼ��Ͽ����ϴ�.");
				
				aDao.insertAlarmInfo(alarm);
				//////////////////////////////////////////////
				
				response.sendRedirect("admin.lf?menu=admin_notice");
				
			}
			
			else if("modify_notice".equals(mode)){
				int niNo = Integer.parseInt(multi.getParameter("ni_no"));
				String niTitle = multi.getParameter("ni_title");
				String niThumbnail = multi.getFilesystemName("ni_thumbnail");
				String niThumbnailOld = multi.getParameter("ni_thumbnail_old");
				String niAuthor = multi.getParameter("ni_author");
				String niContent = multi.getParameter("content");
				
				NoticeInfoModel ni = new NoticeInfoModel();
				ni.setNiNo(niNo);
				ni.setNiTitle(niTitle);
				ni.setNiThumbnail(niThumbnailOld);
				ni.setNiAuthor(niAuthor);
				ni.setNiContent(niContent);
				
				String newFilename = "";
				/// ÷������ ó��
				if("".equals(niThumbnail) == false && niThumbnail != null) {
					
					//���� �ð����� ���ϸ� ����
					String[] fileTok = niThumbnail.split("\\.");
					
					Calendar cal = Calendar.getInstance();
					newFilename = String.valueOf(cal.getTimeInMillis());
					if(fileTok.length > 0)
						newFilename += "." + fileTok[fileTok.length - 1];
				}
				
				/// ÷������ ó��
				if("".equals(niThumbnail) == false && niThumbnail != null) {
					
					File directory = new File(context.getRealPath("/upload/notice")+"/"+niNo);		// ���� ���� ���
					
					if(directory.exists() == false) {		
						if(directory.mkdir()) {				
							File orgFile = new File(context.getRealPath("/upload/notice/"+niThumbnail));
							File movFile = new File(context.getRealPath("/upload/notice/"+niNo)+"/"+newFilename);
							File oldFile = new File(context.getRealPath("/upload/notice/"+niNo)+"/"+niThumbnailOld);
							
							if(oldFile.exists())	oldFile.delete();
							if(movFile.exists())	movFile.delete();			// �ش� ���丮�� ������ ���ϸ��� �ִٸ� ���� ����..
							if(orgFile.exists())	orgFile.renameTo(movFile);	// �ٱ� ���丮�� ������ �ش� ���� ��û ��ȣ�� ���丮�� �̵�.
						}
					}
					else {								
						File orgFile = new File(context.getRealPath("/upload/notice/"+niThumbnail));
						File movFile = new File(context.getRealPath("/upload/notice/"+niNo)+"/"+newFilename);
						File oldFile = new File(context.getRealPath("/upload/notice/"+niNo)+"/"+niThumbnailOld);
						
						if(oldFile.exists())	oldFile.delete();
						if(movFile.exists())	movFile.delete();			// �ش� ���丮�� ������ ���ϸ��� �ִٸ� ���� ����..
						if(orgFile.exists())	orgFile.renameTo(movFile);	// �ٱ� ���丮�� ������ �ش� ���� ��û ��ȣ�� ���丮�� �̵�.
					}
					
					ni.setNiThumbnail(newFilename);
				}
				
				AelfDAO aDao = new AelfDAO();
				aDao.updateNoticeInfo(ni);
				
				response.sendRedirect("admin.lf?menu=admin_notice_view&ni_no="+niNo);
			}
			
			
			
			
		} catch(Exception e) {
			e.printStackTrace();
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script> alert('���� ũ�Ⱑ 50MByte�� �ʰ��߰ų� ��Ÿ ������ ������ ÷���� �� �����ϴ�.'); history.go(-1); </script>");
		}
	}

}
