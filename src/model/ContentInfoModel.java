package model;

public class ContentInfoModel {
	private int ciNo = -1;
	private int ccNo = -1;					// 코드 기본키
	private String ciThumbnail = "";		// 썸네일
	private String ciContent = "";			// 내용
	private String ciTitle = "";			// 제목
	private String ciAuthor = "";			// 작성자
	private String ciDate = "";				// 날짜
	private int ciView = 0;					// 조회수
	private String ciLink = "";				// 링크
	private int ciSort = 0;					// 정렬
	
	private String ccName = "";				// 코드 이름
	
	private String pageNum = "1";			//제이슨 처리 페이지넘버
	private int listCount = 8;				//한 블럭당 커뮤니티 게시물 갯수
	private int pagePerBlock = 5;			// 네비게이션 블록 수
	
	public int getCiSort() {
		return ciSort;
	}
	public void setCiSort(int ciSort) {
		this.ciSort = ciSort;
	}
	public String getCcName() {
		return ccName;
	}
	public void setCcName(String ccName) {
		this.ccName = ccName;
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
	public int getCiNo() {
		return ciNo;
	}
	public void setCiNo(int ciNo) {
		this.ciNo = ciNo;
	}
	public int getCcNo() {
		return ccNo;
	}
	public void setCcNo(int ccNo) {
		this.ccNo = ccNo;
	}
	public String getCiThumbnail() {
		return ciThumbnail;
	}
	public void setCiThumbnail(String ciThumbnail) {
		this.ciThumbnail = ciThumbnail;
	}
	public String getCiContent() {
		return ciContent;
	}
	public void setCiContent(String ciContent) {
		this.ciContent = ciContent;
	}
	public String getCiTitle() {
		return ciTitle;
	}
	public void setCiTitle(String ciTitle) {
		this.ciTitle = ciTitle;
	}
	public String getCiAuthor() {
		return ciAuthor;
	}
	public void setCiAuthor(String ciAuthor) {
		this.ciAuthor = ciAuthor;
	}
	public String getCiDate() {
		return ciDate;
	}
	public void setCiDate(String ciDate) {
		this.ciDate = ciDate;
	}
	public int getCiView() {
		return ciView;
	}
	public void setCiView(int ciView) {
		this.ciView = ciView;
	}
	public String getCiLink() {
		return ciLink;
	}
	public void setCiLink(String ciLink) {
		this.ciLink = ciLink;
	}
}
