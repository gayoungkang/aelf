package model;

public class UserInfoModel {

	private int uiNo = -1;				// �⺻Ű
	private String uiId = "";			// ���̵�
	private String uiName = "";			// �̸�
	private String uiProfile = "";		// ������ ����
	private String uiInfollow = "";		// ���԰�� 
	
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
