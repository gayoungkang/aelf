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
	List<ContentInfoModel> listCI = (List<ContentInfoModel>) request.getAttribute("listCI");
	String pageNavigator = (String)request.getAttribute("pageNavigator");
	String gubun = (String) request.getAttribute("gubun");
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

<meta name="Title" content="엘프 코리아 컨텐츠">
<meta name="Keyword" content="aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain">
<meta name="Description" content="엘프에 다양한 정보, 진행서와 보고서 보기. 인터뷰 동영상 및 엘프코리아 관련 동영상과 기사들을 볼 수 있습니다.">
<meta name="Author" content="Daniel Gong">

<meta itemprop="name" content="엘프 코리아 컨텐츠">
<meta itemprop="description" content="엘프에 다양한 정보, 진행서와 보고서 보기. 인터뷰 동영상 및 엘프코리아 관련 동영상과 기사들을 볼 수 있습니다.">
<meta itemprop="image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">
<meta property="og:type" content="website">
<meta property="og:site_name" content="AELF KOREA">
<meta property="og:title" content="엘프 코리아 컨텐츠">
<meta property="og:description" content="엘프에 다양한 정보, 진행서와 보고서 보기. 인터뷰 동영상 및 엘프코리아 관련 동영상과 기사들을 볼 수 있습니다.">
<meta property="og:image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io/contents.lf?menu=contents&mode=list">
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
    
    <div class="contents-wrap">
        
        <table cellpadding="0" cellspacing="0" class="petition-tap">
            <tr>
                <td onclick="javascript:location.href='contents.lf?menu=contents&mode=list&gubun=video'" <%if("video".equals(gubun)){ %>class="active"<%} %> >VIDEO</td>
                <td onclick="javascript:location.href='contents.lf?menu=contents&mode=list&gubun=info'" <%if("info".equals(gubun)){ %>class="active"<%} %> >INFOGRAPHIC</td>
                <td onclick="javascript:location.href='contents.lf?menu=contents&mode=list&gubun=article'" <%if("article".equals(gubun)){ %>class="active"<%} %> >ETC</td>
            </tr>
        </table>
        
        <div class="contents">
            
            <div class="main-contents-wrap contents-wrap main-notice-wrap">
                <div class="main-contents contents">
                
				<%
				for(int i=0; i<listCI.size(); i++){
					ContentInfoModel list = listCI.get(i);
					
					String tag = "";
					if("video".equals(list.getCcName()))		tag = "m-img/contents-video.png";
					else if("info".equals(list.getCcName()))	tag = "m-img/contents-info.png";
					else										tag = "m-img/contents-vision.png";
					
					String dateStr[] = list.getCiDate().split(" ");
				%>                    
                    <table cellpadding="0" cellspacing="0" onclick="javascript:location.href='contents.lf?menu=contents&mode=view&ci_no=<%=list.getCiNo() %>'">
                        <tr>
                            <td class="contents-img-wrap">
                                <img src="upload/content/<%=list.getCiNo() %>/<%=list.getCiThumbnail() %>" alt="" class="contents-img" width="100%" height="130" />
                                <span class="contents-emblem"><img src="<%=tag %>" alt="" /></span>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-size:13px;"><p class="two-lines"><%=list.getCiTitle() %></p></td>
                        </tr>
                        <tr height="5"></tr>
                        <tr>
                            <td><%=list.getCiAuthor() %> ｜ <%=DateConvert.month(dateStr[0]) %><%=dateStr[0].substring(8, 10) %>.<%=dateStr[0].substring(0, 4) %></td>
                        </tr>
                    </table>
				<%
				}
				%>
                </div>
            </div>
            
        </div>
        
		<%= pageNavigator %>
        
    </div>
    
    <jsp:include page="./m_footer.jsp"></jsp:include>
    
</body>
</html>