<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户</title>
    <jsp:include page="../common/include_css.jsp" />
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5><small>用户</small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <form class="form-horizontal" id="editForm">
                        	<input type="hidden" name="id" value="${admin.id }">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">用户名</label>

                                <div class="col-sm-10">
                                    <input name="username" value="${admin.username }" type="text" class="form-control" placeholder="用户名">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">真实姓名</label>
                                <div class="col-sm-10">
                                    <input name="truename" value="${admin.truename }" type="text" class="form-control" placeholder="真实姓名">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label">联系方式</label>
                                <div class="col-sm-10">
                                    <input name="telephone" value="${admin.telephone }" type="text" class="form-control" placeholder="联系方式">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label">电子邮箱</label>
                                <div class="col-sm-10">
                                    <input name="email" value="${admin.email }" type="text" class="form-control" placeholder="电子邮箱">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label">性别</label>
                                <div class="col-sm-10">
                                    <select class="form-control m-b" name="sex">
                                    		<option value="0" ${admin.sex==0 ? 'selected' :'' }>男</option>
                                    		<option value="1" ${admin.sex==1 ? 'selected' :'' }>女</option>
                                    </select>
                                </div>
                            </div>
                            
                            
                            <div class="form-group">
                               <label class="col-sm-2 control-label">职务</label>
                                <div class="col-sm-10">
                                    <select class="form-control m-b" name="power">
                                    		<option value="0" ${admin.power==0 ? 'selected' :'' }>根级管理员</option>
                                    		<option value="1" ${admin.power==1 ? 'selected' :'' }>一级管理员</option>
                                    		<option value="2" ${admin.power==2 ? 'selected' :'' }>操作管理员</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label">屏幕数</label>
                                <div class="col-sm-10">
                                    <input name="screenNum" value="${admin.screenNum }" type="text" disabled="disabled" class="form-control" placeholder="屏幕数">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-2">
                                    <button class="btn btn-primary" type="button" onclick="updateInfo()">保存</button>
                                    <button class="btn btn-white" type="reset">取消</button>
                                    <c:if test="${admin.power!=0 }">
                                    	<button class="btn btn-primary" type="button" onclick="reSetPwd()">重置密码</button>
                                    </c:if>
                                </div>
                            </div>
                        </form> 
                    </div>
                </div>
            </div>
        </div>
    </div>
	
	<jsp:include page="../common/include_js.jsp" />

</body>
<script type="text/javascript">
	
	$(document).ready(function () {
	    $('.i-checks').iCheck({
	        checkboxClass: 'icheckbox_square-green',
	        radioClass: 'iradio_square-green',
	    });
	});
	
	function updateInfo(){
		$.ajax({
			url:"/aihudong-web/admin/updateAdmin",
			data:$("#editForm").serialize(),
			type:"post",
			success:function(data){
				if(data=='success'){
					alert("操作成功！");
					window.location="/aihudong-web/admin/toAdminInfo";
				}else{
					alert("操作失败");
				}
			}
		})
	}
	
	function reSetPwd(){
		swal({   
			title: "请输入旧密码",
			text: "",   
			type: "input",   
			showCancelButton: true,   
			closeOnConfirm: false,   
			animation: "slide-from-top",   
			inputPlaceholder: "原密码",
			confirmButtonText: "确定",
	        cancelButtonText: "取消",
		}, function (inputValue){
			$.ajax({
				url:"/aihudong-web/admin/testOldPwd",
				data:"password="+inputValue,
				type:"post",
				//与原密码进行比对
				success:function(data){
					//成功匹配，准备输入新密码
					if(data=='success'){
						inputNewPwdFirst();
					}else{
						//未成功匹配
						swal("与原密码不匹配!","请重试","error");
					}
				}
			})
		})
	}
	
	function inputNewPwdFirst(){
		swal({   
			title: "请输入新密码",
			text: "",   
			type: "input",   
			showCancelButton: true,   
			closeOnConfirm: false,   
			animation: "slide-from-top",   
			inputPlaceholder: "密码",
			confirmButtonText: "确定",
	        cancelButtonText: "取消",
		}, function (inputValue){
			inputNewPwdSecond(inputValue);
		})
	}
	
	function inputNewPwdSecond(pwd){
		swal({   
			title: "请再次输入新密码",
			text: "",   
			type: "input",   
			showCancelButton: true,   
			closeOnConfirm: false,   
			animation: "slide-from-top",   
			inputPlaceholder: "密码",
			confirmButtonText: "确定",
	        cancelButtonText: "取消",
		}, function (inputValue){
			if(pwd!=inputValue){
				swal("两次输入密码不一致!","操作失败","error");
			}else{
				$.ajax({
					url:"/aihudong-web/admin/updateAdmin",
					data:"password="+inputValue,
					type:"post",
					//与原密码进行比对
					success:function(data){
						//成功匹配，准备输入新密码
						if(data=='success'){
							swal("添加成功!","","success");
						}else{
							//未成功匹配
							swal("添加失败!","请重试","error");
						}
					}
				})
			}
		})
	}
</script>
</html>
