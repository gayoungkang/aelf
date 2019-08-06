<%@page import="util.CryptoSlate"%>
<%@page import="model.UserInfoModel"%>
<%@page import="model.ReplyModel"%>
<%@page import="model.DebateInfoModel"%>
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
String dateStr[] = ni.getNiDate().split(" ");

NoticeInfoModel reNi = (NoticeInfoModel) request.getAttribute("reNi");
ContentInfoModel reCi = (ContentInfoModel) request.getAttribute("reCi");
NewsInfoModel reNresInfo = (NewsInfoModel) request.getAttribute("reNresInfo");
List<DebateInfoModel> listReDi = (List<DebateInfoModel>) request.getAttribute("listReDi");

//int replyCnt = (Integer) request.getAttribute("replyCnt");
int partCnt = (Integer) request.getAttribute("partCnt");
int likeCnt = (Integer) request.getAttribute("likeCnt");
List<ReplyModel> listReply = (List<ReplyModel>) request.getAttribute("listReply");
String sortType = (String) request.getAttribute("sortType");

NumberFormat nf = NumberFormat.getInstance();

UserInfoModel userInfo = (UserInfoModel) session.getAttribute("userInfo");
int uiNo = -1;		/// 로그인 사용자 번호
String uiName = "";
String loginProfile = "m-img/notice-re-person.png";	/// 사용자 프로필
if(userInfo != null) {
	uiNo = userInfo.getUiNo();
	uiName = userInfo.getUiName();
	if("".equals(userInfo.getUiProfile())==false)
		loginProfile = "upload/profile/"+userInfo.getUiProfile();
}

String Contents = CryptoSlate.removeTag(ni.getNiContent());
Contents = Contents.replaceAll("&nbsp", "");
Contents = Contents.replaceAll("\n", "");
Contents = Contents.replaceAll("\r", "");
Contents = Contents.replaceAll("<br>", "");


if(Contents.length() > 300){
	Contents = Contents.substring(0 , 300);	
} 

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

<meta name="Title" content="<%=ni.getNiTitle()%>">
<meta name="Keyword" content="aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain 엘프이벤트  엘프퀴즈 엘프QR 엘프QR코드 엘프QR코드찾기 엘프상품 엘프커뮤니티 엘프오픈채팅 엘프밋업 엘프카카오톡 엘프카톡 엘프텔레그램 엘프텔레 엘프관리자 엘프포럼 엘프캔디">
<meta name="Description" content="<%=Contents%>">
<meta name="Author" content="Daniel Gong">

<meta itemprop="name" content="엘프 코리아">
<meta itemprop="description" content="<%=Contents%>">
<meta itemprop="image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">

<meta property="og:type" content="website">
<meta property="og:site_name" content="AELF KOREA">
<meta property="og:title" content="<%=ni.getNiTitle()%>">
<meta property="og:description" content="<%=Contents%>">
<meta property="og:image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io/notice.lf?menu=notice">

<meta name="apple-mobile-web-app-title" content="<%=ni.getNiTitle()%>">
<meta name="application-name" content="엘프 코리아">


<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="js/jquery-ui.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-m-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->
<link rel="stylesheet" href="//fonts.googleapis.com/earlyaccess/nanummyeongjo.css"><!-- 나눔명조 웹폰트 -->

    <style>
        .notice-top{
            margin:20px 0 100px 0;
        }
        .notice-tx img{
        	width: 100%;
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


///////////////////////////////////////////////////////////
/// 공지사항 답글 달기..
function addReply() {
<%if(uiNo == -1) {%>
	alert('로그인이 필요합니다.');
<%} else {%>
	var uiNo = <%=uiNo %>;
	var niNo = '<%=ni.getNiNo() %>';
	var content = document.getElementById('txt_reply').value;
	
	if(content == '') {
		alert('답글 내용을 입력하세요.');
		return;
	}
	
	var param = "mode=add_reply&ni_no="+niNo+"&ui_no="+uiNo+"&nr_content="+encodeURIComponent(content);
	
	$.ajax({
		type: "POST",
		url: 'notice.lf',
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
	var niNo = '<%=ni.getNiNo() %>';
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
		url: 'notice.lf',
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
		url: 'notice.lf',
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
	var niNo = '<%=ni.getNiNo() %>';
	
	//// 먼저 해당 사용자 좋아요 등록했는지 확안...
	var param = "mode=check_like&board_no="+boardNo+"&board_type="+boardType+"&ui_no="+uiNo;
	$.ajax({
		type: "POST",
		url: 'notice.lf',
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
			url: 'notice.lf',
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
			url: 'notice.lf',
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
		window.open('http://blog.naver.com/openapi/share?url='+url+'&title='+txt);
	}
	else if(sns == 'kakao') {
	}
}

function ajaxFailed(xmlRequest)	{
	alert(xmlRequest.status+"\n\r"+xmlRequest.statusText+"\n\r"+xmlRequest.responseText);
}

</script>

</head>
<body>

	<jsp:include page="./m_top.jsp"></jsp:include>
    
   <div class="page-up" id="up_btn" style="display: none;">
        <img src="m-img/page-up.png" alt="" onclick="javascript:topBtn()" />
    </div>
    
    <div class="notice-wrap notice-on-wrap">
        <div class="notice notice-on">
            
            <div class="notice-top-wrap">
                <div class="notice-top">
                    <p class="notice-title"><%=ni.getNiTitle() %></p>
                    <div class="notice-top-info-wrap">
                        <div class="notice-top-info">
                            <p>날짜</p>
                            <p><%=dateStr[0].substring(2, 4) %>.<%=dateStr[0].substring(5, 7) %>.<%=dateStr[0].substring(8, 10) %></p>
                            <p>조회수</p>
                            <p><%=nf.format(ni.getNiView()) %>명</p>
                        </div>
                    </div>
                    <div class="notice-tx" style=" word-break:break-all;"><%=ni.getNiContent() %></div>
                    <div class="notice-top-like">
                        <img src="m-img/notice-like.png" alt="" onclick="javascript:likeHandler(<%=ni.getNiNo() %>, 'notice_info', -1)" />
                        <span><%=nf.format(likeCnt) %></span>
                    </div>
                    <div class="notice-sns-wrap">
                        <div class="notice-sns">
                            <img src="m-img/sns-kakao.png" alt="" onclick="javascript:sendLink()" />
                            <img src="m-img/sns-twitter.png" alt="" onclick="javascript:shareSNS('twitter')" />
                            <img src="m-img/sns-facebook.png" alt="" onclick="javascript:shareSNS('facebook')" />
                            <img src="m-img/sns-naver.png" alt="" onclick="javascript:shareSNS('naver')" />
                            <img src="m-img/sns-telegram.png" alt="" onclick="javascript:shareSNS('google')" />
                        </div>
                    </div>
                    
                    <div class="notice-re">
                        <div class="notice-re-top-wrap">
                            <div class="notice-re-top">
                                <img src="<%=loginProfile %>" style="border-radius: 50%;" alt="" width="40px" height="40px" />
                                <div class="notice-re-input-wrap">
                                    <input type="text" id="txt_reply" />
                                    <button onclick="javascript:addReply()">답글달기</button>
                                </div>
                            </div>
                        </div>

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
				
				String profile = "m-img/notice-re-person.png";
				if("".equals(reply.getUiProfile())==false)
					profile = "upload/profile/"+reply.getUiProfile();
				
				String content = reply.getNrContent();
				if(reply.getNrDelete()==1)
					content = "삭제된 답글입니다.";
			%>
			<%if(reply.getNrGroupLayer()==0) { %>
                        <div class="notice-re-mid">
                            <div class="notice-re-mid-img-wrap">
                                <img src="<%=profile %>" style="border-radius: 50%;" alt="" width="40px" height="40px" />
                            </div>
                            <p class="notice-re-name"><%=reply.getUiName() %><span><%=regTime %></span></p>
                            <p class="notice-re-tx"><%=content %></p>
                            <div class="notice-re-mid-reaction">
                                
							<%if(reply.getNrDelete()==0) { %>
								<span class="notice-re-like" onclick="javascript:likeHandler(<%=reply.getNrNo() %>, 'notice_reply', <%=reply.getUiNo() %>)">좋아요</span>
                                <span class="notice-re-input" onclick="javascript:viewReply2(<%=reply.getNrGroupNo() %>)">답글달기</span>
								<%if(uiNo!=-1 && uiNo==reply.getUiNo()) { %>
								&nbsp;&nbsp;&nbsp;<span class="notice-re-like" onclick="javascript:deleteReply(<%=reply.getNrNo() %>)">삭제하기</span>
								<%} %>
							<%} %>
                            </div>
                            
                            <div class="notice-re-top" id="reply_tr_<%=reply.getNrNo() %>" style="display: none;">
                                <div class="notice-re-input-wrap">
                                    <input type="text" id="txt_<%=reply.getNrNo() %>" />
                                    <button onclick="javascript:addReply2(<%=reply.getNrGroupNo() %>, <%=reply.getNrGroupOrder() %>, <%=reply.getNrGroupLayer() %>, <%=reply.getUiNo() %>)">답글달기</button>
                                </div>
                            </div>
                        </div>
			<%} else { %>                            
                        <div class="notice-re-mid">
                            <div class="notice-re-mid-wrap">                            
                            	<div class="notice-re-mid">
		                            <div class="notice-re-mid-img-wrap">
		                            	<p>└</p>
		                                <img src="<%=profile %>" style="border-radius: 50%;" alt="" width="40px" height="40px" />
		                            </div>
		                            <p class="notice-re-name"><%=reply.getUiName() %><span><%=regTime %></span></p>
		                            <p class="notice-re-tx"><%=content %></p>
		                            <div class="notice-re-mid-reaction">
		                            <%if(reply.getNrDelete()==0) { %>
										<span class="notice-re-like" onclick="javascript:likeHandler(<%=reply.getNrNo() %>, 'notice_reply', <%=reply.getUiNo() %>)">좋아요</span>
										<%if(uiNo!=-1 && uiNo==reply.getUiNo()) { %>
										<span class="notice-re-like" onclick="javascript:deleteReply(<%=reply.getNrNo() %>)">삭제하기</span>
										<%} %>
									<%} %>
		                            </div>		                            
		                        </div>		                        
                            </div>                            
                        </div>
			<%
			}
		}
			%>
<!-- 
                        <div class="notice-re-bottom">
                            <p class="notice-refresh">▼ 답글 더보기</p>
                        </div>
 -->        

                    </div>
                </div>
                
            </div>
            
        </div>
    </div>
    
    <jsp:include page="./m_footer.jsp"></jsp:include>
    
    
<script type='text/javascript'>
var url = window.location.href;
var txt = "<%=ni.getNiTitle() %>";

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
          imageUrl: 'http://www.atarad.io/aelf/upload/notice/<%=ni.getNiNo()%>/<%=ni.getNiThumbnail()%>',
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