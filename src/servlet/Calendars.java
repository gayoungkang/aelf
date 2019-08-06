package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.CalendarInfoModel;
import util.CheckMobile;
import util.PageNavigator;
import dao.AelfDAO;

/**
 * Servlet implementation class Calendars
 */
@WebServlet("/calendar.lf")
public class Calendars extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Calendars() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		boolean bMobile = CheckMobile.isMobile(request.getHeader("user-agent"));
		
		Calendar cal = Calendar.getInstance();
		
		String curYear = request.getParameter("year");
		String curMonth = request.getParameter("month");
		
		if(curYear == null)
			curYear = cal.get(Calendar.YEAR) + "";
		if(curMonth == null)
			curMonth = (cal.get(Calendar.MONTH)+1) + "";
		
		int year = Integer.parseInt(curYear);
		int month = Integer.parseInt(curMonth);
		
		if(month < 1){
			year = year - 1;
			month = 12;
		}
		
		if(month > 12){
			year = year + 1;
			month = 1;
		}
		
		AelfDAO aDao = new AelfDAO();
		
		String startDate = String.format("%04d-%02d-01", year, month);
		String endDate = String.format("%04d-%02d-%02d", year, month, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		List<CalendarInfoModel> listCIM = aDao.selectListCalendarInfo(startDate, endDate); 
		
		request.setAttribute("listCIM", listCIM);
		request.setAttribute("year", year);
		request.setAttribute("month", month);
		
		if(bMobile) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/mobile/m_calendar_list.jsp");
			dispatcher.forward(request, response);
		}
		else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/calendar/calendar_list.jsp");
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
		
		if("view".equals(mode)) {
			int calNo = Integer.parseInt(request.getParameter("cal_no"));
			
			AelfDAO aDao = new AelfDAO();
			CalendarInfoModel cal = aDao.selectCalendarInfo(calNo);
			
			JSONObject jObj = new JSONObject();
			jObj.put("tag", cal.getCalTag());
			jObj.put("title", cal.getCalTitle());
			jObj.put("comment", cal.getCalComment());
			jObj.put("time", cal.getCalTime());
			jObj.put("place", cal.getCalPlace());
			jObj.put("start_date", cal.getCalStartDate());
			jObj.put("end_date", cal.getCalEndDate());
			jObj.put("content", cal.getCalContent());
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(jObj);
		}
		
		else if("list".equals(mode)) {
			/*String pageNum = request.getParameter("pageNum");			
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
			cal.setPageNum(pageNum);
			cal.setListCount(8);
			
			AelfDAO aDao = new AelfDAO();
			List<CalendarInfoModel> listCal = aDao.selectListCalendarInfo(cal);
			
			String arrWeek[] = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
			
			JSONArray arr = new JSONArray();
			for(int i=0; i<listCal.size(); i++) {
				CalendarInfoModel list = listCal.get(i);
				
				Calendar tCal = Calendar.getInstance();
				tCal.set(Integer.parseInt(list.getCalStartDate().substring(0, 4)), 
						Integer.parseInt(list.getCalStartDate().substring(5, 7))-1,
						Integer.parseInt(list.getCalStartDate().substring(8, 10)));
				
				JSONObject obj = new JSONObject();
				obj.put("no", list.getCalNo()+"");
				obj.put("tag", list.getCalTag());
				obj.put("title", list.getCalTitle());
				obj.put("date", list.getCalStartDate().substring(8, 10));
				obj.put("week", arrWeek[tCal.get(Calendar.DAY_OF_WEEK)-1]);
				obj.put("comment", list.getCalComment());
				obj.put("time", list.getCalTime());
				obj.put("place", list.getCalPlace());
				obj.put("content", list.getCalContent());
				
				arr.add(obj);
			}
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(arr);*/
		}
	}

}
