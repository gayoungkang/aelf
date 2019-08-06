package model;

public class LikeInfoModel {

	private int liNo = -1;				// 기본키
	private int boardNo = -1;			// 관련 게시물 번호
	private String boardType = "";		// 관련 게시물 유형(notice_info / notice_reply / ....)
	private String liType = "";			// 피드백 유형(like / unlike)
	private int uiNo = -1;				// 해당 사용자
	private String liDate = "";			// 등록일
	
	
	public int getLiNo() {
		return liNo;
	}
	public void setLiNo(int liNo) {
		this.liNo = liNo;
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
	public String getLiType() {
		return liType;
	}
	public void setLiType(String liType) {
		this.liType = liType;
	}
	public int getUiNo() {
		return uiNo;
	}
	public void setUiNo(int uiNo) {
		this.uiNo = uiNo;
	}
	public String getLiDate() {
		return liDate;
	}
	public void setLiDate(String liDate) {
		this.liDate = liDate;
	}
}
