<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
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
	
	int noticeSize = listNI.size();
	if(listNI.size()<=4)
		noticeSize = 1;
	
	int contentSize = listCI.size();
	if(listCI.size() <= 4)
		contentSize = 1;
	
	int newsSize = listNews.size();
	if(newsSize == 0)
		newsSize = 1;
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AELF</title>
<meta property="og:title" content="AELF">
<meta property="og:image" content="img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io">
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, width=1920-width">
<link rel="shortcut icon" type="image/x-icon" href="fabicon.ico" />
<meta name="description" content="AELF">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="js/jquery-ui.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css">
<!-- 스타일시트 -->
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<!-- 노토산스 웹폰트 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-mousewheel/3.1.13/jquery.mousewheel.js"></script>

<style type="text/css">
.opacity_bg_layer {
	display: none;
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: #000;
	opacity: .5;
	filter: alpha(opacity = 50);
	z-index: 100000;
}

.layer_pop_center {
	position: absolute;
	background: #FFF;
	padding: 5px;
	z-index: 100001;
	overflow: hidden;
	overflow-y: auto;
}

.div_modal img {
	max-width: 100%;
	height: auto;
}
</style>

<script type="text/javascript">


///////////////////////////////////////////
// 불투명 배경 레이어 뛰우기 
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
// 레이어 생성
// -cls : class
// -cont : 내용
function layer_pop_crt(cls, cont) {
	if(!cls) 
		return false;
	
	if(!$(cls).length) {
		$('<div class="' + cls + '">' + cont + '</div>').appendTo($('body'));
	}
	return true;
}

//////////////////////////////////////////
// 레이어 띄우기
// -oj : 레이어 객체
function layer_pop_center() {
	var oj = $('.layer_pop_center');
	if(!oj.length) 
		return false;
	oj.layer_pop_center_set();
} 

//////////////////////////////////////////
// 레이어 팝업 위치 설정 
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
// 레이어 닫기 후 삭제
// -oj : 레이어 객체
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
// 화면을 불러온 후 처리  
$(document).ready(function() {
	$(document).on('click', '.opacity_bg_layer', function() { // 불투명 배경 레이어를 클릭하면 닫기
		layer_pop_close();	    
		$('body').css('overflow', '');		// body 스크롤 막기 해제
	});
}); 
 
//////////////////////////////////////////
// 브라우저 창 크기 변경에 따른 처리
$(window).resize(function() {
	var oj = $('.layer_pop_center');
	if(oj.length) layer_pop_center(oj); // 레이어 팝업이 실행된 상태에서만 진행
	if($('.opacity_bg_layer').length) opacity_bg_layer(); // 불투명 배경 레이어가 실행된 상태에서만 진행
});


function goModal(img) {	
	$('body').css('overflow', 'hidden');	// body 스크롤 막지
	
	if(!$('.opacity_bg_layer').length) 
		opacity_bg_layer(); // 불투명 배경 레이어 띄우기
		
	var str_html = 
		"<div style='width: 800px;'>" +
			"<img src='img/"+img+"' width='100%;' />" +
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


function goModalPDF(pdf) {	
	$('body').css('overflow', 'hidden');	// body 스크롤 막지
	
	var dpWidth = $(window).width()-100;
	if($(window).width()>1200)
		dpWidth = 1000;
	
	var dpHeight = $(window).height()-105;
	
	if(!$('.opacity_bg_layer').length) 
		opacity_bg_layer(); // 불투명 배경 레이어 띄우기
		
	var str_html = 
		"<div style='width: "+dpWidth+"px;'>" +
			"<iframe id='pdf_iframe' src='pdfjs/web/viewer.html?file=../../pdf/"+pdf+"' frameborder='0' style='width: 100%; height: "+dpHeight+"px;'></iframe>" +
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


function goModalContent(ciNo) {
	
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

function goModalContent2(ciNo) {
	
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
						"<p style='width: 150px; height: 13px; text-align: left; font-size: 13px; font-weight: 300; vertical-align: middle; display: table-cell; padding-left: 20px;'>"+obj.ciView+"명</p>" +
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

function goBrandFilm() {
	
	$('body').css('overflow', 'hidden');	// body 스크롤 막지
	
	if(!$('.opacity_bg_layer').length) 
		opacity_bg_layer(); // 불투명 배경 레이어 띄우기
		
	var str_html = 
		"<div class='div_modal' style='width: 900px; height:300px; padding: 20px;'>" +
			"<div style='width: 100%; padding-top: 10px;'>"+
				"<iframe type=\"text/html\" width='900' height='600' src=\"http://www.youtube.com/embed/ethufsujrUQ\"></iframe>"+
			"</div>"+
		"</div>";

	if(layer_pop_crt('layer_pop_center', str_html)) {
		var oj = $('.layer_pop_center');
		oj.css("top", $(window).scrollTop()+160);    
		oj.css("left", ($(window).width() - $(oj).outerWidth())/2);
		oj.css("height", $(window).height() - 310);
		oj.fadeIn(500);
	} else {
		if($('.opacity_bg_layer').length) 
			$('.opacity_bg_layer').remove();
	}
	
}

function ajaxFailed(xmlRequest)	{
	alert(xmlRequest.status+"\n\r"+xmlRequest.statusText+"\n\r"+xmlRequest.responseText);
}

////////////////////////////////////////////////////////////////////////////
/// 공지사항 슬라이드
var noticeCurIdx = 1;
var noticeMaxIdx = <%=noticeSize%>;	// 최대 우측 슬라이드시 보여줄 첫번째 인덱스 (리스트 -3)

function goNoticeLeft() {
	//console.log('left : ' + $('#test').css("margin-left"));
	if(noticeCurIdx == 1) {
		$("#notice_slide").stop().animate({"margin-left":"+=80px"},100).animate({"margin-left":"0px"},300, 'easeOutBounce');	
	}
	else {
		var divWidth = 262+19;	
		$("#notice_slide").animate({"margin-left":"+=" + divWidth + "px"},300);
		
		noticeCurIdx--;
	}
}

function goNoticeRight() {
	//console.log('right : ' + $('#test').css("margin-left"));	
	if(noticeCurIdx == noticeMaxIdx) {
		var maxWidth = (262+19)*(noticeMaxIdx-1);
		$("#notice_slide").stop().animate({"margin-left":"-=80px"},100).animate({"margin-left":"-"+maxWidth+"px"},300, 'easeOutBounce');
	}
	else {
		var divWidth = 262+19;
		$("#notice_slide").animate({"margin-left":"-=" + divWidth + "px"},300);
		
		noticeCurIdx++;
	}
}
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////
/// 뉴스 슬라이드
var newsCurIdx = 1;
var newMaxIdx = <%=newsSize%>;

function goNewsLeft() {
	if(newsCurIdx == 1) {
		$("#news_slide").stop().animate({"margin-left":"+=80px"},100).animate({"margin-left":"0px"},300, 'easeOutBounce');	
	}
	else {
		var divWidth = 1108;	
		$("#news_slide").animate({"margin-left":"+=" + divWidth + "px"},300);
		
		newsCurIdx--;
	}
}

function goNewsRight() {
	if(newsCurIdx == newMaxIdx) {
		var maxWidth = (1108)*(newsCurIdx-1);
		$("#news_slide").stop().animate({"margin-left":"-=80px"},100).animate({"margin-left":"-"+maxWidth+"px"},300, 'easeOutBounce');
	}
	else {
		var divWidth = 1108;
		$("#news_slide").animate({"margin-left":"-=" + divWidth + "px"},300);
		
		newsCurIdx++;
	}
}
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////
/// 컨텐츠 슬라이드
var contentCurIdx = 1;
var contentMaxIdx = <%=contentSize%>;	// 최대 우측 슬라이드시 보여줄 첫번째 인덱스

function goContentLeft() {
	if(contentCurIdx == 1) {
		$("#content_slide").stop().animate({"margin-left":"+=80px"},100).animate({"margin-left":"0px"},300, 'easeOutBounce');	
	}
	else {
		var divWidth = 262+19;	
		$("#content_slide").animate({"margin-left":"+=" + divWidth + "px"},300);
		
		contentCurIdx--;
	}
}

function goContentRight() {
	if(contentCurIdx == contentMaxIdx) {
		var maxWidth = (262+19)*(contentMaxIdx-1);
		$("#content_slide").stop().animate({"margin-left":"-=80px"},100).animate({"margin-left":"-"+maxWidth+"px"},300, 'easeOutBounce');
	}
	else {
		var divWidth = 262+19;
		$("#content_slide").animate({"margin-left":"-=" + divWidth + "px"},300);
		
		contentCurIdx++;
	}
}

////////////////////////////////////////////////////////////////////////////////

/*06-27 추가 작업*/

$(document).ready(function(){
	$('.section').css('height', $(window).height());
	
	$(window).resize(function() {
		$('.section').css('height', $(window).height());
	});
});

/*웹 스크롤 이벤트*/
var idx = 1;

$(function(){

	var moving=false;
	
	$(".main-wrap").mousewheel(function(e, delta){
		if(!moving){
			if(delta > 0){
				 console.log("up");
				if(idx > 1){
					idx = idx -1;
				}			
			}else{
				 console.log("down");			
				if(idx < 6){
					idx = idx+1;
				}
			}
			
			moving = true;
			if(moving == true){
				
				$("html, body").stop().animate({scrollTop:($('#contain_'+idx).offset().top)}, 800, function(){
					moving=false;
					scrollActive();
				});
			}
		}
	});	
	$(window).resize(function(){
		var h=$(this).height();
		$(".section").css({height:h+"px"});
	});	

	$(window).trigger("resize");
});

	function topBtn(){
		   $("html, body").stop().animate({scrollTop:0}, 500, 'swing', function(){
			      
		   });
		}
	$(window).scroll(function(event){
	     var scroll = $(window).scrollTop();
	    if (scroll >= 50) {
	        $(".top_btn").addClass("show");
	    } else {
	        $(".top_btn").removeClass("show");
	    }
	});

</script>

</head>
<body class="mainbody">

	<jsp:include page="./main_top.jsp"></jsp:include>

	<div class="main-wrap">
		<div class="main">
			<div class="main-bn-wrap section" id="contain_1">
				<div class="video_wrap">
					<video id="main_video" preload="metadata" autoplay muted
						playsinline>
						<source src="./img/video/Comp1_3.mp4" type="video/mp4">
					</video>
				</div>
				<div class="main_centertxt">
					<span class="bsize_txt">aelf, 진화이자 혁신</span><br />
					<br /> <span class="ssize_txt">여러 블록이 모여 위대한 건축물을 형성하고<br />
						집단과 사회를 형성 하듯이,
					</span> <br /> <br /> <span class="msize_txt first">Aelf Evolving</span><br />
					<span class="msize_txt last">Self Evolving</span>
				</div>
				<div class="main-btn-wrap">
					<div class="main-btn">
						<ul>
							<!-- https://www.youtube.com/watch?v=ethufsujrUQ -->
							<li><a href="#"><img id="img1" src="img/ico_pager.png"
									alt="one pager" /><span>One Pager</span></a></li>
							<li><a href="javascript:void()"
								onclick="javascript:goModalPDF('aelf_whitepaper_v1.2.pdf')"><img
									id="img2" src="img/ico_pager.png" alt="white paper" /><span>White
										Paper</span></a></li>
							<li><a href="#"><img id="img3" src="img/ico_road.png"
									alt="road map" /><span>Road Map</span></a></li>
							<li><a href="javascript:goBrandFilm()" target="_blank"><img
									id="img4" src="img/ico_film.png" alt="brand film" /><span>Brand
										Film</span></a></li>
						</ul>
					</div>
				</div>
				<div class="ico_scroll">
					<span class="txt">SCROLL</span>
					<div>
						<img src="img/ico_scroll.png" alt="scroll" />
					</div>
				</div>
				<div class="main-bn-navi">
					<ul>
						<li id="main_nav_1" class="main-bn-navi-target"><a
							href="javascript:void()"
							onclick="javascript:goPage('.main-bn-wrap')"><span
								class="txt">HOME</span><span class="gray_dot_wrap"><span
									class="ring"></span><span class="dot"></span></span></a></li>
						<li id="main_nav_2"><a href="javascript:void(0)"
							onclick="javascript:goPage('.main-notice-wrap')"><span
								class="txt">공지사항</span><span class="gray_dot_wrap"><span
									class="dot"></span></span></a></li>
						<li id="main_nav_3"><a href="javascript:void(0)"
							onclick="javascript:goPage('.main-news-wrap')"><span
								class="txt">뉴스</span><span class="gray_dot_wrap"><span
									class="dot"></span></span></a></li>
						<li id="main_nav_4"><a href="javascript:void(0)"
							onclick="javascript:goPage('.main-content-wrap')"><span
								class="txt">컨텐츠</span><span class="gray_dot_wrap"><span
									class="dot"></span></span></a></li>
						<li id="main_nav_5"><a href="javascript:void(0)"
							onclick="javascript:goPage('.main-team-wrap')"><span
								class="txt">TEAM</span><span class="gray_dot_wrap"><span
									class="dot"></span></span></a></li>
						<li id="main_nav_6"><a href="javascript:void(0)"
							onclick="javascript:goPage('.main-info-wrap')"><span
								class="txt">ABOUT</span><span class="gray_dot_wrap"><span
									class="dot"></span></span></a></li>
					</ul>
				</div>
			</div>


			<!-- 공지 -->
			<div class="main-notice-wrap section" id="contain_2">
				<p class="h2title">Notice</p>
				<div class="notice-content-nav">
					<div class="notice-left" onclick="javascript:goNoticeLeft()"></div>
					<div class="notice-right" onclick="javascript:goNoticeRight()"></div>
				</div>

				<div class="main-notice">
					<div class="notice-content-wrap" id="notice_slide">
						<%for(int i=0; i<listNI.size(); i++){
                    		NoticeInfoModel list = listNI.get(i);
                    		
                    		String dateStr[] = list.getNiDate().split(" ");
                    		
                    		
                    		%>
						<div class="notice-tb-wrap">
							<table cellpadding="0" cellspacing="0">
								<tr class="notice-wrap-img">
									<td>
										<div class="img_wrap"
											onclick="javascript: location.href='notice.lf?menu=notice&mode=view&ni_no=<%=list.getNiNo()%>'">
											<div class="img_box"
												style="background-image: url('upload/notice/<%=list.getNiNo() %>/<%=list.getNiThumbnail() %>')"></div>
											<%--수정라인 <img src="upload/notice/<%=list.getNiNo() %>/<%=list.getNiThumbnail() %>" alt="" /> --%>
										</div> <span class="notice-active"><img
											src="img/notice-non.png" alt="notice" /></span>
										<table cellpadding="0" cellspacing="0">
											<tr class="notice-fig-wrap">
												<td>
													<figcaption class="notice-fig"
														onclick="javascript:location.href='notice.lf?menu=notice&mode=view&ni_no=<%=list.getNiNo()%>'">
														<figure>
															<img src="img/notice-on.png" alt="" class="notice-fig-1" />
															<img src="img/notice-plus.png" alt=""
																class="notice-fig-2" />
														</figure>
													</figcaption>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr height="18"></tr>
								<tr>
									<td class="txt"><p><%=list.getNiTitle() %></p></td>
								</tr>
								<tr height="5"></tr>
								<!-- 		                            <tr>
		                                <td class="txt">＜엘프(AELF)＞</td>
		                            </tr> -->
								<tr height="20"></tr>
								<tr>
									<td class="notice-date txt"><%=list.getNiAuthor() %>｜<%=DateConvert.month(dateStr[0]) %><%=dateStr[0].substring(8, 10) %>.<%=dateStr[0].substring(0, 4) %></td>
								</tr>
							</table>
						</div>
						<%} %>

					</div>

				</div>
				<div class="notice-viwe">
					<input type="button" value="VIEW ALL NOTICE"
						onclick="javascript:location.href='notice.lf?menu=notice&mode=list'" />
				</div>
			</div>
			<!-- 공지 -->

			<!-- 뉴스 -->
			<div class="main-news-wrap section" id="contain_3">
				<p class="h2title">News</p>
				<div class="notice-content-nav">
					<div class="notice-left" onclick="javascript:goNewsLeft()"></div>
					<div class="notice-right" onclick="javascript:goNewsRight()"></div>
				</div>

				<div class="main-news">
					<div class="news-content-wrap" id="news_slide">
						<%for(int i=0; i<listNews.size(); i++){
	            			NewsInfoModel list = listNews.get(i);
	            			
	            			String dateStr[] = list.getNewsDate().split(" ");
	            			%>
						<div class="news-tb-wrap">
							<table cellpadding="0" cellspacing="0" style="cursor: pointer;"
								onclick="javascript: location.href='news.lf?menu=news&mode=view&news_no=<%=list.getNewsNo() %>'">
								<tr>
									<td colspan="2" class="td_news_tit" height="95"><span><%=list.getNewsTitle() %></span>
										<a class="bar"></a>
									<!--수정 --></td>
									<td width="37"></td>
									<td rowspan="3" style="position: relative;">
										<div class="img_wrap">
											<div class="img_box"
												style="background-image: url('upload/news/<%=list.getNewsNo() %>/<%=list.getNewsThumbnail() %>')"></div>
										</div> <%-- 			                               수정 라인 <img src="upload/news/<%=list.getNewsNo() %>/<%=list.getNewsThumbnail() %>" alt="" /> --%>
										<span class="news-icon"><img src="img/news-non.png"
											alt="" /></span>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="about_txt"><p><%=CryptoSlate.getRemoveHtmlText(list.getNewsContent()) %></p></td>
									<td></td>
								</tr>
								<tr class="news-btn-wrap" height="40">
									<td class="news-company"><%=list.getNewsAuthor() %>｜<%=DateConvert.month(dateStr[0]) %><%=dateStr[0].substring(8, 10) %>.<%=dateStr[0].substring(0, 4) %></td>
									<td></td>
									<td></td>
								</tr>
								<tr height="90"></tr>
							</table>
						</div>
						<%} %>
					</div>
					<!-- 						                            <tr>
	                            	<td class="news-company"></td>
	                                <td>
	                                    <div class="notice-viwe news-viwe">
	                                        <input type="button" value="VIEW ALL NEWS" onclick="javascript:location.href='news.lf?menu=news'" />
	                                    </div>
	                                </td>
	                                <td></td>	                            
	                            </tr>    -->
					<div class="notice-viwe news-viwe">
						<input type="button" value="VIEW ALL NEWS"
							onclick="javascript:location.href='news.lf?menu=news&mode=list'" />
					</div>
				</div>

			</div>
			<!-- 뉴스 -->

			<!-- 컨텐츠 -->
			<div class="main-content-wrap section" id="contain_4">
				<p class="h2title">Contents</p>
				<div class="notice-content-nav contents4">
					<div class="notice-left" onclick="javascript:goContentLeft()"></div>
					<div class="notice-right" onclick="javascript:goContentRight()"></div>
				</div>

				<div class="main-content">
					<div class="content-wrap" id="content_slide">

						<%for(int i=0; i<listCI.size(); i++){ 
                        	ContentInfoModel list = listCI.get(i);
                        	
                        	if("video".equals(list.getCcName())){
                        %>
						<div class="content-box content-box-1">
							<div class="num_wrap">
								<table cellpadding="0" cellspacing="0">
									<tr height="20">
										<td style="font-size: 14px; color: #fff;"><%=String.format("%02d", i+1) %></td>
									</tr>
									<tr height="66">
										<td width="261" style="border-left: 1px solid #535353;"></td>
									<tr>
								</table>
							</div>

							<table class="content-bn-wrap">
								<tr height="10"></tr>
								<tr height="160">
									<td width="261" class="content-img">
										<div class="img_wrap">
											<img
												src="upload/content/<%=list.getCiNo() %>/<%=list.getCiThumbnail() %>"
												alt="" />
										</div> <span class="notice-active"><img
											src="img/content-non-3.png" alt="content" /></span>
										<table cellpadding="0" cellspacing="0">
											<tr class="notice-fig-wrap">
												<td>
													<figcaption class="notice-fig content-fig"
														onclick="javascript: goModalContent2(<%=list.getCiNo()%>)">
														<figure>
															<img src="img/content-on-3.png" alt=""
																class="notice-fig-1" />
															<img src="img/notice-plus.png" alt=""
																class="notice-fig-2" />
														</figure>
													</figcaption>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr height="80">
									<td class="tit"><p><%=list.getCiTitle() %></p></td>
								</tr>
								<tr height="25">
									<td class="about_txt" width="261"><p><%=CryptoSlate.getRemoveHtmlText(list.getCiContent()) %></p></td>
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
						<div class="content-box content-box-1">
							<div class="num_wrap">
								<table cellpadding="0" cellspacing="0">
									<tr height="20">
										<td style="font-size: 14px; color: #fff;"><%=String.format("%02d", i+1) %></td>
									</tr>
									<tr height="66">
										<td width="261" style="border-left: 1px solid #535353;"></td>
									<tr>
								</table>
							</div>

							<table class="content-bn-wrap">
								<tr height="10"></tr>
								<tr height="160">
									<td width="261" class="content-img">
										<div class="img_wrap">
											<img
												src="upload/content/<%=list.getCiNo() %>/<%=list.getCiThumbnail() %>"
												alt="" />
										</div> <span class="notice-active"><img
											src="<%=noticeActive %>" alt="content" /></span>
										<table cellpadding="0" cellspacing="0">
											<tr class="notice-fig-wrap">
												<td>
													<figcaption class="notice-fig content-fig"
														onclick="javascript: goModalContent(<%=list.getCiNo()%>)">
														<figure>
															<img src="<%=noticeActiveOn %>" alt=""
																class="notice-fig-1" />
															<img src="img/notice-plus.png" alt=""
																class="notice-fig-2" />
														</figure>
													</figcaption>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr height="80">
									<td class="tit"><p><%=list.getCiTitle() %></p></td>
								</tr>
								<tr height="25">
									<td class="about_txt" width="261"><p><%=CryptoSlate.getRemoveHtmlText(list.getCiContent())%></p></td>
								</tr>
							</table>
						</div>
						<%}
                        }%>
						<!-- end -->
					</div>

				</div>
				<div class="notice-viwe content-btn">
					<input type="button" value="VIEW CONTENT"
						onclick="javascript:location.href='contents.lf?menu=contents&mode=list'" />
				</div>
			</div>
			<!-- 컨텐츠 -->
			<!-- TEAM -->
			<div class="main-team-wrap section" id="contain_5">
				<div class="content">
					<div class="main-title">
						<h1>Team</h1>
					</div>
					<ul class="list clearfix">
						<li class="list1">
							<a href="#"><div class="img img1"></div></a>
							<div class="title">
								<h2>JB LEE</h2>
							</div>
							<div class="text-box">
								<p>MIT 공학 석사, McKinsey &amp; Company 에서 컨설턴트로 활약. 새로운 프로젝트
									또는 기업체의 구조 구축과 설계, 그리고 Business Development를 포함한 다방면의 운영에 전문화
									되어있음.</p>
							</div>
						</li>
						<li class="list2">
							<a href="#"><div class="img img2"></div></a>
							<div class="title">
								<h2>DASOL LEE</h2>
							</div>
							<div class="text-box">
								<p>University of Toronto 화학과 졸업 후 IT 스타트업에서 매니저로 활약. 운영, 경영
									및 Business deveopment 등 스타트업에 특화된 다양한 경험이 풍부함. 엘프코리아 브랜딩 관리 및
									마케팅 담당.</p>
							</div>
						</li>
						<li>
							<a href="#"><div class="img img3"></div></a>
							<div class="title">
								<h2>GM CHUNG</h2>
							</div>
							<div class="text-box">
								<p>국민대학교 졸업. 엘프코리아의 막내. 재학중 블록체인에 관심을 가지게 되었으며, 오랜 기간의 커뮤니티
									활동을 통해 한국 크립토 마켓의 환경과 트렌드에 능숙하고 투자자로써의 입장과 관심 포인트 이해도가 높음.</p>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<!-- TEAM 끝 -->
			<!-- 정보 -->
			<div class="main-info-wrap section" id="contain_6">
				<div class="info_wrap">
					<p class="h2title"></p>
					<div class="main-info">
						<img src="img/info_img.png" alt="" />
					</div>
				</div>

			</div>
			<!-- 정보 -->
		</div>
	</div>
	<div class="top_btn">
		<a href="javascript:topBtn()"><img src="./img/ico_top.png"
			alt="TOP" /></a>
		<!--     <a href="#topline"  class="go-top" onclick="javascript: goTop();" ></span></a> -->
	</div>

	<script type="text/javascript">
	
	function scrollActive(){
		var position = $(this).scrollTop();
		console.log(position);
		
		//console.log($(this).scrollTop()+", "+$('.main-notice-wrap').offset().top);
		$('#main_nav_1').removeClass('main-bn-navi-target');
		$('#main_nav_2').removeClass('main-bn-navi-target main-bn-navi-target-2');
		$('#main_nav_3').removeClass('main-bn-navi-target main-bn-navi-target-3');
		$('#main_nav_4').removeClass('main-bn-navi-target main-bn-navi-target-4');
		$('#main_nav_5').removeClass('main-bn-navi-target main-bn-navi-target-5');
		$('#main_nav_6').removeClass('main-bn-navi-target main-bn-navi-target-6');
		
		if(0 <= position && position <  $('.main-notice-wrap').offset().top) {			
			$('#main_nav_1').addClass('main-bn-navi-target');
		}
		else if(position >=  $('.main-notice-wrap').offset().top && position < $('.main-news-wrap').offset().top) {			
			$('#main_nav_2').addClass('main-bn-navi-target main-bn-navi-target-2');
		}
		else if(position >= $('.main-news-wrap').offset().top && position < $('.main-content-wrap').offset().top) {			
			$('#main_nav_3').addClass('main-bn-navi-target main-bn-navi-target-3');
		}
		else if(position >= $('.main-content-wrap').offset().top &&position <$('.main-team-wrap').offset().top) {
			$('#main_nav_4').addClass('main-bn-navi-target main-bn-navi-target-4');
		}
		else if( position >= $('.main-team-wrap').offset().top && position <$('.main-info-wrap').offset().top) {
			$('#main_nav_5').addClass('main-bn-navi-target main-bn-navi-target-5');
		}
		else if(position >= $('.main-info-wrap').offset().top){
			$('#main_nav_6').addClass('main-bn-navi-target main-bn-navi-target-6');
		}
	}
	
    function goPage(where) {
        $("html, body").stop().animate({scrollTop:$(where).offset().top+0}, 1000, 'swing', function(){
           scrollActive();
           
        });
     }

	</script>

	<jsp:include page="./main_footer.jsp"></jsp:include>

</body>
</html>