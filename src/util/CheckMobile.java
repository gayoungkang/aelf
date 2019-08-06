package util;

public class CheckMobile {

	public static boolean isMobile(String userAgent) {
		
		boolean bMobile = false;
		
		String[] mobileos = {"iPhone","iPod","Android","BlackBerry","Windows CE","Nokia","Webos","Opera Mini","SonyEricsson","Opera Mobi","IEMobile"};
		int j = -1;
		for(int i=0; i<mobileos.length; i++) {
			j=userAgent.indexOf(mobileos[i]);
			if(j > -1 ) {
				bMobile = true;
				break;
			}
		}
		
		return bMobile;
	}
}
