package model;

public class ReplyModel {

	private int nrNo = -1;				// 기본키
	private int niNo = -1;				// 게시물 번호
	private int nrGroupNo = 0;			// 답글 묶음 식별번호
	private int nrGroupOrder = 0;		// 답글 묶음 내 순서
	private int nrGroupLayer = 0;		// 답글 묶음 내 계층
	private int uiNo = -1;				// 작성자 번호
	private String nrContent = "";		// 답글 내용
	private String nrDate = "";			// 작성일	
	private int nrDelete = 0;			// 삭제 여부
	
	private String uiName = "";			// 작성자
	private String uiProfile = "";		// 작성자 프로필
	
	private String sortType = "desc";	// 정렬 유형
	
	
	public int getNrNo() {
		return nrNo;
	}
	public void setNrNo(int nrNo) {
		this.nrNo = nrNo;
	}
	public int getNiNo() {
		return niNo;
	}
	public void setNiNo(int niNo) {
		this.niNo = niNo;
	}
	public int getNrGroupNo() {
		return nrGroupNo;
	}
	public void setNrGroupNo(int nrGroupNo) {
		this.nrGroupNo = nrGroupNo;
	}
	public int getNrGroupOrder() {
		return nrGroupOrder;
	}
	public void setNrGroupOrder(int nrGroupOrder) {
		this.nrGroupOrder = nrGroupOrder;
	}
	public int getNrGroupLayer() {
		return nrGroupLayer;
	}
	public void setNrGroupLayer(int nrGroupLayer) {
		this.nrGroupLayer = nrGroupLayer;
	}
	public int getUiNo() {
		return uiNo;
	}
	public void setUiNo(int uiNo) {
		this.uiNo = uiNo;
	}
	public String getNrContent() {
		return nrContent;
	}
	public void setNrContent(String nrContent) {
		this.nrContent = nrContent;
	}
	public String getNrDate() {
		return nrDate;
	}
	public void setNrDate(String nrDate) {
		this.nrDate = nrDate;
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
	public int getNrDelete() {
		return nrDelete;
	}
	public void setNrDelete(int nrDelete) {
		this.nrDelete = nrDelete;
	}
	public String getSortType() {
		return sortType;
	}
	public void setSortType(String sortType) {
		this.sortType = sortType;
	}
}
