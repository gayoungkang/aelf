package model;

public class NewsInfoModel {
	private int newsNo = -1;			// �⺻Ű
	private String newsThumbnail = "";	// �����
	private String newsContent = "";	// ����
	private String newsTitle = "";		// ����
	private String newsAuthor = "";		// �ۼ���
	private String newsDate = "";		// �ۼ���
	private int newsView = 0;			// ��ȸ��
	private int newsSort = 0;			// ���� ����
	private String newsLink = "";		// ���� ��ũ
	
	private String pageNum = "1";			//���̽� ó�� �������ѹ�
	private int listCount = 30;			//�� ���� Ŀ�´�Ƽ �Խù� ����
	private int pagePerBlock = 10;			// �׺���̼� ��� ��
	
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
