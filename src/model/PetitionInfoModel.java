package model;

public class PetitionInfoModel {

	private int piNo = -1;					// 기본키
	private String piTitle = "";			// 제목
	private String piContent = "";			// 내용
	private String piAuthor = "";			// 작성자명
	private int uiNo = -1;					// 작성자 번호
	private String piDate = "";				// 작성일
	private int piView = 0;					// 조회수
	private int piSort = 0;					// 정렬
	private String piReply = "";			// 청원답변
	
	private String orderType = "";			// 정렬유형
	
	private int likeCnt = 0;				// 추천 수
	private int replyCnt = 0;				// 답글 수
	
	private String pageNum = "1";			//제이슨 처리 페이지넘버
	private int listCount = 30;				//한 블럭당 커뮤니티 게시물 갯수
	private int pagePerBlock = 10;			// 네비게이션 블록 수
	
	public int getPiNo() {
		return piNo;
	}
	public void setPiNo(int piNo) {
		this.piNo = piNo;
	}
	public String getPiTitle() {
		return piTitle;
	}
	public void setPiTitle(String piTitle) {
		this.piTitle = piTitle;
	}
	public String getPiContent() {
		return piContent;
	}
	public void setPiContent(String piContent) {
		this.piContent = piContent;
	}
	public String getPiAuthor() {
		return piAuthor;
	}
	public void setPiAuthor(String piAuthor) {
		this.piAuthor = piAuthor;
	}
	public int getUiNo() {
		return uiNo;
	}
	public void setUiNo(int uiNo) {
		this.uiNo = uiNo;
	}
	public String getPiDate() {
		return piDate;
	}
	public void setPiDate(String piDate) {
		this.piDate = piDate;
	}
	public int getPiView() {
		return piView;
	}
	public void setPiView(int piView) {
		this.piView = piView;
	}
	public int getPiSort() {
		return piSort;
	}
	public void setPiSort(int piSort) {
		this.piSort = piSort;
	}
	public String getPiReply() {
		return piReply;
	}
	public void setPiReply(String piReply) {
		this.piReply = piReply;
	}
	public String getOrderType() {
		return orderType;
	}
	public void setOrderType(String orderType) {
		this.orderType = orderType;
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
	public int getLikeCnt() {
		return likeCnt;
	}
	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}
	public int getReplyCnt() {
		return replyCnt;
	}
	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}
}
