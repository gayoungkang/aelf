<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userName = (String) session.getAttribute("user_name");	// 로그인 사용자명
	String menu = request.getParameter("menu");
%>

    <div class="footer-wrap" <%if(menu!=null) {%>style="background-color: #001028 ;"<%} %> >
        <div class="footer">
            <p>Copyright © 2018 ælf</p>
            <img src="m-img/footer-1.png" onclick="javascript:window.open('https://www.instagram.com/aelfblockchain/?hl=en')" alt="" />
            <img src="m-img/footer-2.png" onclick="javascript:window.open('https://twitter.com/aelfblockchain?lang=en')" alt="" />
            <img src="m-img/footer-3.png" onclick="javascript:window.open('https://github.com/AElfProject/AElf')" alt="" />
        </div>
    </div>

    