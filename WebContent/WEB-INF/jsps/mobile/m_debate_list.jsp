<%@page import="model.UserInfoModel"%>
<%@page import="model.DebateInfoModel"%>
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
	DebateInfoModel di = (DebateInfoModel) request.getAttribute("di");
	List<DebateInfoModel> listDI = (List<DebateInfoModel>) request.getAttribute("listDI");
	
	int totalCount = (Integer) request.getAttribute("totalCount");
	String pageNum = (String) request.getAttribute("pageNum");
	String pageNavigator = (String) request.getAttribute("pageNavigator");
	String searchText = (String) request.getAttribute("searchText");
	
	UserInfoModel userInfo = (UserInfoModel) session.getAttribute("userInfo");
	
	List<DebateInfoModel> listTop = (List<DebateInfoModel>) request.getAttribute("listTop");
	List<DebateInfoModel> listBest = (List<DebateInfoModel>) request.getAttribute("listBest");
	
	NumberFormat nf = NumberFormat.getInstance();
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

<meta name="Title" content="엘프 코리아 토론">
<meta name="Keyword" content="aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain 엘프관리자 엘프정보 엘프커뮤니티 엘프연락 엘프포럼 엘프캔디 엘프밋업 엘프문의">
<meta name="Description" content="엘프커뮤니티 – 핫이슈, 트렌드와 토론. 엘프에 대한 모든 대화, 소통, 문의, 의견을 올려주세요.">
<meta name="Author" content="Daniel Gong">

<meta itemprop="name" content="엘프 코리아 토론">
<meta itemprop="description" content="엘프커뮤니티 – 핫이슈, 트렌드와 토론. 엘프에 대한 모든 대화, 소통, 문의, 의견을 올려주세요.">
<meta itemprop="image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">
<meta property="og:type" content="website">
<meta property="og:site_name" content="AELF KOREA">
<meta property="og:title" content="엘프 코리아 토론">
<meta property="og:description" content="엘프커뮤니티 – 핫이슈, 트렌드와 토론. 엘프에 대한 모든 대화, 소통, 문의, 의견을 올려주세요.">
<meta property="og:image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io/debate.lf?menu=debate&mode=list">
<meta name="apple-mobile-web-app-title" content="엘프 코리아">
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

</script>

</head>
<body>

	<jsp:include page="./m_top.jsp"></jsp:include>
    
   <div class="page-up" id="up_btn" style="display: none;">
        <img src="m-img/page-up.png" alt="" onclick="javascript:topBtn()" />
    </div>
    
    <div class="notice-wrap debate-wrap">
    
        <div class="notice">
        <%if(listBest.size()>0) { %>
        	<div class="notice-top-wrap">
        	
        		<p class="title">베스트 토론</p>
        
        		<!-- Swiper -->
				<div class="swiper-container">
					<div class="swiper-wrapper">
					<%
					for(int i=0; i<listBest.size(); i++) {
						DebateInfoModel bestDI = listBest.get(i);
                    	
                    	int likeWidth = 50, dislikeWidth = 50;
                    	if(bestDI.getLikeCnt()+bestDI.getDislikeCnt() > 0) {                            		
                    		likeWidth = (int)(((float)bestDI.getLikeCnt() / (bestDI.getLikeCnt()+bestDI.getDislikeCnt())) * 100);
                    		dislikeWidth = 100 - likeWidth;
                    	}
					%>
						<div class="swiper-slide">
								<div class="notice-top debate-top">
				                    <p class="notice-title"><%=bestDI.getDiTitle() %></p>
				                    <div class="debate-like-wrap">
				                        <div class="debete-like">
				                            
				                            <div class="debete-like-top">
				                                <div class="debete-like-top-up">
				                                    <img src="m-img/sns-up.png" alt="" width="28" />
				                                    <span>찬성</span>
				                                </div>
				                                <div class="debete-like-top-down">
				                                    <span>반대</span>
				                                    <img src="m-img/sns-down.png" alt="" width="28" />
				                                </div>
				                            </div>
				                            
				                            <div class="debete-like-bottom">
                                            <div class="debete-graph">
                                            	<div class="graph-left" style="width: <%=likeWidth%>%;"><span><%=nf.format(bestDI.getLikeCnt()) %>명</span></div>
                                            	<div class="graph-right" style="width: <%=dislikeWidth%>%;"><span><%=nf.format(bestDI.getDislikeCnt()) %>명</span></div>
                                            </div>
                                        </div>
				                            
				                            <div class="debete-like-info">
				                                <span><%=bestDI.getDiDate().substring(0, 4) %>.<%=bestDI.getDiDate().substring(5, 7) %>.<%=bestDI.getDiDate().substring(8, 10) %></span>
				                                <span><img src="m-img/debate-re.png" alt="" /><%=nf.format(bestDI.getReplyCnt()) %>건</span>
				                            </div>
				                            
				                        </div>				                        
				                    </div>
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
				
			</div>
		<%} %>
            
            <div class="notice-bottom-wrap">
                <p class="title">토론방</p>
                <div class="aelf-list-wrap">
                    <ul class="aelf-list">
                    <%for(int i=0; i<listDI.size(); i++){
						DebateInfoModel list = listDI.get(i);
                    	
                    	String dateStr[] = list.getDiDate().split(" ");
                    %>
                    	<li onclick="javascript:location.href='debate.lf?menu=debate&mode=view&di_no=<%=list.getDiNo() %>'"><%=list.getDiTitle() %>
                    		<span class="bottom-info"><%=dateStr[0].substring(2, 4) %>.<%=dateStr[0].substring(5, 7) %>.<%=dateStr[0].substring(8, 10) %></span>
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