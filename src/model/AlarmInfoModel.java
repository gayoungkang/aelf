package model;

public class AlarmInfoModel {

	private int aiNo = -1;					// 기본키
	private int boardNo = -1;				// 해당 게시물 번호
	private String boardType = "";			// 해당 게시물 유형(notice_info, news_info, ...)
	private int uiNo = -1;					// 해당 알람 대상자 번호(-1이면 전체)
	private int fromUiNo = -1;				// 알람 유발 행위자 번호(-1이면 aelf korea)
	private String aiContent = "";			// 알람 내용
	private String aiDate = "";				// 알람 등록일
	private String fromUiProfile = "";		// 알람 유발자 프로필 사진
	
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
