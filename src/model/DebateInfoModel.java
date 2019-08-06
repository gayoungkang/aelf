package model;

public class DebateInfoModel {

	private int diNo = -1;					// 기본키
	private String diTitle = "";			// 제목
	private String diContent = "";			// 내용
	private String diAuthor = "";			// 작성자명
	private int uiNo = -1;					// 작성자 번호
	private String diDate = "";				// 작성일
	private int diView = 0;					// 조회수
	private String diTopFix = "0";			// 상단 고정 여부
	private String diApprove = "0";			// 관리자 승인 여부
	private int diSort = 0;					// 정렬
	
	private int likeCnt = 0;				// 좋아요 수
	private int dislikeCnt = 0;				// 싫어요 수
	private int replyCnt = 0;				// 답글 수
	
	private String pageNum = "1";			//제이슨 처리 페이지넘버
	private int listCount = 30;			//한 블럭당 커뮤니티 게시물 갯수
	private int pagePerBlock = 10;			// 네비게이션 블록 수
	
	public int getDiNo() {
		return diNo;
	}
	public void setDiNo(int diNo) {
		this.diNo = diNo;
	}
	public String getDiTitle() {
		return diTitle;
	}
	public void setDiTitle(String diTitle) {
		this.diTitle = diTitle;
	}
	public String getDiContent() {
		return diContent;
	}
	public void setDiContent(String diContent) {
		this.diContent = diContent;
	}
	public String getDiAuthor() {
		return diAuthor;
	}
	public void setDiAuthor(String diAuthor) {
		this.diAuthor = diAuthor;
	}
	public int getUiNo() {
		return uiNo;
	}
	public void setUiNo(int uiNo) {
		this.uiNo = uiNo;
	}
	public String getDiDate() {
		return diDate;
	}
	public void setDiDate(String diDate) {
		this.diDate = diDate;
	}
	public int getDiView() {
		return diView;
	}
	public void setDiView(int diView) {
		this.diView = diView;
	}
	public String getDiTopFix() {
		return diTopFix;
	}
	public void setDiTopFix(String diTopFix) {
		this.diTopFix = diTopFix;
	}
	public String getDiApprove() {
		return diApprove;
	}
	public void setDiApprove(String diApprove) {
		this.diApprove = diApprove;
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
	public int getDiSort() {
		return diSort;
	}
	public void setDiSort(int diSort) {
		this.diSort = diSort;
	}
	public int getLikeCnt() {
		return likeCnt;
	}
	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}
	public int getDislikeCnt() {
		return dislikeCnt;
	}
	public void setDislikeCnt(int dislikeCnt) {
		this.dislikeCnt = dislikeCnt;
	}
	public int getReplyCnt() {
		return replyCnt;
	}
	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}
}
