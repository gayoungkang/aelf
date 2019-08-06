package model;

public class AlarmInfoModel {

	private int aiNo = -1;					// �⺻Ű
	private int boardNo = -1;				// �ش� �Խù� ��ȣ
	private String boardType = "";			// �ش� �Խù� ����(notice_info, news_info, ...)
	private int uiNo = -1;					// �ش� �˶� ����� ��ȣ(-1�̸� ��ü)
	private int fromUiNo = -1;				// �˶� ���� ������ ��ȣ(-1�̸� aelf korea)
	private String aiContent = "";			// �˶� ����
	private String aiDate = "";				// �˶� �����
	private String fromUiProfile = "";		// �˶� ������ ������ ����
	
	public int getAiNo() {
		return aiNo;
	}
	public void setAiNo(int aiNo) {
		this.aiNo = aiNo;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public int getUiNo() {
		return uiNo;
	}
	public void setUiNo(int uiNo) {
		this.uiNo = uiNo;
	}
	public int getFromUiNo() {
		return fromUiNo;
	}
	public void setFromUiNo(int fromUiNo) {
		this.fromUiNo = fromUiNo;
	}
	public String getAiContent() {
		return aiContent;
	}
	public void setAiContent(String aiContent) {
		this.aiContent = aiContent;
	}
	public String getAiDate() {
		return aiDate;
	}
	public void setAiDate(String aiDate) {
		this.aiDate = aiDate;
	}
	public String getFromUiProfile() {
		return fromUiProfile;
	}
	public void setFromUiProfile(String fromUiProfile) {
		this.fromUiProfile = fromUiProfile;
	}
}
