package model;

public class UserLogModel {
	private String ulPrevLink = "";			// ���� ���
	private String ulIp = "";				// ���� IP
	private String ulCountry = "";			// ����
	private String ulCity = "";				// ����
	private String ulDevice = "";			// ����̽� (��, �����)
	private String ulDate = "";				// ��¥
	private String ulTime = "";				// �ð�
	
	private String pageNum = "1";			//���̽� ó�� �������ѹ�
	private int listCount = 50;			//�� ���� Ŀ�´�Ƽ �Խù� ����
	private int pagePerBlock = 10;			// �׺���̼� ��� ��
	
	public String getUlIp() {
		return ulIp;
	}
	public void setUlIp(String ulIp) {
		this.ulIp = ulIp;
	}
	public String getUlPrevLink() {
		return ulPrevLink;
	}
	public void setUlPrevLink(String ulPrevLink) {
		this.ulPrevLink = ulPrevLink;
	}
	public String getUlCountry() {
		return ulCountry;
	}
	public void setUlCountry(String ulCountry) {
		this.ulCountry = ulCountry;
	}
	public String getUlCity() {
		return ulCity;
	}
	public void setUlCity(String ulCity) {
		this.ulCity = ulCity;
	}
	public String getUlDevice() {
		return ulDevice;
	}
	public void setUlDevice(String ulDevice) {
		this.ulDevice = ulDevice;
	}
	public String getUlDate() {
		return ulDate;
	}
	public void setUlDate(String ulDate) {
		this.ulDate = ulDate;
	}
	public String getUlTime() {
		return ulTime;
	}
	public void setUlTime(String ulTime) {
		this.ulTime = ulTime;
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
