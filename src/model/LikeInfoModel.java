package model;

public class LikeInfoModel {

	private int liNo = -1;				// �⺻Ű
	private int boardNo = -1;			// ���� �Խù� ��ȣ
	private String boardType = "";		// ���� �Խù� ����(notice_info / notice_reply / ....)
	private String liType = "";			// �ǵ�� ����(like / unlike)
	private int uiNo = -1;				// �ش� �����
	private String liDate = "";			// �����
	
	
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
