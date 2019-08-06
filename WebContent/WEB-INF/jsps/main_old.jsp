<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AELF</title>
<meta name="description" content="AELF">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->
<link rel="stylesheet" type="text/css" href="swiper.min.css" >

<style type="text/css">
.opacity_bg_layer {display:none; position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50); z-index:100000;}
.layer_pop_center {position:absolute; background:#FFF; padding:5px; z-index:100001; overflow: hidden; overflow-y: auto;}

.swiper-container {
  width: 650px;
  height: auto;
}

.swiper-container-contents {
  width: 650px;
  height: auto;
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
</style>

<script type="text/javascript">

/* 불투명 배경 레이어 뛰우기 */
function opacity_bg_layer() {
  if(!$('.opacity_bg_layer').length) {
    $('<div class="opacity_bg_layer"></div>').appendTo($('body'));
  }

  var oj = $(".opacity_bg_layer");

  // 화면의 가로, 세로 알아내기
  var w = $(document).width();
  var h = $(document).height();

  oj.css({'width':w,'height':h+300}); // 불투명 배경 레이어 크기 설정
  oj.fadeIn(500); // 불투명 배경 레이어 보이기 속도
} 

/* 레이어 생성
cls : class
cont : 내용
기본 : 숨기기
*/
function layer_pop_crt(cls, cont) {
  if(!cls) return false;
  if(!$(cls).length) {
    $('<div class="' + cls + '">' + cont + '</div>').appendTo($('body'));
  }

  return true;
} 

/* 레이어 띄우기
oj : 레이어 객체
*/
function layer_pop_center(oj) {
  if(!oj.length) return false;
  oj.layer_pop_center_set();
} 

/* 레이어 팝업 위치 설정 */
$.fn.layer_pop_center_set = function () {
    //this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
    //this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
    /*
    if($(window).scrollTop()>500) {
    	this.css("top", $(window).scrollTop()+10);
    }
    else {
    	var topPos = ($(window).height() - $(this).outerHeight())/2;    
        if(topPos<0) {
        	this.css("top", 150);
        } else {
        	this.css("top", ($(window).height() - $(this).outerHeight())/2);    	
        }
    }
    
    
    var topPos = ($(window).height() - $(this).outerHeight())/2;    
    if(topPos<0) {
    	this.css("top", $(window).scrollTop()+100);
    } else {
    	this.css("top", $(window).scrollTop() + (($(window).height() - $(this).outerHeight())/2));    	
    }*/
    
    this.css("top", $(window).scrollTop()+50);
    
   	this.css("left", ($(window).width() - $(this).outerWidth())/2);
    return this;
} 

/* 레이어 닫기 후 삭제
oj : 레이어 객체
*/
function layer_pop_close(oj) {
  if(oj.length) {
    oj.fadeOut(500, function() {
      oj.remove();
    });
  }
  // 불투명 배경 레이어 삭제
  var oj = $('.opacity_bg_layer');
  if(oj.length) {
    oj.fadeOut(500, function() {
     oj.remove();
    });
  }
}
 

/* 화면을 불러온 후 처리 */
 var ly = 'layer_pop_center';
 var _ly;
 var ly_bg = $('.opacity_bg_layer');
 
$(document).ready(function() {

  $(document).on('click', '.opacity_bg_layer', function() { // 불투명 배경 레이어를 클릭하면 닫기
    layer_pop_close(_ly);
    $('.content-wrap').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
    
    $('body').css('overflow', '');
  });
});
 

// 브라우저 창 크기 변경에 따른 처리
$(window).resize(function() {
  var oj = $('.layer_pop_center');
  if(oj.length) layer_pop_center(oj); // 레이어 팝업이 실행된 상태에서만 진행
  if($('.opacity_bg_layer').length) opacity_bg_layer(); // 불투명 배경 레이어가 실행된 상태에서만 진행
});


function goModal() {	
	if(!ly_bg.length) opacity_bg_layer(); // 불투명 배경 레이어 띄우기
    var str_html =
    	"<div class='swiper-container'>" +
    		"<div class='swiper-wrapper'>" +
    		<%for(int i=1; i<=34; i++) {%>
				"<div class='swiper-slide'>" +
    				"<img src='img/modal_view_<%=String.format("%02d", i) %>.jpg' width='650' />" +
    			"</div>" +
    		<%}%>
    		"</div>" +
    		"<div class='swiper-button-next'></div>" + 
		    "<div class='swiper-button-prev'></div>" +
    	"</div>";
    if(layer_pop_crt(ly, str_html)) {
      _ly = $('.' + ly); // 레이어 팝업 생성 후 재 선언
      layer_pop_center(_ly);
      _ly.fadeIn(500);
    } else {
      if(ly_bg.length) ly_bg.remove();
    }
    
    $('.content-wrap').on('scroll touchmove mousewheel', function(event) { // 터치무브와 마우스휠 스크롤 방지     
    	event.preventDefault();    
    	event.stopPropagation();     
    	return false; 
    });
    $('.layer_pop_center').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
    
    var swiper = new Swiper('.swiper-container', {
    	spaceBetween: 0,
        centeredSlides: true,
        autoplay: {
          delay: 15000,
          disableOnInteraction: false,
        },
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev',
        },
      });
}


function goModal2() {	
	if(!ly_bg.length) opacity_bg_layer(); // 불투명 배경 레이어 띄우기
    var str_html = 
    	"<div class='swiper-container-contents'>" +
			"<div class='swiper-wrapper'>" +
			<%for(int i=1; i<=6; i++) {%>
				"<div class='swiper-slide'>" +
					"<img src='img/contents-<%=i %>.jpg' width='650' />" +
				"</div>" +
			<%}%>
			"</div>" +
			"<div class='swiper-button-next'></div>" + 
		    "<div class='swiper-button-prev'></div>" +
		"</div>";
    if(layer_pop_crt(ly, str_html)) {
      _ly = $('.' + ly); // 레이어 팝업 생성 후 재 선언
      layer_pop_center(_ly);
      _ly.fadeIn(500);
    } else {
      if(ly_bg.length) ly_bg.remove();
    }
    
    $('.content-wrap').on('scroll touchmove mousewheel', function(event) { // 터치무브와 마우스휠 스크롤 방지     
    	event.preventDefault();    
    	event.stopPropagation();     
    	return false; 
    });
    $('.layer_pop_center').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
    
    var swiper = new Swiper('.swiper-container-contents', {
    	spaceBetween: 0,
        centeredSlides: true,
        autoplay: {
          delay: 15000,
          disableOnInteraction: false,
        },
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev',
        },
      });
}


function goModal3() {	
	if(!ly_bg.length) opacity_bg_layer(); // 불투명 배경 레이어 띄우기
    var str_html = 
    	"<div class='swiper-container-contents'>" +
			"<div class='swiper-wrapper'>" +
			<%for(int i=1; i<=5; i++) {%>
				"<div class='swiper-slide'>" +
					"<img src='img/contents-1<%=i %>.jpg' width='650' />" +
				"</div>" +
			<%}%>
			"</div>" +
			"<div class='swiper-button-next'></div>" + 
		    "<div class='swiper-button-prev'></div>" +
		"</div>";
    if(layer_pop_crt(ly, str_html)) {
      _ly = $('.' + ly); // 레이어 팝업 생성 후 재 선언
      layer_pop_center(_ly);
      _ly.fadeIn(500);
    } else {
      if(ly_bg.length) ly_bg.remove();
    }
    
    $('.content-wrap').on('scroll touchmove mousewheel', function(event) { // 터치무브와 마우스휠 스크롤 방지     
    	event.preventDefault();    
    	event.stopPropagation();     
    	return false; 
    });
    $('.layer_pop_center').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
    
    var swiper = new Swiper('.swiper-container-contents', {
    	spaceBetween: 0,
        centeredSlides: true,
        autoplay: {
          delay: 15000,
          disableOnInteraction: false,
        },
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev',
        },
      });
}


function goModal4() {	
	$('body').css('overflow', 'hidden');
	
	if(!ly_bg.length) opacity_bg_layer(); // 불투명 배경 레이어 띄우기
    var str_html = 
    	"<div style='width:650px; height:600px;'>" +
    		"<img src='img/modal_view1.jpg' width='650' />" +
		"</div>";
    if(layer_pop_crt(ly, str_html)) {
      _ly = $('.' + ly); // 레이어 팝업 생성 후 재 선언
      layer_pop_center(_ly);
      _ly.fadeIn(500);
    } else {
      if(ly_bg.length) ly_bg.remove();
    }
}


function goLeft() {
	console.log('left : ' + $('#test').css("margin-left"));
	var divWidth = 262+19;	
	$("#test").animate({"margin-left":"+=" + divWidth + "px"},300);
}

function goRight() {
	console.log('right : ' + $('#test').css("margin-left"));
	var divWidth = 262+19;
	$("#test").animate({"margin-left":"-=" + divWidth + "px"},300);
}

</script>

</head>
<body>

	<jsp:include page="./top.jsp"></jsp:include>

	<div class="main-wrap">
        <div class="main">
            <div class="main-bn-wrap">
                <div class="main-bn"></div>
                <div class="main-bn-navi">
                    <ul>
                        <li id="main_nav_1" class="main-bn-navi-target"><a href="javascript:void()" onclick="javascript:goPage('.main-bn-wrap')"></a></li>
                        <li id="main_nav_2"><a href="javascript:void()" onclick="javascript:goPage('.main-notice-wrap')"></a></li>
                        <li id="main_nav_3"><a href="javascript:void()" onclick="javascript:goPage('.main-news-wrap')"></a></li>
                        <li id="main_nav_4"><a href="javascript:void()" onclick="javascript:goPage('.main-content-wrap')"></a></li>
                    </ul>
                </div>
            </div>
            
            <div class="main-btn-wrap">
	            <div class="main-btn">
	                <ul>
	                    <li><a href="#"><img src="img/main-btn-1.png" alt="one pager" />One Pager</a></li>
	                    <li><a href="javascript:void()" onclick="javascript:goModal4()"><img src="img/main-btn-1.png" alt="white paper" />White Paper</a></li>
	                    <li><a href="#"><img src="img/main-btn-2.png" alt="road map" />Road Map</a></li>
	                    <li><a href="#"><img src="img/main-btn-3.png" alt="brand film"/>Brand Film</a></li>
	                </ul>
	            </div>
            </div>
            
            <!-- 공지 -->
            <div class="main-notice-wrap">
            	<div class="notice-content-nav">
                	<div class="notice-left">
                        <img src="img/notice-left.png" alt="왼쪽" onclick="javascript:goLeft()" />
                    </div>
                    <div class="notice-right">
                        <img src="img/notice-right.png" alt="오른쪽" onclick="javascript:goRight()" />
                    </div>	                    
               	</div>
               
                <div class="main-notice">
                    <div class="notice-content-wrap" id="test">
                    
                    <div class="notice-tb-wrap">
                        <table cellpadding="0" cellspacing="0">
                            <tr class="notice-wrap-img">
                                <td>
                                    <img src="img/notice-view-1.png" alt="" />
                                    <span class="notice-active"><img src="img/notice-non.png" alt="notice" /></span>
                                    <table cellpadding="0" cellspacing="0">
                                        <tr class="notice-fig-wrap">
                                            <td>
                                                <figcaption class="notice-fig" onclick="javascript:location.href='notice.lf?menu=notice&mode=view'">
                                                    <figure>
                                                        <img src="img/notice-on.png" alt="" class="notice-fig-1" />
                                                        <img src="img/notice-plus.png" alt="" class="notice-fig-2" />
                                                    </figure>
                                                </figcaption>
                                            </td>
                                        </tr>        
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>[캔디] 캔디 시스템 새로운 업데이트 aelfigo를 사용한 점수 반영 개시</td>
                            </tr>
                            <tr>
                                <td>＜엘프(AELF)＞</td>
                            </tr>
                            <tr>
                                <td class="notice-date">AELF KOREA｜Mar14.2018</td>
                            </tr>
                        </table>
                    </div>
                    <div class="notice-tb-wrap">
                        <table cellpadding="0" cellspacing="0">
                            <tr class="notice-wrap-img">
                                <td>
                                    <img src="img/notice-view-1.png" alt="" />
                                    <span class="notice-active"><img src="img/notice-non.png" alt="notice" /></span>
                                    <table cellpadding="0" cellspacing="0">
                                        <tr class="notice-fig-wrap">
                                            <td>
                                                <figcaption class="notice-fig" onclick="javascript:location.href='notice.lf?menu=notice&mode=view'">
                                                    <figure>
                                                        <img src="img/notice-on.png" alt="" class="notice-fig-1" />
                                                        <img src="img/notice-plus.png" alt="" class="notice-fig-2" />
                                                    </figure>
                                                </figcaption>
                                            </td>
                                        </tr>        
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>[캔디] 캔디 시스템 새로운 업데이트 aelfigo를 사용한 점수 반영 개시</td>
                            </tr>
                            <tr>
                                <td>＜엘프(AELF)＞</td>
                            </tr>
                            <tr>
                                <td class="notice-date">AELF KOREA｜Mar14.2018</td>
                            </tr>
                        </table>
                    </div>
                    <div class="notice-tb-wrap">
                        <table cellpadding="0" cellspacing="0">
                            <tr class="notice-wrap-img">
                                <td>
                                    <img src="img/notice-view-1.png" alt="" />
                                    <span class="notice-active"><img src="img/notice-non.png" alt="notice" /></span>
                                    <table cellpadding="0" cellspacing="0">
                                        <tr class="notice-fig-wrap">
                                            <td>
                                                <figcaption class="notice-fig" onclick="javascript:location.href='notice.lf?menu=notice&mode=view'">
                                                    <figure>
                                                        <img src="img/notice-on.png" alt="" class="notice-fig-1" />
                                                        <img src="img/notice-plus.png" alt="" class="notice-fig-2" />
                                                    </figure>
                                                </figcaption>
                                            </td>
                                        </tr>        
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>[캔디] 캔디 시스템 새로운 업데이트 aelfigo를 사용한 점수 반영 개시</td>
                            </tr>
                            <tr>
                                <td>＜엘프(AELF)＞</td>
                            </tr>
                            <tr>
                                <td class="notice-date">AELF KOREA｜Mar14.2018</td>
                            </tr>
                        </table>
                    </div>
                    <div class="notice-tb-wrap">
                        <table cellpadding="0" cellspacing="0">
                            <tr class="notice-wrap-img">
                                <td>
                                    <img src="img/notice-view-2.png" alt="" />
                                    <span class="notice-active"><img src="img/notice-non.png" alt="notice" /></span>
                                    <table cellpadding="0" cellspacing="0">
                                        <tr class="notice-fig-wrap">
                                            <td>
                                                <figcaption class="notice-fig" onclick="javascript:location.href='notice.lf?menu=notice&mode=view'">
                                                    <figure>
                                                        <img src="img/notice-on.png" alt="" class="notice-fig-1" />
                                                        <img src="img/notice-plus.png" alt="" class="notice-fig-2" />
                                                    </figure>
                                                </figcaption>
                                            </td>
                                        </tr>        
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>[신규 거래소 상장] 엘프 빗썸에서 12일 6:00PM 부터 거래시작. 상장 이벤트는 이 주소에서 확인하세요</td>
                            </tr>
                            <tr>
                                <td>＜엘프(AELF)＞</td>
                            </tr>
                            <tr>
                                <td class="notice-date">AELF KOREA｜Mar14.2018</td>
                            </tr>
                        </table>
                    </div>
                    <div class="notice-tb-wrap">
                        <table cellpadding="0" cellspacing="0">
                            <tr class="notice-wrap-img">
                                <td>
                                    <img src="img/notice-view-3.png" alt="" />
                                    <span class="notice-active"><img src="img/notice-non.png" alt="notice" /></span>
                                    <table cellpadding="0" cellspacing="0">
                                        <tr class="notice-fig-wrap">
                                            <td>
                                                <figcaption class="notice-fig" onclick="javascript:location.href='notice.lf?menu=notice&mode=view'">
                                                    <figure>
                                                        <img src="img/notice-on.png" alt="" class="notice-fig-1" />
                                                        <img src="img/notice-plus.png" alt="" class="notice-fig-2" />
                                                    </figure>
                                                </figcaption>
                                            </td>
                                        </tr>        
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>[이벤트] 5월 25일 금요일 오후 3시에 엘프가 한국 마케팅 관련 기자회견을 개최합니다</td>
                            </tr>
                            <tr>
                                <td>＜엘프(AELF)＞</td>
                            </tr>
                            <tr>
                                <td class="notice-date">AELF KOREA｜Mar14.2018</td>
                            </tr>
                        </table>
                    </div>
                    <div class="notice-tb-wrap">
                        <table cellpadding="0" cellspacing="0">
                            <tr class="notice-wrap-img">
                                <td>
                                    <img src="img/notice-view-4.png" alt="" />
                                    <span class="notice-active"><img src="img/notice-non.png" alt="notice" /></span>
                                    <table cellpadding="0" cellspacing="0">
                                        <tr class="notice-fig-wrap">
                                            <td>
                                                <figcaption class="notice-fig" onclick="javascript:location.href='notice.lf?menu=notice&mode=view'">
                                                    <figure>
                                                        <img src="img/notice-on.png" alt="" class="notice-fig-1" />
                                                        <img src="img/notice-plus.png" alt="" class="notice-fig-2" />
                                                    </figure>
                                                </figcaption>
                                            </td>
                                        </tr>        
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>[활동] aelf COO 주링이 뉴욕에서 개최된 Consensus 2018 에서 패널 멤버로 참가해 아시아의 블록체인 마켓에 대해서 의견을 나눴습니다.</td>
                            </tr>
                            <tr>
                                <td>＜엘프(AELF)＞</td>
                            </tr>
                            <tr>
                                <td class="notice-date">AELF KOREA｜Mar14.2018</td>
                            </tr>
                        </table>
                    </div>
                    
                    </div>
                    
                </div>
                <div class="notice-viwe">
                    <input type="button" value="VIEW ALL NOTICE" onclick="javascript:location.href='notice.lf?menu=notice'" />
                </div>
            </div>
            <!-- 공지 -->
            
            <!-- 뉴스 -->
            <div class="main-news-wrap">
                <div class="main-news">
                    <div class="notice-left news-left">
                        <img src="img/notice-left.png" alt="왼쪽" />
                    </div>
                    <div class="news-tb-wrap">
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td colspan="2" style="font-size:30px; font-weight: 400; line-height: 30px; border-bottom:3px solid #000;" height="103">엘프, 혁신 얼라이언스 창립...<br>상업용 블록체인 액셀러레이팅 목적</td>
                                <td width="17"></td>
                                <td rowspan="3" style="position: relative;"><img src="img/news-view-3.png" alt="" /><span class="news-icon"><img src="img/news-non.png" alt="" /></span></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="font-size:12px; line-height: 18px; letter-spacing: -0.7px;">블록체인 네트워크인 엘프(aelf)가 ‘혁신 얼라이언스(Innovation Alliance)’ 창립을 발표했다.<br>혁신 얼라이언스는 블록체인 연구에 관심 있는 각각 다른 규모의 비즈니스 자원 공유 및 산업적 자문 등을 목적으로 한다.<br>혁신 얼라이언스의 창립 멤버로는 싱가포르에서 최대 규모이자 가장 영향력 있다고 손꼽히는 블록체인 펀드 시그넘<br>캐피털(Signum Capital)과 아시아 지역 암호화폐 및 블록체인 분야의 메이저 헤지 펀드인 FBG 캐피털, 독일 뮌헨 기반의<br>글로벌 전략 컨설팅 회사인 로란드 버저(Roland Berger) 그리고 테크 크런치의 창립자이자 에링턴 XRP 캐피털의<br>창립자 마이클 에링턴이 참여했다.</td>
                                <td></td>
                            </tr>
                            <tr class="news-btn-wrap" height="31">
                                <td class="news-company">AELF KOREA｜Mar14.2018</td>
                                <td>
                                    <div class="notice-viwe news-viwe">
                                        <input type="button" value="VIEW ALL NEWS" onclick="javascript:location.href='news.lf?menu=news'" />
                                    </div>
                                </td>
                                <td></td>
                            </tr>
                        </table>
                    </div>
                    <div class="notice-right news-right">
                        <img src="img/notice-right.png" alt="오른쪽" />
                    </div>
                </div>
            </div>
            <!-- 뉴스 -->
            
            <!-- 컨텐츠 -->
            <div class="main-content-wrap">
                <div class="main-content">
                    <div class="content-wrap">
                        <div class="content-tb-wrap">
                            <table cellpadding="0" cellspacing="0">
                                <tr height="66">
                                    <td width="261" style="border-left:1px solid #535353;"></td>
                                    <td width="20"></td>
                                    <td width="261" style="border-left:1px solid #535353;"></td>
                                    <td width="20"></td>
                                    <td width="261" style="border-left:1px solid #535353;"></td>
                                    <td width="20"></td>
                                    <td width="261" style="border-left:1px solid #535353;"></td>
                                </tr>
                                <tr>
                                    <td style="font-size:14px; color:#fff;">01</td>
                                    <td width="20"></td>
                                    <td style="font-size:14px; color:#fff;">02</td>
                                    <td width="20"></td>
                                    <td style="font-size:14px; color:#fff;">03</td>
                                    <td width="20"></td>
                                    <td style="font-size:14px; color:#fff;">04</td>
                                </tr>
                            </table>
                        </div>
                        
                        <div class="content-box content-box-1">
                            <table class="content-bn-wrap">
                                <tr height="160">
                                    <td width="261" class="content-img">
                                        <img src="img/content-view-1.png" alt="" />
                                        <span class="notice-active"><img src="img/content-non-3.png" alt="content" /></span>
                                        <table cellpadding="0" cellspacing="0">
                                            <tr class="notice-fig-wrap">
                                                <td>
                                                    <figcaption class="notice-fig content-fig" onclick="javascript:window.open('https://www.youtube.com/watch?v=VMnCJzNsOrY&feature=youtu.be')">
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
			                        <td width="261" style="font-size:14px; padding-bottom: 17px; color:#fff;">aelf COO 주링의 나스닥 인터뷰</td>
			                    </tr>
			                    <tr height="25">
			                        <td width="261" style="font-size:12px; letter-spacing: -0.9px; color:#fff;">Zhuling Chen, Co-Founder of Aelf, joins Jill Malandrino on TradeTalks broadcasting from Consensus 2018 in NYC.</td>
			                    </tr>
                            </table>
                        </div>
                        
                        <div class="content-box content-box-1">
                            <table class="content-bn-wrap">
                                <tr height="160">
                                    <td width="261" class="content-img">
                                        <img src="img/content-view-2.png" alt="" />
                                        <span class="notice-active"><img src="img/content-non-3.png" alt="content" /></span>
                                        <table cellpadding="0" cellspacing="0">
                                            <tr class="notice-fig-wrap">
                                                <td>
                                                    <figcaption class="notice-fig content-fig" onclick="javascript:window.open('https://www.youtube.com/watch?v=VMnCJzNsOrY&feature=youtu.be')">
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
                        			<td width="261" style="font-size:14px; color:#fff;">한국 총괄 JB Lee 의 매일경제 블록팩트 생방송 인터뷰</td>
			                    </tr>
			                    <tr height="25">
			                        <td width="261" style="font-size:12px; letter-spacing: -0.9px; color:#fff;">출연자:  펜타시큐리티시스템 한인수 이사,<br>이준범 엘프(AELF) 한국 총괄</td>
			                    </tr>
                            </table>
                        </div>
                        
                        <div class="content-box content-box-1">
                            <table class="content-bn-wrap">
                                <tr height="160">
                                    <td width="261" class="content-img">
                                        <img src="img/content-view-3.png" alt="" />
                                        <span class="notice-active"><img src="img/content-non-4.png" alt="content" /></span>
                                        <table cellpadding="0" cellspacing="0">
                                            <tr class="notice-fig-wrap">
                                                <td>
                                                    <figcaption class="notice-fig content-fig" onclick="javascript:goModal2()">
                                                        <figure>
                                                            <img src="img/content-on-4.png" alt="" class="notice-fig-1" />
                                                            <img src="img/notice-plus.png" alt="" class="notice-fig-2" />
                                                        </figure>
                                                    </figcaption>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                               <tr height="80">
			                        <td width="261" style="font-size:14px; padding-bottom: 17px; color:#fff;"> aelf가 무엇인가요? 초보자 가이드</td>
			                    </tr>
			                    <tr height="25">
			                        <td width="261" style="font-size:12px; letter-spacing: -0.9px;"></td>
			                    </tr>
                            </table>
                        </div>
                        
                        <div class="content-box content-box-1">
                            <table class="content-bn-wrap">
                                <tr height="160">
                                    <td width="261" class="content-img">
                                        <img src="img/content-view-4.png" alt="" />
                                        <span class="notice-active"><img src="img/content-non-4.png" alt="content" /></span>
                                        <table cellpadding="0" cellspacing="0">
                                            <tr class="notice-fig-wrap">
                                                <td>
                                                    <figcaption class="notice-fig content-fig" onclick="javascript:goModal3()">
                                                        <figure>
                                                            <img src="img/content-on-4.png" alt="" class="notice-fig-1" />
                                                            <img src="img/notice-plus.png" alt="" class="notice-fig-2" />
                                                        </figure>
                                                    </figcaption>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr height="80">
	                     		   <td width="261" style="font-size:14px; padding-bottom: 17px; color:#fff;">aelf에 대한 모든것 파헤치기<br></td>
			                    </tr>
			                    <tr height="42">
			                        <td width="261" style="font-size:12px; letter-spacing: -0.9px;"></td>
			                    </tr>
                            </table>
                        </div>
                        
                            <div class="notice-viwe content-btn">
                            <input type="button" value="VIEW CONTENT" onclick="javascript:location.href='contents.lf?menu=contents'" />
                        </div>
                    </div>
                </div>
            </div>
            <!-- 컨텐츠 -->
            
            <!-- 정보 -->
            <div class="main-info-wrap">
                <div class="main-info">
                    <img src="img/main-info.jpg" alt="" />
                </div>
            </div>
            <!-- 정보 -->
            
        </div>
    </div>
    
	<script src="js/swiper.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		
	});
	
	$(window).scroll(function(){
		//console.log($(this).scrollTop()+", "+$('.main-notice-wrap').offset().top);
		$('#main_nav_1').removeClass('main-bn-navi-target');
		$('#main_nav_2').removeClass('main-bn-navi-target main-bn-navi-target-2');
		$('#main_nav_3').removeClass('main-bn-navi-target main-bn-navi-target-3');
		$('#main_nav_4').removeClass('main-bn-navi-target main-bn-navi-target-4');
		
		if($(this).scrollTop()<$('.main-notice-wrap').offset().top) {
			$('#main_nav_1').addClass('main-bn-navi-target');
		}
		else if($(this).scrollTop()>=$('.main-notice-wrap').offset().top && $(this).scrollTop()<$('.main-news-wrap').offset().top) {
			$('#main_nav_2').addClass('main-bn-navi-target main-bn-navi-target-2');
		}
		else if($(this).scrollTop()>=$('.main-news-wrap').offset().top && $(this).scrollTop()<$('.main-content-wrap').offset().top) {
			$('#main_nav_3').addClass('main-bn-navi-target main-bn-navi-target-3');
		}
		else if($(this).scrollTop()>=$('.main-content-wrap').offset().top && $(this).scrollTop()<$('.main-info-wrap').offset().top) {
			$('#main_nav_4').addClass('main-bn-navi-target main-bn-navi-target-4');
		}
		/*
		if($(this).scrollTop()==$('.main-notice-wrap').offset().top-10) {
			
		}*/
	});	
	
	function goPage(where) {
		$("html, body").stop().animate({scrollTop:$(where).offset().top+30}, 1000, 'swing', function(){});
	}
	
	</script>
    
    <jsp:include page="./footer.jsp"></jsp:include>

</body>
</html>