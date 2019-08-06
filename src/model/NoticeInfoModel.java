package model;

public class NoticeInfoModel {
	private int niNo = -1;				// 기본키
	private String niTitle = "";		// 제목
	private String niThumbnail = "";	// 썸네일
	private String niAuthor = "";		// 글쓴이
	private String niDate = "";			// 작성일
	private String niContent = "";		// 내용
	private int niView = 0;				// 조회수
	private String niTopFix = "0";		// 상단 고정(공지사항 목록 페이지에서)
	private int niSort = 0;				// 공지사항 정렬
	
	private String pageNum = "1";			//제이슨 처리 페이지넘버
	private int listCount = 30;			//한 블럭당 커뮤니티 게시물 갯수
	private int pagePerBlock = 10;			// 네비게이션 블록 수
	
	public int getNiSort() {
		return niSort;
	}
	public void setNiSort(int niSort) {
		this.niSort = niSort;
	}
	public int getNiView() {
		return niView;
	}
	public void setNiView(int niView) {
		this.niView = niView;
	}
	public String getNiTopFix() {
		return niTopFix;
	}
	public void setNiTopFix(String niTopFix) {
		this.niTopFix = niTopFix;
	}
	public int getNiNo() {
		return niNo;
	}
	public void setNiNo(int niNo) {
		this.niNo = niNo;
	}
	public String getNiTitle() {
		return niTitle;
	}
	public void setNiTitle(String niTitle) {
		this.niTitle = niTitle;
	}
	public String getNiThumbnail() {
		return niThumbnail;
	}
	public void setNiThumbnail(String niThumbnail) {
		this.niThumbnail = niThumbnail;
	}
	public String getNiAuthor() {
		return niAuthor;
	}
	public void setNiAuthor(String niAuthor) {
		this.niAuthor = niAuthor;
	}
	public String getNiDate() {
		return niDate;
	}
	public void setNiDate(String niDate) {
		this.niDate = niDate;
	}
	public String getNiContent() {
		return niContent;
	}
	public void setNiContent(String niContent) {
		this.niContent = niContent;
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
