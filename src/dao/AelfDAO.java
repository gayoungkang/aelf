package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.AlarmInfoModel;
import model.CalendarInfoModel;
import model.ContentCodeModel;
import model.ContentInfoModel;
import model.DebateInfoModel;
import model.LikeInfoModel;
import model.NewsInfoModel;
import model.NoticeInfoModel;
import model.PetitionInfoModel;
import model.ReplyModel;
import model.UserInfoModel;
import model.UserLogModel;

public class AelfDAO {
	protected Connection connection = null;
	protected PreparedStatement pstmt = null;
	protected ResultSet rs = null;
	
	//	DB 접속 정보
	private final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	//private final String DB_URL = "jdbc:mysql://127.0.0.1:3306/aelfkorea";
	//private final String DB_ID = "aelfkorea";
	//private final String DB_PASSWD = "Aelf2018";
	
	private final String DB_URL = "jdbc:mysql://127.0.0.1:3306/aelf";
	private final String DB_ID = "aelf";
	private final String DB_PASSWD = "aelf2017#";
	
	
	// 유저 로그 입력
	public void insertUserLog(UserLogModel modelParam){
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"INSERT INTO user_log(ul_prev_link, ul_ip, ul_country, ul_city, ul_device, ul_date, ul_time) "
					+ "VALUES(?, ?, ?, ?, ?, curdate(), NOW())");
			
			pstmt.setString(1, modelParam.getUlPrevLink());
			pstmt.setString(2, modelParam.getUlIp());
			pstmt.setString(3, modelParam.getUlCountry());
			pstmt.setString(4, modelParam.getUlCity());
			pstmt.setString(5, modelParam.getUlDevice());
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	// 유저 목록 불러오기
	public List<UserLogModel> selectListUserLog(UserLogModel modelParam){
		List<UserLogModel> listUL = new ArrayList<UserLogModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT ul_prev_link, ul_ip, ul_country, ul_city, ul_device, ul_date, ul_time "
					+ "FROM user_log "
					+ "WHERE ul_date=? "
					+ "ORDER BY ul_date DESC, ul_time DESC LIMIT ?, ?");
			
			pstmt.setString(1, modelParam.getUlDate());
			pstmt.setInt(2, modelParam.getListCount() * (pageNum-1));
			pstmt.setInt(3, modelParam.getListCount());
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				UserLogModel ul = new UserLogModel();
				ul.setUlPrevLink(rs.getString("ul_prev_link"));
				ul.setUlIp(rs.getString("ul_ip"));
				ul.setUlCountry(rs.getString("ul_country"));
				ul.setUlCity(rs.getString("ul_city"));
				ul.setUlDevice(rs.getString("ul_device"));
				ul.setUlDate(rs.getString("ul_date"));
				ul.setUlTime(rs.getString("ul_time"));
				
				listUL.add(ul);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listUL;
	}
	
	// 유저 목록 갯수 조회
	public int selectCountListUserLog(UserLogModel modelParam){
		int totalCount = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT COUNT(*) AS total FROM user_log WHERE ul_date=?");
			
			pstmt.setString(1, modelParam.getUlDate());
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return totalCount;
	}
	
	
	
	////////////////////////////////////////////////////
	// ---------------- 사용자 정보 관련 ----------------------//
	///////////////////////////////////////////////////
	
	/// 사용자 정보 등록
	public void insertUserInfo(UserInfoModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"INSERT INTO user_info(ui_id, ui_name, ui_profile, ui_infollow) VALUES(?, ?, ?, ?)");
			
			pstmt.setString(1, modelParam.getUiId());
			pstmt.setString(2, modelParam.getUiName());
			pstmt.setString(3, modelParam.getUiProfile());
			pstmt.setString(4, modelParam.getUiInfollow());
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 사용자 정보 조회
	public UserInfoModel selectUserInfo(UserInfoModel modelParam) {
		
		UserInfoModel userInfo = new UserInfoModel();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT * FROM user_info WHERE ui_id=? AND ui_name=?");
			
			pstmt.setString(1, modelParam.getUiId());
			pstmt.setString(2, modelParam.getUiName());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				userInfo.setUiNo(rs.getInt("ui_no"));
				userInfo.setUiId(rs.getString("ui_id"));
				userInfo.setUiName(rs.getString("ui_name"));
				userInfo.setUiProfile(rs.getString("ui_profile"));
				userInfo.setUiInfollow(rs.getString("ui_infollow"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return userInfo;
	}
	
	
	
	
	////////////////////////////////////////////////////
	// ---------------- 공지사항 관련 ----------------------//
	///////////////////////////////////////////////////
	
	// 공지사항 목록 불러오기
	public List<NoticeInfoModel> selectListNoticeInfo(NoticeInfoModel modelParam){
		List<NoticeInfoModel> listNI = new ArrayList<NoticeInfoModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT ni_no, ni_thumbnail, ni_content, ni_title, ni_author, ni_date, ni_view, ni_top_fix, ni_sort "
					+ "FROM notice_info "
					+ "WHERE ni_title LIKE CONCAT('%', ?, '%') "
					+ "ORDER BY ni_sort DESC LIMIT ?, ?");
			
			pstmt.setString(1, modelParam.getNiContent());
			pstmt.setInt(2, modelParam.getListCount() * (pageNum-1));
			pstmt.setInt(3, modelParam.getListCount());
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				NoticeInfoModel ni = new NoticeInfoModel();
				ni.setNiNo(rs.getInt("ni_no"));
				ni.setNiThumbnail(rs.getString("ni_thumbnail"));
				ni.setNiContent(rs.getString("ni_content"));
				ni.setNiTitle(rs.getString("ni_title"));
				ni.setNiAuthor(rs.getString("ni_author"));
				ni.setNiDate(rs.getString("ni_date"));
				ni.setNiView(rs.getInt("ni_view"));
				ni.setNiTopFix(rs.getString("ni_top_fix"));
				ni.setNiSort(rs.getInt("ni_sort"));
				
				listNI.add(ni);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listNI;
	}
	
	// 공지사항 갯수 불러오기
	public int selectCountListNoticeInfo(NoticeInfoModel modelParam){
		int totalCount = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT COUNT(ni_no) AS total FROM notice_info WHERE ni_title LIKE CONCAT('%', ?, '%')");
			
			pstmt.setString(1, modelParam.getNiContent());
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return totalCount;
	}
	
	// 공지사항 조회수 올리기
	public void updateNoticeView(int niNo, int view){
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"UPDATE notice_info SET ni_view=? WHERE ni_no=?");
			
			pstmt.setInt(1, view);
			pstmt.setInt(2, niNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	// 공지사항 조회하기
	public NoticeInfoModel selectNoticeInfo(int niNo){
		NoticeInfoModel ni = new NoticeInfoModel();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT ni_no, ni_thumbnail, ni_content, ni_title, ni_author, ni_date, ni_view, ni_top_fix "
					+ "FROM notice_info "
					+ "WHERE ni_no=?");
			
			pstmt.setInt(1, niNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				ni.setNiNo(rs.getInt("ni_no"));
				ni.setNiThumbnail(rs.getString("ni_thumbnail"));
				ni.setNiContent(rs.getString("ni_content"));
				ni.setNiTitle(rs.getString("ni_title"));
				ni.setNiAuthor(rs.getString("ni_author"));
				ni.setNiDate(rs.getString("ni_date"));
				ni.setNiView(rs.getInt("ni_view"));
				ni.setNiTopFix(rs.getString("ni_top_fix"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return ni;
	}
	
	// 공지사항 등록
	public int insertNoticeInfo(NoticeInfoModel modelParam){
		int niNo = -1;
		int sort = 1;
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT MAX(ni_sort) AS max_sort FROM notice_info");
			
			rs = pstmt.executeQuery();
			if(rs.next())
				sort = rs.getInt("max_sort")+1;
			
			pstmt = connection.prepareStatement(
					"INSERT INTO notice_info(ni_thumbnail, ni_content, ni_title, ni_author, ni_date, ni_view, ni_top_fix, ni_sort) "
					+ "VALUES(?, ?, ?, ?, NOW(), ?, ?, ?)");
			
			pstmt.setString(1, modelParam.getNiThumbnail());
			pstmt.setString(2, modelParam.getNiContent());
			pstmt.setString(3, modelParam.getNiTitle());
			pstmt.setString(4, modelParam.getNiAuthor());
			pstmt.setInt(5, modelParam.getNiView());
			pstmt.setString(6, modelParam.getNiTopFix());
			pstmt.setInt(7, sort);
			
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement(
					"SELECT MAX(ni_no) AS max_no FROM notice_info");
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				niNo = rs.getInt("max_no");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return niNo;
	}
	
	// 공지 정렬 다운
	public void noticeSortDown(NoticeInfoModel modelParam){
		int targetNo = -1;
		int targetSort = -1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT ni_sort, ni_no FROM notice_info WHERE ni_sort<? ORDER BY ni_sort DESC LIMIT 1");
			
			pstmt.setInt(1, modelParam.getNiSort());
			rs = pstmt.executeQuery();
			if(rs.next()){
				targetNo = rs.getInt("ni_no");
				targetSort = rs.getInt("ni_sort");
			}
			
			pstmt = connection.prepareStatement(
					"UPDATE notice_info SET ni_sort=? WHERE ni_no=?");
			
			pstmt.setInt(1, targetSort);
			pstmt.setInt(2, modelParam.getNiNo());
			
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement(
					"UPDATE notice_info SET ni_sort=? WHERE ni_no=?");
			
			pstmt.setInt(1, modelParam.getNiSort());
			pstmt.setInt(2, targetNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	// 공지 정렬 업
	public void noticeSortUp(NoticeInfoModel modelParam){
		int targetNo = -1;
		int targetSort = -1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT ni_sort, ni_no FROM notice_info WHERE ni_sort>? ORDER BY ni_sort ASC LIMIT 1");
			
			pstmt.setInt(1, modelParam.getNiSort());
			rs = pstmt.executeQuery();
			if(rs.next()){
				targetNo = rs.getInt("ni_no");
				targetSort = rs.getInt("ni_sort");
			}
			
			pstmt = connection.prepareStatement(
					"UPDATE notice_info SET ni_sort=? WHERE ni_no=?");
			
			pstmt.setInt(1, targetSort);
			pstmt.setInt(2, modelParam.getNiNo());
			
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement(
					"UPDATE notice_info SET ni_sort=? WHERE ni_no=?");
			
			pstmt.setInt(1, modelParam.getNiSort());
			pstmt.setInt(2, targetNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	
	// 공지사항 수정
	public void updateNoticeInfo(NoticeInfoModel modelParam){
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"UPDATE notice_info SET ni_thumbnail=?, ni_content=?, ni_title=?, ni_author=? "
					+ "WHERE ni_no=?");
			
			pstmt.setString(1, modelParam.getNiThumbnail());
			pstmt.setString(2, modelParam.getNiContent());
			pstmt.setString(3, modelParam.getNiTitle());
			pstmt.setString(4, modelParam.getNiAuthor());
			pstmt.setInt(5, modelParam.getNiNo());
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
	}
	
	// 공지사항 삭제
	public void deleteNoticeInfo(int niNo){
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"DELETE FROM notice_info WHERE ni_no=?");
			
			pstmt.setInt(1, niNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
	}
	
	// 공지사항 탑 고정 관련
	public void updateNoticeTopFix(int niNo){
		boolean bRet = false;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT ni_no FROM notice_info WHERE ni_no=? AND ni_top_fix=?");
			
			pstmt.setInt(1, niNo);
			pstmt.setString(2, "1");
			
			rs = pstmt.executeQuery();
			if(rs.next())
				bRet = true;
			
			
			if(bRet){
				pstmt = connection.prepareStatement(
						"UPDATE notice_info SET ni_top_fix=? WHERE ni_no=?");
				
				pstmt.setString(1, "0");
				pstmt.setInt(2, niNo);
				
				pstmt.executeUpdate();
			}
			else{
				pstmt = connection.prepareStatement(
						"UPDATE notice_info SET ni_top_fix=? WHERE ni_no=?");
				
				pstmt.setString(1, "1");
				pstmt.setInt(2, niNo);
				
				pstmt.executeUpdate();
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
	}
	
	
	// 공지사항 좋아요 수
	public int getNoticeLikeCount(int niNo) {
		
		int count = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(li_no) AS cnt FROM like_info WHERE board_no=? AND board_type='notice_info'");
			
			pstmt.setInt(1, niNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}
	
	// 공지사항 답글 수
	public int getNoticeReplyCount(int niNo) {
		
		int count = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(nr_no) AS cnt FROM notice_reply WHERE ni_no=?");
			
			pstmt.setInt(1, niNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}
	
	// 공지사항 참여인원 수(좋아요, 답글 중복 제거)
	public int getNoticePartCount(int niNo) {
		
		int count = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(li_no) AS cnt FROM like_info WHERE board_no=? AND board_type='notice_info'");
			
			pstmt.setInt(1, niNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			////////////////
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(nr_no) AS cnt FROM notice_reply "
					+ "WHERE ni_no=? AND nr_delete=0 AND ui_no NOT IN (SELECT ui_no FROM like_info WHERE board_no=? AND board_type='notice_info') "
					+ "GROUP BY ui_no");
			
			pstmt.setInt(1, niNo);
			pstmt.setInt(2, niNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}
	
	
	
	
	////////////////////////////////////////////////////
	// ------------------- 뉴스 관련 ----------------------//
	////////////////////////////////////////////////////
	
	// 뉴스 목록 불러오기
	public List<NewsInfoModel> selectListNewsInfo(NewsInfoModel modelParam){
		List<NewsInfoModel> listNews = new ArrayList<NewsInfoModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT news_no, news_thumbnail, news_content, news_title, news_author, news_date, news_view, news_sort "
					+ "FROM news_info "
					+ "ORDER BY news_sort DESC LIMIT ?, ?");
			
			pstmt.setInt(1, modelParam.getListCount() * (pageNum-1));
			pstmt.setInt(2, modelParam.getListCount());
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				NewsInfoModel newsInfo = new NewsInfoModel();
				newsInfo.setNewsNo(rs.getInt("news_no"));
				newsInfo.setNewsThumbnail(rs.getString("news_thumbnail"));
				newsInfo.setNewsContent(rs.getString("news_content"));
				newsInfo.setNewsTitle(rs.getString("news_title"));
				newsInfo.setNewsAuthor(rs.getString("news_author"));
				newsInfo.setNewsDate(rs.getString("news_date"));
				newsInfo.setNewsView(rs.getInt("news_view"));
				newsInfo.setNewsSort(rs.getInt("news_sort"));
				
				listNews.add(newsInfo);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listNews;
	}
	
	// 뉴스 갯수 불러오기
	public int selectCountListNewsInfo(NewsInfoModel modelParam){
		int totalCount = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT COUNT(news_no) AS total FROM news_info");
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return totalCount;
	}
	
	// 뉴스 조회하기
	public NewsInfoModel selectNewsInfo(int newsNo){
		NewsInfoModel newsInfo = new NewsInfoModel();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT news_no, news_thumbnail, news_content, news_title, news_author, news_date, news_view "
					+ "FROM news_info "
					+ "WHERE news_no=?");
			
			pstmt.setInt(1, newsNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				newsInfo.setNewsNo(rs.getInt("news_no"));
				newsInfo.setNewsThumbnail(rs.getString("news_thumbnail"));
				newsInfo.setNewsContent(rs.getString("news_content"));
				newsInfo.setNewsTitle(rs.getString("news_title"));
				newsInfo.setNewsAuthor(rs.getString("news_author"));
				newsInfo.setNewsDate(rs.getString("news_date"));
				newsInfo.setNewsView(rs.getInt("news_view"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return newsInfo;
	}
	
	// 뉴스 등록
	public int insertNewsInfo(NewsInfoModel modelParam){
		int newsNo = -1;
		int sort = 1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			pstmt = connection.prepareStatement(
					"SELECT MAX(news_sort) AS max_sort FROM news_info");
			
			rs = pstmt.executeQuery();
			if(rs.next())
				sort = rs.getInt("max_sort")+1;
			
			pstmt = connection.prepareStatement(
					"INSERT INTO news_info(news_thumbnail, news_content, news_title, news_author, news_date, news_view, news_sort) "
					+ "VALUES(?, ?, ?, ?, NOW(), ?, ?)");
			
			pstmt.setString(1, modelParam.getNewsThumbnail());
			pstmt.setString(2, modelParam.getNewsContent());
			pstmt.setString(3, modelParam.getNewsTitle());
			pstmt.setString(4, modelParam.getNewsAuthor());
			pstmt.setInt(5, modelParam.getNewsView());
			pstmt.setInt(6, sort);
			
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement(
					"SELECT MAX(news_no) AS max_no FROM news_info");
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				newsNo = rs.getInt("max_no");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return newsNo;
	}
	
	// 뉴스 정렬 다운
	public void newsSortDown(NewsInfoModel modelParam){
		int targetNo = -1;
		int targetSort = -1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT news_sort, news_no FROM news_info WHERE news_sort<? ORDER BY news_sort DESC LIMIT 1");
			
			pstmt.setInt(1, modelParam.getNewsSort());
			rs = pstmt.executeQuery();
			if(rs.next()){
				targetNo = rs.getInt("news_no");
				targetSort = rs.getInt("news_sort");
			}
			
			pstmt = connection.prepareStatement(
					"UPDATE news_info SET news_sort=? WHERE news_no=?");
			
			pstmt.setInt(1, targetSort);
			pstmt.setInt(2, modelParam.getNewsNo());
			
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement(
					"UPDATE news_info SET news_sort=? WHERE news_no=?");
			
			pstmt.setInt(1, modelParam.getNewsSort());
			pstmt.setInt(2, targetNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	// 뉴스 정렬 업
	public void newsSortUp(NewsInfoModel modelParam){
		int targetNo = -1;
		int targetSort = -1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT news_sort, news_no FROM news_info WHERE news_sort>? ORDER BY news_sort ASC LIMIT 1");
			
			pstmt.setInt(1, modelParam.getNewsSort());
			rs = pstmt.executeQuery();
			if(rs.next()){
				targetNo = rs.getInt("news_no");
				targetSort = rs.getInt("news_sort");
			}
			
			pstmt = connection.prepareStatement(
					"UPDATE news_info SET news_sort=? WHERE news_no=?");
			
			pstmt.setInt(1, targetSort);
			pstmt.setInt(2, modelParam.getNewsNo());
			
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement(
					"UPDATE news_info SET news_sort=? WHERE news_no=?");
			
			pstmt.setInt(1, modelParam.getNewsSort());
			pstmt.setInt(2, targetNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	// 뉴스 수정
	public void updateNewsInfo(NewsInfoModel modelParam){
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"UPDATE news_info SET news_thumbnail=?, news_content=?, news_title=?, news_author=? "
					+ "WHERE news_no=?");
			
			pstmt.setString(1, modelParam.getNewsThumbnail());
			pstmt.setString(2, modelParam.getNewsContent());
			pstmt.setString(3, modelParam.getNewsTitle());
			pstmt.setString(4, modelParam.getNewsAuthor());
			pstmt.setInt(5, modelParam.getNewsNo());
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
	}
	
	// 뉴스 삭제
	public void deleteNewsInfo(int newsNo){
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"DELETE FROM news_info WHERE news_no=?");
			
			pstmt.setInt(1, newsNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
	}
	
	
	// 뉴스 좋아요 수
	public int getNewsLikeCount(int newsNo) {
		
		int count = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(li_no) AS cnt FROM like_info WHERE board_no=? AND board_type='news_info'");
			
			pstmt.setInt(1, newsNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}
	
	// 뉴스 답글 수
	public int getNewsReplyCount(int newsNo) {
		
		int count = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(nr_no) AS cnt FROM news_reply WHERE ni_no=?");
			
			pstmt.setInt(1, newsNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}
		
	// 뉴스 참여인원 수(좋아요, 답글 중복 제거)
	public int getNewsPartCount(int newsNo) {
		
		int count = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(li_no) AS cnt FROM like_info WHERE board_no=? AND board_type='news_info'");
			
			pstmt.setInt(1, newsNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			////////////////
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(nr_no) AS cnt FROM news_reply "
					+ "WHERE ni_no=? AND nr_delete=0 AND ui_no NOT IN (SELECT ui_no FROM like_info WHERE board_no=? AND board_type='news_info') "
					+ "GROUP BY ui_no");
			
			pstmt.setInt(1, newsNo);
			pstmt.setInt(2, newsNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}
	
	
	
	/////////////////////////////////////////////////////
	// ------------------ 컨텐츠 관련 -----------------------//
	/////////////////////////////////////////////////////
	
	// 컨텐츠 코드 목록 불러오기
	public List<ContentCodeModel> selectListContentCode(){
		List<ContentCodeModel> listCC = new ArrayList<ContentCodeModel>();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT cc_no, cc_name, cc_del FROM content_code WHERE cc_del<>'1' ORDER BY cc_no ASC");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				ContentCodeModel cc = new ContentCodeModel();
				cc.setCcNo(rs.getInt("cc_no"));
				cc.setCcName(rs.getString("cc_name"));
				cc.setCcDel(rs.getString("cc_del"));
				listCC.add(cc);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listCC;
	}
	
	// 컨텐츠 목록 불러오기
	public List<ContentInfoModel> selectListContentInfo(ContentInfoModel modelParam){
		List<ContentInfoModel> listCI = new ArrayList<ContentInfoModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT i.ci_no, i.cc_no, i.ci_thumbnail, i.ci_content, i.ci_title, i.ci_author, i.ci_date, i.ci_view, i.ci_link, i.ci_sort, "
					+ "(select cc_name from content_code where cc_no=i.cc_no) AS cc_name "
					+ "FROM content_info i WHERE i.cc_no=? "
					+ "ORDER BY i.ci_sort DESC LIMIT ?, ?");
			
			pstmt.setInt(1, modelParam.getCcNo());
			pstmt.setInt(2, modelParam.getListCount() * (pageNum -1));
			pstmt.setInt(3, modelParam.getListCount());
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				ContentInfoModel ci = new ContentInfoModel();
				ci.setCiNo(rs.getInt("ci_no"));
				ci.setCcNo(rs.getInt("cc_no"));
				ci.setCiThumbnail(rs.getString("ci_thumbnail"));
				ci.setCiContent(rs.getString("ci_content"));
				ci.setCiTitle(rs.getString("ci_title"));
				ci.setCiAuthor(rs.getString("ci_author"));
				ci.setCiDate(rs.getString("ci_date"));
				ci.setCiView(rs.getInt("ci_view"));
				ci.setCiLink(rs.getString("ci_link"));
				ci.setCcName(rs.getString("cc_name"));
				ci.setCiSort(rs.getInt("ci_sort"));
				listCI.add(ci);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listCI;
	}
	
	// 컨텐츠 목록 갯수 구하기
	public int selectCountListContentInfo(ContentInfoModel modelParam){
		int totalCount = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT COUNT(ci_no) AS total FROM content_info WHERE cc_no=?");
			
			pstmt.setInt(1, modelParam.getCcNo());
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return totalCount;
	}
	
	// 컨텐츠 조회하기
	public ContentInfoModel selectContentInfo(int ciNo){
		ContentInfoModel ci = new ContentInfoModel();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT i.ci_no, i.cc_no, i.ci_thumbnail, i.ci_content, i.ci_title, i.ci_author, i.ci_date, i.ci_view, i.ci_link, "
					+ "(select cc_name from content_code where cc_no=i.cc_no) AS cc_name "
					+ "FROM content_info i "
					+ "WHERE ci_no=?");
			
			pstmt.setInt(1, ciNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				ci.setCiNo(rs.getInt("ci_no"));
				ci.setCcNo(rs.getInt("cc_no"));
				ci.setCiThumbnail(rs.getString("ci_thumbnail"));
				ci.setCiContent(rs.getString("ci_content"));
				ci.setCiTitle(rs.getString("ci_title"));
				ci.setCiAuthor(rs.getString("ci_author"));
				ci.setCiDate(rs.getString("ci_date"));
				ci.setCiView(rs.getInt("ci_view"));
				ci.setCiLink(rs.getString("ci_link"));
				ci.setCcName(rs.getString("cc_name"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return ci;
	}
	
	// 컨텐츠 등록하기
	public int insertContentInfo(ContentInfoModel modelParam){
		int ciNo = -1;
		int sort = 1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT MAX(ci_sort) AS max_sort FROM content_info WHERE cc_no=?");
			
			pstmt.setInt(1, modelParam.getCcNo());
			rs = pstmt.executeQuery();
			if(rs.next())
				sort = rs.getInt("max_sort")+1;
			
			pstmt = connection.prepareStatement(
					"INSERT INTO content_info(cc_no, ci_thumbnail, ci_content, ci_title, ci_author, ci_date, ci_view, ci_link, ci_sort) "
					+ "VALUES(?, ?, ?, ?, ?, NOW(), ?, ?, ?)");
			
			pstmt.setInt(1, modelParam.getCcNo());
			pstmt.setString(2, modelParam.getCiThumbnail());
			pstmt.setString(3, modelParam.getCiContent());
			pstmt.setString(4, modelParam.getCiTitle());
			pstmt.setString(5, modelParam.getCiAuthor());
			pstmt.setInt(6, modelParam.getCiView());
			pstmt.setString(7, modelParam.getCiLink());
			pstmt.setInt(8, sort);
			
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement(
					"SELECT MAX(ci_no) AS max_no FROM content_info");
			
			rs = pstmt.executeQuery();
			if(rs.next())
				ciNo = rs.getInt("max_no");
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return ciNo;
	}
	
	
	// 컨텐츠 정렬 다운
	public void contentSortDown(ContentInfoModel modelParam){
		int targetNo = -1;
		int targetSort = -1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT ci_sort, ci_no FROM content_info WHERE ci_sort<? AND cc_no=? ORDER BY ci_sort DESC LIMIT 1");
			
			pstmt.setInt(1, modelParam.getCiSort());
			pstmt.setInt(2, modelParam.getCcNo());
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				targetNo = rs.getInt("ci_no");
				targetSort = rs.getInt("ci_sort");
			}
			
			pstmt = connection.prepareStatement(
					"UPDATE content_info SET ci_sort=? WHERE ci_no=?");
			
			pstmt.setInt(1, targetSort);
			pstmt.setInt(2, modelParam.getCiNo());
			
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement(
					"UPDATE content_info SET ci_sort=? WHERE ci_no=?");
			
			pstmt.setInt(1, modelParam.getCiSort());
			pstmt.setInt(2, targetNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	// 컨텐츠 정렬 업
	public void contentSortUp(ContentInfoModel modelParam){
		int targetNo = -1;
		int targetSort = -1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT ci_sort, ci_no FROM content_info WHERE ci_sort>? AND cc_no=? ORDER BY ci_sort ASC LIMIT 1");
			
			pstmt.setInt(1, modelParam.getCiSort());
			pstmt.setInt(2, modelParam.getCcNo());
			rs = pstmt.executeQuery();
			if(rs.next()){
				targetNo = rs.getInt("ci_no");
				targetSort = rs.getInt("ci_sort");
			}
			
			pstmt = connection.prepareStatement(
					"UPDATE content_info SET ci_sort=? WHERE ci_no=?");
			
			pstmt.setInt(1, targetSort);
			pstmt.setInt(2, modelParam.getCiNo());
			
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement(
					"UPDATE content_info SET ci_sort=? WHERE ci_no=?");
			
			pstmt.setInt(1, modelParam.getCiSort());
			pstmt.setInt(2, targetNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	// 컨텐츠 수정하기
	public void updateContentInfo(ContentInfoModel modelParam){
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"UPDATE content_info SET cc_no=?, ci_thumbnail=?, ci_content=?, ci_title=?, "
					+ "ci_author=?, ci_link=? "
					+ "WHERE ci_no=?");
			
			pstmt.setInt(1, modelParam.getCcNo());
			pstmt.setString(2, modelParam.getCiThumbnail());
			pstmt.setString(3, modelParam.getCiContent());
			pstmt.setString(4, modelParam.getCiTitle());
			pstmt.setString(5, modelParam.getCiAuthor());
			pstmt.setString(6, modelParam.getCiLink());
			pstmt.setInt(7, modelParam.getCiNo());
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	// 컨텐츠 삭제하기
	public void deleteContentInfo(int ciNo){
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"DELETE FROM content_info WHERE ci_no=?");
			
			pstmt.setInt(1, ciNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	
	
	////////////////////////////////////////////////////
	// ---------------- 토론방 관련 ----------------------//
	///////////////////////////////////////////////////
	
	/// 토론방 목록 불러오기
	public List<DebateInfoModel> selectListDebateInfo(DebateInfoModel modelParam) {
		
		List<DebateInfoModel> listDI = new ArrayList<DebateInfoModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		String whereSQL = "";
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			if("all".equals(modelParam.getDiApprove())==false)
				whereSQL = " AND di_approve='"+modelParam.getDiApprove()+"' ";
			
			pstmt = connection.prepareStatement(
					"SELECT di_no, di_title, di_content, di_author, ui_no, di_date, di_view, di_sort, di_top_fix, di_approve, "
					+ "(select count(li_no) from like_info where board_no=di_no and board_type='debate_info' and li_type='like') AS like_cnt, "
					+ "(select count(li_no) from like_info where board_no=di_no and board_type='debate_info' and li_type='dislike') AS dislike_cnt "
					+ "FROM debate_info "
					+ "WHERE di_title LIKE CONCAT('%', ?, '%') " + whereSQL
					+ "ORDER BY di_sort DESC LIMIT ?, ?");
			
			pstmt.setString(1, modelParam.getDiTitle());
			pstmt.setInt(2, modelParam.getListCount() * (pageNum-1));
			pstmt.setInt(3, modelParam.getListCount());
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				DebateInfoModel di = new DebateInfoModel();
				di.setDiNo(rs.getInt("di_no"));
				di.setDiTitle(rs.getString("di_title"));
				di.setDiContent(rs.getString("di_content"));
				di.setDiAuthor(rs.getString("di_author"));
				di.setUiNo(rs.getInt("ui_no"));
				di.setDiDate(rs.getString("di_date"));
				di.setDiView(rs.getInt("di_view"));
				di.setDiSort(rs.getInt("di_sort"));
				di.setDiTopFix(rs.getString("di_top_fix"));
				di.setDiApprove(rs.getString("di_approve"));
				di.setLikeCnt(rs.getInt("like_cnt"));
				di.setDislikeCnt(rs.getInt("dislike_cnt"));
				
				listDI.add(di);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listDI;
	}	
	
	/// 토론방 갯수 불러오기
	public int selectCountDebateInfo(DebateInfoModel modelParam) {
		
		int count = 0;
		String whereSQL = "";
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			if("all".equals(modelParam.getDiApprove())==false)
				whereSQL = " AND di_approve='"+modelParam.getDiApprove()+"' ";
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(di_no) AS cnt FROM debate_info "
					+ "WHERE di_title LIKE CONCAT('%', ?, '%') " + whereSQL);
			
			pstmt.setString(1, modelParam.getDiTitle());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}
	
	/// 토론방 조회수 올리기
	public void updateDebateView(int diNo, int view) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"UPDATE debate_info SET di_view=? WHERE di_no=?");
			
			pstmt.setInt(1, view);
			pstmt.setInt(2, diNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 토론방 조회하기
	public DebateInfoModel selectDebateInfo(int diNo) {
		
		DebateInfoModel di = new DebateInfoModel();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT * "
					+ "FROM debate_info "
					+ "WHERE di_no=?");
			
			pstmt.setInt(1, diNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				di.setDiNo(rs.getInt("di_no"));
				di.setDiTitle(rs.getString("di_title"));
				di.setDiContent(rs.getString("di_content"));
				di.setDiAuthor(rs.getString("di_author"));
				di.setUiNo(rs.getInt("ui_no"));
				di.setDiDate(rs.getString("di_date"));
				di.setDiView(rs.getInt("di_view"));
				di.setDiSort(rs.getInt("di_sort"));
				di.setDiTopFix(rs.getString("di_top_fix"));
				di.setDiApprove(rs.getString("di_approve"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return di;
	}
	
	/// 토론방 등록
	public int insertDebateInfo(DebateInfoModel modelParam) {
		
		int diNo = -1;
		int sort = -1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT MAX(di_sort) AS max_sort FROM debate_info");
			
			rs = pstmt.executeQuery();
			if(rs.next())
				sort = rs.getInt("max_sort")+1;
			//////
			
			pstmt = connection.prepareStatement(
					"INSERT INTO "
					+ "debate_info(di_title, di_content, di_author, ui_no, di_date, di_sort) "
					+ "VALUES(?, ?, ?, ?, now(), ?)");
			
			pstmt.setString(1, modelParam.getDiTitle());
			pstmt.setString(2, modelParam.getDiContent());
			pstmt.setString(3, modelParam.getDiAuthor());
			pstmt.setInt(4, modelParam.getUiNo());
			pstmt.setInt(5, sort);
			
			pstmt.executeUpdate();
			//////
			
			pstmt = connection.prepareStatement(
					"SELECT MAX(di_no) AS max_no FROM debate_info");
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				diNo = rs.getInt("max_no");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return diNo;
	}
	
	/// 토론방 정렬 다운
	public void debateSortDown(DebateInfoModel modelParam) {
		
		int targetNo = -1;
		int targetSort = -1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT di_sort, di_no FROM debate_info WHERE di_sort<? ORDER BY di_sort DESC LIMIT 1");
			
			pstmt.setInt(1, modelParam.getDiSort());
			rs = pstmt.executeQuery();
			if(rs.next()){
				targetNo = rs.getInt("di_no");
				targetSort = rs.getInt("di_sort");
			}
			
			pstmt = connection.prepareStatement(
					"UPDATE debate_info SET di_sort=? WHERE di_no=?");
			
			pstmt.setInt(1, targetSort);
			pstmt.setInt(2, modelParam.getDiNo());
			
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement(
					"UPDATE debate_info SET di_sort=? WHERE di_no=?");
			
			pstmt.setInt(1, modelParam.getDiSort());
			pstmt.setInt(2, targetNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 토론방 정렬 업
	public void debateSortUp(DebateInfoModel modelParam) {
		
		int targetNo = -1;
		int targetSort = -1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT di_sort, di_no FROM debate_info WHERE di_sort>? ORDER BY di_sort ASC LIMIT 1");
			
			pstmt.setInt(1, modelParam.getDiSort());
			rs = pstmt.executeQuery();
			if(rs.next()){
				targetNo = rs.getInt("di_no");
				targetSort = rs.getInt("di_sort");
			}
			
			pstmt = connection.prepareStatement(
					"UPDATE debate_info SET di_sort=? WHERE di_no=?");
			
			pstmt.setInt(1, targetSort);
			pstmt.setInt(2, modelParam.getDiNo());
			
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement(
					"UPDATE debate_info SET di_sort=? WHERE di_no=?");
			
			pstmt.setInt(1, modelParam.getDiSort());
			pstmt.setInt(2, targetNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 토론방 수정
	public void updateDebateInfo(DebateInfoModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"UPDATE debate_info SET di_title=?, di_content=? "
					+ "WHERE di_no=?");
			
			pstmt.setString(1, modelParam.getDiTitle());
			pstmt.setString(2, modelParam.getDiContent());
			pstmt.setInt(3, modelParam.getDiNo());
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	// 토론방 삭제
	public void deleteDebateInfo(int diNo) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"DELETE FROM debate_info WHERE di_no=?");
			
			pstmt.setInt(1, diNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 토론방 상단 고정 관련
	public void updateDebateTopFix(int diNo) {
		
		boolean bRet = false;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT di_no FROM debate_info WHERE di_no=? AND di_top_fix=?");
			
			pstmt.setInt(1, diNo);
			pstmt.setString(2, "1");
			
			rs = pstmt.executeQuery();
			if(rs.next())
				bRet = true;			
			
			if(bRet){
				pstmt = connection.prepareStatement(
						"UPDATE debate_info SET di_top_fix=? WHERE di_no=?");
				
				pstmt.setString(1, "0");
				pstmt.setInt(2, diNo);
				
				pstmt.executeUpdate();
			}
			else{
				pstmt = connection.prepareStatement(
						"UPDATE debate_info SET di_top_fix=? WHERE di_no=?");
				
				pstmt.setString(1, "1");
				pstmt.setInt(2, diNo);
				
				pstmt.executeUpdate();
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 토론방 신청 승인 처리
	public void setDebateApprove(int diNo) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"UPDATE debate_info SET di_approve='1' WHERE di_no=?");
			
			pstmt.setInt(1, diNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	
	// 토론방 좋아요 수
	public int getDebateLikeCount(int debateNo, String type) {
		
		int count = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(li_no) AS cnt FROM like_info "
					+ "WHERE board_no=? AND board_type='debate_info' AND li_type=?");
			
			pstmt.setInt(1, debateNo);
			pstmt.setString(2, type);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}
	
	// 토론방 답글 수
	public int getDebateReplyCount(int debateNo) {
		
		int count = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(nr_no) AS cnt FROM debate_reply WHERE ni_no=?");
			
			pstmt.setInt(1, debateNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}
	
	// 토론방 참여인원 수(좋아요, 답글 중복 제거)
	public int getDebatePartCount(int debateNo) {
		
		int count = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(li_no) AS cnt FROM like_info WHERE board_no=? AND board_type='debate_info'");
			
			pstmt.setInt(1, debateNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			////////////////
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(nr_no) AS cnt FROM debate_reply "
					+ "WHERE ni_no=? AND nr_delete=0 AND ui_no NOT IN (SELECT ui_no FROM like_info WHERE board_no=? AND board_type='debate_info') "
					+ "GROUP BY ui_no");
			
			pstmt.setInt(1, debateNo);
			pstmt.setInt(2, debateNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}
	/////////////////////////////////////////////////////////////////
	
	
	////////////////////////////////////////////////////
	// ---------------- 청원 관련 ----------------------//
	///////////////////////////////////////////////////
	
	//// 청원 목록 불러오기
	public List<PetitionInfoModel> selectListPetitionInfo(PetitionInfoModel modelParam) {
		
		List<PetitionInfoModel> listPI = new ArrayList<PetitionInfoModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		String orderSQL = "";
		String whereSQL = "";
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			if("recommend".equals(modelParam.getOrderType()))
				orderSQL = " ORDER BY like_cnt DESC, pi_no DESC ";
			else
				orderSQL = " ORDER BY pi_date DESC, pi_no DESC ";
			
			if("1".equals(modelParam.getPiReply()))
				whereSQL = " AND TRIM(pi_reply)<>'' ";
			else if("0".equals(modelParam.getPiReply()))
				whereSQL = " AND TRIM(pi_reply)='' ";
			
			pstmt = connection.prepareStatement(
					"SELECT pi_no, pi_title, pi_content, pi_author, ui_no, pi_date, pi_view, pi_sort, pi_reply, "
					+ "(select count(li_no) from like_info where board_no=pi_no and board_type='petition_info' and li_type='like') AS like_cnt, "
					+ "(select count(nr_no) from petition_reply where ni_no=pi_no) AS reply_cnt "
					+ "FROM petition_info "
					+ "WHERE pi_title LIKE CONCAT('%', ?, '%') " + whereSQL
					+ orderSQL + " LIMIT ?, ?");
			
			pstmt.setString(1, modelParam.getPiTitle());
			pstmt.setInt(2, modelParam.getListCount() * (pageNum-1));
			pstmt.setInt(3, modelParam.getListCount());
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PetitionInfoModel pi = new PetitionInfoModel();
				pi.setPiNo(rs.getInt("pi_no"));
				pi.setPiTitle(rs.getString("pi_title"));
				pi.setPiContent(rs.getString("pi_content"));
				pi.setPiAuthor(rs.getString("pi_author"));
				pi.setUiNo(rs.getInt("ui_no"));
				pi.setPiDate(rs.getString("pi_date"));
				pi.setPiView(rs.getInt("pi_view"));
				pi.setPiSort(rs.getInt("pi_sort"));
				pi.setPiReply(rs.getString("pi_reply"));
				pi.setLikeCnt(rs.getInt("like_cnt"));
				pi.setReplyCnt(rs.getInt("reply_cnt"));
				
				listPI.add(pi);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listPI;
	}
	
	/// 청원 갯수 불러오기
	public int selectCountPetitionInfo(PetitionInfoModel modelParam) {
		
		int count = 0;
		String whereSQL = "";
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			if("1".equals(modelParam.getPiReply()))
				whereSQL = " AND TRIM(pi_reply)<>'' ";
			else if("0".equals(modelParam.getPiReply()))
				whereSQL = " AND TRIM(pi_reply)='' ";
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(pi_no) AS cnt FROM petition_info "
					+ "WHERE pi_title LIKE CONCAT('%', ?, '%') " + whereSQL);
			
			pstmt.setString(1, modelParam.getPiTitle());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}
	
	/// 청원 조회수 올리기
	public void updatePetitionView(int piNo, int view) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"UPDATE petition_info SET pi_view=? WHERE pi_no=?");
			
			pstmt.setInt(1, view);
			pstmt.setInt(2, piNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 청원 조회하기
	public PetitionInfoModel selectPetitionInfo(int piNo) {
		
		PetitionInfoModel pi = new PetitionInfoModel();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT * FROM petition_info WHERE pi_no=?");
			
			pstmt.setInt(1, piNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pi.setPiNo(rs.getInt("pi_no"));
				pi.setPiTitle(rs.getString("pi_title"));
				pi.setPiContent(rs.getString("pi_content"));
				pi.setPiAuthor(rs.getString("pi_author"));
				pi.setUiNo(rs.getInt("ui_no"));
				pi.setPiDate(rs.getString("pi_date"));
				pi.setPiView(rs.getInt("pi_view"));
				pi.setPiSort(rs.getInt("pi_sort"));
				pi.setPiReply(rs.getString("pi_reply").trim());
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return pi;
	}
	
	/// 청원 등록
	public int insertPetitionInfo(PetitionInfoModel modelParam) {
		
		int piNo = -1;
		int sort = -1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT MAX(pi_sort) AS max_sort FROM petition_info");
			
			rs = pstmt.executeQuery();
			if(rs.next())
				sort = rs.getInt("max_sort")+1;
			//////
			
			pstmt = connection.prepareStatement(
					"INSERT INTO "
					+ "petition_info(pi_title, pi_content, pi_author, ui_no, pi_date, pi_sort, pi_reply) "
					+ "VALUES(?, ?, ?, ?, now(), ?, ?)");
			
			pstmt.setString(1, modelParam.getPiTitle());
			pstmt.setString(2, modelParam.getPiContent());
			pstmt.setString(3, modelParam.getPiAuthor());
			pstmt.setInt(4, modelParam.getUiNo());
			pstmt.setInt(5, sort);
			pstmt.setString(6, modelParam.getPiReply());
			
			pstmt.executeUpdate();
			//////
			
			pstmt = connection.prepareStatement(
					"SELECT MAX(pi_no) AS max_no FROM petition_info");
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				piNo = rs.getInt("max_no");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return piNo;
	}
	
	/// 청원 정렬 다운
	public void petitionSortDown(PetitionInfoModel modelParam) {
		
		int targetNo = -1;
		int targetSort = -1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT pi_sort, pi_no FROM petition_info WHERE pi_sort<? ORDER BY pi_sort DESC LIMIT 1");
			
			pstmt.setInt(1, modelParam.getPiSort());
			rs = pstmt.executeQuery();
			if(rs.next()){
				targetNo = rs.getInt("pi_no");
				targetSort = rs.getInt("pi_sort");
			}
			
			pstmt = connection.prepareStatement(
					"UPDATE petition_info SET pi_sort=? WHERE pi_no=?");
			
			pstmt.setInt(1, targetSort);
			pstmt.setInt(2, modelParam.getPiNo());
			
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement(
					"UPDATE petition_info SET pi_sort=? WHERE pi_no=?");
			
			pstmt.setInt(1, modelParam.getPiSort());
			pstmt.setInt(2, targetNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 청원 정렬 업
	public void petitionSortUp(PetitionInfoModel modelParam) {
		
		int targetNo = -1;
		int targetSort = -1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT pi_sort, pi_no FROM petition_info WHERE pi_sort>? ORDER BY pi_sort ASC LIMIT 1");
			
			pstmt.setInt(1, modelParam.getPiSort());
			rs = pstmt.executeQuery();
			if(rs.next()){
				targetNo = rs.getInt("pi_no");
				targetSort = rs.getInt("pi_sort");
			}
			
			pstmt = connection.prepareStatement(
					"UPDATE petition_info SET pi_sort=? WHERE pi_no=?");
			
			pstmt.setInt(1, targetSort);
			pstmt.setInt(2, modelParam.getPiNo());
			
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement(
					"UPDATE petition_info SET pi_sort=? WHERE pi_no=?");
			
			pstmt.setInt(1, modelParam.getPiSort());
			pstmt.setInt(2, targetNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 청원 내역 수정
	public void updatePetitionInfo(PetitionInfoModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"UPDATE petition_info SET pi_title=?, pi_content=? "
					+ "WHERE pi_no=?");
			
			pstmt.setString(1, modelParam.getPiTitle());
			pstmt.setString(2, modelParam.getPiContent());
			pstmt.setInt(3, modelParam.getPiNo());
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 청원 삭제
	public void deletePetitionInfo(int piNo) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"DELETE FROM petition_info WHERE pi_no=?");
			
			pstmt.setInt(1, piNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 청원 답변 수정
	public void updatePetitionReply(PetitionInfoModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"UPDATE petition_info SET pi_reply=? WHERE pi_no=?");
			
			pstmt.setString(1, modelParam.getPiReply());
			pstmt.setInt(2, modelParam.getPiNo());
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 청원 좋아요 수
	public int getPetitionLikeCount(int petitionNo) {
		
		int count = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(li_no) AS cnt FROM like_info WHERE board_no=? AND board_type='petition_info'");
			
			pstmt.setInt(1, petitionNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}
	
	/// 청원 답글 수
	public int getPetitionReplyCount(int petitionNo) {
		
		int count = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(nr_no) AS cnt FROM petition_reply WHERE ni_no=?");
			
			pstmt.setInt(1, petitionNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}
	
	// 청원 참여인원 수(좋아요, 답글 중복 제거)
	public int getPetitionPartCount(int petitionNo) {
		
		int count = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(li_no) AS cnt FROM like_info WHERE board_no=? AND board_type='petition_info'");
			
			pstmt.setInt(1, petitionNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			////////////////
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(nr_no) AS cnt FROM petition_reply "
					+ "WHERE ni_no=? AND nr_delete=0 AND ui_no NOT IN (SELECT ui_no FROM like_info WHERE board_no=? AND board_type='petition_info') "
					+ "GROUP BY ui_no");
			
			pstmt.setInt(1, petitionNo);
			pstmt.setInt(2, petitionNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count += rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}	
	/////////////////////////////////////////////////////////////////
	
	
	////////////////////////////////////////////////////
	// ---------------- 캘린더 관련 ----------------------//
	///////////////////////////////////////////////////
	
	/// 캘린더 목록 불러오기
	public List<CalendarInfoModel> selectListCalendarInfo(CalendarInfoModel modelParam) {
		
		List<CalendarInfoModel> listCal = new ArrayList<CalendarInfoModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT * FROM calendar_info "
					+ "WHERE cal_start_date LIKE CONCAT(?, '%') "
					+ "ORDER BY cal_start_date ASC LIMIT ?, ?");
			
			pstmt.setString(1, modelParam.getCalStartDate());
			pstmt.setInt(2, modelParam.getListCount() * (pageNum-1));
			pstmt.setInt(3, modelParam.getListCount());
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CalendarInfoModel cal = new CalendarInfoModel();
				cal.setCalNo(rs.getInt("cal_no"));
				cal.setCalTag(rs.getString("cal_tag"));
				cal.setCalTitle(rs.getString("cal_title"));
				cal.setCalComment(rs.getString("cal_comment"));
				cal.setCalTime(rs.getString("cal_time"));
				cal.setCalPlace(rs.getString("cal_place"));
				cal.setCalStartDate(rs.getString("cal_start_date"));
				cal.setCalEndDate(rs.getString("cal_end_date"));
				cal.setCalContent(rs.getString("cal_content"));
				
				listCal.add(cal);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listCal;
	}
	
	// 캘린더 목록 불러오기 (뷰)
	public List<CalendarInfoModel> selectListCalendarInfo(String startDate, String endDate) {
		
		List<CalendarInfoModel> listCal = new ArrayList<CalendarInfoModel>();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT cal_no, cal_tag, cal_title, cal_comment, cal_time, cal_place, cal_start_date, cal_end_date, cal_content, cal_link, "
					+ "(TO_DAYS(NOW())-TO_DAYS(cal_start_date)) AS cal_dday "
					+ "FROM calendar_info WHERE cal_start_date >= ? AND cal_start_date <= ? ORDER BY cal_start_date ASC");
			
			pstmt.setString(1, startDate);
			pstmt.setString(2, endDate);

			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CalendarInfoModel cal = new CalendarInfoModel();
				
				cal.setCalNo(rs.getInt("cal_no"));
				cal.setCalTag(rs.getString("cal_tag"));
				cal.setCalTitle(rs.getString("cal_title"));
				cal.setCalComment(rs.getString("cal_comment"));
				cal.setCalTime(rs.getString("cal_time"));
				cal.setCalPlace(rs.getString("cal_place"));
				cal.setCalStartDate(rs.getString("cal_start_date"));
				cal.setCalEndDate(rs.getString("cal_end_date"));
				cal.setCalContent(rs.getString("cal_content"));
				if(rs.getString("cal_dday").indexOf('-') == -1){
					cal.setCalDday("D+"+rs.getString("cal_dday"));
				}else{
					cal.setCalDday("D"+rs.getString("cal_dday"));
				}
				
				listCal.add(cal);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listCal;
	}
	
	/// 캘린더 개수 불러오기
	public int selectCountCalendarInfo(CalendarInfoModel modelParam) {
		
		int count = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT COUNT(cal_no) AS cnt FROM calendar_info "
					+ "WHERE cal_start_date LIKE CONCAT(?, '%') ");
			
			pstmt.setString(1, modelParam.getCalStartDate());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("cnt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return count;
	}
	
	/// 캘린더 조회하기
	public CalendarInfoModel selectCalendarInfo(int calNo) {
		
		CalendarInfoModel cal = new CalendarInfoModel();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT * FROM calendar_info WHERE cal_no=?");
			
			pstmt.setInt(1, calNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cal.setCalNo(rs.getInt("cal_no"));
				cal.setCalTag(rs.getString("cal_tag"));
				cal.setCalTitle(rs.getString("cal_title"));
				cal.setCalComment(rs.getString("cal_comment"));
				cal.setCalTime(rs.getString("cal_time"));
				cal.setCalPlace(rs.getString("cal_place"));
				cal.setCalContent(rs.getString("cal_content"));
				cal.setCalStartDate(rs.getString("cal_start_date"));
				cal.setCalEndDate(rs.getString("cal_end_date"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return cal;
	}
	
	/// 캘린더 등록
	public void insertCalendarInfo(CalendarInfoModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"INSERT INTO "
					+ "calendar_info(cal_tag, cal_title, cal_comment, cal_time, cal_place, cal_content, cal_start_date, cal_end_date) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?)");
			
			pstmt.setString(1, modelParam.getCalTag());
			pstmt.setString(2, modelParam.getCalTitle());
			pstmt.setString(3, modelParam.getCalComment());
			pstmt.setString(4, modelParam.getCalTime());
			pstmt.setString(5, modelParam.getCalPlace());
			pstmt.setString(6, modelParam.getCalContent());
			pstmt.setString(7, modelParam.getCalStartDate());
			pstmt.setString(8, modelParam.getCalEndDate());
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 캘린더 수정
	public void updateCalendarInfo(CalendarInfoModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"UPDATE calendar_info "
					+ "SET cal_tag=?, cal_title=?, cal_comment=?, cal_time=?, cal_place=?, "
					+ "cal_content=?, cal_start_date=?, cal_end_date=? "
					+ "WHERE cal_no=?");
			
			pstmt.setString(1, modelParam.getCalTag());
			pstmt.setString(2, modelParam.getCalTitle());
			pstmt.setString(3, modelParam.getCalComment());
			pstmt.setString(4, modelParam.getCalTime());
			pstmt.setString(5, modelParam.getCalPlace());
			pstmt.setString(6, modelParam.getCalContent());
			pstmt.setString(7, modelParam.getCalStartDate());
			pstmt.setString(8, modelParam.getCalEndDate());
			pstmt.setInt(9, modelParam.getCalNo());
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 캘린더 삭제
	public void deleteCalendarInfo(int calNo) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"DELETE FROM calendar_info WHERE cal_no=?");
			
			pstmt.setInt(1, calNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/////////////////////////////////////////////////////////////////
	
	
	// 공지사항 목록 불러오기 메인용
	public List<NoticeInfoModel> selectListNoticeInfoForMain(int listCount){
		List<NoticeInfoModel> listNI = new ArrayList<NoticeInfoModel>();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT ni_no, ni_thumbnail, ni_content, ni_title, ni_author, ni_date, ni_view, "
					+ "ni_top_fix "
					+ "FROM notice_info "
					+ "ORDER BY ni_sort DESC LIMIT ?");
			
			pstmt.setInt(1, listCount);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				NoticeInfoModel ni = new NoticeInfoModel();
				ni.setNiNo(rs.getInt("ni_no"));
				ni.setNiThumbnail(rs.getString("ni_thumbnail"));
				ni.setNiTitle(rs.getString("ni_title"));
				ni.setNiAuthor(rs.getString("ni_author"));
				ni.setNiDate(rs.getString("ni_date"));
				ni.setNiView(rs.getInt("ni_view"));
				ni.setNiTopFix(rs.getString("ni_top_fix"));
				listNI.add(ni);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listNI;
	}
	
	
	// 컨텐츠 목록 불러오기 메인용
	public List<ContentInfoModel> selectListContentInfoForMain(int listCount){
		List<ContentInfoModel> listCI = new ArrayList<ContentInfoModel>();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT i.ci_no, i.cc_no, i.ci_thumbnail, i.ci_content, i.ci_title, i.ci_author, i.ci_date, i.ci_view, i.ci_link, "
					+ "(select cc_name from content_code where cc_no=i.cc_no) AS cc_name "
					+ "FROM content_info i "
					+ "ORDER BY i.ci_sort ASC LIMIT ?");
			
			pstmt.setInt(1, listCount);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				ContentInfoModel ci = new ContentInfoModel();
				ci.setCiNo(rs.getInt("ci_no"));
				ci.setCcNo(rs.getInt("cc_no"));
				ci.setCiThumbnail(rs.getString("ci_thumbnail"));
				ci.setCiContent(rs.getString("ci_content"));
				ci.setCiTitle(rs.getString("ci_title"));
				ci.setCiAuthor(rs.getString("ci_author"));
				ci.setCiDate(rs.getString("ci_date"));
				ci.setCiView(rs.getInt("ci_view"));
				ci.setCiLink(rs.getString("ci_link"));
				ci.setCcName(rs.getString("cc_name"));
				
				listCI.add(ci);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listCI;
	}
	
	// 뉴스 목록 불러오기 메인용
	public List<NewsInfoModel> selectListNewsInfoForMain(int listCount){
		List<NewsInfoModel> listNews = new ArrayList<NewsInfoModel>();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT news_no, news_thumbnail, news_content, news_title, news_author, news_date, news_view "
					+ "FROM news_info "
					+ "ORDER BY news_sort DESC LIMIT ?");
			
			pstmt.setInt(1, listCount);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				NewsInfoModel news = new NewsInfoModel();
				news.setNewsNo(rs.getInt("news_no"));
				news.setNewsThumbnail(rs.getString("news_thumbnail"));
				news.setNewsContent(rs.getString("news_content"));
				news.setNewsTitle(rs.getString("news_title"));
				news.setNewsAuthor(rs.getString("news_author"));
				news.setNewsDate(rs.getString("news_date"));
				news.setNewsView(rs.getInt("news_view"));
				
				listNews.add(news);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listNews;
	}
	
	// 공지 리스트용 메인 공지 하나 조회
	public List<NoticeInfoModel> selectNoticeInfoForListTop(){
		
		List<NoticeInfoModel> listNotice = new ArrayList<NoticeInfoModel>();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT ni_no, ni_thumbnail, ni_content, ni_title, ni_author, ni_date, ni_view, ni_top_fix "
					+ "FROM notice_info WHERE ni_top_fix='1' "
					+ "ORDER BY ni_date DESC LIMIT 5");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				NoticeInfoModel ni = new NoticeInfoModel();
				ni.setNiNo(rs.getInt("ni_no"));
				ni.setNiThumbnail(rs.getString("ni_thumbnail"));
				ni.setNiContent(rs.getString("ni_content"));
				ni.setNiTitle(rs.getString("ni_title"));
				ni.setNiAuthor(rs.getString("ni_author"));
				ni.setNiDate(rs.getString("ni_date"));
				ni.setNiView(rs.getInt("ni_view"));
				ni.setNiTopFix(rs.getString("ni_top_fix"));
				
				listNotice.add(ni);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listNotice;
	}
	
	// 공지사항 최근꺼 자기꺼 빼고 조회하기
	public NoticeInfoModel selectNoticeInfoRecently(int niNo){
		NoticeInfoModel ni = new NoticeInfoModel();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT ni_no, ni_thumbnail, ni_content, ni_title, ni_author, ni_date, ni_view, ni_top_fix "
					+ "FROM notice_info WHERE ni_no<>? "
					+ "ORDER BY ni_date DESC LIMIT 1");
			
			pstmt.setInt(1, niNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				ni.setNiNo(rs.getInt("ni_no"));
				ni.setNiThumbnail(rs.getString("ni_thumbnail"));
				ni.setNiContent(rs.getString("ni_content"));
				ni.setNiTitle(rs.getString("ni_title"));
				ni.setNiAuthor(rs.getString("ni_author"));
				ni.setNiDate(rs.getString("ni_date"));
				ni.setNiView(rs.getInt("ni_view"));
				ni.setNiTopFix(rs.getString("ni_top_fix"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return ni;
	}
	
	// 컨텐츠 최신거 하나 불러오기
	public ContentInfoModel selectContentInfoRecently(int ciNo){
		ContentInfoModel ci = new ContentInfoModel();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT i.ci_no, i.cc_no, i.ci_thumbnail, i.ci_content, i.ci_title, i.ci_author, i.ci_date, i.ci_view, i.ci_link, "
					+ "(select cc_name from content_code where cc_no=i.cc_no) AS cc_name "
					+ "FROM content_info i "
					+ "WHERE ci_no<>? "
					+ "ORDER BY i.ci_date DESC LIMIT 1");
			
			pstmt.setInt(1, ciNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				ci.setCiNo(rs.getInt("ci_no"));
				ci.setCcNo(rs.getInt("cc_no"));
				ci.setCiThumbnail(rs.getString("ci_thumbnail"));
				ci.setCiContent(rs.getString("ci_content"));
				ci.setCiTitle(rs.getString("ci_title"));
				ci.setCiAuthor(rs.getString("ci_author"));
				ci.setCiDate(rs.getString("ci_date"));
				ci.setCiView(rs.getInt("ci_view"));
				ci.setCiLink(rs.getString("ci_link"));
				ci.setCcName(rs.getString("cc_name"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return ci;
	}
	
	// 뉴스 최신거 하나 조회하기
	public NewsInfoModel selectNewsInfoRecently(int newsNo){
		NewsInfoModel newsInfo = new NewsInfoModel();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT news_no, news_thumbnail, news_content, news_title, news_author, news_date, news_view "
					+ "FROM news_info "
					+ "WHERE news_no<>? "
					+ "ORDER BY news_date DESC LIMIT 1");
			
			pstmt.setInt(1, newsNo);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				newsInfo.setNewsNo(rs.getInt("news_no"));
				newsInfo.setNewsThumbnail(rs.getString("news_thumbnail"));
				newsInfo.setNewsContent(rs.getString("news_content"));
				newsInfo.setNewsTitle(rs.getString("news_title"));
				newsInfo.setNewsAuthor(rs.getString("news_author"));
				newsInfo.setNewsDate(rs.getString("news_date"));
				newsInfo.setNewsView(rs.getInt("news_view"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return newsInfo;
	}
	
	/// 토론 최신 6개 자기거 빼고
	public List<DebateInfoModel> selectDebateInfoRecently(int diNo) {
		
		List<DebateInfoModel> listDI = new ArrayList<DebateInfoModel>();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT di_no, di_title FROM debate_info "
					+ "WHERE di_no<>? AND di_approve='1' "
					+ "ORDER BY di_date DESC LIMIT 6");
			
			pstmt.setInt(1, diNo);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				DebateInfoModel di = new DebateInfoModel();
				di.setDiNo(rs.getInt("di_no"));
				di.setDiTitle(rs.getString("di_title"));
				
				listDI.add(di);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listDI;
	}
	
	// 컨텐츠 토탈카운트 조회
	public int selectCountContent(ContentInfoModel modelParam) {
		int totalCount = 0;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			if("total".equals(modelParam.getCcName())){
				pstmt = connection.prepareStatement(
						"SELECT count(*) AS total_count FROM content_info i");
			}else{
				pstmt = connection.prepareStatement(
						"SELECT count(*) AS total_count FROM content_info i "
								+ "WHERE (select cc_name from content_code where cc_no=i.cc_no)=?");
				
				pstmt.setString(1, modelParam.getCcName());				
			}
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total_count");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return totalCount;
	}
	
	// 컨텐츠 목록 불러오기 실제 리스트용
	public List<ContentInfoModel> selectListContentInfoForList(ContentInfoModel modelParam){
		List<ContentInfoModel> listCI = new ArrayList<ContentInfoModel>();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT i.ci_no, i.cc_no, i.ci_thumbnail, i.ci_content, i.ci_title, i.ci_author, i.ci_date, i.ci_view, i.ci_link, "
					+ "(select cc_name from content_code where cc_no=i.cc_no) AS cc_name "
					+ "FROM content_info i "
					+ "WHERE (select cc_name from content_code where cc_no=i.cc_no)=? "
					+ "ORDER BY i.ci_sort DESC");
			
			pstmt.setString(1, modelParam.getCcName());
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				ContentInfoModel ci = new ContentInfoModel();
				ci.setCiNo(rs.getInt("ci_no"));
				ci.setCcNo(rs.getInt("cc_no"));
				ci.setCiThumbnail(rs.getString("ci_thumbnail"));
				ci.setCiContent(rs.getString("ci_content"));
				ci.setCiTitle(rs.getString("ci_title"));
				ci.setCiAuthor(rs.getString("ci_author"));
				ci.setCiDate(rs.getString("ci_date"));
				ci.setCiView(rs.getInt("ci_view"));
				ci.setCiLink(rs.getString("ci_link"));
				ci.setCcName(rs.getString("cc_name"));
				listCI.add(ci);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listCI;
	}
	
	// 컨텐츠 목록 불러오기 실제 리스트용 (모바일)
	public List<ContentInfoModel> selectListContentInfoForMobile(ContentInfoModel modelParam){
		List<ContentInfoModel> listCI = new ArrayList<ContentInfoModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			if("total".equals(modelParam.getCcName())){
				pstmt = connection.prepareStatement(
						"SELECT i.ci_no, i.cc_no, i.ci_thumbnail, i.ci_content, i.ci_title, i.ci_author, i.ci_date, i.ci_view, i.ci_link, "
								+ "(select cc_name from content_code where cc_no=i.cc_no) AS cc_name "
								+ "FROM content_info i "
								+ "ORDER BY i.ci_sort DESC LIMIT ?, ?");
		
				pstmt.setInt(1, modelParam.getListCount() * (pageNum-1));
				pstmt.setInt(2, modelParam.getListCount());
			}else {
				pstmt = connection.prepareStatement(
						"SELECT i.ci_no, i.cc_no, i.ci_thumbnail, i.ci_content, i.ci_title, i.ci_author, i.ci_date, i.ci_view, i.ci_link, "
								+ "(select cc_name from content_code where cc_no=i.cc_no) AS cc_name "
								+ "FROM content_info i "
								+ "WHERE (select cc_name from content_code where cc_no=i.cc_no)=? "
								+ "ORDER BY i.ci_sort DESC LIMIT ?, ?");
				
				pstmt.setString(1, modelParam.getCcName());
				pstmt.setInt(2, modelParam.getListCount() * (pageNum-1));
				pstmt.setInt(3, modelParam.getListCount());				
			}
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				ContentInfoModel ci = new ContentInfoModel();
				ci.setCiNo(rs.getInt("ci_no"));
				ci.setCcNo(rs.getInt("cc_no"));
				ci.setCiThumbnail(rs.getString("ci_thumbnail"));
				ci.setCiContent(rs.getString("ci_content"));
				ci.setCiTitle(rs.getString("ci_title"));
				ci.setCiAuthor(rs.getString("ci_author"));
				ci.setCiDate(rs.getString("ci_date"));
				ci.setCiView(rs.getInt("ci_view"));
				ci.setCiLink(rs.getString("ci_link"));
				ci.setCcName(rs.getString("cc_name"));
				listCI.add(ci);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listCI;
	}

	// 뉴스 목록 불러오기
	public List<NewsInfoModel> selectListNewsInfoForList(NewsInfoModel modelParam){
		List<NewsInfoModel> listNews = new ArrayList<NewsInfoModel>();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT news_no, news_thumbnail, news_content, news_title, news_author, news_date, news_view "
					+ "FROM news_info "
					+ "ORDER BY news_sort DESC");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				NewsInfoModel newsInfo = new NewsInfoModel();
				newsInfo.setNewsNo(rs.getInt("news_no"));
				newsInfo.setNewsThumbnail(rs.getString("news_thumbnail"));
				newsInfo.setNewsContent(rs.getString("news_content"));
				newsInfo.setNewsTitle(rs.getString("news_title"));
				newsInfo.setNewsAuthor(rs.getString("news_author"));
				newsInfo.setNewsDate(rs.getString("news_date"));
				newsInfo.setNewsView(rs.getInt("news_view"));
				
				listNews.add(newsInfo);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listNews;
	}
	
	// 뉴스 조회수 업데이트
	public void updateNewsView(int newsNo, int view){
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"UPDATE news_info SET news_view=? WHERE news_no=?");
			
			pstmt.setInt(1, view);
			pstmt.setInt(2, newsNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	// 컨텐츠 조회수 업데이트
	public void updateContentView(int ciNo, int view){
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"UPDATE content_info SET ci_view=? WHERE ci_no=?");
			
			pstmt.setInt(1, view);
			pstmt.setInt(2, ciNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	
	///// 토론방 관리자가 선정한 토픽들
	public List<DebateInfoModel> selectDebateInfoForListTop(){
		
		List<DebateInfoModel> listDebate = new ArrayList<DebateInfoModel>();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT di_no, di_content, di_title, di_author, ui_no, di_date, di_view, di_top_fix, "
					+ "(select count(nr_no) from debate_reply where ni_no=di_no and nr_delete=0) AS reply_cnt, "
					+ "(select count(li_no) from like_info where board_no=di_no and board_type='debate_info' and li_type='like') AS like_cnt, "
					+ "(select count(li_no) from like_info where board_no=di_no and board_type='debate_info' and li_type='dislike') AS dislike_cnt "
					+ "FROM debate_info WHERE di_top_fix='1' and di_approve='1' "
					+ "ORDER BY di_date DESC LIMIT 5");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				DebateInfoModel di = new DebateInfoModel();
				di.setDiNo(rs.getInt("di_no"));
				di.setDiContent(rs.getString("di_content"));
				di.setDiTitle(rs.getString("di_title"));
				di.setDiAuthor(rs.getString("di_author"));
				di.setUiNo(rs.getInt("ui_no"));
				di.setDiDate(rs.getString("di_date"));
				di.setDiView(rs.getInt("di_view"));
				di.setDiTopFix(rs.getString("di_top_fix"));
				di.setReplyCnt(rs.getInt("reply_cnt"));
				di.setLikeCnt(rs.getInt("like_cnt"));
				di.setDislikeCnt(rs.getInt("dislike_cnt"));
				
				listDebate.add(di);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listDebate;
	}
	
	///// 토론방 참여율 가장 높은 것
	public List<DebateInfoModel> selectDebateInfoForListBest(){
		
		List<DebateInfoModel> listDebate = new ArrayList<DebateInfoModel>();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
						
			pstmt = connection.prepareStatement(
					"SELECT di_no, di_content, di_title, di_author, ui_no, di_date, di_view, di_top_fix, "
					+ "(select count(nr_no) from debate_reply where ni_no=di_no and nr_delete=0) AS reply_cnt, "
					+ "(select count(li_no) from like_info where board_no=di_no and board_type='debate_info' and li_type='like') AS like_cnt, "
					+ "(select count(li_no) from like_info where board_no=di_no and board_type='debate_info' and li_type='dislike') AS dislike_cnt, "
					+ "( (select count(nr_no) from debate_reply where ni_no=di_no) + (select count(li_no) from like_info where board_no=di_no and board_type='debate_info') ) AS total_cnt "
					+ "FROM debate_info WHERE di_approve='1' "
					+ "ORDER BY total_cnt DESC, di_no DESC LIMIT 5");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				DebateInfoModel di = new DebateInfoModel();
				di.setDiNo(rs.getInt("di_no"));
				di.setDiContent(rs.getString("di_content"));
				di.setDiTitle(rs.getString("di_title"));
				di.setDiAuthor(rs.getString("di_author"));
				di.setUiNo(rs.getInt("ui_no"));
				di.setDiDate(rs.getString("di_date"));
				di.setDiView(rs.getInt("di_view"));
				di.setDiTopFix(rs.getString("di_top_fix"));
				di.setReplyCnt(rs.getInt("reply_cnt"));
				di.setLikeCnt(rs.getInt("like_cnt"));
				di.setDislikeCnt(rs.getInt("dislike_cnt"));
				
				listDebate.add(di);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listDebate;
	}
	
	
	//// 청원 최다 추천
	public List<PetitionInfoModel> selectPetitionInfoForListBest() {
		
		List<PetitionInfoModel> listPI = new ArrayList<PetitionInfoModel>();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT pi_no, pi_title, pi_content, pi_author, ui_no, pi_date, pi_view, pi_sort, pi_reply, "
					+ "(select count(li_no) from like_info where board_no=pi_no and board_type='petition_info' and li_type='like') AS like_cnt "
					+ "FROM petition_info "
					+ "ORDER BY like_cnt DESC, pi_no DESC LIMIT 5");
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PetitionInfoModel pi = new PetitionInfoModel();
				pi.setPiNo(rs.getInt("pi_no"));
				pi.setPiTitle(rs.getString("pi_title"));
				pi.setPiContent(rs.getString("pi_content"));
				pi.setPiAuthor(rs.getString("pi_author"));
				pi.setUiNo(rs.getInt("ui_no"));
				pi.setPiDate(rs.getString("pi_date"));
				pi.setPiView(rs.getInt("pi_view"));
				pi.setPiSort(rs.getInt("pi_sort"));
				pi.setPiReply(rs.getString("pi_reply"));
				pi.setLikeCnt(rs.getInt("like_cnt"));
				
				listPI.add(pi);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listPI;
	}
	
	//////////////////////////////////////////////
	// 좋아요 정보 등록
	public void insertLikeInfo(LikeInfoModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"INSERT INTO like_info(board_no, board_type, li_type, ui_no, li_date) VALUES(?, ?, ?, ?, now())");
			
			pstmt.setInt(1, modelParam.getBoardNo());
			pstmt.setString(2, modelParam.getBoardType());
			pstmt.setString(3, modelParam.getLiType());
			pstmt.setInt(4, modelParam.getUiNo());
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	// 좋아요 정보 취소
	public void deleteLikeInfo(LikeInfoModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"DELETE FROM like_info WHERE board_no=? AND board_type=? AND ui_no=?");
			
			pstmt.setInt(1, modelParam.getBoardNo());
			pstmt.setString(2, modelParam.getBoardType());
			pstmt.setInt(3, modelParam.getUiNo());
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	// 좋아요 등록 여부 체크
	public boolean checkLikeInfo(LikeInfoModel modelParam) {
		
		boolean bRet = false;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT li_no, li_type FROM like_info "
					+ "WHERE board_no=? AND board_type=? AND ui_no=?");
			
			pstmt.setInt(1, modelParam.getBoardNo());
			pstmt.setString(2, modelParam.getBoardType());
			pstmt.setInt(3, modelParam.getUiNo());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bRet = true;
				
				modelParam.setLiType(rs.getString("li_type"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return bRet;
	}
	
	
	/// 찬성/반대 바로 반영
	public void setLikeInfo(LikeInfoModel modelParam) {
		
		int liNo = -1;
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT li_no FROM like_info "
					+ "WHERE board_no=? AND board_type=? AND ui_no=?");
			
			pstmt.setInt(1, modelParam.getBoardNo());
			pstmt.setString(2, modelParam.getBoardType());
			pstmt.setInt(3, modelParam.getUiNo());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				liNo = rs.getInt("li_no");
			}
			
			if(liNo == -1) {
				pstmt = connection.prepareStatement(
						"INSERT INTO like_info(board_no, board_type, li_type, ui_no, li_date) VALUES(?, ?, ?, ?, now())");
				
				pstmt.setInt(1, modelParam.getBoardNo());
				pstmt.setString(2, modelParam.getBoardType());
				pstmt.setString(3, modelParam.getLiType());
				pstmt.setInt(4, modelParam.getUiNo());
				
				pstmt.executeUpdate();
			}
			else {
				pstmt = connection.prepareStatement(
						"UPDATE like_info SET li_type=?, li_date=now() WHERE li_no=?");
				
				pstmt.setString(1, modelParam.getLiType());
				pstmt.setInt(2, liNo);
				
				pstmt.executeUpdate();
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	
	//////////////////////////////////////////////
	/// 공지사항 답글 등록
	public void insertNoticeReply(ReplyModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"INSERT INTO "
					+ "notice_reply(ni_no, ui_no, nr_content, nr_date) VALUES(?, ?, ?, now())");
			
			pstmt.setInt(1, modelParam.getNiNo());
			pstmt.setInt(2, modelParam.getUiNo());
			pstmt.setString(3, modelParam.getNrContent());
			
			pstmt.executeUpdate();
			/////
			
			pstmt = connection.prepareStatement(
					"UPDATE notice_reply SET nr_group_no=nr_no "
					+ "WHERE nr_no=(select * from (select max(nr_no) from notice_reply) as t)");
			
			pstmt.executeUpdate();
			/////
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
		
	/// 공지사항 답글의 답글 등록
	public void insertNoticeReply2(ReplyModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"UPDATE notice_reply SET nr_group_order=nr_group_order+1 "
					+ "WHERE nr_group_no=? AND nr_group_order>?");
			
			pstmt.setInt(1, modelParam.getNrGroupNo());			// 원글 그룹번호
			pstmt.setInt(2, modelParam.getNrGroupOrder());		// 원글 순서
			
			pstmt.executeUpdate();
			/////

			pstmt = connection.prepareStatement(
					"INSERT INTO "
					+ "notice_reply(ni_no, nr_group_no, nr_group_order, nr_group_layer, ui_no, nr_content, nr_date) "
					+ "VALUES(?, ?, ?, ?, ?, ?, now())");
			
			pstmt.setInt(1, modelParam.getNiNo());
			pstmt.setInt(2, modelParam.getNrGroupNo());
			pstmt.setInt(3, modelParam.getNrGroupOrder()+1);
			pstmt.setInt(4, modelParam.getNrGroupLayer()+1);
			pstmt.setInt(5, modelParam.getUiNo());
			pstmt.setString(6, modelParam.getNrContent());
			
			pstmt.executeUpdate();
			/////
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 공지사항 답글 삭제
	public void deleteNoticeReply(int nrNo) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"UPDATE notice_reply SET nr_delete=1 WHERE nr_no=?");
			
			pstmt.setInt(1, nrNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
		
	/// 공지사항 답글 목록 조회
	public List<ReplyModel> selectListNoticeReply(ReplyModel modelParam) {
		
		List<ReplyModel> listReply = new ArrayList<ReplyModel>();
		String orderSQL = " ORDER BY nr_group_no DESC, nr_group_layer ASC, nr_group_order ASC ";
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			if("asc".equals(modelParam.getSortType()))
				orderSQL = " ORDER BY nr_group_no ASC, nr_group_layer ASC, nr_group_order DESC ";
			
			pstmt = connection.prepareStatement(
					"SELECT nr_no, ni_no, nr_group_no, nr_group_order, nr_group_layer, r.ui_no, nr_content, nr_date, nr_delete, "
					+ "(select ui_name from user_info where ui_no=r.ui_no) AS user_name, "
					+ "(select ui_profile from user_info where ui_no=r.ui_no) AS user_profile "
					+ "FROM notice_reply r "
					+ "WHERE ni_no=? " + orderSQL);
			
			pstmt.setInt(1, modelParam.getNiNo());
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReplyModel reply = new ReplyModel();
				reply.setNrNo(rs.getInt("nr_no"));
				reply.setNiNo(rs.getInt("ni_no"));
				reply.setNrGroupNo(rs.getInt("nr_group_no"));
				reply.setNrGroupOrder(rs.getInt("nr_group_order"));
				reply.setNrGroupLayer(rs.getInt("nr_group_layer"));
				reply.setUiNo(rs.getInt("ui_no"));
				reply.setNrContent(rs.getString("nr_content"));
				reply.setNrDate(rs.getString("nr_date"));
				reply.setNrDelete(rs.getInt("nr_delete"));
				reply.setUiName(rs.getString("user_name"));
				reply.setUiProfile(rs.getString("user_profile"));
				
				listReply.add(reply);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listReply;
	}
	
	
	//////////////////////////////////////////////
	/// 뉴스 답글 등록
	public void insertNewsReply(ReplyModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"INSERT INTO "
					+ "news_reply(ni_no, ui_no, nr_content, nr_date) VALUES(?, ?, ?, now())");
			
			pstmt.setInt(1, modelParam.getNiNo());
			pstmt.setInt(2, modelParam.getUiNo());
			pstmt.setString(3, modelParam.getNrContent());
			
			pstmt.executeUpdate();
			/////
			
			pstmt = connection.prepareStatement(
					"UPDATE news_reply SET nr_group_no=nr_no "
					+ "WHERE nr_no=(select * from (select max(nr_no) from news_reply) as t)");
			
			pstmt.executeUpdate();
			/////
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
		
	/// 뉴스 답글의 답글 등록
	public void insertNewsReply2(ReplyModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"UPDATE news_reply SET nr_group_order=nr_group_order+1 "
					+ "WHERE nr_group_no=? AND nr_group_order>?");
			
			pstmt.setInt(1, modelParam.getNrGroupNo());			// 원글 그룹번호
			pstmt.setInt(2, modelParam.getNrGroupOrder());		// 원글 순서
			
			pstmt.executeUpdate();
			/////

			pstmt = connection.prepareStatement(
					"INSERT INTO "
					+ "news_reply(ni_no, nr_group_no, nr_group_order, nr_group_layer, ui_no, nr_content, nr_date) "
					+ "VALUES(?, ?, ?, ?, ?, ?, now())");
			
			pstmt.setInt(1, modelParam.getNiNo());
			pstmt.setInt(2, modelParam.getNrGroupNo());
			pstmt.setInt(3, modelParam.getNrGroupOrder()+1);
			pstmt.setInt(4, modelParam.getNrGroupLayer()+1);
			pstmt.setInt(5, modelParam.getUiNo());
			pstmt.setString(6, modelParam.getNrContent());
			
			pstmt.executeUpdate();
			/////
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 뉴스 답글 삭제
	public void deleteNewsReply(int nrNo) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"UPDATE news_reply SET nr_delete=1 WHERE nr_no=?");
			
			pstmt.setInt(1, nrNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
		
	/// 뉴스 답글 목록 조회
	public List<ReplyModel> selectListNewsReply(ReplyModel modelParam) {
		
		List<ReplyModel> listReply = new ArrayList<ReplyModel>();
		String orderSQL = " ORDER BY nr_group_no DESC, nr_group_layer ASC, nr_group_order ASC ";
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			if("asc".equals(modelParam.getSortType()))
				orderSQL = " ORDER BY nr_group_no ASC, nr_group_layer ASC, nr_group_order DESC ";
			
			pstmt = connection.prepareStatement(
					"SELECT nr_no, ni_no, nr_group_no, nr_group_order, nr_group_layer, r.ui_no, nr_content, nr_date, nr_delete, "
					+ "(select ui_name from user_info where ui_no=r.ui_no) AS user_name, "
					+ "(select ui_profile from user_info where ui_no=r.ui_no) AS user_profile "
					+ "FROM news_reply r "
					+ "WHERE ni_no=? " + orderSQL);
			
			pstmt.setInt(1, modelParam.getNiNo());
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReplyModel reply = new ReplyModel();
				reply.setNrNo(rs.getInt("nr_no"));
				reply.setNiNo(rs.getInt("ni_no"));
				reply.setNrGroupNo(rs.getInt("nr_group_no"));
				reply.setNrGroupOrder(rs.getInt("nr_group_order"));
				reply.setNrGroupLayer(rs.getInt("nr_group_layer"));
				reply.setUiNo(rs.getInt("ui_no"));
				reply.setNrContent(rs.getString("nr_content"));
				reply.setNrDate(rs.getString("nr_date"));
				reply.setNrDelete(rs.getInt("nr_delete"));
				reply.setUiName(rs.getString("user_name"));
				reply.setUiProfile(rs.getString("user_profile"));
				
				listReply.add(reply);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listReply;
	}
	
		
	//////////////////////////////////////////////
	/// 토론방 답글 등록
	public void insertDebateReply(ReplyModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"INSERT INTO "
					+ "debate_reply(ni_no, ui_no, nr_content, nr_date) VALUES(?, ?, ?, now())");
			
			pstmt.setInt(1, modelParam.getNiNo());
			pstmt.setInt(2, modelParam.getUiNo());
			pstmt.setString(3, modelParam.getNrContent());
			
			pstmt.executeUpdate();
			/////
			
			pstmt = connection.prepareStatement(
					"UPDATE debate_reply SET nr_group_no=nr_no "
					+ "WHERE nr_no=(select * from (select max(nr_no) from debate_reply) as t)");
			
			pstmt.executeUpdate();
			/////
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
		
	/// 토론방 답글의 답글 등록
	public void insertDebateReply2(ReplyModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"UPDATE debate_reply SET nr_group_order=nr_group_order+1 "
					+ "WHERE nr_group_no=? AND nr_group_order>?");
			
			pstmt.setInt(1, modelParam.getNrGroupNo());			// 원글 그룹번호
			pstmt.setInt(2, modelParam.getNrGroupOrder());		// 원글 순서
			
			pstmt.executeUpdate();
			/////

			pstmt = connection.prepareStatement(
					"INSERT INTO "
					+ "debate_reply(ni_no, nr_group_no, nr_group_order, nr_group_layer, ui_no, nr_content, nr_date) "
					+ "VALUES(?, ?, ?, ?, ?, ?, now())");
			
			pstmt.setInt(1, modelParam.getNiNo());
			pstmt.setInt(2, modelParam.getNrGroupNo());
			pstmt.setInt(3, modelParam.getNrGroupOrder()+1);
			pstmt.setInt(4, modelParam.getNrGroupLayer()+1);
			pstmt.setInt(5, modelParam.getUiNo());
			pstmt.setString(6, modelParam.getNrContent());
			
			pstmt.executeUpdate();
			/////
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 토론방 답글 삭제
	public void deleteDebateReply(int nrNo) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"UPDATE debate_reply SET nr_delete=1 WHERE nr_no=?");
			
			pstmt.setInt(1, nrNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
		
	/// 토론방 답글 목록 조회
	public List<ReplyModel> selectListDebateReply(ReplyModel modelParam) {
		
		List<ReplyModel> listReply = new ArrayList<ReplyModel>();
		String orderSQL = " ORDER BY nr_group_no DESC, nr_group_layer ASC, nr_group_order ASC ";
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			if("asc".equals(modelParam.getSortType()))
				orderSQL = " ORDER BY nr_group_no ASC, nr_group_layer ASC, nr_group_order DESC ";
			
			pstmt = connection.prepareStatement(
					"SELECT nr_no, ni_no, nr_group_no, nr_group_order, nr_group_layer, r.ui_no, nr_content, nr_date, nr_delete, "
					+ "(select ui_name from user_info where ui_no=r.ui_no) AS user_name, "
					+ "(select ui_profile from user_info where ui_no=r.ui_no) AS user_profile "
					+ "FROM debate_reply r "
					+ "WHERE ni_no=? " + orderSQL);
			
			pstmt.setInt(1, modelParam.getNiNo());
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReplyModel reply = new ReplyModel();
				reply.setNrNo(rs.getInt("nr_no"));
				reply.setNiNo(rs.getInt("ni_no"));
				reply.setNrGroupNo(rs.getInt("nr_group_no"));
				reply.setNrGroupOrder(rs.getInt("nr_group_order"));
				reply.setNrGroupLayer(rs.getInt("nr_group_layer"));
				reply.setUiNo(rs.getInt("ui_no"));
				reply.setNrContent(rs.getString("nr_content"));
				reply.setNrDate(rs.getString("nr_date"));
				reply.setNrDelete(rs.getInt("nr_delete"));
				reply.setUiName(rs.getString("user_name"));
				reply.setUiProfile(rs.getString("user_profile"));
				
				listReply.add(reply);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listReply;
	}
	
	
	
	//////////////////////////////////////////////
	/// 청원 답글 등록
	public void insertPetitionReply(ReplyModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"INSERT INTO "
					+ "petition_reply(ni_no, ui_no, nr_content, nr_date) VALUES(?, ?, ?, now())");
			
			pstmt.setInt(1, modelParam.getNiNo());
			pstmt.setInt(2, modelParam.getUiNo());
			pstmt.setString(3, modelParam.getNrContent());
			
			pstmt.executeUpdate();
			/////
			
			pstmt = connection.prepareStatement(
					"UPDATE petition_reply SET nr_group_no=nr_no "
					+ "WHERE nr_no=(select * from (select max(nr_no) from petition_reply) as t)");
			
			pstmt.executeUpdate();
			/////
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
		
	/// 청원 답글의 답글 등록
	public void insertPetitionReply2(ReplyModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"UPDATE petition_reply SET nr_group_order=nr_group_order+1 "
					+ "WHERE nr_group_no=? AND nr_group_order>?");
			
			pstmt.setInt(1, modelParam.getNrGroupNo());			// 원글 그룹번호
			pstmt.setInt(2, modelParam.getNrGroupOrder());		// 원글 순서
			
			pstmt.executeUpdate();
			/////

			pstmt = connection.prepareStatement(
					"INSERT INTO "
					+ "petition_reply(ni_no, nr_group_no, nr_group_order, nr_group_layer, ui_no, nr_content, nr_date) "
					+ "VALUES(?, ?, ?, ?, ?, ?, now())");
			
			pstmt.setInt(1, modelParam.getNiNo());
			pstmt.setInt(2, modelParam.getNrGroupNo());
			pstmt.setInt(3, modelParam.getNrGroupOrder()+1);
			pstmt.setInt(4, modelParam.getNrGroupLayer()+1);
			pstmt.setInt(5, modelParam.getUiNo());
			pstmt.setString(6, modelParam.getNrContent());
			
			pstmt.executeUpdate();
			/////
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 청원 답글 삭제
	public void deletePetitionReply(int nrNo) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"UPDATE petition_reply SET nr_delete=1 WHERE nr_no=?");
			
			pstmt.setInt(1, nrNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
		
	/// 청원 답글 목록 조회
	public List<ReplyModel> selectListPetitionReply(ReplyModel modelParam) {
		
		List<ReplyModel> listReply = new ArrayList<ReplyModel>();
		String orderSQL = " ORDER BY nr_group_no DESC, nr_group_layer ASC, nr_group_order ASC ";
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			if("asc".equals(modelParam.getSortType()))
				orderSQL = " ORDER BY nr_group_no ASC, nr_group_layer ASC, nr_group_order DESC ";
			
			pstmt = connection.prepareStatement(
					"SELECT nr_no, ni_no, nr_group_no, nr_group_order, nr_group_layer, r.ui_no, nr_content, nr_date, nr_delete, "
					+ "(select ui_name from user_info where ui_no=r.ui_no) AS user_name, "
					+ "(select ui_profile from user_info where ui_no=r.ui_no) AS user_profile "
					+ "FROM petition_reply r "
					+ "WHERE ni_no=? " + orderSQL);
			
			pstmt.setInt(1, modelParam.getNiNo());
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReplyModel reply = new ReplyModel();
				reply.setNrNo(rs.getInt("nr_no"));
				reply.setNiNo(rs.getInt("ni_no"));
				reply.setNrGroupNo(rs.getInt("nr_group_no"));
				reply.setNrGroupOrder(rs.getInt("nr_group_order"));
				reply.setNrGroupLayer(rs.getInt("nr_group_layer"));
				reply.setUiNo(rs.getInt("ui_no"));
				reply.setNrContent(rs.getString("nr_content"));
				reply.setNrDate(rs.getString("nr_date"));
				reply.setNrDelete(rs.getInt("nr_delete"));
				reply.setUiName(rs.getString("user_name"));
				reply.setUiProfile(rs.getString("user_profile"));
				
				listReply.add(reply);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listReply;
	}
	
	
	////////////////////////////////////////////////////
	// ---------------- 알람 관련 ----------------------//
	///////////////////////////////////////////////////
	
	/// 알람 정보 등록
	public void insertAlarmInfo(AlarmInfoModel modelParam) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"INSERT INTO "
					+ "alarm_info(board_no, board_type, ui_no, from_ui_no, ai_content, ai_date) "
					+ "VALUES(?, ?, ?, ?, ?, now())");
			
			pstmt.setInt(1, modelParam.getBoardNo());
			pstmt.setString(2, modelParam.getBoardType());
			pstmt.setInt(3, modelParam.getUiNo());
			pstmt.setInt(4, modelParam.getFromUiNo());
			pstmt.setString(5, modelParam.getAiContent());
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	/// 해당된 알람 목록 조회
	public List<AlarmInfoModel> selectListAlarmInfo(int uiNo) {
		
		List<AlarmInfoModel> listAlarm = new ArrayList<AlarmInfoModel>();
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"SELECT ai_no, board_no, board_type, ui_no, from_ui_no, ai_content, ai_date, "
					+ "(select ui_profile from user_info where ui_no=from_ui_no) AS profile "
					+ "FROM alarm_info a "
					+ "WHERE (ui_no=? OR ui_no=-1) "
					+ "AND (select count(ui_no) from alarm_read where ai_no=a.ai_no and ui_no=?)=0 "
					+ "ORDER BY ai_date DESC, ai_no DESC LIMIT 10");
			
			pstmt.setInt(1, uiNo);
			pstmt.setInt(2, uiNo);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				AlarmInfoModel alarm = new AlarmInfoModel();
				alarm.setAiNo(rs.getInt("ai_no"));
				alarm.setBoardNo(rs.getInt("board_no"));
				alarm.setBoardType(rs.getString("board_type"));
				alarm.setUiNo(rs.getInt("ui_no"));
				alarm.setFromUiNo(rs.getInt("from_ui_no"));
				alarm.setAiContent(rs.getString("ai_content"));
				alarm.setAiDate(rs.getString("ai_date"));
				alarm.setFromUiProfile(rs.getString("profile"));
				
				listAlarm.add(alarm);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
		
		return listAlarm;
	}
	
	
	/// 알람 확인 정보 등록
	public void insertAlarmRead(int aiNo, int uiNo) {
		
		try {
			// 데이터베이스 객체 생성
			Class.forName(JDBC_DRIVER);
			connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);
			
			pstmt = connection.prepareStatement(
					"INSERT INTO alarm_read(ai_no, ui_no) VALUES(?, ?)");
			
			pstmt.setInt(1, aiNo);
			pstmt.setInt(2, uiNo);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, connection);
		}
	}
	
	
	////////////////////////////////////////////////////
	//	- 데이터베이스 관련 객체 정리 -
	public void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
	
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	//-------------------------------------------------------------

}
