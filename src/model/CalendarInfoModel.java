package model;

public class CalendarInfoModel {

	private int calNo = -1;					// 기본키 
	private String calTag = "";				// 태그
	private String calTitle = "";			// 제목
	private String calComment = "";			// 한줄코멘트
	private String calTime = "";			// 시간
	private String calPlace = "";			// 장소
	private String calContent = "";			// 내용
	private String calStartDate = "";		// 시작일자
	private String calEndDate = "";			// 종료일자
	private String calDday = ""; 			// 디데이 
	
	private String pageNum = "1";			//제이슨 처리 페이지넘버
	private int listCount = 30;			//한 블럭당 커뮤니티 게시물 갯수
	private int pagePerBlock = 10;			// 네비게이션 블록 수
	
	
	public String getCalDday() {
		return calDday;
	}
	public void setCalDday(String calDday) {
		this.calDday = calDday;
	}
	public int getCalNo() {
		return calNo;
	}
	public void setCalNo(int calNo) {
		this.calNo = calNo;
	}
	public String getCalTag() {
		return calTag;
	}
	public void setCalTag(String calTag) {
		this.calTag = calTag;
	}
	public String getCalTitle() {
		return calTitle;
	}
	public void setCalTitle(String calTitle) {
		this.calTitle = calTitle;
	}
	public String getCalComment() {
		return calComment;
	}
	public void setCalComment(String calComment) {
		this.calComment = calComment;
	}
	public String getCalTime() {
		return calTime;
	}
	public void setCalTime(String calTime) {
		this.calTime = calTime;
	}
	public String getCalPlace() {
		return calPlace;
	}
	public void setCalPlace(String calPlace) {
		this.calPlace = calPlace;
	}
	public String getCalContent() {
		return calContent;
	}
	public void setCalContent(String calContent) {
		this.calContent = calContent;
	}
	public String getCalStartDate() {
		return calStartDate;
	}
	public void setCalStartDate(String calStartDate) {
		this.calStartDate = calStartDate;
	}
	public String getCalEndDate() {
		return calEndDate;
	}
	public void setCalEndDate(String calEndDate) {
		this.calEndDate = calEndDate;
	}
	public String getPageNum() {
		return pageNum;
	}
	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}
	public int getListCount() {
		return listCount;
	}
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	public int getPagePerBlock() {
		return pagePerBlock;
	}
	public void setPagePerBlock(int pagePerBlock) {
		this.pagePerBlock = pagePerBlock;
	}
}
