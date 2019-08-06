<%@page import="model.UserInfoModel"%>
<%@page import="model.PetitionInfoModel"%>
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
   PetitionInfoModel pi = (PetitionInfoModel) request.getAttribute("pi");
   List<PetitionInfoModel> listPI = (List<PetitionInfoModel>) request.getAttribute("listPI");
   List<PetitionInfoModel> listBest = (List<PetitionInfoModel>) request.getAttribute("listBest");
   
   int totalCount = (Integer) request.getAttribute("totalCount");
   String pageNum = (String) request.getAttribute("pageNum");
   String pageNavigator = (String) request.getAttribute("pageNavigator");
   String searchText = (String) request.getAttribute("searchText");
   String gubun = (String) request.getAttribute("gubun");
   
   UserInfoModel userInfo = (UserInfoModel) session.getAttribute("userInfo");
   
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

<meta name="Title" content="엘프 코리아 청원게시판">
<meta name="Keyword" content="엘프관리자 엘프정보 엘프커뮤니티 엘프연락 엘프포럼 엘프캔디 엘프밋업 엘프지원 엘프문의 aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain">
<meta name="Description" content="엘프 청원, 지원 및 의견 제안하기. 엘프 관리 팀과 소통하고 무엇이든 물어보세요. 엘프코리아가 개선할 수 있도록 많은 참여 바랍니다.">
<meta name="Author" content="Daniel Gong">

<meta itemprop="name" content="엘프 코리아">
<meta itemprop="description" content="엘프 청원, 지원 및 의견 제안하기. 엘프 관리 팀과 소통하고 무엇이든 물어보세요. 엘프코리아가 개선할 수 있도록 많은 참여 바랍니다.">
<meta itemprop="image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">

<meta property="og:type" content="website">
<meta property="og:site_name" content="AELF KOREA">
<meta property="og:title" content="엘프 코리아 청원게시판">
<meta property="og:description" content="엘프 청원, 지원 및 의견 제안하기. 엘프 관리 팀과 소통하고 무엇이든 물어보세요. 엘프코리아가 개선할 수 있도록 많은 참여 바랍니다.">
<meta property="og:image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io/petition.lf?menu=petition">

<meta name="apple-mobile-web-app-title" content="엘프 코리아 청원게시판">
<meta name="application-name" content="엘프 코리아">


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

function writePetition() {
   <%if(userInfo == null) {%>
      alert('로그인 후 사용할 수 있습니다.');
   <%} else { %>
      location.href = 'petition.lf?menu=petition&mode=write&gubun=<%=gubun %>';
   <%} %>
}
</script>

</head>
<body>

   <jsp:include page="./m_top.jsp"></jsp:include>
    
   <div class="page-up" id="up_btn" style="display: none;">
        <img src="m-img/page-up.png" alt="" onclick="javascript:topBtn()" />
    </div>    
    
   <div class="notice-wrap">
        
        <table cellpadding="0" cellspacing="0" class="petition-tap">
            <tr>
                <td onclick="javascript:location.href='petition.lf?menu=petition&mode=list&gubun=recent'" <%if("recent".equals(gubun)) {%> class="active" <%} %> >최신순</td>
                <td onclick="javascript:location.href='petition.lf?menu=petition&mode=list&gubun=recommend'" <%if("recommend".equals(gubun)) {%> class="active" <%} %>>추천순</td>
                <td onclick="javascript:location.href='petition.lf?menu=petition&mode=list&gubun=complete'" <%if("complete".equals(gubun)) {%> class="active" <%} %>>답변완료</td>
            </tr>
        </table>
        
<%if("complete".equals(gubun)) {   ////////////// 답변 된 청원 %>

        <div class="notice">
            <p class="title">답변 완료 청원</p>
            
            <%
            for(int i=0; i<listPI.size(); i++) {
               PetitionInfoModel list = listPI.get(i);
            %>
            <div class="notice-top-wrap">
                <div class="notice-top">
                    <p class="notice-title"><%=list.getPiTitle() %></p>
                    <p class="notice-tx"><%=CryptoSlate.getRemoveHtmlText(list.getPiContent()) %></p>
                    <div class="notice-top-info">
                        <span class="info-title">날짜</span><span class="info-sub"><%=list.getPiDate().substring(2, 4) %>.<%=list.getPiDate().substring(5, 7) %>.<%=list.getPiDate().substring(8, 10) %></span><br>
                        <span class="info-title">조회수</span><span class="info-sub" style="color:#35b1ff;"><%=nf.format(list.getPiView()) %>명</span>
                    </div>
                    <button class="aelf-btn">내용 자세히 보기</button>
                </div>
            </div>
            <%
            }
            %>
            
            <div class="notice-bottom-wrap">
                <div class="aelf-list-wrap">
                    <%=pageNavigator %>
                </div>
            </div>
            
        </div>

<%} else { %>
        <div class="notice">
      <%if(listBest.size()>0) { %>
            <div class="notice-top-wrap">
                <p class="title">최다 추천 청원</p>
                <!-- Swiper -->
            <div class="swiper-container">
               <div class="swiper-wrapper">
               
               <%
               for(int i=0; i<listBest.size(); i++) {
                  PetitionInfoModel bestPI = listBest.get(i);
               %>
               <div class="swiper-slide">
                      <div class="notice-top notice-top-list">
                          <p class="notice-title"><%=bestPI.getPiTitle() %></p>
                          <p class="notice-tx"><%=CryptoSlate.getRemoveHtmlText(bestPI.getPiContent()) %></p>
                          <div class="notice-top-info">
                              <span class="info-title">날짜</span><span class="info-sub"><%=bestPI.getPiDate().substring(2, 4) %>.<%=bestPI.getPiDate().substring(5, 7) %>.<%=bestPI.getPiDate().substring(8, 10) %></span><br>
                              <span class="info-title">조회수</span><span class="info-sub" style="color:#35b1ff;"><%=nf.format(bestPI.getPiView()) %>명</span>
                          </div>
                          <button class="aelf-btn" onclick="javascript:location.href='petition.lf?menu=petition&mode=view&gubun=<%=gubun %>&pi_no=<%=bestPI.getPiNo() %>'">내용 자세히 보기</button>
                      </div>
                   </div>
                      
                  <%} %>  
                
                   </div>
               <!-- Add Pagination -->
               <div class="swiper-pagination"></div>
            </div>
            </div>
      <%} %>
            
            <div class="notice-bottom-wrap">
                <p class="title">유저청원</p>
                <div class="aelf-list-wrap">
                    <ul class="aelf-list">
                     <%
                    for(int i=0; i<listPI.size(); i++) {
                       PetitionInfoModel list = listPI.get(i);
                       
                       String dateStr[] = list.getPiDate().split(" ");
                    %>
                        <li onclick="javascript:location.href='petition.lf?menu=petition&mode=view&gubun=<%=gubun %>&pi_no=<%=list.getPiNo() %>'">
                           <%=list.getPiTitle() %><span class="bottom-info"><%=dateStr[0].substring(2, 4) %>.<%=dateStr[0].substring(5, 7) %>.<%=dateStr[0].substring(8, 10) %></span>
                        </li>
                    <%
                    } 
                    %>
                    </ul>
                       <ul>
                        <li style="text-align: right;">
                           <input type="button" value="신청" style="margin-top:4%; width: 17%; height: 32px; background-color: #001c33; color:#fff; cursor: pointer; vertical-align: bottom" onclick="javascript:writePetition()" />
                        </li>
                    </ul>
                    <ul>
                        <li>
                           <form action="petition.lf" method="get">
                              <input type="hidden" name="menu" value="petition" />
                              <input type="hidden" name="mode" value="list" />
                               <input type="text" name="searchText" value="<%=searchText %>" style="margin-left:12%; margin-top:4%; width: 58%; height: 30px; border:1px solid #bfbfbf;"/>
                               <input type="submit" value="검색" style="width: 14%; height: 32px; background-color: #001c33; color:#fff; cursor: pointer; vertical-align: bottom"/>
                            </form>
                        </li>
                    </ul>
                    <%=pageNavigator %>
                </div>
            </div>
            
        </div>
<%} %>
        

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