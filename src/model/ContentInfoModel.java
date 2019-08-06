package model;

public class ContentInfoModel {
	private int ciNo = -1;
	private int ccNo = -1;					// �ڵ� �⺻Ű
	private String ciThumbnail = "";		// �����
	private String ciContent = "";			// ����
	private String ciTitle = "";			// ����
	private String ciAuthor = "";			// �ۼ���
	private String ciDate = "";				// ��¥
	private int ciView = 0;					// ��ȸ��
	private String ciLink = "";				// ��ũ
	private int ciSort = 0;					// ����
	
	private String ccName = "";				// �ڵ� �̸�
	
	private String pageNum = "1";			//���̽� ó�� �������ѹ�
	private int listCount = 8;				//�� ���� Ŀ�´�Ƽ �Խù� ����
	private int pagePerBlock = 5;			// �׺���̼� ��� ��
	
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
