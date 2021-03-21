<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <li class="active">分配角色</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form role="form" class="form-inline">
                        <div class="form-group">
                            <label>未分配角色列表</label><br>
                            <select id="leftList" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
                                <c:forEach items="${leftList}" var="role">
                                    <option class="active" id="froleid" value="${role.id}">${role.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <ul>
                                <li id="leftBtn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                                <br>
                                <li id="rightBtn" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                            </ul>
                        </div>
                        <div class="form-group" style="margin-left:40px;">
                            <label>已分配角色列表</label><br>
                            <select id="rightList" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
                                <c:forEach items="${rightList}" var="role">
                                    <option  value=${role.id}>${role.name}</option>
                                </c:forEach>
                            </select>
                        </div>
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

    //分配角色
    $("#leftBtn").click(function () {
        var options=$("#leftList option:selected");
        var jsonObj={
            userid:${param.id},
        };
        $.each(options,function (i,n) {
            jsonObj["ids["+i+"]"]=parseInt(this.value);
        });

        var index=-1;
        $.ajax({
            type:"post",
            url:"doAssignRole.do",
            data:jsonObj,
            beforeSend:function () {
                index=layer.msg('正在分配角色!', {icon: 16});
                return true;
            },
            success:function (result) {
                layer.close(index);
                if(result.success){
                    $("#rightList").append(options);
                }else {
                    layer.msg("修改失败", {time:1000, icon:5, shift:6});
                }
            },
            error:function () {
                layer.msg("修改失败", {time:1000, icon:5, shift:6});
            }
        });
    });

    //取消角色
    $("#rightBtn").click(function () {
        var options=$("#rightList option:selected");
        var jsonObj={
            userid:${param.id},
            //类似ids:["1","2","3","4"]
        };
        $.each(options,function (i,n) {
            jsonObj["ids["+i+"]"]=this.value;
        });
        var index=-1;

        $.ajax({
            type:"post",
            url:"doUnAssignRole.do",
            data:jsonObj,
            beforeSend:function () {
                index=layer.msg('正在分配角色!', {icon: 16});
                return true;
            },
            success:function (result) {
                layer.close(index);
                if(result.success){
                    $("#leftList").append(options);
                }else {
                    layer.msg("修改失败", {time:1000, icon:5, shift:6});
                }
            },
            error:function () {
                layer.msg("修改失败", {time:1000, icon:5, shift:6});
            }
        });
    });
</script>
</body>
</html>

