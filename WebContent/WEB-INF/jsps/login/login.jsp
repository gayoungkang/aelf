<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String url = request.getParameter("url");
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

</head>
<style>
#naverIdLogin > a > img {  margin-top:0; opacity:0; }
#naverIdLogin { position: relative; background: url('./img/sns-nv.png') 20px center  #fff no-repeat; }
#naverIdLogin:hover {  background-color: #f2f2f2;}
#naverIdLogin:before { content:"네이버 계정으로 로그인"; clear:both; position: absolute; left:70px; display:block; font-weight:600; }
#naverIdLogin > a {position: relative;}
#naverIdLogin > a:before {content:""; clear:both; position: absolute; top:24px;  left:61px; width:1px; height:15px; display:block;  background-color:#e4e4e4; }

</style>
<body>

	<jsp:include page="../main_top.jsp"></jsp:include>

    <div class="login-wrap">
        <div class="login">
        	<form action="login.lf" method="post">
        		<input type="hidden" name="mode" value="login" />
        		<input type="hidden" name="url" value="<%=url %>" />
        		
            <table cellpadding="0" cellspacing="0" class="login-sns-wrap">
                <tr>
                    <td><img src="img/aelf-login-logo.png" alt="엘프 로그인" /></td>
                </tr>
                <tr height="100"></tr>
                <tr height="60">
                	<td class="login-sns-box" onclick="javascript:facebookLogin()"><img src="img/sns-fb.png" /><span>페이스북 계정으로 로그인</span></td>
                </tr>
                <tr height="10"></tr>
                <tr height="60">
                	<td class="login-sns-box" onclick="javascript:kakaoLogin()"><img src="img/sns-kt.png" /><span>카카오톡 계정으로 로그인</span> </td>
                </tr>
                <!-- <tr height="10"></tr>
                <tr height="60">
                	<td class="login-sns-box"><img src="img/sns-tw.png" /><span>트위터 계정으로 로그인</span></td>
                </tr> -->
                <tr height="10"></tr>
                <tr height="60">
                	<td class="login-sns-box" id="naverIdLogin"></td>
                </tr>
                <tr height="10"></tr>
                <tr height="60">
                	<td class="login-sns-box" id="googleLogin"><img src="img/sns-gg.png" /><span>구글 계정으로 로그인</span></td>
                </tr>
            </table>
            </form>
        </div>
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>

    
<script type="text/javascript">

function loginCheck(email, name, gubun){

	var param = "mode=login&id="+encodeURIComponent(email)+"&name="+encodeURIComponent(name);
	
	$.ajax({
		type: "POST",
		url: 'login.lf',
		data: param,
		error: ajaxFailed,
		success: function(ret){
			
			if(ret == "[true]"){
				alert(gubun+" 아이디로 로그인 되었습니다.");
				location.href="main.lf";
			}
			else{
				location.href="login.lf?menu=signup&id="+encodeURIComponent(email)+"&name="+encodeURIComponent(name);	
			}
		}
	});	
} 

function ajaxFailed(xmlRequest){
	alert(xmlRequest.status+"\n\r"+xmlRequest.statusText+"\n\r"+xmlRequest.responseText);
}
</script>


<!-- 페이스북 -->
<script>
   window.fbAsyncInit = function() {
  FB.init({
    appId      : '403774836770239',  // 앱 ID
    status     : true,    // 로그인 상태를 확인
   // cookie     : false,    // 쿠키허용
    xfbml      : true     // parse XFBML
  });           
   };
 
   // Load the SDK Asynchronously
   (function(d){
   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement('script'); js.id = id; js.async = true;
   js.src = "//connect.facebook.net/ko_KR/all.js";
   ref.parentNode.insertBefore(js, ref);
    }(document));
   
   function facebookLogin() {
    FB.login(function(response) {
   FB.getLoginStatus(function(response) {   
    statusChangeCallback(response);
   });
    }, {scope: 'public_profile,email'});
   }

   function statusChangeCallback(response) {
   if (response.status === 'connected') {                 
    FB.api('/me?fields=id,name,email', function(user) {
     if (user) {
      //console.log(JSON.stringify(user));
      /*var image = document.getElementById('image');
      image.src = 'http://graph.facebook.com/' + user.id + '/picture';
      var name = document.getElementById('name');
      name.innerHTML = user.name
      var id = document.getElementById('id');
      id.innerHTML = user.id 
      var email = document.getElementById('email');
      email.innerHTML = user.email        
      //console.log(response.authResponse.accessToken);
      */
      loginCheck(user.email,user.name,"페이스북");
     }
    });      
   } else if (response.status === 'not_authorized') {     
   } else { }
   }
</script>


<!--카카오-->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>  
 Kakao.init("1c778626456954737e6f06041ec1ee4b");
 
 function kakaoLogin(){
  Kakao.Auth.login({      
   success: function(authObj) {
    Kakao.API.request({
     url: '/v1/user/me',
     success: function(res) {
    	 
    	 console.log(res.id);
      
      if(res.kaccount_email=="" || res.kaccount_email==undefined){
    	  alert("이메일 정보제공을 동의해주세요.");
    	  return false;
      }
      
      loginCheck(res.kaccount_email, res.properties.nickname, "카카오톡");
     },
     fail: function(error) {
      console.log(error);
     }
    });
   },
   fail: function(err) {
    console.log(err);
   }
  });      
 }
</script>


<!-- 구글 -->
<script src="https://apis.google.com/js/api:client.js"></script>
<script>
  var googleUser = {};
  var startApp = function() {
    gapi.load('auth2', function(){
      // Retrieve the singleton for the GoogleAuth library and set up the client.
      auth2 = gapi.auth2.init({
        client_id: '810084313443-bebnhpsr4tjsapfq690nsa5scd9imnll.apps.googleusercontent.com',
        cookiepolicy: 'single_host_origin',
        // Request scopes in addition to 'profile' and 'email'
        scope: 'profile email'
      });
      attachSignin(document.getElementById('googleLogin'));
    });
  };

  function attachSignin(element) {   
    auth2.attachClickHandler(element, {},
  function(googleUser) {
   var profile = googleUser.getBasicProfile();
   
   console.log(profile);
   
   loginCheck(profile.getEmail(), profile.getName(), "구글");
  }, function(error) {
    //alert(JSON.stringify(error, undefined, 2));
  });
  }
</script>
<script>startApp();</script>


<!-- 네이버 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script> 
 var naverLogin = new naver.LoginWithNaverId(
 	{
 		clientId: "dK9PYEzpRFvzF9r6B2eh",
 		callbackUrl: "http://localhost:8080/aelf/login.lf?menu=login",
 		isPopup: false, /* 팝업을 통한 연동처리 여부 */
 		loginButton: {color: "white", type: 3, height: 60} /* 로그인 버튼의 타입을 지정 */
 	}
 );

 /* 설정정보를 초기화하고 연동을 준비 */
 naverLogin.init();

 naverLogin.getLoginStatus(function (status) {
 	if (status) {
 		var email = naverLogin.user.getEmail();
 		var name = naverLogin.user.getName();
 		//var profileImage = naverLogin.user.getProfileImage();
 	//	var birthday = naverLogin.user.getBirthday();			
 	//	var uniqId = naverLogin.user.getId();
 	//	var age = naverLogin.user.getAge();
 		
 		alert(email+"//"+name);

 	} else {
 		console.log("AccessToken이 올바르지 않습니다.");
 	}
 });
</script>


</body>
</html>