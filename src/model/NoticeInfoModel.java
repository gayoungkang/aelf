package model;

public class NoticeInfoModel {
	private int niNo = -1;				// �⺻Ű
	private String niTitle = "";		// ����
	private String niThumbnail = "";	// �����
	private String niAuthor = "";		// �۾���
	private String niDate = "";			// �ۼ���
	private String niContent = "";		// ����
	private int niView = 0;				// ��ȸ��
	private String niTopFix = "0";		// ��� ����(�������� ��� ����������)
	private int niSort = 0;				// �������� ����
	
	private String pageNum = "1";			//���̽� ó�� �������ѹ�
	private int listCount = 30;			//�� ���� Ŀ�´�Ƽ �Խù� ����
	private int pagePerBlock = 10;			// �׺���̼� ��� ��
	
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
