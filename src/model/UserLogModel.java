package model;

public class UserLogModel {
	private String ulPrevLink = "";			// 유입 경로
	private String ulIp = "";				// 접속 IP
	private String ulCountry = "";			// 국가
	private String ulCity = "";				// 지역
	private String ulDevice = "";			// 디바이스 (웹, 모바일)
	private String ulDate = "";				// 날짜
	private String ulTime = "";				// 시간
	
	private String pageNum = "1";			//제이슨 처리 페이지넘버
	private int listCount = 50;			//한 블럭당 커뮤니티 게시물 갯수
	private int pagePerBlock = 10;			// 네비게이션 블록 수
	
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
