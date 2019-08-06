<%@page import="model.CalendarInfoModel"%>
<%@page import="util.CryptoSlate"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="util.DateConvert"%>
<%@page import="model.NewsInfoModel"%>
<%@page import="model.ContentInfoModel"%>
<%@page import="model.NoticeInfoModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<CalendarInfoModel> listCal = (List<CalendarInfoModel>) request.getAttribute("listCal");
	CalendarInfoModel cal = (CalendarInfoModel) request.getAttribute("cal");
	int totalCount = (Integer) request.getAttribute("totalCount");
	String pageNavigator = (String) request.getAttribute("pageNavigator");
	String pageNum = (String) request.getAttribute("pageNum");
	
	String year = (String) request.getAttribute("year");
	String month = (String) request.getAttribute("month");
	
	int prevYear = Integer.parseInt(year)-1;
	int nextYear = Integer.parseInt(year)+1;
	
	String arrWeek[] = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AELF</title>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-124162297-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-124162297-1');
</script>
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "10e055c33a4b84";
wcs_do();
</script>
<meta name="description" content="AELF">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">

<meta name="Title" content="엘프 코리아 캘린더">
<meta name="Keyword" content="aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain 엘프정보 엘프커뮤니티 엘프포럼 엘프캔디 엘프밋업 엘프이벤트 엘프소식">
<meta name="Description" content="엘프의 최신 이벤트와 활동을 한눈에 보실 수 있습니다. 엘프와 엘프코리아가 참여하는 컨퍼런스와 이벤트 정보를 받아보세요.">
<meta name="Author" content="Daniel Gong">

<meta itemprop="name" content="엘프 코리아 캘린더">
<meta itemprop="description" content="엘프의 최신 이벤트와 활동을 한눈에 보실 수 있습니다. 엘프와 엘프코리아가 참여하는 컨퍼런스와 이벤트 정보를 받아보세요.">
<meta itemprop="image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">
<meta property="og:type" content="website">
<meta property="og:site_name" content="AELF KOREA">
<meta property="og:title" content="엘프 코리아 캘린더">
<meta property="og:description" content="엘프의 최신 이벤트와 활동을 한눈에 보실 수 있습니다. 엘프와 엘프코리아가 참여하는 컨퍼런스와 이벤트 정보를 받아보세요.">
<meta property="og:image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io/calendar.lf?menu=calendar">
<meta name="apple-mobile-web-app-title" content="엘프 코리아">
<meta name="application-name" content="엘프 코리아">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="js/jquery-ui.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-m-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->
<link rel="stylesheet" href="//fonts.googleapis.com/earlyaccess/nanummyeongjo.css"><!-- 나눔명조 웹폰트 -->

<script type="text/javascript">

function topBtn(){
   $("html, body").stop().animate({scrollTop:0}, 500, 'swing', function(){});
}

$(window).scroll(function(event){
	var scroll = $(window).scrollTop();
	if(scroll >= 100) {
		document.getElementById('up_btn').style.display = '';
   } else {
		document.getElementById('up_btn').style.display = 'none';
   }
});

</script>

</head>
<body>

	<jsp:include page="./m_top.jsp"></jsp:include>
    
   <div class="page-up" id="up_btn" style="display: none;">
        <img src="m-img/page-up.png" alt="" onclick="javascript:topBtn()" />
    </div>
    
    <div class="notice-wrap calender-wrap">
        
        <table cellpadding="0" cellspacing="0" class="petition-tap">
            <tr>
                <td style="text-align: right" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=prevYear%>&month=<%=month%>'">＜</td>
                <td style="letter-spacing: 0;"><%=year %></td>
                <td style="text-align: left;" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=nextYear%>&month=<%=month%>'">＞</td>
            </tr>
        </table>
        
        <div class="calender-month-wrap">
            <table cellpadding="0" cellspacing="0" class="calender-month">
                <tr>
                    <td><a href="calendar.lf?menu=calendar&year=<%=year%>&month=01" <%if("01".equals(month)) {%>class="active"<%}%> >1<span></span></a></td>
                    <td><a href="calendar.lf?menu=calendar&year=<%=year%>&month=02" <%if("02".equals(month)) {%>class="active"<%}%> >2<span></span></a></td>
                    <td><a href="calendar.lf?menu=calendar&year=<%=year%>&month=03" <%if("03".equals(month)) {%>class="active"<%}%> >3<span></span></a></td>
                    <td><a href="calendar.lf?menu=calendar&year=<%=year%>&month=04" <%if("04".equals(month)) {%>class="active"<%}%> >4<span></span></a></td>
                    <td><a href="calendar.lf?menu=calendar&year=<%=year%>&month=05" <%if("05".equals(month)) {%>class="active"<%}%> >5<span></span></a></td>
                    <td><a href="calendar.lf?menu=calendar&year=<%=year%>&month=06" <%if("06".equals(month)) {%>class="active"<%}%> >6<span></span></a></td>
                    <td><a href="calendar.lf?menu=calendar&year=<%=year%>&month=07" <%if("07".equals(month)) {%>class="active"<%}%> >7<span></span></a></td>
                    <td><a href="calendar.lf?menu=calendar&year=<%=year%>&month=08" <%if("08".equals(month)) {%>class="active"<%}%> >8<span></span></a></td>
                    <td><a href="calendar.lf?menu=calendar&year=<%=year%>&month=09" <%if("09".equals(month)) {%>class="active"<%}%> >9<span></span></a></td>
                    <td><a href="calendar.lf?menu=calendar&year=<%=year%>&month=10" <%if("10".equals(month)) {%>class="active"<%}%> >10<span></span></a></td>
                    <td><a href="calendar.lf?menu=calendar&year=<%=year%>&month=11" <%if("11".equals(month)) {%>class="active"<%}%> >11<span></span></a></td>
                    <td><a href="calendar.lf?menu=calendar&year=<%=year%>&month=12" <%if("12".equals(month)) {%>class="active"<%}%> >12<span></span></a></td>
                </tr>
            </table>
        </div>
        
        <div class="notice-top-wrap calender">
		<%
		String curDate = "";
		for(int i=0; i<listCal.size(); i++) {
			CalendarInfoModel list = listCal.get(i);
			
			if(curDate.equals(list.getCalStartDate())==false) {
		%>
			<p class="title"><%=list.getCalStartDate().substring(5, 7) %>월 <%=list.getCalStartDate().substring(8, 10) %>일</p>
		<%
			}
		%>
			<table cellpadding="0" cellspacing="0">
                <tr>
                    <td width="8.5%"><%=list.getCalTag() %></td>
                    <td><%=list.getCalTitle() %></td>
                    <td width="17%"><%=list.getCalStartDate().substring(0, 4) %>.<%=list.getCalStartDate().substring(5, 7) %>.<%=list.getCalStartDate().substring(8, 10) %></td>
                </tr>
            </table>
		<%			
			curDate = list.getCalStartDate();
		}
		%>
		</div>        
    </div>
    
    <jsp:include page="./m_footer.jsp"></jsp:include>
    
</body>
</html>