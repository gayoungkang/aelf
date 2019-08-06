package model;

public class DebateInfoModel {

	private int diNo = -1;					// �⺻Ű
	private String diTitle = "";			// ����
	private String diContent = "";			// ����
	private String diAuthor = "";			// �ۼ��ڸ�
	private int uiNo = -1;					// �ۼ��� ��ȣ
	private String diDate = "";				// �ۼ���
	private int diView = 0;					// ��ȸ��
	private String diTopFix = "0";			// ��� ���� ����
	private String diApprove = "0";			// ������ ���� ����
	private int diSort = 0;					// ����
	
	private int likeCnt = 0;				// ���ƿ� ��
	private int dislikeCnt = 0;				// �Ⱦ�� ��
	private int replyCnt = 0;				// ��� ��
	
	private String pageNum = "1";			//���̽� ó�� �������ѹ�
	private int listCount = 30;			//�� ���� Ŀ�´�Ƽ �Խù� ����
	private int pagePerBlock = 10;			// �׺���̼� ��� ��
	
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
