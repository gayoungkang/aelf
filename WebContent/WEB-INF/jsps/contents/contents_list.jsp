<%@page import="util.CryptoSlate"%>
<%@page import="model.ContentInfoModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<ContentInfoModel> listCI = (List<ContentInfoModel>) request.getAttribute("listCI");
	String gubun = (String) request.getAttribute("gubun");
	String pageNavigator  = (String)request.getAttribute("pageNavigator"); 
	
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
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, width=1920-width">
<link rel="shortcut icon" type="image/x-icon" href="fabicon.ico" />
 
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
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css"
><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->

<style type="text/css">
.opacity_bg_layer {display:none; position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50); z-index:100000;}
.layer_pop_center {position:absolute; background:#FFF; padding:5px; z-index:100001; overflow: hidden; overflow-y: auto;}
.div_modal img {max-width: 100% !important; height: auto;}
</style>

<script type="text/javascript">

///////////////////////////////////////////
//불투명 배경 레이어 뛰우기 
function opacity_bg_layer() {
	if(!$('.opacity_bg_layer').length) {
		$('<div class="opacity_bg_layer"></div>').appendTo($('body'));
	}

	var oj = $(".opacity_bg_layer");

	// 화면의 가로, 세로 알아내기
	var w = $(document).width();
	var h = $(document).height();

	oj.css({'width':w,'height':h}); // 불투명 배경 레이어 크기 설정
	oj.fadeIn(500); // 불투명 배경 레이어 보이기 속도
}

//////////////////////////////////////////
//레이어 생성
//-cls : class
//-cont : 내용
function layer_pop_crt(cls, cont) {
	if(!cls) 
		return false;
	
	if(!$(cls).length) {
		$('<div class="' + cls + '">' + cont + '</div>').appendTo($('body'));
	}
	return true;
}

//////////////////////////////////////////
//레이어 띄우기
//-oj : 레이어 객체
function layer_pop_center() {
	var oj = $('.layer_pop_center');
	if(!oj.length) 
		return false;
	oj.layer_pop_center_set();
} 

//////////////////////////////////////////
//레이어 팝업 위치 설정 
$.fn.layer_pop_center_set = function () {
	//console.log($(this).outerWidth());	
 this.css("top", $(window).scrollTop()+50);    
	this.css("left", ($(window).width() - $(this).outerWidth())/2);
	this.css("height", $(window).height() - 100);
	if($('#pdf_iframe').length)
		$('#pdf_iframe').css("height", $(window).height() - 105);
 return this;
} 

//////////////////////////////////////////
//레이어 닫기 후 삭제
//-oj : 레이어 객체
function layer_pop_close() {
	var oj = $('.layer_pop_center');
	if(oj.length) {
		oj.fadeOut(500, function() {
			if($('#pdf_iframe').length)
				$('#pdf_iframe').attr('src', '_blank');		/// PDF 로딩 중 스크립트 에러 방지
			oj.remove();
		});
	}
	// 불투명 배경 레이어 삭제
	var oj_bg = $('.opacity_bg_layer');
	if(oj_bg.length) {
		oj_bg.fadeOut(500, function() {
			oj_bg.remove();
		});
	}
}

//////////////////////////////////////////
//화면을 불러온 후 처리  
$(document).ready(function() {
	$(document).on('click', '.opacity_bg_layer', function() { // 불투명 배경 레이어를 클릭하면 닫기
		layer_pop_close();	    
		$('body').css('overflow', '');		// body 스크롤 막기 해제
	});
}); 

//////////////////////////////////////////
//브라우저 창 크기 변경에 따른 처리
$(window).resize(function() {
	var oj = $('.layer_pop_center');
	if(oj.length) layer_pop_center(oj); // 레이어 팝업이 실행된 상태에서만 진행
	if($('.opacity_bg_layer').length) opacity_bg_layer(); // 불투명 배경 레이어가 실행된 상태에서만 진행
});


function goModal(ciNo) {
	
	var param = "ci_no="+ciNo;
	$.ajax({
		type: "POST",
		url: 'contents.lf',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			
			var obj = JSON.parse(ret);
			
			$('body').css('overflow', 'hidden');	// body 스크롤 막지
			
			if(!$('.opacity_bg_layer').length) 
				opacity_bg_layer(); // 불투명 배경 레이어 띄우기
				
			var str_html = 
				"<div class='div_modal' style='width: 900px; padding: 20px;'>" +
					"<div style=' width: 100%;'><p style='font-size: 16px; font-weight: 500; border-bottom: 1px solid #e0e0e0; padding-bottom: 20px; line-height: 25px; width: 100%; word-wrap: break-word;'>"+obj.ciTitle+"</p></div>" +
					"<div style=' width: 100%; padding-top: 20px; padding-bottom: 20px; border-bottom: 1px solid #e0e0e0;'>" +
						"<p style='width: 80px; height: 13px; text-align: center; font-size: 13px; font-weight: 400; border-right: 1px solid #e0e0e0; vertical-align: middle; display: table-cell;'>날짜</p>" + 
						"<p style='width: 100px; height: 13px; text-align: center; font-size: 13px; font-weight: 300; vertical-align: middle; display: table-cell;'>"+obj.ciDate+"</p>" +
						"<p style='width: 80px; height: 13px; text-align: center; font-size: 13px; font-weight: 400; border-right: 1px solid #e0e0e0; vertical-align: middle; display: table-cell;'>조회수</p>" +
						"<p style='width: 100px; height: 13px; text-align: left; font-size: 13px; font-weight: 300; vertical-align: middle; display: table-cell; padding-left: 20px;'>"+obj.ciView+"명</p>" +
					"</div>"+
					"<div style='width: 100%; padding-top: 10px;' class='model_in_div'>"+obj.ciContent+"</div>"+
				"</div>";

			if(layer_pop_crt('layer_pop_center', str_html)) {
				layer_pop_center();
				var oj = $('.layer_pop_center');
				oj.fadeIn(500);
			} else {
				if($('.opacity_bg_layer').length) 
					$('.opacity_bg_layer').remove();
			}
			
		}
	});
}

function goModal2(ciNo) {
	
	var param = "ci_no="+ciNo+"&video_check=1";
	$.ajax({
		type: "POST",
		url: 'contents.lf',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			
			var obj = JSON.parse(ret);
			
			$('body').css('overflow', 'hidden');	// body 스크롤 막지
			
			if(!$('.opacity_bg_layer').length) 
				opacity_bg_layer(); // 불투명 배경 레이어 띄우기
				
			var str_html = 
				"<div class='div_modal' style='width: 900px; padding: 20px;'>" +
					"<div style=' width: 100%;'><p style='font-size: 16px; font-weight: 500; border-bottom: 1px solid #e0e0e0; padding-bottom: 20px; line-height: 25px; width: 100%; word-wrap: break-word;'>"+obj.ciTitle+"</p></div>" +
					"<div style=' width: 100%; padding-top: 20px; padding-bottom: 20px; border-bottom: 1px solid #e0e0e0;'>" +
						"<p style='width: 80px; height: 13px; text-align: center; font-size: 13px; font-weight: 400; border-right: 1px solid #e0e0e0; vertical-align: middle; display: table-cell;'>날짜</p>" + 
						"<p style='width: 100px; height: 13px; text-align: center; font-size: 13px; font-weight: 300; vertical-align: middle; display: table-cell;'>"+obj.ciDate+"</p>" +
						"<p style='width: 80px; height: 13px; text-align: center; font-size: 13px; font-weight: 400; border-right: 1px solid #e0e0e0; vertical-align: middle; display: table-cell;'>조회수</p>" +
						"<p style='width: 100px; height: 13px; text-align: left; font-size: 13px; font-weight: 300; vertical-align: middle; display: table-cell; padding-left: 20px;'>"+obj.ciView+"명</p>" +
						"<p style='width: 80px; height: 13px; text-align: center; font-size: 13px; font-weight: 400; border-right: 1px solid #e0e0e0; vertical-align: middle; display: table-cell;'>링크</p>" +
						"<p style='width: 100px; height: 13px; text-align: left; font-size: 13px; font-weight: 300; vertical-align: middle; display: table-cell; padding-left: 20px;'><a href=\""+obj.ciLink+"\" target='_blank'>바로가기</a></p>" +
					"</div>"+
					"<div style='width: 100%; padding-top: 10px;'>"+
						"<iframe type=\"text/html\" width='900' height='600' src=\""+obj.ciVideo+"\"></iframe>"+
					"</div>"+
					"<div style='width: 100%; padding-top: 10px;' class='model_in_div'>"+obj.ciContent+"</div>"+
				"</div>";

			if(layer_pop_crt('layer_pop_center', str_html)) {
				layer_pop_center();
				var oj = $('.layer_pop_center');
				oj.fadeIn(500);
			} else {
				if($('.opacity_bg_layer').length) 
					$('.opacity_bg_layer').remove();
			}
			
		}
	});
}

function goDetail(ciNo){
	location.href="contents.lf?menu=contents&mode=view&ci_no="+ciNo;
}

function ajaxFailed(xmlRequest)	{
	alert(xmlRequest.status+"\n\r"+xmlRequest.statusText+"\n\r"+xmlRequest.responseText);
}

</script>

</head>
<body style="padding-bottom: 140px;">

	<jsp:include page="../main_top.jsp"></jsp:include>
	<div class="tab_wrap">
		 <ul>
	   		<li><a href="contents.lf?menu=contents&mode=list&gubun=info" <%if("info".equals(gubun)){ %> class="on" <%} %>>INFO</a></li>
	   		<li><a href="contents.lf?menu=contents&mode=list&gubun=video" <%if("video".equals(gubun)){ %> class="on" <%} %>>VIDEO</a></li>
			<li><a href="contents.lf?menu=contents&mode=list&gubun=article" <%if("article".equals(gubun)){ %> class="on" <%} %>>ARTICLE</a></li>
	   	</ul>	
	</div>
      <div class="content-wrap">
        <div class="content" style="width: 1122px;">         
			<%for(int i=0; i<listCI.size(); i++){
				ContentInfoModel list = listCI.get(i);
				
				String divMargin = "";
				if((i+1)%4==0)
					divMargin = " style='margin-right: 0px;' ";
				
				if("video".equals(list.getCcName())){
					
				%>
					<div class="content-box content-box-1" <%=divMargin %>>
		                <table class="content-bn-wrap">
		                    <tr height="160">
		                        <td width="261" class="content-img">
		                            <img src="upload/content/<%=list.getCiNo() %>/<%=list.getCiThumbnail() %>" alt="" style="width: 261px; height: 160px;" />
		                            <span class="notice-active"><img src="img/content-non-3.png" alt="content" /></span>
		                            <table cellpadding="0" cellspacing="0">
		                                <tr class="notice-fig-wrap">
		                                    <td>
		                                        <figcaption class="notice-fig content-fig" onclick="javascript:goModal2(<%=list.getCiNo()%>)">
		                                            <figure>
		                                                <img src="img/content-on-3.png" alt="" class="notice-fig-1" />
		                                                <img src="img/notice-plus.png" alt="" class="notice-fig-2" />
		                                            </figure>
		                                        </figcaption>
		                                    </td>
		                                </tr>
		                            </table>
		                        </td>
		                    </tr>
		                    <tr height="80">
		                        <td width="261" style="font-size:14px; padding-bottom: 17px; padding-top: 17px;"><p class="two_tit_p w261 h44"><%=list.getCiTitle() %></p></td>
		                    </tr>
		                    <tr height="25">
		                        <td width="261" style="font-size:12px; letter-spacing: -0.9px;"><p class="txt_h73"><%=CryptoSlate.getRemoveHtmlText(list.getCiContent()) %></p></td>
		                    </tr>
		                </table>
		            </div>
	            <%}else{
	            	String noticeActive = "img/content-non-5.png";
                	String noticeActiveOn = "img/content-on-5.png";
                	
                	if("info".equals(list.getCcName())){
                		noticeActive = "img/content-non-4.png";
                    	noticeActiveOn = "img/content-on-4.png";
                	}
	            	%>
	            	<div class="content-box content-box-1" <%=divMargin %>>
		                <table class="content-bn-wrap">
		                    <tr height="160">
		                        <td width="261" class="content-img">
		                            <img src="upload/content/<%=list.getCiNo() %>/<%=list.getCiThumbnail() %>" alt="" style="width: 261px; height: 160px;" />
		                            <span class="notice-active"><img src="<%=noticeActive %>" alt="content"  /></span>
		                            <table cellpadding="0" cellspacing="0">
		                                <tr class="notice-fig-wrap">
		                                    <td>
		                                        <figcaption class="notice-fig content-fig" onclick="javascript: goModal(<%=list.getCiNo()%>)">
		                                            <figure>
		                                                <img src="<%=noticeActiveOn %>" alt="" class="notice-fig-1" />
		                                                <img src="img/notice-plus.png" alt="" class="notice-fig-2" />
		                                            </figure>
		                                        </figcaption>
		                                    </td>
		                                </tr>
		                            </table>
		                        </td>
		                    </tr>
		                    <tr height="80">
		                        <td width="261" style="font-size:14px;"><p class="two_tit_p w261 h44"><%=list.getCiTitle() %></p></td>
		                    </tr>
		                    <tr height="25">
		                        <td width="261" style="font-size:12px; letter-spacing: -0.9px;"><p class="txt_h73"><%=CryptoSlate.getRemoveHtmlText(list.getCiContent()) %></p></td>
		                    </tr>
		                </table>
		            </div>
				<%}
			}%>  
            

            <%= pageNavigator %>
            <!-- 
            <div class="content-cross">
                <img src="img/notice-plus.png" alt="컨텐츠 더보기" />
            </div>
             -->
        </div>
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>
    
</body>
</html>