package model;

public class PetitionInfoModel {

	private int piNo = -1;					// �⺻Ű
	private String piTitle = "";			// ����
	private String piContent = "";			// ����
	private String piAuthor = "";			// �ۼ��ڸ�
	private int uiNo = -1;					// �ۼ��� ��ȣ
	private String piDate = "";				// �ۼ���
	private int piView = 0;					// ��ȸ��
	private int piSort = 0;					// ����
	private String piReply = "";			// û���亯
	
	private String orderType = "";			// ��������
	
	private int likeCnt = 0;				// ��õ ��
	private int replyCnt = 0;				// ��� ��
	
	private String pageNum = "1";			//���̽� ó�� �������ѹ�
	private int listCount = 30;				//�� ���� Ŀ�´�Ƽ �Խù� ����
	private int pagePerBlock = 10;			// �׺���̼� ��� ��
	
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
