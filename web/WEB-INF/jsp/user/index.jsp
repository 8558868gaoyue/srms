<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
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
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="queryBtn" type="button" class="btn btn-warning" ><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th>账号</th>
                                <th>姓名</th>
                                <th>性别</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>

                            <tbody></tbody>

                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                    </ul>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
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
        queryUserPage(1);
    });
    $("tbody .btn-success").click(function(){
        window.location.href = "assignRole.html";
    });
    $("tbody .btn-primary").click(function(){
        window.location.href = "edit.html";
    });

    var jsonObj={
        pageno:1,
        pagesize:5
    };

    var loadingIndex=-1;
    function queryUserPage(pageno){
        jsonObj.pageno=pageno;
        $.ajax({
            url:"${pageContext.request.contextPath}/user/doIndex.do",
            type:"post",
            data:jsonObj,
            beforeSend:function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
                return true;
            },
            success:function (result){
                layer.close(loadingIndex);
                if(result.success){
                    var page=result.page;
                    var data=page.datas;
                    var string='';
                    $.each(data,function (i,n) {
                        string+='<tr>';
                        string+='<td>'+(i+1)+'</td>';
                        string+='<td>'+n.loginacct+'</td>';
                        string+='<td>'+n.name+'</td>';
                        string+='<td>'+n.gender+ '</td>';
                        string+='<td>';
                        string+='<button type="button" class="btn btn-success btn-xs" onclick="toAssignrole('+n.id+')"><i class=" glyphicon glyphicon-check"></i></button>';
                        string+='<button type="button" id="updateBtn" class="btn btn-primary btn-xs" onclick="update('+n.id+')"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        string+='<button type="button" id="deleteBtn" class="btn btn-danger btn-xs" onclick="doDelete('+n.id+')"><i class=" glyphicon glyphicon-remove"></i></button>';
                        string+='</td>';
                        string+='</tr>';
                    });

                    $("tbody").html(string);
                    var string2="";

                    if (page.pageno==1){
                        string2+='<li class="disabled"><a href="#">上一页</a></li>';
                    }else{
                        string2+='<li><a href="#" onclick="changePage('+(page.pageno-1)+')">上一页</a></li>';
                    }
                    for(var i=1;i<=page.totalno;i++){
                        if(page.pageno==i){
                            string2+='<li class="active"><a href="#"onclick="changePage('+i+')">'+i+'</a></li>';
                        }else{
                            string2+='<li><a href="#"onclick="changePage('+i+')">'+i+'</a></li>';
                        }
                    }
                    if(page.pageno==page.totalno){
                        string2+='<li class="disabled"><a href="#">下一页</a></li>';
                    }else{
                        string2+='<li><a href="#" onclick="changePage('+(page.pageno+1)+')">下一页</a></li>';
                    }

                    $(".pagination").html(string2);
                }else{
                layer.msg("查询失败", {time:1000, icon:5, shift:6});
    }
    },
        error:function () {
            layer.msg("查询失败", {time:1000, icon:5, shift:6});
        }
        });
    }
    function changePage(pageno){
        queryUserPage(pageno);
    }

    $("#queryBtn").click(function () {
        var queryText=$("#queryText").val();
        jsonObj.queryText=queryText;
        queryUserPage(1);
    });

    function update(id) {
        window.location.href="toAdd.htm";
    }

    function update(id) {
        window.location.href="toUpdate.htm?id="+id;
    }

    function doDelete(id) {
        layer.confirm("确认要删除该用户吗？",{icon:3,title:'提示'},function () {
            window.location.href="delete.do?id="+id;
        })
    }
    function toAssignrole(id) {
        window.location.href="toAssignrole.htm?id="+id;
    }
</script>
</body>
</html>







