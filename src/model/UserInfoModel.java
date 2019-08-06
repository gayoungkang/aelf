package model;

public class UserInfoModel {

	private int uiNo = -1;				// 기본키
	private String uiId = "";			// 아이디
	private String uiName = "";			// 이름
	private String uiProfile = "";		// 프로필 사진
	private String uiInfollow = "";		// 유입경로 
	
	public int getUiNo() {
		return uiNo;
	}
	public void setUiNo(int uiNo) {
		this.uiNo = uiNo;
	}
	public String getUiId() {
		return uiId;
	}
	public void setUiId(String uiId) {
		this.uiId = uiId;
	}
	public String getUiName() {
		return uiName;
	}
	public void setUiName(String uiName) {
		this.uiName = uiName;
	}
	public String getUiProfile() {
		return uiProfile;
	}
	public void setUiProfile(String uiProfile) {
		this.uiProfile = uiProfile;
	}
	public String getUiInfollow() {
		return uiInfollow;
	}
	public void setUiInfollow(String uiInfollow) {
		this.uiInfollow = uiInfollow;
	}
}
