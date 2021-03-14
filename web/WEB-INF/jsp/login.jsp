<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/login.css">
    <style>

    </style>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="index.html" style="font-size:32px;">科研管理平台</a></div>
        </div>
    </div>
</nav>

<div class="container">

    <form id="loginForm" action="${pageContext.request.contextPath}/doLogin.do" method="post" class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="floginacct" name="loginacct" value="superadmin" placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="password" class="form-control" id="fuserpswd" name="userpswd" value="123" placeholder="请输入登录密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <select class="form-control" id="ftype" name="type">
                <option value="member">会员</option>
                <option value="user" selected>管理</option>
            </select>
        </div>${exception.message}
        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me"> 记住我
            </label>
            <br>
            <label>
                忘记密码
            </label>
            <label style="float:right">
                <a href="reg.html">我要注册</a>
            </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
    </form>
</div>
<script src="${pageContext.request.contextPath}/jquery/jquery-2.1.1.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/jquery/layer/layer.js"></script>
<script>
    function dologin() {
        var floginacct = $("#floginacct");
        var fuserpswd = $("#fuserpswd");
        var ftype = $("#ftype");

        if($.trim(floginacct.val())==""||$.trim(fuserpswd.val())==""){
            layer.msg("账号和密码不能为空！", {time:1000, icon:5, shift:6},function(){
                floginacct.val("");
                fuserpswd.val("");
            });
            return false;
        }
        var loadingIndex=-1;
        $.ajax({
            url:"${pageContext.request.contextPath}/doLogin.do",
            type:"post",
            data:{
                loginacct:floginacct.val(),
                userpswd:fuserpswd.val(),
                type:ftype.val()
            },
            beforeSend:function () {
                loadingIndex = layer.msg('处理中', {icon: 16});
                return true;
            },
            success:function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    layer.msg("登陆成功！", {time:1000, icon:6});
                    window.location.href = "main.htm";
                }else {
                    layer.msg("账号或密码错误！", {time:1000, icon:5, shift:6});
                }
            },
            error:function () {
                layer.msg("登录失败！", {time:1000, icon:5, shift:6});
            }
        });
    }
</script>
</body>
</html>
