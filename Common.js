$(function () {
    $("#btnBack").click(function () {
        $(this).attr("disabled", true);
        history.go(-1);
    });
    $("#btnClose").click(function () {
        closeLayerWindow();
        if (parent.oTable) {
            parent.oTable.fnDraw(false);
        }
    });
});

function openWinFull(url, title, w, h) {
    if(title=="拍照上传"){
        parent.layer.closeAll();
        var index = parent.layer.open({
            type: 2,
            title: title,
            //shadeClose: true,
            shade: 0.5,
            maxmin: false,
            area: ['300px', '150px'],
            content: url
        });
        parent.layer.full(index);
    }else{
        var index = layer.open({
            type: 2,
            title: title,
            //shadeClose: true,
            shade: 0.5,
            maxmin: false,
            area: ['300px', '150px'],
            content: url
        });
        layer.full(index);
    }

}
function openWinXianChangBiLu(url, title, w, h) {
        parent.layer.closeAll();
        var index = parent.layer.open({
            type: 2,
            title: title,
            //shadeClose: true,
            shade: 0.5,
            maxmin: false,
            area: ['300px', '150px'],
            content: url
        });
        parent.layer.full(index);

}
function openWin(url, title, w, h) {
    layer.open({
        offset:'50px',
        type: 2,
        title: title,
        //shadeClose: true,
        shade: 0.5,
        maxmin: true,
        area: [w + 'px', h + 'px'],
        content: url
    });
}

function openDiv(url, title, w, h) {
    layer.open({
        type: 1,
        title: title,
        shadeClose: true,
        shade: 0.5,
        maxmin: true,
        area: [w + 'px', h + 'px'],
        content: $(url)
    });
}

function formPost(url, callback) {
    if ($.isFunction(url))
        ajaxPost($("#webform").attr("action"), $("#webform").serializeArray(), function (data) {
            url(data);
        });
    else if (typeof url == "string")
        ajaxPost(url, $("#webform").serializeArray(), function (data) {
            callback(data);
        });
    else if (typeof url == "object")
        ajaxPost(!!url.url ? url.url : $("#" + url.formid).attr("action"), $("#" + url.formid).serializeArray(), function (data) {
            url.callback(data);
        });
    else
        return;
}

function formPost1( url, callback, formId) {
    if(!formId)
        formId = 'webform'
    if ($.isFunction(url))
        ajaxPost($("#" + formId).attr("action"), $("#" + formId).serializeArray(), function (data) {
            url(data);
        });
    else if (typeof url == "string")
        ajaxPost(url, $("#" + formId).serializeArray(), function (data) {
            callback(data);
        });
    else if (typeof url == "object")
        ajaxPost(!!url.url ? url.url : $("#" + url.formid).attr("action"), $("#" + url.formid).serializeArray(), function (data) {
            url.callback(data);
        });
    else
        return;
}

function ajaxPost(url, data, fnCallback) {
    return $.ajax({
        "type": "POST",
        "url": url,
        "data": JSON.stringify(data),
        "contentType": "application/json; charset=utf-8",
        "dataType": "json",
        "processData": true,
        "success": function (data) {
            try {
                if (data.code == -2) {
                    alert(data.msg);
                    top.location.href = "/";
                    return;
                }
            } catch (e) {
                ;
            }
            fnCallback(data);
        },
        "error": function (r) {
            try {
                if (!!layer) layer.alert(r.statusText + "!" + r.responseText); else alert(r.statusText + "!" + r.responseText);
            } catch (e) {
                ;
            }
            if (r.statusText === "Server Too Busy") {
                location.href = "/";
            }
        }
    });
}

function getTree(treeid) {
    return $.fn.zTree.getZTreeObj(treeid);
}

function bindTree(treeid, setting) {
    formPost(!!setting.getDataUrl ? setting.getDataUrl : $("#webform").attr("action"), function (d) {
        $.fn.zTree.init($("#" + treeid), treeSetting(setting.idKey, setting.pIdKey, setting.title, setting.showCheck, setting.selectedMulti, setting.callback), d.data);
        getTree(treeid).expandAll(true);
        if (!!setting.setCheckUrl) formPost(setting.setCheckUrl, function (data) {
            var zT = getTree(treeid);
            try {
                $.each(data, function (i, v) {
                    /*var zT = getTree(treeid);*/
                    var node = zT.getNodeByTId();
                    zT.checkNode(node, true, false);
                });
            } //v.toString()
                /*catch (e) { $.each(zT.transformToArray(zT.getNodes()), function (i, node) { if (data.indexOf(node[setting.idKey]) > -1) zT.checkNode(node, true, false); }); }*/
            catch (e) {
                $.each(zT.transformToArray(zT.getNodes()), function (i, node) {
                    var indexstr = node[setting.idKey];
                    if (data.indexOf(parseInt(indexstr)) > -1)
                    /* if (data.indexOf(node) > -1)*/
                        zT.checkNode(node, true, false);
                });
            }
        });
    });
}

function saveTree(treeid, setting, fnCallBack) {
    var data = [];
    $.each(getTree(treeid).getChangeCheckedNodes(), function (i, v) {
        data.push(v[setting.idKey]);
    });
    $("#" + setting.inputId).val(data.join(','));
    formPost(setting.saveUrl, function (data) {
        fnCallBack(data);
    });
}

function treeSetting(idKey, pIdKey, title, showCheck, selectedMulti, callback) {
    return {
        check: {enable: showCheck},
        view: {selectedMulti: selectedMulti},
        data: {key: {name: title, title: title}, simpleData: {enable: true, idKey: idKey, pIdKey: pIdKey}},
        callback: callback
    };
}

function formAssign(data, formid, callback) {
    var fid = formid;
    if (typeof formid == "function" || typeof formid == "object")
        fid = "";
    if (typeof formid == "string" || !!!fid) {
        if (!!data) {
            for (var p in data) {
                if (typeof (data[p]) != "function") {
                    if (!!!data[p] && data[p] != 0 && data[p] != "0")
                        continue;
                    var ele = $((!!fid ? "#" + fid + " " : "") + "[name=" + p + "]");
                    if (['LABEL', 'DIV', 'SPAN', 'P', 'TD'].indexOf(ele.prop("tagName")) > -1) ele.text(data1(ele, data[p]));
                    else if (ele.attr("type") != "radio" && ele.attr("type") != "checkbox")
                        ele.val(data2(ele, data[p]));
                    else {
                        $((!!fid ? "#" + fid + " " : "") + "[name=" + p + "]").each(function () {
                            $(this).prop("checked", $(this).val() == data[p]);
                        });
                    }
                }
            }
        }
    }
    else if (typeof formid == "object") {
        ;
    }
    else if (typeof formid == "function") {
        formid(data);
    }
    try {
        callback(data);
    } catch (e) {
        ;
    }
}

function data1(ele, v) {
    return ele.hasClass("Ndate") ? formatCommonDate(v, !!ele.attr("format") ? Number(ele.attr("format")) : 8) : v;
}

function data2(ele, v) {
    return ele.hasClass("Wdate") ? ele.hasClass("Ndate") ? formatCommonDate(v, !!ele.attr("format") ? Number(ele.attr("format")) : 8) : dataFormat(v, ele.attr("format")) : v;
}

function dataFormat(val, fmt) {
    if (!!!val)
        return "";
    var re = /-?\d+/;
    var m = re.exec(val);
    if (m.input.indexOf("-2209017600000") > -1)
        return "";
    var d = new Date(parseInt(m[0]));
    return d.format(!!!fmt ? 'yyyy-MM-dd hh:mm:ss' : fmt);
}

Date.prototype.format = function (format) {
    var o = {
        "M+": this.getMonth() + 1, //month
        "d+": this.getDate(),    //day
        "h+": this.getHours(),   //hour
        "m+": this.getMinutes(), //minute
        "s+": this.getSeconds(), //second
        "q+": Math.floor((this.getMonth() + 3) / 3),  //quarter
        "S": this.getMilliseconds() //millisecond
    }
    if (/(y+)/.test(format)) format = format.replace(RegExp.$1,
        (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o) if (new RegExp("(" + k + ")").test(format))
        format = format.replace(RegExp.$1,
            RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
    return format;
}

Array.prototype.unique3 = function () {
    var res = [];
    var json = {};
    for (var i = 0; i < this.length; i++) {
        if (!json[this[i]]) {
            res.push(this[i]);
            json[this[i]] = 1;
        }
    }
    return res;
}

function formatTime(val) {
    var re = /-?\d+/;
    var m = re.exec(val);
    var d = new Date(parseInt(m[0]));
    return d.format("yyyy-MM-dd hh:mm:ss");
}

function formatDate(val) {
    var re = /-?\d+/;
    var m = re.exec(val);
    var d = new Date(parseInt(m[0]));
    return d.format("yyyy-MM-dd");
}

function formatCommonDate(sDate, lenth) {
    if (!sDate) return "";
    var sDateTime = sDate.toString();
    var len = sDateTime.length;
    if (lenth) {
        len = lenth;
    }
    if (len > 0) {
        switch (len) {
            case 4:
                return sDateTime.substr(0, 4);
            case 6:
                return sDateTime.substr(0, 4) + "-" +
                    sDateTime.substr(4, 2);
            case 8:
                return sDateTime.substr(0, 4) + "-" +
                    sDateTime.substr(4, 2) + "-" +
                    sDateTime.substr(4 + 2, 2);
            case 10:
                return sDateTime.substr(0, 4) + "-" +
                    sDateTime.substr(4, 2) + "-" +
                    sDateTime.substr(4 + 2, 2) + " " +
                    sDateTime.substr(4 + 2 + 2, 2);
            case 12:
                return sDateTime.substr(0, 4) + "-" +
                    sDateTime.substr(4, 2) + "-" +
                    sDateTime.substr(4 + 2, 2) + " " +
                    sDateTime.substr(4 + 2 + 2, 2) + ":" +
                    sDateTime.substr(4 + 2 + 2 + 2, 2);
            case 14:
                return sDateTime.substr(0, 4) + "-" +
                    sDateTime.substr(4, 2) + "-" +
                    sDateTime.substr(4 + 2, 2) + " " +
                    sDateTime.substr(4 + 2 + 2, 2) + ":" +
                    sDateTime.substr(4 + 2 + 2 + 2, 2) + ":" +
                    sDateTime.substr(4 + 2 + 2 + 2 + 2, 2);
            case 17:
                return sDateTime.substr(0, 4) + "-" +
                    sDateTime.substr(4, 2) + "-" +
                    sDateTime.substr(4 + 2, 2) + " " +
                    sDateTime.substr(4 + 2 + 2, 2) + ":" +
                    sDateTime.substr(4 + 2 + 2 + 2, 2) + ":" +
                    sDateTime.substr(4 + 2 + 2 + 2 + 2, 2) + " " +
                    sDateTime.substr(4 + 2 + 2 + 2 + 2 + 2, 3);
        }
    }
    return sDateTime;
}

String.prototype.PadLeft = function (bchar, alength) {
    var xchar = '' + this;
    for (var i = 0; i < alength; i++) {
        xchar = bchar + xchar;
        if (xchar.length == alength)
            break;
    }
    return (xchar);
}

String.prototype.PadRight = function (padChar, width) {
    var ret = this;
    while (ret.length < width) {
        if (ret.length + padChar.length < width) {
            ret += padChar;
        }
        else {
            ret += padChar.substring(0, width - ret.length);
        }
    }
    return ret;
};

function isnull(d) {
    return !!d ? d : "";
}

function SessionKeeper() {
    ajaxPost('index.aspx/SessionKeeper', {_: (new Date()).getTime()}, function (d) {
        setTimeout("SessionKeeper()", 1000);
    });
}

function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return decodeURI(r[2]);
    }
    return "";
}

Math.formatFloat = function (f, digit) {
    var m = Math.pow(10, digit);
    return parseInt(f * m, 10) / m;
}

//删除图片
function deleteimg(url, lx, iid) {
    var imgurl = $("#" + lx).val();
    imgurl = imgurl.replace(url, "").replace(",,", ",");
    if (imgurl.indexOf(",") == 0)
        imgurl = imgurl.substring(1);
    if (imgurl.lastIndexOf(",") == imgurl.length - 1)
        imgurl = imgurl.substring(0, imgurl.length - 1);
    $("#" + lx).val(imgurl);
    $("#" + iid).remove();
}

function closeLayerWindow() {
    parent.layer.close(parent.layer.getFrameIndex(window.name));
}

function BindCurrYear(cid) {
    var yYear = new Date();
    var nowYear = yYear.getFullYear() - 1;
    $("#" + cid).val(nowYear);
}

function toMoney(n) {
    return n.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,")
}

function simplearea(c, n) {
    if (!!!n)
        return simplearea(c, 10000000000);
    if (c % n == 0)
        return (c / n).toString();
    else if (n <= 1000)
        return c.toString();
    return simplearea(c, n / (n > 1000000 ? 100 : 1000));
}

function bindSelect(selector, url, data, txtField, valField, callback) {
    ajaxPost(url, data, function (d) {
        if (d.data) {
            $.each(d.data, function (i, v) {
                $('<option></option>').text(v[txtField]).val(v[valField]).appendTo($(selector));
            });
        }
        if (callback) callback();
    });
}

function sum(url, data, table) {
    $.ajax({
        url: url,
        type: 'GET',
        data: data,
        dataType: 'json',
        timeout: 1000,
        cache: false,
        success: function succFunction(data) {

            var i = table.rows.length;
            if (table.rows[i - 1].cells[0].innerHTML === '<b>数量总计：</b>') return;
            var j = table.getElementsByTagName('th').length;
            var newTr = table.insertRow();
            //添加列
            var newTd0 = newTr.insertCell();
            var newTd1 = newTr.insertCell();
            newTd0.setAttribute("colspan", 2);
            newTd1.setAttribute("colspan", j - 2);
            newTd1.setAttribute("style", "text-align: left;padding-left: 20px");
            newTd0.setAttribute("style", "text-align: center");
            if (data.sum == null || data.sum == '') {
                var count = 0;
            } else {
                var count = data.sum;
            }
            //设置列内容
            newTd0.innerHTML = '<b>数量总计：</b>';
            newTd1.innerHTML = count;
        }
    });
}

// zui库的提示消息，需要引用zui库
function zuiMsg(msg, opt) {
    if (opt)
        new $.zui.Messager(msg, opt).show();
    else
        new $.zui.Messager(msg).show();
}

function openWinFullBzhjc(url, title, w, h) {
    var index = layer.open({
        type: 2,
        title: title,
        shade: 0.5,
        maxmin: false,
        area: ['300px', '150px'],
        content: url,
        cancel: function (index, layero) {
            closeLayerWindow();
            window.location.href="/sop?pindex=bzhjcList";
        }
    });
    layer.full(index);
}

function openWinFullXcjcbl(url, title, w, h) {
    var index = layer.open({
        type: 2,
        title: title,
        shade: 0.5,
        maxmin: false,
        area: ['300px', '150px'],
        content: url,
        cancel: function (index, layero) {
            closeLayerWindow();
            window.location.href="/tpage/access?pindex=xcjcblquery";
        }
    });
    layer.full(index);
}

//点击图表，全屏展示相关页面
function openWinFullCharts(url, title, w, h) {
    var index = parent.layer.open({
        type: 2,
        title: title,
        shade: 0.5,
        maxmin: false,
        area: ['300px', '150px'],
        content: url
    });
    parent.layer.full(index);
}
