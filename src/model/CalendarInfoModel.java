package model;

public class CalendarInfoModel {

	private int calNo = -1;					// �⺻Ű 
	private String calTag = "";				// �±�
	private String calTitle = "";			// ����
	private String calComment = "";			// �����ڸ�Ʈ
	private String calTime = "";			// �ð�
	private String calPlace = "";			// ���
	private String calContent = "";			// ����
	private String calStartDate = "";		// ��������
	private String calEndDate = "";			// ��������
	private String calDday = ""; 			// ���� 
	
	private String pageNum = "1";			//���̽� ó�� �������ѹ�
	private int listCount = 30;			//�� ���� Ŀ�´�Ƽ �Խù� ����
	private int pagePerBlock = 10;			// �׺���̼� ��� ��
	
	
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
