package util;

public class DateConvert {
	public static String month(String date) {
		String convert = "";
		
		String strArr[] = date.split("-");
		
		if("01".equals(strArr[1]))
			convert = "Jan";
		else if("02".equals(strArr[1]))
			convert = "Feb";
		else if("03".equals(strArr[1]))
			convert = "Mar";
		else if("04".equals(strArr[1]))
			convert = "Apr";
		else if("05".equals(strArr[1]))
			convert = "May";
		else if("06".equals(strArr[1]))
			convert = "Jun";
		else if("07".equals(strArr[1]))
			convert = "Jul";
		else if("08".equals(strArr[1]))
			convert = "Aug";
		else if("09".equals(strArr[1]))
			convert = "Sep";
		else if("10".equals(strArr[1]))
			convert = "Oct";
		else if("11".equals(strArr[1]))
			convert = "Nov";
		else if("12".equals(strArr[1]))
			convert = "Dec";
		
		return convert;
	}
}
