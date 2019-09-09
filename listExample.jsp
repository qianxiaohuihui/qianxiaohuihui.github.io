<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>进口代理人登记表</title>
    <link href="${ctx}/include/Scripts/H-ui/css/H-ui.min.css" rel="stylesheet"/>
    <link href="${ctx}/include/Scripts/H-ui/lib/Hui-iconfont/iconfont.css" rel="stylesheet"/>
    <link href="${ctx}/include/Scripts/H-ui/skin/default/skin.css" rel="stylesheet"/>
    <link href="${ctx}/include/Scripts/H-ui/css/style.css" rel="stylesheet"/>
</head>
<body>
<div class="pd-20">
    <div id="search" class="text-c pd">
        <form id="webform">
            <input type="hidden" id="userid"
                   value="<%=((com.hyjk.model.APPUSER)session.getAttribute("Appuser")).getUSERID()%>">
            代理人：
            <input type="text" class="input-text" style="width: 160px" placeholder="代理人" name="CNAME"/>
            产品名称：
            <input type="text" class="input-text" style="width: 160px" placeholder="产品名称" name="CPMC"/>
            备案号：
            <input type="text" class="input-text" style="width: 160px" placeholder="备案号" name="BAH"/>&nbsp;
            备案(许可)日期：
            <input type="text" class="input-text" style="width: 100px" placeholder="请输入日期" name="MINXKRQ"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" readonly/>
            -&nbsp;
            <input type="text" class="input-text" style="width: 100px" placeholder="请输入日期" name="MAXXKRQ"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" readonly/>
            &nbsp;<button type="button" class="btn btn-primary radius" id="btnSearch"><i
                class="Hui-iconfont">&#xe665;</i> 查询
        </button>
            </td>
            &nbsp;
            <button type="button" class="btn btn-primary radius" id="btnRemove"><i class="Hui-iconfont">&#xe68f;</i> 清空
            </button>
        </form>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-10">
        <span class="r">
            <a id="btnNew" onclick="openWinFull('${ctx}/sop?pindex=jkdlrAdd','新增',640, 630);" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加</a>
        </span>
    </div>
    <div class="text-c pd">
        <div class="cl">
            <table id="datalist" class="table table-border table-bordered table-bg table-hover mt-5"
                   style="width: 100%;">
                <thead>
                <tr>
                    <th>代理人</th>
                    <th>产品名称</th>
                    <th>备案号</th>
                    <th>备案(许可)日期</th>
                    <th>所在地市</th>
                    <th>操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
<script src="${ctx}/include/Scripts/jquery-new.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/layer/layer.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/DataTables/jquery.dataTables.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/DataTables/jquery.dataTables.defaults.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx}/include/Scripts/H-ui/js/H-ui.js"></script>
<script src="${ctx}/include/Scripts/Common.js"></script>
<script>
    var oTable = null;
    $(function () {
        $("#btnSearch").click(function () {
            oTable.fnDraw();
        });
        $("#btnRemove").click(function () {
            $("#webform :input").not(":button, :submit, :reset, :hidden").val("").removeAttr("checked").remove("selected");
        });
        bindData();
    });

    function bindData() {
        oTable = $("#datalist").dataTable({
            "sAjaxSource": "${ctx}/sop/jkdlrList",
            "columns": [
                {"data": "CNAME", "sClass": "text-l"},
                {"data": "CPMC", "sClass": "text-c"},
                {"data": "BAH", "sClass": "text-c"},
                {"data": "XKRQ", "sClass": "text-c", "sWidth": "110px"},
                {"data": "SZDS", "sClass": "text-c", "sWidth": "100px"},
                {
                    "data": null, "sClass": "text-c", "sWidth": "130px", "mRender": function (data, type, full) {
                        return Btns(data);
                    }
                }
            ]
        });
    }

    function Btns(data) {
        var userid = $("#userid").val();
        if (data.USERID == userid) {
            var btns = ['<a onclick="openWinFull(\'/sop?pindex=jkdlrShow&id=' + data.PK_ID + '\',\'详细信息\',1000, 800);\" class="btn-link">详细</a>',
                '<a onclick="openWinFull(\'/sop?pindex=jkdlrUpdate&id=' + data.PK_ID + '\',\'修改信息\',1000, 800);\" class="btn-link">修改</a>',
                '<a href="javascript:delAsk(\'' + data.PK_ID + '\');" class="btn-link">删除</a>'];
        } else {
            var btns = ['<a onclick="openWinFull(\'/sop?pindex=jkdlrShow&id=' + data.PK_ID + '\',\'详细信息\',1000, 800);\" class="btn-link">详细</a>'];
        }
        return btns.join('&nbsp; ');
    }

    function delAsk(pk_id) {
        layer.confirm("确认删除吗？", function () {
            ajaxPost("/tpage/delete", {id: pk_id, ptype: 'TBJkdlr'}, function (d) {
                if (d.code > 0) {
                    layer.msg("删除成功", {time: 300}, function () {
                        oTable.fnDraw(false);
                    });
                } else {
                    layer.alert("删除失败！" + d.msg);
                }
            })
        });
    }

</script>
</body>
</html>
