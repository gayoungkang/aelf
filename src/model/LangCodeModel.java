package model;

public class LangCodeModel {
	private String langName = "";
	private int langCode = -1;			// 국가코드 순번
	
	public String getLangName() {
		return langName;
	}
	public void setLangName(String langName) {
		this.langName = langName;
	}
	public int getLangCode() {
		return langCode;
	}
	public void setLangCode(int langCode) {
		this.langCode = langCode;
	}
}
