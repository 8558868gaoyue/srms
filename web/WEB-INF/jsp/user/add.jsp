<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/doc.min.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="user.html">用户维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <jsp:include page="/WEB-INF/jsp/common/top.jsp"></jsp:include>
            </ul>
            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="tree">
                <jsp:include page="/WEB-INF/jsp/common/menu.jsp"></jsp:include>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form role="addForm">
                        <div class="form-group">
                            <label for="loginacct">登陆账号</label>
                            <input type="text" class="form-control" id="loginacct" placeholder="请输入登陆账号">
                        </div>
                        <div class="form-group">
                            <label for="username">用户姓名</label>
                            <input type="text" class="form-control" id="username" placeholder="请输入用户姓名">
                        </div>
                        <button type="button" onclick="add()" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                        <button type="button" onclick="reset()" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/jquery/jquery-2.1.1.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/script/docs.min.js"></script>
<script src="${pageContext.request.contextPath}/jquery/layer/layer.js"></script>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });

    var loadingIndex=-1;
    function add(){
        var loginacct=$("#loginacct");
        var username=$("#username");

        $.ajax({
            type:"post",
            url:"${pageContext.request.contextPath}/user/doAdd.do",
            data:{
                loginacct:loginacct.val(),
                username:username.val(),
            },
            beforeSend:function () {
                loadingIndex = layer.msg('处理中', {icon: 16});
                return true;
            },
            success:function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    layer.msg("保存成功", {time:1000, icon:6, shift:6});
                    window.location.href = "toIndex.htm";
                }else{
                    layer.msg("保存失败", {time:1000, icon:5, shift:6});
                }
            },
            error:function () {
                layer.msg("保存失败", {time:1000, icon:5, shift:6});
            }
        });
    }
    function reset(){
        $("#addForm")[0].reset();
    }
</script>
</body>
</html>

