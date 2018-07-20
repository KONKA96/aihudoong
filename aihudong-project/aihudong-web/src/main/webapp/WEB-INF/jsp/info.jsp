<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<jsp:include page="common/include_css.jsp" />
<jsp:include page="common/include_js.jsp" />
<head>
	<script type="text/javascript" src="http://res.wx.qq.com/connect/zh_CN/htmledition/js/wxLogin.js"></script>
    <base href="<%=basePath%>">

    <title>微信扫码登录</title>

</head>

<body>
<div  id="login_container">
</div>
<div>
	<a href="javascript:void(0)" onclick="WeiChatLogin()">微信扫码登录</a>
	<a href="" >登录了</a>
</div>
</body>
<script type="text/javascript">
	/* window.onload=function(){
		$.ajax({
			url:"/aihudong-web/index/getWeiChatInfo",
			type:"post",
			success:function(data){
				console.log(data);
				var obj = new WxLogin({
					 self_redirect:true,
					 id:"login_container", 
					 appid: data.appid, 
					 scope: "snsapi_login", 
					 redirect_uri: data.redirect_uri,
					 });
				}
			})
		} 
	*/
	function WeiChatLogin(){
		$.ajax({
			url:"/aihudong-web/index/getWeiChatInfo",
			type:"post",
			success:function(data){
				console.log(data);
				window.location=data;
			}
		})
	}
		
</script>
</html>
