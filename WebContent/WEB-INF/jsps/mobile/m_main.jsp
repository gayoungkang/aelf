<%@page import="util.CryptoSlate"%>
<%@page import="util.DateConvert"%>
<%@page import="model.NewsInfoModel"%>
<%@page import="model.ContentInfoModel"%>
<%@page import="model.NoticeInfoModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<NoticeInfoModel> listNI = (List<NoticeInfoModel>) request.getAttribute("listNI");
	List<ContentInfoModel> listCI = (List<ContentInfoModel>) request.getAttribute("listCI");
	List<NewsInfoModel> listNews = (List<NewsInfoModel>) request.getAttribute("listNews");
	
	int newsSize = listNews.size();
	if(newsSize == 0)
		newsSize = 1;
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AELF</title>
<meta name="description" content="AELF">
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


////////////////////////////////////////////////////////////////////////////
/// 뉴스 슬라이드
var newsCurIdx = 1;
var newMaxIdx = <%=newsSize%>;
var newsWidth = $(window).width();

function goNewsLeft() {
	console.log('left');
	console.log(newsWidth);
	if(newsCurIdx == 1) {
		$("#news_slide").stop().animate({"margin-left":"+=80px"},100).animate({"margin-left":"0px"},300, 'easeOutBounce');	
	}
	else {
		var divWidth = 1108;	
		$("#news_slide").animate({"margin-left":"+=" + newsWidth + "px"},300);
		
		newsCurIdx--;
	}
}

function goNewsRight() {
	console.log('right');
	if(newsCurIdx == newMaxIdx) {
		var maxWidth = (newsWidth)*(newsCurIdx-1);
		$("#news_slide").stop().animate({"margin-left":"-=80px"},100).animate({"margin-left":"-"+maxWidth+"px"},300, 'easeOutBounce');
	}
	else {
		var divWidth = 1108;
		$("#news_slide").animate({"margin-left":"-=" + newsWidth + "px"},300);
		
		newsCurIdx++;
	}
}
////////////////////////////////////////////////////////////////////////////////

</script>

</head>
<body>

	<jsp:include page="./m_top.jsp"></jsp:include>
    
    <div class="main-move-down">
        <img src="m-img/main-move.png" alt="" />
    </div>
    <div class="main-move-up" id="up_btn" style="display: none;">
        <img src="m-img/main-move-box.png" alt="" onclick="javascript:topBtn()" />
    </div>
    
    <div class="main-wrap">
    
        <div class="main">
            <div class="main-bn">
            	<div class="video_wrap">
	            	<video  id="main_video" preload="metadata" autoplay loop muted playsinline>
	  					<source src="m-img/video/m-aelf01.mp4" type="video/mp4">
	            	</video>            	
            	</div> 
                <div class="aelf-main-title-wrap">
                    <p>aelf, 진화이자 혁신</p>
                    <span class="aelf-main-title-sub">여러 블록이 모여 위대한 건출물을 형성하고<br>집단과 사회를 형성 하듯이,</span>
                    <span class="after-line">Aelf Evolving</span>
                    <span>Self Evolving</span>
                </div>
                <div class="main-bn-icon-wrap">
                    <div class="main-bn-icon">
                        <span><a href=""><img src="m-img/main-bn-one.png" alt="" />One pager</a></span>
                        <span><a href=""><img src="m-img/main-bn-white.png" alt="" />White Paper</a></span>
                        <span><a href=""><img src="m-img/main-bn-road.png" alt="" />Road Map</a></span>
                        <span><a href=""><img src="m-img/main-bn-brand.png" alt="" />Brand Film</a></span>
                    </div>
                </div>
            </div><!-- main-bn -->
            <div class="main-notice-wrap">
                <div class="main-title-wrap">
                    <p class="main-title">Notice</p>
                </div>
                <div class="main-notice">
                <%
                for(int i=0; i<listNI.size(); i++) {
                	NoticeInfoModel list = listNI.get(i);
            		
            		String dateStr[] = list.getNiDate().split(" ");
            	%>
            		<table cellpadding="0" cellspacing="0" onclick="javascript:location.href='notice.lf?menu=notice&mode=view&ni_no=<%=list.getNiNo()%>'">
                        <tr>
                            <td><img src="upload/notice/<%=list.getNiNo() %>/<%=list.getNiThumbnail() %>" alt="" class="contents-img" width="100%" height="130" /></td>
                        </tr>
                        <tr>
                            <td style="font-size:13px;"><p class="two-lines"><%=list.getNiTitle() %></p></td>
                        </tr>
                        <tr height="5"></tr>
                        <tr>
                            <td><%=list.getNiAuthor() %>｜<%=DateConvert.month(dateStr[0]) %><%=dateStr[0].substring(8, 10) %>.<%=dateStr[0].substring(0, 4) %></td>
                        </tr>
                    </table>
            	<%
                }
                %>                   
                     <div class="aelf-btn-wrap">
                    	<button class="aelf-btn" onclick="javascript:location.href='notice.lf?menu=notice&mode=list'">VIEW ALL NOTICE</button>
                     </div>
                </div>
            </div><!-- main-notice-wrap -->
            <div class="main-news-wrap">
                <div class="main-title-wrap">
                    <p class="main-title">NEWS</p>
                </div>

                <div class="main-news" id="news_slide"><!-- 무브 -->
                	
                	
              	<%for(int i=0; i< listNews.size(); i++){
           			NewsInfoModel list = listNews.get(i);
           			
           			String dateStr[] = list.getNewsDate().split(" ");
           			%>
                <div class="main-news-left">
	                <div class="main-news-img-wrap">
	                    <img src="upload/news/<%=list.getNewsNo() %>/<%=list.getNewsThumbnail() %>" alt="" />
	                </div>
	                
	                <div class="main-news-contents-wrap" onclick="javascript: location.href='news.lf?menu=news&mode=view&news_no=<%=list.getNewsNo() %>'"><!-- 온클릭 -->
	                 <div class="news-top">
	                     <p class="news-title two-lines" style="padding-bottom: 30px;"><%=list.getNewsTitle() %></p>
	                     <p class="news-tx three-lines"><%=CryptoSlate.getRemoveHtmlText(list.getNewsContent()) %></p>
	                 </div>
	                </div>
	                 <div class="news-bottom">
	                     <span><%=list.getNewsAuthor() %>｜<%=DateConvert.month(dateStr[0]) %><%=dateStr[0].substring(8, 10) %>.<%=dateStr[0].substring(0, 4) %></span>
	                 </div>
                </div>
                <%} %>
	                
              </div><!-- main-news -->
              <div class="aelf-btn-wrap">
               	<button class="aelf-btn" onclick="javascript:location.href='news.lf?menu=news&mode=list'">VIEW ALL NEWS</button>
              </div>
              <div class="main-news-move">
                   <img src="m-img/main-news-move.png" alt="" onclick="javascript:goNewsLeft()" />
                   <img src="m-img/main-news-move.png" alt="" onclick="javascript:goNewsRight()" />
              </div>
           </div><!-- main-news-wrap -->
       </div><!-- main -->
            
       <div class="main-notice-wrap">
			<div class="main-title-wrap">
			    <p class="main-title">CONTENTS</p>
			</div>
			<div class="main-notice">
                    
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
                <div class="aelf-btn-wrap">
                	<button class="aelf-btn" onclick="javascript:location.href='contents.lf?menu=contents&mode=list'">VIEW ALL CONTENTS</button>
                </div>
                
            </div>
        </div><!-- main-notice-wrap -->
            
        <div class="main-about-wrap">
            <div class="main-title-wrap">
                <p class="main-title">ABOUT</p>
            </div>
            <div class="main-about-contents main-about-1">
                <img src="m-img/main-about-1.png" alt="" />
                <p>자율화와 전문화</p>
                <span>개별적인 사이드체인, 그들을 연결하는 메인체인, 즉 멀티체인 시스템을<br>이용하여 한 스마트 컨트렉트의  네트워크 포화가 다른 스마트 컨트렉트의<br>처리를  방해할수 없도록 한 체인의 병렬화</span>
            </div>
            <div class="main-about-contents main-about-2">
                <img src="m-img/main-about-2.png" alt="" />
                <p>확장성과 컴퓨팅 파워</p>
                <span>각각의 노드가 하나의 컴퓨터가 아닌 컴퓨터의 집합 (클라우드)으로써<br>컴퓨팅 파워의 극대화</span>
            </div>
            <div class="main-about-contents main-about-3">
                <img src="m-img/main-about-3.png" alt="" />
                <p>유연성과 개발의 편의성</p>
                <span>리눅스와 같이 블럭체인 개발을 가볍고 커스터마이징이 가능하도록 함<br>사이드체인 템플렛을 제공하여 보다 쉽고 빠르게 블럭체인 개발 가능</span>
            </div>
            <div class="main-about">
                
            </div>
    	</div><!-- main=about-wrap -->
    </div><!-- main-wrap -->
    
    <jsp:include page="./m_footer.jsp"></jsp:include>
    
</body>
</html>