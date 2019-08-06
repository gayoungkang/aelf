<%@page import="java.util.Calendar"%>
<%@page import="model.CalendarInfoModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<CalendarInfoModel> listCal = (List<CalendarInfoModel>) request.getAttribute("listCal");
	CalendarInfoModel cal = (CalendarInfoModel) request.getAttribute("cal");
	int totalCount = (Integer) request.getAttribute("totalCount");
	String pageNavigator = (String) request.getAttribute("pageNavigator");
	String pageNum = (String) request.getAttribute("pageNum");
	
	String year = (String) request.getAttribute("year");
	String month = (String) request.getAttribute("month");
	
	int prevYear = Integer.parseInt(year)-1;
	int nextYear = Integer.parseInt(year)+1;
	
	String arrWeek[] = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
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

<meta name="Title" content="엘프 코리아 캘린더">
<meta name="Keyword" content="aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain 엘프정보 엘프커뮤니티 엘프포럼 엘프캔디 엘프밋업 엘프이벤트 엘프소식">
<meta name="Description" content="엘프의 최신 이벤트와 활동을 한눈에 보실 수 있습니다. 엘프와 엘프코리아가 참여하는 컨퍼런스와 이벤트 정보를 받아보세요.">
<meta name="Author" content="Daniel Gong">

<meta itemprop="name" content="엘프 코리아 캘린더">
<meta itemprop="description" content="엘프의 최신 이벤트와 활동을 한눈에 보실 수 있습니다. 엘프와 엘프코리아가 참여하는 컨퍼런스와 이벤트 정보를 받아보세요.">
<meta itemprop="image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">
<meta property="og:type" content="website">
<meta property="og:site_name" content="AELF KOREA">
<meta property="og:title" content="엘프 코리아 캘린더">
<meta property="og:description" content="엘프의 최신 이벤트와 활동을 한눈에 보실 수 있습니다. 엘프와 엘프코리아가 참여하는 컨퍼런스와 이벤트 정보를 받아보세요.">
<meta property="og:image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io/calendar.lf?menu=calendar">
<meta name="apple-mobile-web-app-title" content="엘프 코리아">
<meta name="application-name" content="엘프 코리아">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css"><!-- 스타일시트 -->
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


function goModal(calNo) {
	
	var param = "mode=view&cal_no="+calNo;
	$.ajax({
		type: "POST",
		url: 'calendar.lf',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			var obj = JSON.parse(ret);
			
			$('body').css('overflow', 'hidden');	// body 스크롤 막지
			
			if(!$('.opacity_bg_layer').length) 
				opacity_bg_layer(); // 불투명 배경 레이어 띄우기
				
			var str_html = 
				"<div class='div_modal' style='width: 900px;'>" +
					"<p style='font-size:15px;'>"+obj.title+" ("+obj.start_date+"~"+obj.end_date+")</p><br/>" +
					//"<hr style='height:1px; background: #ccc;' />" +
					obj.content +
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



function getNextPage() {
	var pageNum = document.getElementById('pageNum').value;
	var year = '<%=year %>';
	var month = '<%=month %>';
	
	var param = "mode=list&pageNum="+pageNum+"&year="+year+"&month="+month;
	$.ajax({
		type: "POST",
		url: 'calendar.lf',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			var obj = JSON.parse(ret);
			
			if(obj.length>0) {
				document.getElementById('pageNum').value = eval(pageNum)+1;
				
				var strHTML = "";
				
				for(var i=0; i<obj.length; i++) {
					strHTML += 
						"<table cellpadding=\"0\" cellspacing=\"0\" class=\"calendar-tb-2\" onclick=\"javascript:window.open('"+obj[i].content+"')\">" +
							"<tr height=\"20\">" +
		                	    "<td colspan=\"2\" style=\"border-top:2px solid #35b1ff; border-radius: 5px;\"></td>"+
		                	"</tr>"+
		                	"<tr height=\"21\" style=\"font-size:16px;\">"+
		                    	"<td style=\"border-right: 1px solid #c4c4c4; color:#35b1ff;\" width=\"65\">"+obj[i].tag+"</td>"+
		                    	"<td style=\"text-align: left; padding-left: 20px;\"><p class=\"one_tit_p\">"+obj[i].title+"</p></td>"+
		                	"</tr>"+
		                	"<tr height=\"10\">"+
		                    	"<td style=\"border-right: 1px solid #c4c4c4;\"><span style=\"border-top:1px solid #c4c4c4; width: 30px; display: block; margin:0 auto;\"></span></td>"+
		                    	"<td><span style=\"border-top:1px solid #c4c4c4; width:30px; display: block; margin-left:20px;\"></span></td>"+
		                	"</tr>"+
		                	"<tr>"+
		                    	"<td rowspan=\"3\" style=\"font-size:24px; border-right: 1px solid #c4c4c4; line-height: 18px;\">"+obj[i].date+"<br><span style=\"font-size:14px;\">"+obj[i].week+"-</span></td>"+
		                    	"<td style=\"text-align: left; padding-left: 20px; font-size:12px;\"><p class=\"one_tit_p\">"+obj[i].comment+"</p></td>"+
		                	"</tr>"+
		                	"<tr>"+
		                    	"<td style=\"text-align: left; padding-left: 20px; font-size:12px;\">시간 : "+obj[i].time+"</td>"+
		                	"</tr>"+
		                	"<tr>"+
		                    	"<td style=\"text-align: left; padding-left: 20px; font-size:12px;\">장소 : "+obj[i].place+"</td>"+
		                	"</tr>"+
		                	"<tr height=\"20\"></tr>"+
	            		"</table>";
				}
				
				$('#div_list').append(strHTML);
			}			
		}
	});
}

function ajaxFailed(xmlRequest)	{
	alert(xmlRequest.status+"\n\r"+xmlRequest.statusText+"\n\r"+xmlRequest.responseText);
}

</script>

</head>
<body>

	<jsp:include page="../main_top.jsp"></jsp:include>
	
	<input type="hidden" id="pageNum" value="<%=Integer.parseInt(pageNum)+1 %>" />

    <div class="calendar-wrap">
        <div class="calendar-wrap-2">
            <div class="calendar">
                <table cellpadding="0" cellspacing="0" class="calendar-tb-1">
                    <tr>
                        <td colspan="12" style="font-size: 18px; font-weight: 500;">
                        	<span style="font-size:22px; cursor: pointer" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=prevYear%>&month=<%=month%>'" >＜</span> 
                        	<%=year %> 
                        	<span style="font-size:22px; cursor: pointer" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=nextYear%>&month=<%=month%>'">＞</span>
                        </td>
                    </tr>
                    <tr height="22"></tr>
                    <tr class="calendar-month">
                        <td class="dot<%if("01".equals(month)) {%> active<%}%>" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=year%>&month=01'" width="23">1</td>
                        <td></td>
                        <td class="dot<%if("02".equals(month)) {%> active<%}%>" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=year%>&month=02'" width="23">2</td>
                        <td></td>
                        <td class="dot<%if("03".equals(month)) {%> active<%}%>" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=year%>&month=03'" width="23">3</td>
                        <td></td>
                        <td class="dot<%if("04".equals(month)) {%> active<%}%>" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=year%>&month=04'" width="23">4</td>
                        <td></td>
                        <td class="dot<%if("05".equals(month)) {%> active<%}%>" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=year%>&month=05'" width="23">5</td>
                        <td></td>
                        <td class="dot<%if("06".equals(month)) {%> active<%}%>" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=year%>&month=06'" width="23">6</td>
                        <td></td>
                        <td class="dot<%if("07".equals(month)) {%> active<%}%>" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=year%>&month=07'" width="23">7</td>
                        <td></td>
                        <td class="dot<%if("08".equals(month)) {%> active<%}%>" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=year%>&month=08'" width="23">8</td>
                        <td></td>
                        <td class="dot<%if("09".equals(month)) {%> active<%}%>" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=year%>&month=09'" width="23">9</td>
                        <td></td>
                        <td class="dot<%if("10".equals(month)) {%> active<%}%>" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=year%>&month=10'" width="23">10</td>
                        <td></td>
                        <td class="dot<%if("11".equals(month)) {%> active<%}%>" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=year%>&month=11'" width="23">11</td>
                        <td></td>
                        <td class="dot<%if("12".equals(month)) {%> active<%}%>" onclick="javascript:location.href='calendar.lf?menu=calendar&year=<%=year%>&month=12'" width="23">12</td>
                    </tr>
                </table>
                <div class="calendar-list" id="div_list">
					<%
					for(int i=0; i<listCal.size(); i++) {
						CalendarInfoModel list = listCal.get(i);
						
						Calendar tCal = Calendar.getInstance();
						tCal.set(Integer.parseInt(list.getCalStartDate().substring(0, 4)), 
								Integer.parseInt(list.getCalStartDate().substring(5, 7))-1,
								Integer.parseInt(list.getCalStartDate().substring(8, 10)));
					%>
                    <table cellpadding="0" cellspacing="0" class="calendar-tb-2" onclick="javascript:window.open('<%=list.getCalContent() %>')">
                        <tr height="20">
                            <td colspan="2" style="border-top:2px solid #35b1ff; border-radius: 5px;"></td>
                        </tr>
                        <tr height="21" style="font-size:16px;">
                            <td style="border-right: 1px solid #c4c4c4; color:#35b1ff;" width="65"><%=list.getCalTag() %></td>
                            <td style="text-align: left; padding-left: 20px;"><p class="one_tit_p"><%=list.getCalTitle() %></p></td>
                        </tr>
                        <tr height="10">
                            <td style="border-right: 1px solid #c4c4c4;"><span style="border-top:1px solid #c4c4c4; width: 30px; display: block; margin:0 auto;"></span></td>
                            <td><span style="border-top:1px solid #c4c4c4; width:30px; display: block; margin-left:20px;"></span></td>
                        </tr>
                        <tr>
                            <td rowspan="3" style="font-size:24px; border-right: 1px solid #c4c4c4; line-height: 18px;"><%=list.getCalStartDate().substring(8, 10) %><br><span style="font-size:14px;"><%=arrWeek[tCal.get(Calendar.DAY_OF_WEEK)-1] %>-</span></td>
                            <td style="text-align: left; padding-left: 20px; font-size:12px;"><p class="one_tit_p"><%=list.getCalComment() %></p></td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding-left: 20px; font-size:12px;">시간 : <%=list.getCalTime() %></td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding-left: 20px; font-size:12px;">장소 : <%=list.getCalPlace() %></td>
                        </tr>
                        <tr height="20"></tr>
                    </table>
                    <%} %>
                    
                    <!-- 
                    <table cellpadding="0" cellspacing="0" class="calendar-tb-2">
                        <tr height="20">
                            <td colspan="2" style="border-top:2px solid #35b1ff; border-radius: 5px;"></td>
                        </tr>
                        <tr height="21" style="font-size:16px;">
                            <td style="border-right: 1px solid #c4c4c4; color:#35b1ff;" width="65">상장</td>
                            <td style="text-align: left; padding-left: 20px;"><p class="one_tit_p">World Blockchain Conference</p></td>
                        </tr>
                        <tr height="10">
                            <td style="border-right: 1px solid #c4c4c4;"><span style="border-top:1px solid #c4c4c4; width: 30px; display: block; margin:0 auto;"></span></td>
                            <td><span style="border-top:1px solid #c4c4c4; width:30px; display: block; margin-left:20px;"></span></td>
                        </tr>
                        <tr>
                            <td rowspan="3" style="font-size:24px; border-right: 1px solid #c4c4c4; line-height: 18px;">13<br><span style="font-size:14px;">Sun-</span></td>
                            <td style="text-align: left; padding-left: 20px; font-size:12px;"><p class="one_tit_p">World Blockchain Conference</p></td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding-left: 20px; font-size:12px;">시간 : 4월 23일 - 25일</td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding-left: 20px; font-size:12px;">장소 : 중국 마카오</td>
                        </tr>
                        <tr height="20"></tr>
                    </table>
                     -->
                </div>
                <div class="calendar-tb-img">
                	<img src="img/calendar-plus.png" alt="캘린더 더보기" onclick="javascript:getNextPage()" />
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>