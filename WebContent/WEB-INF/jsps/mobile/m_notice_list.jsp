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
   NoticeInfoModel ni = (NoticeInfoModel) request.getAttribute("ni");
   List<NoticeInfoModel> listNI = (List<NoticeInfoModel>) request.getAttribute("listNI");
   List<NoticeInfoModel> listTop = (List<NoticeInfoModel>) request.getAttribute("listTop");
   //NoticeInfoModel topNi = (NoticeInfoModel) request.getAttribute("topNi");
   
   int totalCount = (Integer) request.getAttribute("totalCount");
   String pageNum = (String) request.getAttribute("pageNum");
   String pageNavigator = (String) request.getAttribute("pageNavigator");
   String searchText = (String) request.getAttribute("searchText");
   
   NumberFormat nf = NumberFormat.getInstance();
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

<meta name="Title" content="엘프 코리아 공지사항">
<meta name="Keyword" content="aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain 엘프이벤트  엘프퀴즈 엘프QR 엘프QR코드 엘프QR코드찾기 엘프상품 엘프커뮤니티 엘프오픈채팅 엘프밋업 엘프카카오톡 엘프카톡 엘프텔레그램 엘프텔레 엘프관리자 엘프포럼 엘프캔디">
<meta name="Description" content="매주 엘프코리아에서 제공하는 다양한 이벤트와 피드를 받아보세요.  홈페이지 속 숨겨진 QR코드 찾기, 깜짝 퀴즈 등 엘프와 다양한 활동에 참여하고 상품 받기.">
<meta name="Author" content="Daniel Gong">

<meta itemprop="name" content="엘프 코리아">
<meta itemprop="description" content="매주 엘프코리아에서 제공하는 다양한 이벤트와 피드를 받아보세요.  홈페이지 속 숨겨진 QR코드 찾기, 깜짝 퀴즈 등 엘프와 다양한 활동에 참여하고 상품 받기.">
<meta itemprop="image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">

<meta property="og:type" content="website">
<meta property="og:site_name" content="AELF KOREA">
<meta property="og:title" content="엘프 코리아 공지사항">
<meta property="og:description" content="매주 엘프코리아에서 제공하는 다양한 이벤트와 피드를 받아보세요.  홈페이지 속 숨겨진 QR코드 찾기, 깜짝 퀴즈 등 엘프와 다양한 활동에 참여하고 상품 받기.">
<meta property="og:image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io/notice.lf?menu=notice">

<meta name="apple-mobile-web-app-title" content="엘프 코리아 공지사항">
<meta name="application-name" content="엘프 코리아">

<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="js/jquery-ui.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-m-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->
<link rel="stylesheet" href="//fonts.googleapis.com/earlyaccess/nanummyeongjo.css"><!-- 나눔명조 웹폰트 -->
<link rel="stylesheet" type="text/css" href="swiper.min.css" >

<style type="text/css">
    .swiper-container {
      width: 100%;
      height: auto;
      background-color: #f6f6f6;
    }
    .swiper-slide {
      /* Center slide text vertically */
      display: -webkit-box;
      display: -ms-flexbox;
      display: -webkit-flex;
      display: flex;
      -webkit-box-pack: center;
      -ms-flex-pack: center;
      -webkit-justify-content: center;
      justify-content: center;
      -webkit-box-align: center;
      -ms-flex-align: center;
      -webkit-align-items: center;
      align-items: center;
    }
   .swiper-pagination-bullet {
      /*background-image: url(images/dot-non-target.png);*/
      background-color: #e5e5e5 !important;
      border:1px solid #e5e5e5 !important;
      opacity: 1;
      width: 10px;
      height: 10px;
   }
   .swiper-pagination-bullet-active {
      /*background-image: url(images/dot-target.png);*/
      background-color: #001c33 !important;
      border:1px solid #001c33 !important;
      width: 10px;
      height: 10px;
   }
   .swiper-pagination{
      padding-bottom:5px;
   }
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

</script>

</head>
<body>

   <jsp:include page="./m_top.jsp"></jsp:include>
    
   <div class="page-up" id="up_btn" style="display: none;">
        <img src="m-img/page-up.png" alt="" onclick="javascript:topBtn()" />
    </div>
    
    <div class="notice-wrap">
        <div class="notice">
        <%if(listTop.size()>0) { %>
           <div class="notice-top-wrap">
           
              <p class="title">메인 공지사항</p>
        
              <!-- Swiper -->
            <div class="swiper-container">
               <div class="swiper-wrapper">
               <%
               for(int i=0; i<listTop.size(); i++) {
                  NoticeInfoModel topNi = listTop.get(i);
               %>
                  <div class="swiper-slide">    
                         <div class="notice-top notice-top-list">
                             <p class="notice-title"><%=topNi.getNiTitle() %></p>
                             <p class="notice-tx"><%=CryptoSlate.getRemoveHtmlText(topNi.getNiContent()) %></p>
                             <div class="notice-top-info">
                                 <span class="info-title">날짜</span><span class="info-sub"><%=topNi.getNiDate().substring(2, 4) %>.<%=topNi.getNiDate().substring(5, 7) %>.<%=topNi.getNiDate().substring(8, 10) %></span><br>
                                 <!-- <span class="info-title">조회수</span><span class="info-sub" style="color:#35b1ff;">278,128명</span> -->
                                 <span class="info-title">조회수</span><span class="info-sub"><%=nf.format(topNi.getNiView()) %>명</span>
                             </div>
                             <button class="aelf-btn" onclick="javascript:location.href='notice.lf?menu=notice&mode=view&ni_no=<%=topNi.getNiNo() %>'">내용 자세히 보기</button>
                             <!-- <div class="aelf-slider-wrap">
                                 <ul class="aelf-slider">
                                     <li class="active"></li>
                                     <li></li>
                                     <li></li>
                                     <li></li>
                                     <li></li>
                                     <li></li>
                                 </ul>
                             </div> -->
                         </div>
                     </div>
                  <%
                  }
               %>
                     
               </div>
               <!-- Add Pagination -->
               <div class="swiper-pagination"></div>
            </div>
            
         </div>
      <%} %>
            
            <div class="notice-bottom-wrap">
                <p class="title">공지사항</p>
                <div class="aelf-list-wrap">
                    <ul class="aelf-list">
                    <%for(int i=0; i<listNI.size(); i++){
                       NoticeInfoModel list = listNI.get(i);
                       
                       String dateStr[] = list.getNiDate().split(" ");
                    %>
                       <li onclick="javascript:location.href='notice.lf?menu=notice&mode=view&ni_no=<%=list.getNiNo() %>'">
                          <span class="bottom-title" ><%=list.getNiTitle() %></span>
                          <span class="bottom-info" ><%=dateStr[0].substring(2, 4) %>.<%=dateStr[0].substring(5, 7) %>.<%=dateStr[0].substring(8, 10) %></span>
                       </li>
                    <%
                    }
                    %>
                    </ul>
                    <%=pageNavigator %>
                </div>
            </div>
            
        </div>
    </div>
    
    <jsp:include page="./m_footer.jsp"></jsp:include>
    
   <script src="js/swiper.min.js"></script>
   
   <script type="text/javascript">
    var swiper = new Swiper('.swiper-container', {
        spaceBetween: 0,
        centeredSlides: true,
        /*autoplay: {
          delay: 15000,
          disableOnInteraction: false,
        },*/
        pagination: {
          el: '.swiper-pagination',
          clickable: true,
        },
      });
    </script>
    
</body>
</html>