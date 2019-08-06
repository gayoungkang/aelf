package model;

public class NewsInfoModel {
	private int newsNo = -1;			// 기본키
	private String newsThumbnail = "";	// 썸네일
	private String newsContent = "";	// 내용
	private String newsTitle = "";		// 제목
	private String newsAuthor = "";		// 작성자
	private String newsDate = "";		// 작성일
	private int newsView = 0;			// 조회수
	private int newsSort = 0;			// 뉴스 정렬
	private String newsLink = "";		// 뉴스 링크
	
	private String pageNum = "1";			//제이슨 처리 페이지넘버
	private int listCount = 30;			//한 블럭당 커뮤니티 게시물 갯수
	private int pagePerBlock = 10;			// 네비게이션 블록 수
	
	public String getNewsLink() {
		return newsLink;
	}
	public void setNewsLink(String newsLink) {
		this.newsLink = newsLink;
	}
	public int getNewsSort() {
		return newsSort;
	}
	public void setNewsSort(int newsSort) {
		this.newsSort = newsSort;
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
	public int getNewsNo() {
		return newsNo;
	}
	public void setNewsNo(int newsNo) {
		this.newsNo = newsNo;
	}
	public String getNewsThumbnail() {
		return newsThumbnail;
	}
	public void setNewsThumbnail(String newsThumbnail) {
		this.newsThumbnail = newsThumbnail;
	}
	public String getNewsContent() {
		return newsContent;
	}
	public void setNewsContent(String newsContent) {
		this.newsContent = newsContent;
	}
	public String getNewsTitle() {
		return newsTitle;
	}
	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}
	public String getNewsAuthor() {
		return newsAuthor;
	}
	public void setNewsAuthor(String newsAuthor) {
		this.newsAuthor = newsAuthor;
	}
	public String getNewsDate() {
		return newsDate;
	}
	public void setNewsDate(String newsDate) {
		this.newsDate = newsDate;
	}
	public int getNewsView() {
		return newsView;
	}
	public void setNewsView(int newsView) {
		this.newsView = newsView;
	}
}
