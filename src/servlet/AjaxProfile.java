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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class AjaxProfile
 */
@WebServlet(description = "����� ������ ����ó��", urlPatterns = { "/ajaxprofile.lf" })
public class AjaxProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxProfile() {
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
		
		ServletContext context = getServletContext();
		String uploadPath = context.getRealPath("/upload/profile");	// ���� ���� ���
		int maxSize = 30 * 1024 * 1024;								// ���� �ִ� ũ��(30MByte)
		
		try {
			
			MultipartRequest multi = null;
			
			multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
			
			String filename =  multi.getFilesystemName("img_file");
			String oldfile = multi.getParameter("old_file");
			
			/// ���� �ð����� ���ϸ� ����.
			String[] fileTok = filename.split("\\.");
			
			Calendar cal = Calendar.getInstance();
			String newFilename = String.valueOf(cal.getTimeInMillis());
			if(fileTok.length > 0)
				newFilename += "." + fileTok[fileTok.length - 1];
			
			File orgFile = new File(context.getRealPath("/upload/profile/"+filename));
			File movFile = new File(context.getRealPath("/upload/profile/"+newFilename));
			
			if(orgFile.exists())	orgFile.renameTo(movFile);
			
			/// ���� ����â ȭ�� ���� - ���������� ��� �ٲ㼭 ������ ��� ���� ���� ����.
			if(oldfile!=null && "".equals(oldfile)==false) {
				File oldFile = new File(context.getRealPath("/upload/upload/"+oldfile));
				
				if(oldFile.exists())	oldFile.delete();
			}
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(newFilename);
			
		} catch(Exception e) {
			e.printStackTrace();
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("[false]");
		}
	}

}
