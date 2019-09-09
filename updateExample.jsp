<%@ page import="com.hyjk.model.APPUSER" %>
<%--
      上传文件，js加载div
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="renderer" content="webkit|ie-comp|ie-stand"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <title></title>
    <link href="${ctx}/include/Scripts/H-ui/css/H-ui.min.css" rel="stylesheet"/>
    <link href="${ctx}/include/Scripts/H-ui/lib/Hui-iconfont/iconfont.css" rel="stylesheet"/>
    <link href="${ctx}/include/Scripts/H-ui/skin/default/skin.css" rel="stylesheet"/>
    <link href="${ctx}/include/Scripts/H-ui/css/style.css" rel="stylesheet"/>
    <link href="${ctx}/include/Scripts/zui/lib/uploader/zui.uploader.min.css" rel="stylesheet">
    <link href="${ctx}/include/Scripts/zui/css/zui.min.css" rel="stylesheet"/>
    <style>
        html, body {
            height: 100%;
        }

        tr {
            border-bottom: 0;
        }

        p {
            text-indent: 2em;
        }

        .borderLeft {
            border-left: none;
        }

    </style>
</head>
<body>
<div class="pd-5 deform">
    <form id="webform" action="${ctx}/sop/updateJkdlr" class="form form-horizontal" method="post">
        <div>
            <%APPUSER appuser = (APPUSER) session.getAttribute("Appuser");%>
            <input type="hidden" id="txtQYID" name="QYID" datatype="*" nullmsg="请选择【代理人】！"/>
            <input type="hidden" name="USERID" value=<%=appuser.getUSERID() %> />
            <input type="hidden" name="PK_ID" value="${param.get("id")}"/>
            <input type="hidden" id="txtPICURL" name="PICURL" />
            <div class="col-12"
                 style="text-align: center; font-family: 微软雅黑; font-size: 28px; margin-top: 20px;margin-bottom:15px;">
                进口代理人备案注册证登记表
            </div>
        </div>
        <table style="width: 720px; margin: auto;word-break: break-all;border-collapse:separate;" cellPadding="4"
               cellSpacing="0" borderColorLight="#999999" borderColorDark="#ffffff" border="1">
            <tr>
                <td><label class="form-label"><span style="color:red">*</span>代理人：</label></td>
                <td class="formControls col-10 borderLeft" colspan="3">
                    <input type="text" id="txtqyNAME" name="CNAME" class="input-text " style="border: none;width:360px"
                           readonly="readonly" datatype="*" nullmsg="代理人！"/>
                    <button id="btnxzqy" onclick="openWin('/sop?pindex=chooseQyZc','选择代理人',640, 500);"
                            class="btn btn-primary-outline radius "
                            style="width:120px;height:28px;padding: 2px;border:0" type="button"><i class="Hui-iconfont">&#xe6a7;</i>
                        选择
                    </button>
                </td>
            </tr>
            <tr>
                <td><label class="form-label"><span style="color:red">*</span>代理人地址： </label></td>
                <td class="formControls col-10 borderLeft" colspan="3">
                    <input type="text" name="DLDZ" class="input-text " style="border: none;"
                          />
                </td>
            </tr>
            <tr>
                <td><label class="form-label"><span style="color:red">*</span>产品名称： </label></td>
                <td class="formControls col-10 borderLeft" colspan="3">
                    <input type="text" name="CPMC" class="input-text " style="border: none;"
                          />
                </td>
            </tr>
            <tr>
                <td><label class="form-label"><span style="color:red">*</span>备案号： </label></td>
                <td class="formControls col-10 borderLeft" colspan="3">
                    <input type="text" name="BAH" class="input-text " style="border: none;"
                          />
                </td>
            </tr>
            <tr>
                <td><label class="form-label">注册证： </label></td>
                <td class="formControls col-10 borderLeft" colspan="3">
                    <input type="text" name="ZCZ" class="input-text " style="border: none;"
                          />
                </td>
            </tr>
            <tr>
                <td><label class="form-label">所在地市： </label></td>
                <td class="formControls col-10 borderLeft" colspan="3">
                    <select id="shi" name="SZDS" class="input-text" style="border: none;"
                            onchange="DicHBFPArea(this.value, 'xian');">
                        <option value="">请选择...</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label class="form-label">备案(许可)日期：</label></td>
                <td class="formControls col-4 borderLeft">
                    <input type="text" name="XKRQ" class="input-text" style="border: none;"
                           onclick="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})"/>
                </td>
                <td class="form-label borderLeft">资料接收日期：</td>
                <td class="formControls col-4 borderLeft">
                    <input type="text" name="ZLJSRQ" class="input-text" style="border: none;"
                           onclick="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})"/>
                </td>
            </tr>
            <tr>
                <td><label class="form-label">上传文件：</label></td>
                <td style="height:165px;border-left:none" colspan="3" class="formControls col-10">
                    <div style="overflow: hidden;width: auto; height: auto;display: none;margin-left: 10px" id="imgDiv">
                    </div>
                    <div id="myUploader" class="uploader">
                        <div class="uploader-message text-center">
                            <div class="content"></div>
                            <button type="button" class="close">×</button>
                        </div>
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th colspan="2">文件名</th>
                                <th style="width: 160px; text-align: center;">状态/操作</th>
                            </tr>
                            </thead>
                            <tbody class="uploader-files">
                            <tr class="file template">
                                <td style="width: 38px; padding: 3px">
                                    <div class="file-icon"></div>
                                </td>
                                <td style="padding: 0">
                                    <div style="position: relative; padding: 8px;">
                                        <strong class="file-name"></strong>
                                        <div class="file-progress-bar"></div>
                                    </div>
                                </td>
                                <td class="actions text-right" style="padding: 0 4px;">
                                    <div class="file-status" data-toggle="tooltip" style="margin: 8px;"><i
                                            class="icon"></i> <span class="text"></span></div>
                                    <a data-toggle="tooltip" class="btn btn-link btn-download-file" target="_blank"><i
                                            class="icon icon-download-alt"></i></a>
                                    <button type="button" data-toggle="tooltip" class="btn btn-link btn-reset-file"
                                            title="Repeat"><i class="icon icon-repeat"></i></button>
                                    <button type="button" data-toggle="tooltip" class="btn btn-link btn-rename-file"
                                            title="Rename"><i class="icon icon-pencil"></i></button>
                                    <button type="button" data-toggle="tooltip" title="Remove"
                                            class="btn btn-link btn-delete-file"><i
                                            class="icon icon-trash text-danger"></i></button>
                                </td>
                            </tr>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="4" style="padding: 4px 0">
                                    <div style="position: relative;">
                                        <div class="uploader-status pull-right text-muted"
                                             style="margin-top: 5px;"></div>
                                        <button type="button" class="btn btn-link uploader-btn-browse"><i
                                                class="icon icon-plus"></i> 选择文件
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <div style="margin-top: 8px;">
            <div class="text-center" style="text-align: center; margin-bottom: 5px;">
                <button id="btnSave" class="btn btn-primary-outline radius" type="button"><i class="Hui-iconfont">&#xe632;</i>
                    保存
                </button>
                &nbsp;&nbsp;
                <button onclick="closeLayerWindow();" class="btn radius" type="button"><i
                        class="Hui-iconfont">&#xe66b;</i>
                    取消
                </button>
            </div>
        </div>
    </form>
</div>
<br/><br/><br/>
<script src="${ctx}/include/Scripts/jquery-new.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/layer/layer.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/Validform/5.3.2/Validform.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/js/H-ui.js"></script>
<script src="${ctx}/include/Scripts/Common.js"></script>
<script src="${ctx}/include/Scripts/zui/js/zui.min.js"></script>
<script src="${ctx}/include/Scripts/zui/lib/uploader/zui.uploader.min.js"></script>
<script>
    var wForm = null;
    $(function () {
        DicHBFPArea('130000', 'shi');
        wForm = $("#webform").Validform();
        ajaxPost("${ctx}/sop/showJkdlr?ptype=TBJkdlr&id=${param.get('id')}", {}, function (d) {
            formAssign(d.data);
            $("#txtpicurl").attr("value", d.data.PICURL);
            var fileList = d.data.PICURL.split(",");
            if (d.data.PICURL != '') {
                for (var i = 0; i < fileList.length; i++) {
                    var url = "${ctx}/include/files/jkdlr/" + fileList[i];
                    var test='<div id="tmpDiv'+i+'" style="float:left;margin-top:5px;">' +
                        '         <a   id="img'+i+'" href="' + url + '" target="_blank">查看文件</a>' +
                        '         <br/>'+
                        '         <button type="button" onclick="deletePic(this)" class="btn" id="btn' + i + '" style="margin-left:5px">删除</button>' +
                        '      </div>';
                    $("#imgDiv").append(test);
                }
                $("#imgDiv").show();
            }
        });
        $("#btnSave").click(function () {
            if (wForm.check()) {
                formPost(function (r) {
                    if (r.code > 0) {
                        layer.msg("更新成功！", { time: 800 }, function () {
                            closeLayerWindow();
                        });
                        parent.window.location.reload();
                    } else { layer.alert("更新失败！" + r.msg); }
                });
            } else { wForm.ajaxPost(); }
        });
    });

    function openSelect() {
        openWin('/sop?pindex=chooseQyZc', '请选择当事人', 640, 500);
    }

    function showPicClick() {
        var hidPicUrl = $("#txtpicurl").val();
        hidPicUrl = hidPicUrl.replace(/\\/g, "/");
        hidPicUrl = hidPicUrl.replace(/#/g, '%23');
        openWin('/tpage?pindex=showPic&PicUrl=' + hidPicUrl, '浏览图片', 800, 500)
    }

    var finalFileName = '';
    var fileList = null;
    var picurl = '';

    function deletePic(btn) {
        var btnID = btn.id;
        var index = btnID.substring(btnID.length - 1, btnID.length);
        if (finalFileName == '') {
            finalFileName = $("#txtPICURL").val();
            picurl = finalFileName;
        }
        var fileList = finalFileName.split(",");
        var wz = picurl.indexOf(fileList[index]);
        if (wz != -1) {
            var reg = new RegExp(',' + fileList[index], "g");
            if (wz == 0) {
                reg = new RegExp(fileList[index] + ',', "g");
                if (picurl.indexOf(',') == -1) {
                    reg = new RegExp(fileList[index], "g");
                }
            }
            var tmp = picurl.replace(reg, "");
            picurl = tmp;
            $("#tmpDiv".concat(index)).hide();
            $("#txtPICURL").val(tmp);
        }
    }

    $('#myUploader').uploader({
        autoUpload: true,
        deleteActionOnDone: function (file, doRemoveFile) {
            layer.confirm("文档是否被移除?", function (index) {
                doRemoveFile(file);
                var wz = finalFileName.indexOf(file.name);
                if (wz != -1) {
                    var reg = new RegExp(file.name + ',', "g");
                    var tmp = finalFileName.replace(reg, "");
                    $("#txtPICURL").attr("value", tmp.substring(0, tmp.length - 1));
                }
                layer.close(index);
            });
        },
        url: '${ctx}/sop/uploadJkdlrPdf',
        filters: {
            max_file_size: '100mb',
            mime_types: [
                /*{title: '文档', extensions: 'jpg,png,JGP,PNG,JPEG'}*/
                {title: '文档', extensions: 'pdf,PDf'}
            ]
        },
        multi_selection: false,
        limitFilesCount: 1,
        chunk_size: 0,
        onFileUploaded: function (f, r) {
            var d = JSON.parse(r.response);
            if (d.code > 0) {
                finalFileName = $("#txtPICURL").val();
                var fileName = d.fileName;
                if (finalFileName != '') {
                    finalFileName = finalFileName + "," + fileName;
                } else {
                    finalFileName = finalFileName + fileName;
                }
                $("#imgDiv", parent.document).attr("src", d.fileUrl);
                $("#imgDiv", parent.document).show();
                $("#txtPICURL").attr("value", finalFileName.substr(0, finalFileName.length));
            }
        }
    });

    //区划加载
    function DicHBFPArea(pvalue, cid) {
        $("#" + cid + " option").each(function (k, v) {
            if ($(this).attr("value")) $(this).remove();
        });
        $.ajaxSetup({async: false});
        ajaxPost("/tpage/GetAreaCode", {"value": pvalue}, function (uts) {
            if (!!uts.data) {
                $.each(uts.data, function (i, v) {
                    $('<option value="' + v.AREA_NAME + '">' + v.AREA_NAME + '</option>').appendTo($("#" + cid));
                });
            }
        });
        $.ajaxSetup({async: true});
    }
</script>
</body>
</html>
