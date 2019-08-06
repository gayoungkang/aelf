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
	ContentInfoModel ci = (ContentInfoModel) request.getAttribute("ci");

	//디스크립션 관련
	String title = ci.getCiTitle();
	String contents = CryptoSlate.removeTag(ci.getCiContent());
	contents = contents.replaceAll("&nbsp;", "");
	contents = contents.replaceAll("\n", "");
	contents = contents.replaceAll("\r", "");
	contents = contents.replaceAll("<br>", "");
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

<meta name="Title" content="<%= title %>">
<meta name="Keyword" content="aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain">
<meta name="Description" content="<%= contents %>">
<meta name="Author" content="Daniel Gong">

<meta itemprop="name" content="<%= title %>">
<meta itemprop="description" content="<%= contents %>">
<meta itemprop="image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">
<meta property="og:type" content="website">
<meta property="og:site_name" content="AELF KOREA">
<meta property="og:title" content="<%= title %>">
<meta property="og:description" content="<%= contents %>">
<meta property="og:image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io/contents.lf?menu=contents&mode=list">
<meta name="apple-mobile-web-app-title" content="엘프 코리아">
<meta name="application-name" content="엘프 코리아">

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="js/jquery-ui.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-m-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->
<link rel="stylesheet" href="//fonts.googleapis.com/earlyaccess/nanummyeongjo.css"><!-- 나눔명조 웹폰트 -->

<style type="text/css">
.contents img{width: 100%;}
</style>

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

var bToggleShare = 0;

function toggleShare() {
	if(bToggleShare == 0) {
		bToggleShare = 1;
		document.getElementById('tbl_share').style.display = '';
	}
	else {
		bToggleShare = 0;
		document.getElementById('tbl_share').style.display = 'none';
	}
}

/// 공유하기
function shareSNS(sns) {	
	var url = window.location.href;
	var txt = "aelfkorea";
	
	url = encodeURIComponent(url);
	txt = encodeURIComponent(txt);
	
	if(sns == 'facebook') {
		window.open('http://www.facebook.com/sharer/sharer.php?u='+url);
	}
	else if(sns == 'twitter') {
		window.open('http://twitter.com/intent/tweet?text='+txt+'&url='+url);
	}
	else if(sns == 'google') {
		window.open('https://plus.google.com/share?url='+url);
	}
	else if(sns == 'naver') {
		window.open('http://blog.naver.com/openapi/share?url='+url+'&title='+txt);
	}
	else if(sns == 'kakao') {
	}
}

</script>

</head>
<body>

	<jsp:include page="./m_top.jsp"></jsp:include>
    
    <div class="top-wrap" style="background-color: #001b31;">
        <div class="top">
            <img src="m-img/top-back.png" alt="" class="top-menu top-back" onclick="javascript:history.go(-1)" />
            <img src="m-img/top-logo.png" alt="" class="top-logo" onclick="javascript:location.href='main.lf'" />
            <div class="top-alarm top-share">
                <img src="m-img/contents-share.png" alt="" onclick="javascript:toggleShare()" />
                <table cellpadding="0" cellspacing="0" class="contents-share" id="tbl_share" style="display: none;">
                <tr>
                    <td><img src="m-img/share-fb.png" alt="" onclick="javascript:shareSNS('facebook')" /></td>
                    <td><img src="m-img/share-tw.png" alt="" onclick="javascript:shareSNS('twitter')" /></td>
                    <td><img src="m-img/share-nv.png" alt=""  onclick="javascript:shareSNS('naver')" /></td>
                    <td><img src="m-img/share-kt.png" alt="" onclick="javascript:sendLink()" /></td>
                    <td><img src="m-img/share-tg.png" alt="" onclick="javascript:shareSNS('google')" /></td>
                </tr>
        </table>
            </div>
        </div>
    </div>
    
   <div class="page-up" id="up_btn" style="display: none;">
        <img src="m-img/page-up.png" alt="" onclick="javascript:topBtn()" />
    </div>
    
    <div class="contents-wrap contents-on-wrap">
        
        <div class="contents" style="margin-bottom: -4px;">
        
        <%
        if("video".equals(ci.getCcName())) {
        %>
        	<div style='width: 100%; padding-top: 30px;'>
        		<iframe type="text/html" width="100%" height="500px" src="<%=ci.getCiLink() %>"></iframe>
        	</div>
        <%
        }
        else {
        %>
        <%=ci.getCiContent() %>
        <%
        }
        %>
            
        </div>

    </div>
    
    <jsp:include page="./m_footer.jsp"></jsp:include>
    
    
<script type='text/javascript'>
var url = window.location.href;
var txt = "<%=ci.getCiTitle() %>";

//url = encodeURIComponent(url);

    // // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('1c778626456954737e6f06041ec1ee4b');
    // // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
    function sendLink() {
      Kakao.Link.sendDefault({
        objectType: 'feed',
        content: {
          title: 'AelfKorea',
          description: txt,
          imageUrl: 'http://www.atarad.io/aelf/upload/content/<%=ci.getCiNo()%>/<%=ci.getCiThumbnail()%>',
          link: {
            mobileWebUrl: url,
            webUrl: url
          }
        }
      });
    }

</script>
    
</body>
</html>