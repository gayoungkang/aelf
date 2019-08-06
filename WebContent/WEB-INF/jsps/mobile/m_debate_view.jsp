<%@page import="model.ReplyModel"%>
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
String dateStr[] = di.getDiDate().split(" ");

NoticeInfoModel reNi = (NoticeInfoModel) request.getAttribute("reNi");
ContentInfoModel reCi = (ContentInfoModel) request.getAttribute("reCi");
NewsInfoModel reNresInfo = (NewsInfoModel) request.getAttribute("reNresInfo");
List<DebateInfoModel> listReDi = (List<DebateInfoModel>) request.getAttribute("listReDi");

int partCnt = (Integer) request.getAttribute("partCnt");
int likeCnt = (Integer) request.getAttribute("likeCnt");
int dislikeCnt = (Integer) request.getAttribute("dislikeCnt");
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

    <style>
        /* 글 반응 */
        .notice-top-like-wrap:after{
            display: block;
            content: '';
            clear: both;       
        }
        .notice-top-like-wrap{
            margin:0 auto;
            width: 90px;
        }
        .notice-top-like{
            float: left;
            margin-right: 10px;
        }
        .notice-top-like:last-child{
            margin-right: 0;
        }
        .notice-top-like span{
            color:#000;
        }
        .notice-tx img{width: 100%;}
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

/// 공지사항 답글 달기..
function addReply() {
<%if(uiNo == -1) {%>
	alert('로그인이 필요합니다.');
<%} else {%>
	var uiNo = <%=uiNo %>;
	var uiName = '<%=uiName %>';
	var toUiNo = <%=di.getUiNo() %>;
	var niNo = '<%=di.getDiNo() %>';
	var content = document.getElementById('txt_reply').value;
	
	if(content == '') {
		alert('답글 내용을 입력하세요.');
		return;
	}
	
	var param = "mode=add_reply&ni_no="+niNo+"&ui_no="+uiNo+"&ui_name="+encodeURIComponent(uiName)+"&nr_content="+encodeURIComponent(content)+"&to_ui_no="+toUiNo;
	
	$.ajax({
		type: "POST",
		url: 'debate.lf',
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
	var niNo = '<%=di.getDiNo() %>';
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
		url: 'debate.lf',
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
		url: 'debate.lf',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}


/// 토론 찬반
function agreeHandler(boardNo, boardType, liType) {
<%if(uiNo == -1) {%>
	alert('로그인이 필요합니다.');
<%} else {%>
	var uiNo = <%=uiNo %>;
	var uiName = '<%=uiName %>';
	var toUiNo = <%=di.getUiNo() %>;
	var comment = '정말 찬성합니까?';
	
	if(liType == 'dislike')
		comment = '정말 반대합니까?';
	
	if(confirm(comment)==false) {
		return;
	}
	
	var param = "mode=set_agree&board_no="+boardNo+"&board_type="+boardType+"&li_type="+liType+"&ui_no="+uiNo+"&ui_name="+encodeURIComponent(uiName)+"&to_ui_no="+toUiNo;
	$.ajax({
		type: "POST",
		url: 'debate.lf',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			if(ret!='') {
				document.getElementById('span_like').innerHTML = ret.split("|")[0];
				document.getElementById('span_dislike').innerHTML = ret.split("|")[1];
				document.getElementById('span_part').innerHTML = ret.split("|")[2]+"명";
			}
			
			alert('반영 완료!');
		}
	});
<%} %>
}


/// 좋아요
function likeHandler(boardNo, boardType, toUiNo) {	
<%if(uiNo == -1) {%>
	alert('로그인이 필요합니다.');
<%} else {%>
	var likeState = '0';
	var uiNo = <%=uiNo %>;
	var uiName = '<%=uiName %>';
	var niNo = '<%=di.getDiNo() %>';
	
	//// 먼저 해당 사용자 좋아요 등록했는지 확안...
	var param = "mode=check_like&board_no="+boardNo+"&board_type="+boardType+"&ui_no="+uiNo;
	$.ajax({
		type: "POST",
		url: 'debate.lf',
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
			url: 'debate.lf',
			data: param,
			error: ajaxFailed,
			success: function(ret) {
				if(ret!='') {
					document.getElementById('span_like').innerHTML = ret.split("|")[0];
					document.getElementById('span_dislike').innerHTML = ret.split("|")[1];
					document.getElementById('span_part').innerHTML = ret.split("|")[2]+"명";
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
			url: 'debate.lf',
			data: param,
			error: ajaxFailed,
			success: function(ret) {
				if(ret!='') {
					document.getElementById('span_like').innerHTML = ret.split("|")[0];
					document.getElementById('span_dislike').innerHTML = ret.split("|")[1];
					document.getElementById('span_part').innerHTML = ret.split("|")[2]+"명";
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
                    <div class="notice-title"><%=di.getDiTitle() %></div>
                    <div class="notice-top-info-wrap">
                        <div class="notice-top-info">
                            <p>날짜</p>
                            <p><%=dateStr[0].substring(2, 4) %>.<%=dateStr[0].substring(5, 7) %>.<%=dateStr[0].substring(8, 10) %></p>
                            <p>조회수</p>
                            <p><%=nf.format(di.getDiView()) %>명</p>
                        </div>
                    </div>
                    <div class="notice-tx"><%=di.getDiContent() %></div>
                    <div class="notice-top-like-wrap">
                        <div class="notice-top-like">
                            <img src="m-img/sns-up.png" alt="" onclick="javascript:agreeHandler(<%=di.getDiNo() %>, 'debate_info', 'like')" />
                            <span><%=nf.format(likeCnt) %></span>
                        </div>
                        <div class="notice-top-like">
                            <img src="m-img/sns-down.png" alt="" onclick="javascript:agreeHandler(<%=di.getDiNo() %>, 'debate_info', 'dislike')" />
                            <span><%=nf.format(dislikeCnt) %></span>
                        </div>
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
								<span class="notice-re-like" onclick="javascript:likeHandler(<%=reply.getNrNo() %>, 'debate_reply', <%=reply.getUiNo() %>)">좋아요</span>
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
										<span class="notice-re-like" onclick="javascript:likeHandler(<%=reply.getNrNo() %>, 'debate_reply', <%=reply.getUiNo() %>)">좋아요</span>
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
    
    
</body>
</html>