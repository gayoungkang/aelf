package model;

public class ContentCodeModel {
	private int ccNo = -1;
	private String ccName = "";
	private String ccDel = "0";
	
	public int getCcNo() {
		return ccNo;
	}
	public void setCcNo(int ccNo) {
		this.ccNo = ccNo;
	}
	public String getCcName() {
		return ccName;
	}
	public void setCcName(String ccName) {
		this.ccName = ccName;
	}
	public String getCcDel() {
		return ccDel;
	}
	public void setCcDel(String ccDel) {
		this.ccDel = ccDel;
	}
}
