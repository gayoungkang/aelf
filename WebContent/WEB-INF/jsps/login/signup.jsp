<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
String name = request.getParameter("name");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AELF</title>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, width=1920-width">
<link rel="shortcut icon" type="image/x-icon" href="fabicon.ico" />


 <meta property="og:title" content="AELF">
 <meta property="og:image" content="img/og_thumbnail.jpg">
 <meta property="og:url" content="http://www.aelfkorea.io">
<meta name="description" content="AELF">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="js/jquery.form.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->

</head>
<body>

	<jsp:include page="../main_top.jsp"></jsp:include>

	
    <div class="signup-warp">
        <div class="signup">
            <table cellpadding="0" cellspacing="0">
                <tr height="1">
                    <td rowspan="2" width="80"><img src="img/signup-icon.png" id="img_profile" alt="" style="margin-left:37px; margin-right: 19px; border-radius: 50%; width: 80px; height: 80px;"/></td>
                    <td style="font-size:16px; vertical-align: bottom; letter-spacing: -1px;">Aelf에 오신 것을 환영합니다!</td>
                </tr>
                <tr height="1">
                    <td colspan="2"><button class="sigup-btn-pic" onclick="javascript:viewSelProfile()">프로필 사진추가</button></td>
                </tr>
                <tr height="1" id="tr_img" style="display: none;">
                    <td colspan="2" style="text-align: right;">
	                    <form id="ajaxForm1" action="ajaxprofile.lf" method="post" enctype="multipart/form-data">
							<input type="file" id="img_file1" name="img_file" style="width: 70%;" />
							<input type="hidden" id="old_file1" name="old_file" value="" />
							<button type="submit" class="sigup-btn-pic" style="width: 15%;">적용</button>
						</form>
                    </td>
                </tr>
                <tr height="21"></tr>
			</table>
			
		<form action="login.lf" method="post" onsubmit="javascript: return checkSubmit()">
			<input type="hidden" name="mode" value="signup" />
			<input type="hidden" id="u_id" name="u_id" value="<%=id %>">
			<input type="hidden" id="u_name" name="u_name" value="<%=name %>">
			<input type="hidden" id="u_profile" name="u_profile" value="">
            <table cellpadding="0" cellspacing="0">    
                <!--
                
                <tr>
                    <td colspan="2" style="font-size:14px; font-weight: 400;">ID<span style="font-size:12px; color:#35b1ff; font-weight: 200; padding-left: 12px;">* 중복된 ID입니다.</span></td>
                </tr>
                <tr height="11"></tr>
                <tr>
                    <td colspan="2"><input type="text" placeholder="ID 입력" /></td>
                </tr>
                <tr height="10"></tr>
                <tr>
                    <td colspan="2"><button class="signup-btn-id">ID 중복확인</button></td>
                </tr>
                <tr height="21"></tr>
                <tr>
                    <td colspan="2" style="font-size:14px; font-weight: 400;">PW<span style="font-size:12px; color:#35b1ff; font-weight: 200; padding-left: 12px;">10자 이상으로 입력해 주십시오.</span></td>
                </tr>
                <tr height="11"></tr>
                <tr>
                    <td colspan="2"><input type="text" placeholder="비밀번호" /></td>
                </tr>
                <tr height="9"></tr>
                <tr>
                    <td colspan="2"><input type="text" placeholder="비밀번호 확인" /></td>
                </tr>
                <tr height="24"></tr>
                
                 -->
                
                <tr>
                    <td colspan="2" style="font-size:14px; font-weight: 400;">유입경로</td>
                </tr>
                <tr height="10"></tr>
                <tr>
                    <td colspan="2" class="signup-sns-list">                    	
                        <table cellpadding="0" cellspacing="0">
                            <colgroup>
                                <col width="60px" />
                                <col width="80px" />
                                <col width="60px" />
                                <col width="80px" />
                                <col width="70px" />
                            </colgroup>
                            <tr height="21"></tr>
                            <tr height="16">
                                <td></td>
                                <td>
                                	<img src="img/login-check-off.png" alt="" class="bt1" id="img_chk1" onclick="javascript:onClickCheck(1)" />Facebook
                                	<input type="hidden" id="bt1" name="bt1" value="0" />
                                </td>
                                <td></td>
                                <td>
                                	<img src="img/login-check-off.png" alt="" class="bt1" id="img_chk2" onclick="javascript:onClickCheck(2)" />Instagram
                                	<input type="hidden" id="bt2" name="bt2" value="0" />
                                </td>
                                <td></td>
                            </tr>
                            <tr height="15"></tr>
                            <tr height="16">
                                <td></td>
                                <td>
                                	<img src="img/login-check-off.png" alt="" class="bt1" id="img_chk3" onclick="javascript:onClickCheck(3)" />Naver
                                	<input type="hidden" id="bt3" name="bt3" value="0" />
                                </td>
                                <td></td>
                                <td>
                                	<img src="img/login-check-off.png" alt="" class="bt1" id="img_chk4" onclick="javascript:onClickCheck(4)" />검색
                                	<input type="hidden" id="bt4" name="bt4" value="0" />
                                </td>
                                <td></td>
                            </tr>
                            <tr height="15"></tr>
                            <tr height="16">
                                <td></td>
                                <td>
                                	<img src="img/login-check-off.png" alt="" class="bt1" id="img_chk5" onclick="javascript:onClickCheck(5)" />Youtube
                                	<input type="hidden" id="bt5" name="bt5" value="0" />
                                </td>
                                <td></td>
                                <td>
                                	<img src="img/login-check-off.png" alt="" class="bt1" id="img_chk6" onclick="javascript:onClickCheck(6)" />Twitter
                                	<input type="hidden" id="bt6" name="bt6" value="0" />
                                </td>
                                <td></td>
                            </tr>
                            <tr height="15"></tr>
                            <tr height="16">
                                <td></td>
                                <td>
                                	<img src="img/login-check-off.png" alt="" class="bt1" id="img_chk7" onclick="javascript:onClickCheck(7)" />뉴스
                                	<input type="hidden" id="bt7" name="bt7" value="0" />
                                </td>
                                <td></td>
                                <td>
                                	<img src="img/login-check-off.png" alt="" class="bt1" id="img_chk8" onclick="javascript:onClickCheck(8)" />추천
                                	<input type="hidden" id="bt8" name="bt8" value="0" />
                                </td>
                                <td></td>
                            </tr>
                            <tr height="21"></tr>
                        </table>
                    </td>
                </tr>
                <tr height="7"></tr>
                <tr>
                	<td colspan="2" style="font-size:14px; font-weight: 400;">이용약관</td>
                </tr>
                <tr height="10"></tr>
                <tr height="256">
                	<td colspan="2" style="background-color:#fff; padding:20px 10px 20px 20px; border-radius:5px; border:1px solid #e0e0e0;">
	                	<div style="height: 256px; overflow-y: scroll;">
	    	            	<span style="font-size:12px; letter-spacing: -1px;">
		        	        	본 약관(이하 ‘본 약관’이라 함)은 LINE주식회사(이하 ‘당사’라 함)가 제공하는 네이버 라인에 관한 모든 제품 및 서비스(이하 ‘본 서비스’라 함)의 이용에 관한 조건에 대해 본 서비스를 이용하는 고객(이하 ‘고객’이라 함)과 당사간에 정하는 것입니다.<br><br>1. 정의<br><br>본 약관에서는 다음 용어를 사용합니다.<br>1.1. ‘콘텐츠’란 문장, 음성, 음악, 이미지, 동영상, 소프트웨어, 프로그램, 코드 기타 정보를 말합니다.<br>1.2. ‘본 콘텐츠’란 본 서비스를 통해 접속할 수 있는 콘텐츠를 말합니다.<br>1.3. ‘투고 콘텐츠’란 고객이 본 서비스에 투고, 송신, 업로드한 콘텐츠를 말합니다.<br>1.4. ‘코인’이란 본 서비스가 유상으로 제공하는 서비스 또는 콘텐츠와 교환 가능한 전자적 가상통화를 말합니다.<br>1.5. ‘개별 이용약관’이란 본 서비스에 관하여 본 약관과는 별도로 ‘약관’, 가이드라인’, ‘정책’ 등의 명칭으로 당사가 배포 또는 게시한 문서를 말합니다.<br><br>2. 약관 동의<br><br>2.1 고객은 본 약관의 규정에 따라 본 서비스를 이용해야 합니다. 고객은 본 약관에 대해 유효하고 취소 불가능한 동의를 했을 경우에 한하여 본 서비스를 이용할 수 있습니다.<br>2.2. 고객이 미성년자일 경우에는 친권자 등 법정대리인의 동의를 얻은 후 본 서비스를 이용하십시오. 또한 고객이 본 서비스를 사업자를 위해 이용할 경우에는 당해 사업자 역시 본 약관에 동의한 후, 본 서비스를 이용하십시오.<br>2.3. 고객은 본 서비스를 실제로 이용함으로써 본 약관에 대해 유효하고 취소 불가능한 동의를 한 것으로 간주됩니다.<br>2.4. 본 서비스에 개별 이용약관이 존재할 경우, 고객은 본 약관 외에 개별 이용약관의 규정에 따라 본 서비스를 이용해야 합니다.<br><br>3. 약관 변경<br><br>필요하다고 당사에서 판단할 경우, 당사는 고객에 대한 사전 통지 없이 언제라도 본 약관 및 개별 이용약관을 변경할 수 있습니다. 변경 후의 본 약관 및 개별 이용약관은 당사가 운영하는 웹사이트 내의 적절한 장소에 게시된 시점부터 그 효력이 발생하며, 본 약관 및 개별 이용약관이 변경된 후에도 고객이 본 서비스를 계속 이용함으로써 변경 후의 본 약관 및 적용된 개별 이용약관에 대해 유효하고 취소 불가능한 동의를 한 것으로 간주됩니다. 이러한 변경 내용은 고객에게 개별적으로 통지할 수 없기 때문에, 본 서비스를 이용할 때에는 수시로 최신의 본 약관 및 적용된 개별 이용약관을 참조하시기 바랍니다.
	        	        	</span>
        	        	</div>
                	</td>
                </tr>
                <tr height="7"></tr>
                <tr>
                    <td colspan="2">
                    	<img src="img/login-check-off.png" alt=""  class="bt1" id="img_chk9" onclick="javascript:onClickCheck(9)" 
                    			style="cursor: pointer; vertical-align: middle; margin-right: 10px;"/>본인은 이용약관을 읽고 동의했습니다.
                    	<input type="hidden" id="bt9" value="0" />
                    </td>
                </tr>
                <tr height="20"></tr>
                <tr>
                    <td colspan="2" style="text-align: center;"><button type="submit" class="signup-btn-next">다음</button></td>
                </tr>
            </table>    
    	</form>
    	
        </div>
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>
    
    
<script type="text/javascript">

$(function() {
	$('#ajaxForm1').ajaxForm({
		beforeSubmit: function(data, form, option) {			
			if($('#img_file1').val() == '') {
				alert('파일을 선택하세요.');
				return false;
			}
			
			var IMG_FORMAT = "\.(bmp|gif|jpg|jpeg|png)$";
		    if((new RegExp(IMG_FORMAT, "i")).test($('#img_file1').val())==false) {
		    	alert('JPG, GIF, PNG, BMP 확장자만 가능합니다');
		    	return false;
		    }
			
			return true;
		},
		success: function(response, status) {
			if($.trim(response)=='[false]') {	// 파일 첨부 실피
				alert('파일 용량 등의 이유로 첨부할 수 없습니다.');
				
			} else {							// 파일 첨부 성공
				
				document.getElementById('img_profile').src = "upload/profile/"+$.trim(response);
				document.getElementById('old_file1').value = $.trim(response);
				document.getElementById('u_profile').value = $.trim(response);
			}
			
			/// 파일 선택 영역 초기화
			if(/(MSIE|Trident)/.test(navigator.userAgent)) {
				$("#img_file1").replaceWith( $("#img_file1").clone(true) );
			} else {
				$("#img_file1").val("");
			}
		},
		error: function() {
			alert("error");
		}
	});
});


function viewSelProfile() {
	if(document.getElementById('tr_img').style.display == '') {
		document.getElementById('tr_img').style.display = 'none';
	} else {
		document.getElementById('tr_img').style.display = '';
	}
}


function checkSubmit() {
	if(document.getElementById('bt9').value == '0') {
		alert('약관에 동의하세요.');
		return false;
	}
	
	return true;
}


function onClickCheck(idx) {
	if(idx!=9) {
		for(var i=1; i<=8; i++) {
			document.getElementById('bt'+i).value = '0';
			document.getElementById('img_chk'+i).src = 'img/login-check-off.png';
		}
	}
	
	if(document.getElementById('bt'+idx).value=='1') {
		document.getElementById('bt'+idx).value = '0';
		document.getElementById('img_chk'+idx).src = 'img/login-check-off.png';
	}
	else {
		document.getElementById('bt'+idx).value = '1';
		document.getElementById('img_chk'+idx).src = 'img/login-check-on.png';
	}
}

</script>

</body>
</html>