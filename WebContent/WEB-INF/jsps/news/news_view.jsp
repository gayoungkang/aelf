<%@page import="util.CryptoSlate"%>
<%@page import="model.DebateInfoModel"%>
<%@page import="model.UserInfoModel"%>
<%@page import="model.ReplyModel"%>
<%@page import="java.util.List"%>
<%@page import="model.ContentInfoModel"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="model.NewsInfoModel"%>
<%@page import="model.NoticeInfoModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	NewsInfoModel newsInfo = (NewsInfoModel) request.getAttribute("newsInfo");

	NoticeInfoModel reNi = (NoticeInfoModel) request.getAttribute("reNi");
	ContentInfoModel reCi = (ContentInfoModel) request.getAttribute("reCi");
	NewsInfoModel reNewsInfo = (NewsInfoModel) request.getAttribute("reNewsInfo");
	List<DebateInfoModel> listReDi = (List<DebateInfoModel>) request.getAttribute("listReDi");
	
	int likeCnt = (Integer) request.getAttribute("likeCnt");
	int partCnt = (Integer) request.getAttribute("partCnt");
	
	List<ReplyModel> listReply = (List<ReplyModel>) request.getAttribute("listReply");
	String sortType = (String) request.getAttribute("sortType");

	String dateStr[] = newsInfo.getNewsDate().split(" ");
	NumberFormat nf = NumberFormat.getInstance();
	
	UserInfoModel userInfo = (UserInfoModel) session.getAttribute("userInfo");
	int uiNo = -1;		/// 로그인 사용자 번호
	String uiName = "";
	String loginProfile = "img/board-icon-4.png";	/// 사용자 프로필
	if(userInfo != null) {
		uiNo = userInfo.getUiNo();
		uiName = userInfo.getUiName();
		if("".equals(userInfo.getUiProfile())==false)
			loginProfile = "upload/profile/"+userInfo.getUiProfile();
	}
	
	//디스크립션 관련
	String title = newsInfo.getNewsTitle();
	String contents = CryptoSlate.removeTag(newsInfo.getNewsContent());
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
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, width=1920-width">
<link rel="shortcut icon" type="image/x-icon" href="fabicon.ico" />

<meta name="Title" content="<%= title %>">
<meta name="Keyword" content="aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain 엘프커뮤니티 엘프관리자 엘프뉴스 엘프커뮤니티 엘프포럼 엘프캔디 엘프밋업">
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
<meta property="og:url" content="http://www.aelfkorea.io/news.lf?menu=news&mode=list">
<meta name="apple-mobile-web-app-title" content="엘프 코리아">
<meta name="application-name" content="엘프 코리아">

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->


<style type="text/css">
.notice_content img{width: 100% !important;}
</style>


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

</script>

<script type="text/javascript">

/// 공지사항 답글 달기..
function addReply() {
<%if(uiNo == -1) {%>
	alert('로그인이 필요합니다.');
<%} else {%>
	var uiNo = <%=uiNo %>;
	var niNo = '<%=newsInfo.getNewsNo() %>';
	var content = document.getElementById('txt_reply').value;
	
	if(content == '') {
		alert('답글 내용을 입력하세요.');
		return;
	}
	
	var param = "mode=add_reply&ni_no="+niNo+"&ui_no="+uiNo+"&nr_content="+encodeURIComponent(content);
	
	$.ajax({
		type: "POST",
		url: 'news.lf',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
<%} %>
}

/// 답글의 답글 달기...
function addReply2(groupNo, groupOrder, groupLayer, toUiNo) {
<%if(uiNo == -1) {%>
	alert('로그인이 필요합니다.');
<%} else {%>
	var uiNo = <%=uiNo %>;
	var uiName = '<%=uiName %>';
	var niNo = '<%=newsInfo.getNewsNo() %>';
	var content = document.getElementById('txt_'+groupNo).value;
	
	if(content == '') {
		alert('답글 내용을 입력하세요.');
		return;
	}
	
	var param = "mode=add_reply2&ni_no="+niNo
				+"&nr_group_no="+groupNo+"&nr_group_order="+groupOrder+"&nr_group_layer="+groupLayer
				+"&ui_no="+uiNo+"&ui_name="+encodeURIComponent(uiName)+"&nr_content="+encodeURIComponent(content)+"&to_ui_no="+toUiNo;
	
	$.ajax({
		type: "POST",
		url: 'news.lf',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
<%} %>
}

/// 답글의 답글달기 보기 버튼..
function viewReply2(groupNo) {
	document.getElementById('reply_tr_'+groupNo).style.display = '';
}

/// 답글 삭제 버튼..
function deleteReply(nrNo) {
	if(confirm('작성한 답글을 정말 삭제합니까?')==false)
		return;
	
	var param = "mode=delete_reply&nr_no="+nrNo;
	
	$.ajax({
		type: "POST",
		url: 'news.lf',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}


/// 좋아요
function likeHandler(boardNo, boardType, toUiNo) {	
<%if(uiNo == -1) {%>
	alert('로그인이 필요합니다.');
<%} else {%>
	var likeState = '0';
	var uiNo = <%=uiNo %>;
	var uiName = '<%=uiName %>';
	var niNo = '<%=newsInfo.getNewsNo() %>';
	
	//// 먼저 해당 사용자 좋아요 등록했는지 확안...
	var param = "mode=check_like&board_no="+boardNo+"&board_type="+boardType+"&ui_no="+uiNo;
	$.ajax({
		type: "POST",
		url: 'news.lf',
		data: param,
		async: false,
		error: ajaxFailed,
		success: function(ret) {
			likeState = ret;
		}
	});
	
	/// 좋아요 등록한적 없다면 좋아요 등록.
	if(likeState == '0') {
		var param = "mode=add_like&board_no="+boardNo+"&board_type="+boardType+"&ui_no="+uiNo+"&ui_name="+encodeURIComponent(uiName)+"&ni_no="+niNo+"&to_ui_no="+toUiNo;
		$.ajax({
			type: "POST",
			url: 'news.lf',
			data: param,
			error: ajaxFailed,
			success: function(ret) {
				if(ret!='') {
					document.getElementById('span_like').innerHTML = ret.split("|")[0];
					document.getElementById('span_part').innerHTML = ret.split("|")[1]+"명";
				}
				
				alert('좋아요 완료!');
			}
		});
	}
	/// 좋아요 등록한적 있다면 좋아요 취소.
	else {
		if(confirm('이미 등록한 좋아요를 취소 합니까?')==false) {
			return;
		}
		
		var param = "mode=delete_like&board_no="+boardNo+"&board_type="+boardType+"&ui_no="+uiNo;
		$.ajax({
			type: "POST",
			url: 'news.lf',
			data: param,
			error: ajaxFailed,
			success: function(ret) {
				if(ret!='') {
					document.getElementById('span_like').innerHTML = ret.split("|")[0];
					document.getElementById('span_part').innerHTML = ret.split("|")[1]+"명";
				}
				
				alert('좋아요 취소 완료!');
			}
		});
	}
<%} %>
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
		window.open('https://share.naver.com/web/shareView.nhn?url='+url+'&title='+txt);
	}
}

function ajaxFailed(xmlRequest)	{
	alert(xmlRequest.status+"\n\r"+xmlRequest.statusText+"\n\r"+xmlRequest.responseText);
}
</script>

</head>
<body>

	<jsp:include page="../main_top.jsp"></jsp:include>
	
	    <div class="board-wrap">
        <div class="board">
            <div class="board-1">
                <table cellpadding="0" cellspacing="0">
                    <tr height="56">
                        <td colspan="5" style="font-size: 16px; font-weight: 500; border-bottom:1px solid #e0e0e0; padding:10px 20px;" class="notice-td-1"><%=newsInfo.getNewsTitle() %></td>
                    </tr>
                    <tr height="53">
                        <td style="border-bottom:1px solid #e0e0e0; padding-left:20px;">날짜</td>
                        <td style="border-bottom:1px solid #e0e0e0;"><span style="padding:0 10px;">｜</span><%=dateStr[0].substring(2, 4) %>.<%=dateStr[0].substring(5, 7) %>.<%=dateStr[0].substring(8, 10) %></td>
                        <td style="border-bottom:1px solid #e0e0e0;">조회수</td>
                        <td style="border-bottom:1px solid #e0e0e0;"><span style="padding:0 10px;">｜</span><%=nf.format(newsInfo.getNewsView()) %>명</td>
                        <td width="335" style="border-bottom:1px solid #e0e0e0;"></td>
                    </tr>
                    <tr height="190">
                        <td class="notice_content" colspan="5" style="letter-spacing: -0.8px; vertical-align: top; padding-top:20px; padding-bottom:20px; width: 688px; word-break:break-all;  padding-left:20px;  padding-right:20px;"><%=newsInfo.getNewsContent() %></td>
                    </tr>
                    <tr>
                    	<td class="notice-like-wrap" colspan="5">
                    		<img src="img/notice-like.png" onMouseOver="this.src='img/notice-like-on.png'" onMouseOut="this.src='img/notice-like.png'" onclick="javascript:likeHandler(<%=newsInfo.getNewsNo() %>, 'news_info', -1)" alt="" />
                    		<span id="span_like"><%=nf.format(likeCnt) %></span>
                    	</td>
                    </tr>
                    <tr height="40">
                        <td colspan="5"  style="border-bottom:1px solid #e0e0e0;">
                            <table cellpadding="0" cellspacing="0" class="board-action-wrap">
                                <tr height="20">
                                    <td class="notice-personnel" style="padding-left:20px;">참여인원 <span id="span_part"><%=nf.format(partCnt) %>명</span></td>
                                    <td class="notice-share" style="padding-right:20px;">
                                   		<p>공유하기</p>
                                   		<img src="img/notice-kt.png"  onMouseOver="this.src='img/notice-kt-on.png'" onMouseOut="this.src='img/notice-kt.png'" onclick="javascript:sendLink()" alt="" />
                                   		<img src="img/notice-tw.png"  onMouseOver="this.src='img/notice-tw-on.png'" onMouseOut="this.src='img/notice-tw.png'" onclick="javascript:shareSNS('twitter')" alt="" />
                                   		<img src="img/notice-fb.png"  onMouseOver="this.src='img/notice-fb-on.png'" onMouseOut="this.src='img/notice-fb.png'" onclick="javascript:shareSNS('facebook')" alt="" />
                                   		<img src="img/notice-nv.png"  onMouseOver="this.src='img/notice-nv-on.png'" onMouseOut="this.src='img/notice-nv.png'" onclick="javascript:shareSNS('naver')" alt="" />
                                   		<img src="img/notice-gp.png"  onMouseOver="this.src='img/notice-gp-on.png'" onMouseOut="this.src='img/notice-gp.png'" onclick="javascript:shareSNS('google')" alt="" />
                                   		
                               		</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" style="width: 100%;">
                    <tr height="90">
                        <td style="border-bottom:1px solid #e0e0e0;" width="43"></td>
                        <td style="border-bottom:1px solid #e0e0e0;" width="50">
                        	<img src="<%=loginProfile %>" style="border-radius: 50%; width: 50px; height: 50px;" alt="" />
                        </td>
                        <td style="border-bottom:1px solid #e0e0e0;" width="13"></td>
                        <td style="border-bottom:1px solid #e0e0e0; width: 464px;"><input type="text" id="txt_reply" /></td>
                        <td style="border-bottom:1px solid #e0e0e0;" width="20"></td>
                        <td style="border-bottom:1px solid #e0e0e0;"><button onclick="javascript:addReply()">답글달기</button></td>
                        <td style="border-bottom:1px solid #e0e0e0;" width="55"></td>
                    </tr>
                    <%if(listReply.size()>0) { %>
                    <tr height="10">
                    	<td colspan="7" style="padding-left: 5px;">
                    	<%if("desc".equals(sortType)) { %>
                    		<button style="width: 100px; padding: 0px;" onclick="javascript:location.href='news.lf?menu=news&mode=view&news_no=<%=newsInfo.getNewsNo() %>&sort_type=asc'">날짜 순서로</button>
                    	<%} else { %>
                    		<button style="width: 100px; padding: 0px;" onclick="javascript:location.href='news.lf?menu=news&mode=view&news_no=<%=newsInfo.getNewsNo() %>&sort_type=desc'">날짜 역순으로</button>
                    	<%} %>
                    	</td>
                    </tr>
                    <%} %>
                </table>
                
                <div class="board-reply-wrap">
			<%
			for(int i=0; i<listReply.size(); i++) {
				ReplyModel reply = listReply.get(i);
				
				String regTime = "";
				if(reply.getNrDate()!=null) {
					String date = reply.getNrDate().split(" ")[0];
					String time = reply.getNrDate().split(" ")[1];
					
					regTime = Integer.parseInt(date.substring(5, 7))+"월 "+Integer.parseInt(date.substring(8, 10))+"일 ";
					if(Integer.parseInt(time.substring(0, 2))>=12)
						regTime += "오후 ";
					else
						regTime += "오전 ";
					
					int hour = 0;
					if(Integer.parseInt(time.substring(0, 2))==12)
						hour = 12;
					else
						hour = Integer.parseInt(time.substring(0, 2)) %12;
					
					regTime += hour+time.substring(2, 5);
				}
				
				String profile = "img/board-icon-4.png";
				if("".equals(reply.getUiProfile())==false)
					profile = "upload/profile/"+reply.getUiProfile();
				
				String content = reply.getNrContent();
				if(reply.getNrDelete()==1)
					content = "삭제된 답글입니다.";
			%>
			<%if(reply.getNrGroupLayer()==0) { %>
				<table cellpadding="0" cellspacing="0" class="board-reply">
					<colgroup>
						<col width="43" />
						<col width="50" />
						<col width="13" />
						<col width="540" />
					</colgroup>
					<tr height="50">
						<td rowspan="3"></td>
						<td rowspan="3" style="vertical-align: top; padding-top: 30px;"><img src="<%=profile %>" alt="" style="border-radius: 50%; width: 50px; height: 50px;" /></td>
						<td rowspan="3"></td>
						<td style="padding-top:30px; font-size: 16px; font-weight: 500;"><%=reply.getUiName() %><span style="margin-left:10px; font-size: 12px; font-weight: 100;"><%=regTime %></span></td>
					</tr>
					<tr>
						<td style="padding:10px 0;"><%=content %></td>
					</tr>
					<tr height="22">
						<td style="padding-bottom:12px;">
							<table cellpadding="0" cellspacing="0" style="width: 100%;">
								<tr>
									<td>
									<%if(reply.getNrDelete()==0) { %>
										<button onclick="javascript:likeHandler(<%=reply.getNrNo() %>, 'news_reply', <%=reply.getUiNo() %>)">좋아요</button>&nbsp;&nbsp;
										<button onclick="javascript:viewReply2(<%=reply.getNrGroupNo() %>)">답글달기</button>
										<%if(uiNo!=-1 && uiNo==reply.getUiNo()) { %>
										&nbsp;&nbsp;&nbsp;<button onclick="javascript:deleteReply(<%=reply.getNrNo() %>)">삭제하기</button>
										<%} %>
									<%} %>
									</td>
								</tr>
								<tr id="reply_tr_<%=reply.getNrNo() %>" style="display: none;">
									<td>
										<input type="text" id="txt_<%=reply.getNrNo() %>" />
										<button onclick="javascript:addReply2(<%=reply.getNrGroupNo() %>, <%=reply.getNrGroupOrder() %>, <%=reply.getNrGroupLayer() %>, <%=reply.getUiNo() %>)">작성</button>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			<%} else { %>
				<table cellpadding="0" cellspacing="0" class="board-reply">
					<colgroup>
						<col width="63" />
						<col width="50" />
						<col width="13" />
						<col width="520" />
					</colgroup>
					<tr height="50">
						<td rowspan="3" style="text-align: right; vertical-align: top; padding-top: 30px; padding-right: 10px;">ㄴ</td>
						<td rowspan="3" style="vertical-align: top; padding-top: 30px;"><img src="<%=profile %>" alt="" style="border-radius: 50%; width: 50px; height: 50px;" /></td>
						<td rowspan="3"></td>
						<td style="padding-top:30px; font-size: 16px; font-weight: 500;"><%=reply.getUiName() %><span style="margin-left:10px; font-size: 12px; font-weight: 100;"><%=regTime %></span></td>
					</tr>
					<tr>
						<td style="padding:10px 0;"><%=content %></td>
					</tr>
					<tr height="22">
						<td style="padding-bottom:12px;">
							<table cellpadding="0" cellspacing="0" style="width: 100%;">
								<tr>
									<td>
									<%if(reply.getNrDelete()==0) { %>
										<button onclick="javascript:likeHandler(<%=reply.getNrNo() %>, 'news_reply', <%=reply.getUiNo() %>)">좋아요</button>
										<%if(uiNo!=-1 && uiNo==reply.getUiNo()) { %>
										<button onclick="javascript:deleteReply(<%=reply.getNrNo() %>)">삭제하기</button>
										<%} %>
									<%} %>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			<%} %>
			<%
			}
			%>
				</div>
				
                <!-- 
                <table cellpadding="0" cellspacing="0" width="100%" class="board-plus">
                    <tr height="30">
                        <td style="text-align: center;">▼ 답글 더보기</td>
                    </tr>
                </table>
                 -->
                                
            </div>
            <div class="board-2">
            	<%if(reNi.getNiNo() != -1){ %>
	                <table cellpadding="0" cellspacing="0">
	                    <tr>
	                        <td style="font-size: 16px; font-weight: 400;">AELF NOTICE</td>
	                    </tr>
	                    <tr height="13"></tr>
	                    <tr>
	                        <td style="cursor: pointer;" onclick="javascript: location.href='notice.lf?menu=notice&mode=view&ni_no=<%=reNi.getNiNo()%>'"><img src="upload/notice/<%=reNi.getNiNo() %>/<%=reNi.getNiThumbnail() %>" alt="" style="width: 274px;" /></td>
	                    </tr>
	                </table>
                <%} %>
                
                <%if(reNewsInfo.getNewsNo() != -1){ %>
	                <table cellpadding="0" cellspacing="0">
	                    <tr>
	                        <td style="font-size: 16px; font-weight: 400;">AELF NEWS</td>
	                    </tr>
	                    <tr height="13"></tr>
	                    <tr>
	                        <td style="cursor: pointer;" onclick="javascript: location.href='news.lf?menu=news&mode=view&news_no=<%=reNewsInfo.getNewsNo()%>'"><img src="upload/news/<%=reNewsInfo.getNewsNo() %>/<%=reNewsInfo.getNewsThumbnail() %>" alt="" style="width: 274px;" /></td>
	                    </tr>
	                </table>
                <%} %>
                
               <%if(reCi.getCiNo() != -1){
                	if("video".equals(reCi.getCcName())){
                	%>
	                <table cellpadding="0" cellspacing="0">
	                    <tr>
	                        <td style="font-size: 16px; font-weight: 400;">CONTENT</td>
	                    </tr>
	                    <tr height="13"></tr>
	                    <tr>
	                        <td style="cursor: pointer;" onclick="javascript: goModal2(<%=reCi.getCiNo()%>)"><img src="upload/content/<%=reCi.getCiNo()%>/<%=reCi.getCiThumbnail() %>" alt="" style="width: 274px;" /></td>
	                    </tr>
	                </table>
	                <%}else{ %>
	                <table cellpadding="0" cellspacing="0">
	                    <tr>
	                        <td style="font-size: 16px; font-weight: 400;">CONTENT</td>
	                    </tr>
	                    <tr height="13"></tr>
	                    <tr>
	                        <td style="cursor: pointer;" onclick="javascript: goModal(<%=reCi.getCiNo()%>)"><img src="upload/content/<%=reCi.getCiNo()%>/<%=reCi.getCiThumbnail() %>" alt="" style="width: 274px;" /></td>
	                    </tr>
	                </table>
                	<%}
                }%>
                
                <%if(listReDi.size()>0) { %> 
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="font-size: 16px; font-weight: 400;">토론방</td>
                    </tr>
                    <tr>
                        <td>
                            <ul>
                            <%for(int i=0; i<listReDi.size(); i++) { %>
                                <li><a href="debate.lf?menu=debate&mode=view&di_no=<%=listReDi.get(i).getDiNo() %>" class="one_tit_a">· <%=listReDi.get(i).getDiTitle() %></a></li>
                            <%} %>
                            </ul>
                        </td>
                    </tr>
                </table>
                <%} %>
            </div>
        </div>
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>




<script type='text/javascript'>
var url = window.location.href;
var txt = "<%=newsInfo.getNewsTitle() %>";

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
          imageUrl: 'http://www.atarad.io/aelf/upload/news/<%=newsInfo.getNewsNo()%>/<%=newsInfo.getNewsThumbnail()%>',
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