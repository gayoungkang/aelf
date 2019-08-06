package model;

public class ReplyModel {

	private int nrNo = -1;				// �⺻Ű
	private int niNo = -1;				// �Խù� ��ȣ
	private int nrGroupNo = 0;			// ��� ���� �ĺ���ȣ
	private int nrGroupOrder = 0;		// ��� ���� �� ����
	private int nrGroupLayer = 0;		// ��� ���� �� ����
	private int uiNo = -1;				// �ۼ��� ��ȣ
	private String nrContent = "";		// ��� ����
	private String nrDate = "";			// �ۼ���	
	private int nrDelete = 0;			// ���� ����
	
	private String uiName = "";			// �ۼ���
	private String uiProfile = "";		// �ۼ��� ������
	
	private String sortType = "desc";	// ���� ����
	
	
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
