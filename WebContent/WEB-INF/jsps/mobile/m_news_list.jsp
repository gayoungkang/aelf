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
	List<NewsInfoModel> listNI = (List<NewsInfoModel>) request.getAttribute("listNI");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AELF</title>

<!-- Naver Analytics -->	
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "10e055c33a4b84";
wcs_do();
</script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-124162297-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-124162297-1');
</script>

<meta name="Title" content="엘프 코리아 뉴스">
<meta name="Keyword" content="aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain 엘프커뮤니티 엘프관리자 엘프뉴스 엘프커뮤니티 엘프포럼 엘프캔디 엘프밋업">
<meta name="Description" content="엘프에 대한 최신 뉴스 및 속보를 받아보세요. 엘프의 다양한 활동, 성취와 성과를 확인해 보세요.">
<meta name="Author" content="Daniel Gong">

<meta itemprop="name" content="엘프 코리아">
<meta itemprop="description" content="엘프에 대한 최신 뉴스 및 속보를 받아보세요. 엘프의 다양한 활동, 성취와 성과를 확인해 보세요.">
<meta itemprop="image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">

<meta property="og:type" content="website">
<meta property="og:site_name" content="AELF KOREA">
<meta property="og:title" content="엘프 코리아 뉴스">
<meta property="og:description" content="엘프에 대한 최신 뉴스 및 속보를 받아보세요. 엘프의 다양한 활동, 성취와 성과를 확인해 보세요.">
<meta property="og:image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io/news.lf?menu=news&mode=list">

<meta name="apple-mobile-web-app-title" content="엘프 코리아 뉴스">
<meta name="application-name" content="엘프 코리아">

<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">

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
    
    <div class="news-wrap">
		<%
		for(int i=0; i<listNI.size(); i++){
				NewsInfoModel list = listNI.get(i);
                	
				String dateStr[] = list.getNewsDate().split(" ");
		%>
        <div class="news">
            <img src="upload/news/<%=list.getNewsNo() %>/<%=list.getNewsThumbnail() %>" alt="" />
            <div class="news-top">
                <p class="news-title"><%=list.getNewsTitle() %></p>
                <p class="news-tx"><%=CryptoSlate.getRemoveHtmlText(list.getNewsContent()) %></p>
            </div>
            <div class="news-bottom">
                <span><%=list.getNewsAuthor() %>｜<%=DateConvert.month(dateStr[0]) %><%=dateStr[0].substring(8, 10) %>.<%=dateStr[0].substring(0, 4) %></span>
                <button class="aelf-btn" onclick="javascript:location.href='news.lf?menu=news&mode=view&news_no=<%=list.getNewsNo() %>'">내용 자세히 보기</button>
            </div>
        </div>
        <%
		}
        %>                

<!-- 
        <div class="aelf-nav-wrap">
            <ul class="aelf-nav">
                <li>＜</li>
                <li class="active">1</li>
                <li>2</li>
                <li>3</li>
                <li>4</li>
                <li>5</li>
                <li>＞</li>
            </ul>
        </div>
 -->        
    </div>
    
    <jsp:include page="./m_footer.jsp"></jsp:include>
    
</body>
</html>