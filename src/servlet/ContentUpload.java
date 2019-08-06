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
		String uploadPath = context.getRealPath("/upload/content");		// ���� ���� ���
		int maxSize = 50 * 1024 * 1024;									// ���� �ִ� ũ��(30MByte)
		
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
				/// ÷������ ó��
				if("".equals(ciThumbnail) == false && ciThumbnail != null) {
					
					//���� �ð����� ���ϸ� ����
					String[] fileTok = ciThumbnail.split("\\.");
					
					Calendar cal = Calendar.getInstance();
					newFilename = String.valueOf(cal.getTimeInMillis());
					if(fileTok.length > 0)
						newFilename += "." + fileTok[fileTok.length - 1];
				}
				
				ci.setCiThumbnail(newFilename);
				
				AelfDAO aDao = new AelfDAO();
				int ciNo = aDao.insertContentInfo(ci);
				
				/// ÷������ ó��
				if("".equals(ciThumbnail) == false && ciThumbnail != null) {
					
					File directory = new File(context.getRealPath("/upload/content")+"/"+ciNo);		// ���� ���� ���
					
					if(directory.exists() == false) {		
						if(directory.mkdir()) {				
							File orgFile = new File(context.getRealPath("/upload/content/"+ciThumbnail));
							File movFile = new File(context.getRealPath("/upload/content/"+ciNo)+"/"+newFilename);
							
							if(movFile.exists())	movFile.delete();			// �ش� ���丮�� ������ ���ϸ��� �ִٸ� ���� ����..
							if(orgFile.exists())	orgFile.renameTo(movFile);	// �ٱ� ���丮�� ������ �ش� ���� ��û ��ȣ�� ���丮�� �̵�.
						}
					}
					else {								
						File orgFile = new File(context.getRealPath("/upload/content/"+ciThumbnail));
						File movFile = new File(context.getRealPath("/upload/content/"+ciNo)+"/"+newFilename);
						
						if(movFile.exists())	movFile.delete();			// �ش� ���丮�� ������ ���ϸ��� �ִٸ� ���� ����..
						if(orgFile.exists())	orgFile.renameTo(movFile);	// �ٱ� ���丮�� ������ �ش� ���� ��û ��ȣ�� ���丮�� �̵�.
					}
				}
				/*
				/////////// �˶� �߰� ///////////////////////////
				AlarmInfoModel alarm = new AlarmInfoModel();
				alarm.setBoardNo(ciNo);
				alarm.setBoardType("contents_info");
				alarm.setUiNo(-1);
				alarm.setFromUiNo(-1);
				alarm.setAiContent("<span style='font-weight: 400;'>AELF KOREA</span>���� <span style='font-weight: 400;'>������</span>��<br>�ۼ��Ͽ����ϴ�.");
				
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
				/// ÷������ ó��
				if("".equals(ciThumbnail) == false && ciThumbnail != null) {
					
					//���� �ð����� ���ϸ� ����
					String[] fileTok = ciThumbnail.split("\\.");
					
					Calendar cal = Calendar.getInstance();
					newFilename = String.valueOf(cal.getTimeInMillis());
					if(fileTok.length > 0)
						newFilename += "." + fileTok[fileTok.length - 1];
				}
				
				/// ÷������ ó��
				if("".equals(ciThumbnail) == false && ciThumbnail != null) {
					
					File directory = new File(context.getRealPath("/upload/content")+"/"+ciNo);		// ���� ���� ���
					
					if(directory.exists() == false) {		
						if(directory.mkdir()) {				
							File orgFile = new File(context.getRealPath("/upload/content/"+ciThumbnail));
							File movFile = new File(context.getRealPath("/upload/content/"+ciNo)+"/"+newFilename);
							File oldFile = new File(context.getRealPath("/upload/content/"+ciNo)+"/"+ciThumbnailOld);
							
							if(oldFile.exists())	oldFile.delete();
							if(movFile.exists())	movFile.delete();			// �ش� ���丮�� ������ ���ϸ��� �ִٸ� ���� ����..
							if(orgFile.exists())	orgFile.renameTo(movFile);	// �ٱ� ���丮�� ������ �ش� ���� ��û ��ȣ�� ���丮�� �̵�.
						}
					}
					else {								
						File orgFile = new File(context.getRealPath("/upload/content/"+ciThumbnail));
						File movFile = new File(context.getRealPath("/upload/content/"+ciNo)+"/"+newFilename);
						File oldFile = new File(context.getRealPath("/upload/content/"+ciNo)+"/"+ciThumbnailOld);
						
						if(oldFile.exists())	oldFile.delete();
						if(movFile.exists())	movFile.delete();			// �ش� ���丮�� ������ ���ϸ��� �ִٸ� ���� ����..
						if(orgFile.exists())	orgFile.renameTo(movFile);	// �ٱ� ���丮�� ������ �ش� ���� ��û ��ȣ�� ���丮�� �̵�.
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
			out.print("<script> alert('���� ũ�Ⱑ 50MByte�� �ʰ��߰ų� ��Ÿ ������ ������ ÷���� �� �����ϴ�.'); history.go(-1); </script>");
		}
	}

}
