package util;

import java.net.URLDecoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CryptoSlate {
	public static String convertString(String text){
		String convertString = "";
		
		if(text.indexOf("[SyndContentImpl.value=")>-1 && text.indexOf("SyndContentImpl.interface")>-1){
			convertString = text.substring(text.indexOf("[SyndContentImpl.value=")+23, text.indexOf("SyndContentImpl.interface"));
		}
		
		return convertString;
	}
	
	public static String imageLink2(String text){
		String imageLink = "";
		if(text.indexOf("<img")>-1){
		
			String textLink = text.substring(text.indexOf("<img"));			
			textLink = textLink.substring(textLink.indexOf("src"));
			textLink = textLink.substring(textLink.indexOf("src"), textLink.indexOf(">"));
			//System.out.println("textlink : " + textLink);
			if(textLink.indexOf("jpg")>-1){
				textLink = textLink.substring(0, textLink.indexOf("jpg"));
				textLink = textLink.replaceAll("src\\=\"", "");
				textLink = textLink.replaceAll(" ", "");
				imageLink = textLink + "jpg";
			}
			else if(textLink.indexOf("png")>-1){
				textLink = textLink.substring(0, textLink.indexOf("png"));
				textLink = textLink.replaceAll("src\\=\"", "");
				textLink = textLink.replaceAll(" ", "");
				imageLink = textLink + "png";
			}
			else if(textLink.indexOf("jpeg")>-1){
				textLink = textLink.substring(0, textLink.indexOf("jpeg"));
				textLink = textLink.replaceAll("src\\=\"", "");
				textLink = textLink.replaceAll(" ", "");
				imageLink = textLink + "jpeg";
			}
			else if(textLink.indexOf("PNG")>-1){
				textLink = textLink.substring(0, textLink.indexOf("PNG"));
				textLink = textLink.replaceAll("src\\=\"", "");
				textLink = textLink.replaceAll(" ", "");
				imageLink = textLink + "PNG";
			}
			
			else if(textLink.indexOf("JPG")>-1){
				textLink = textLink.substring(0, textLink.indexOf("JPG"));
				textLink = textLink.replaceAll("src\\=\"", "");
				textLink = textLink.replaceAll(" ", "");
				imageLink = textLink + "JPG";
			}
			else if(textLink.indexOf("JPEG")>-1){
				textLink = textLink.substring(0, textLink.indexOf("JPEG"));
				textLink = textLink.replaceAll("src\\=\"", "");
				textLink = textLink.replaceAll(" ", "");
				imageLink = textLink + "JPEG";
			}
			else
				imageLink = "";
		}
		
		return imageLink;
	}
	
	public static String removeTag(String html) throws Exception {
		return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	}
	
	
	public static String getRemoveHtmlText(String content) { 	        

        Pattern SCRIPTS = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>",Pattern.DOTALL);  

      Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>",Pattern.DOTALL);  

      Pattern TAGS = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");  

      Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");  

      Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");  

      Pattern WHITESPACE = Pattern.compile("\\s\\s+");  

               

      Matcher m;  

         

      m = SCRIPTS.matcher(content);  

      content = m.replaceAll("");  

      m = STYLE.matcher(content);  

      content = m.replaceAll("");  

      m = TAGS.matcher(content);  
      
      content = m.replaceAll("");  

      m = nTAGS.matcher(content);  

      content = m.replaceAll("");  

      m = ENTITY_REFS.matcher(content);  

      content = m.replaceAll("");  

      m = WHITESPACE.matcher(content);  

      content = m.replaceAll(" ");          

             

      return content;  

  }   
	
	
	public static String replacer(String outBuffer) {

	    String data = outBuffer;
	    try {
	        StringBuffer tempBuffer = new StringBuffer();
	        int incrementor = 0;
	        int dataLength = data.length();
	        while (incrementor < dataLength) {
	            char charecterAt = data.charAt(incrementor);
	            if (charecterAt == '%') {
	                tempBuffer.append("<percentage>");
	            } else if (charecterAt == '+') {
	                tempBuffer.append("<plus>");
	            } else {
	                tempBuffer.append(charecterAt);
	            }
	            incrementor++;
	        }
	        data = tempBuffer.toString();
	        data = URLDecoder.decode(data, "utf-8");
	        data = data.replaceAll("<percentage>", "%");
	        data = data.replaceAll("<plus>", "+");
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return data;
	}
}
