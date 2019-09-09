function Dic() {
};

/***************************************行政区域***********************************************/
/*
描述：行政区域多级联动
pvalue:上级节点的值
cid:要绑定的控件ID
*/
Dic.Area = function (pvalue, cid) {
    $("#" + cid + " option").each(function (k, v) {
        if ($(this).attr("value")) $(this).remove();
    });
    $.ajaxSetup({ async: false });
    ajaxPost("/tuser/ZAREAList", { AREA_PCODE: pvalue }, function (uts) {
        if (!!uts.data) {
            $.each(uts.data, function (i, v) {
                $('<option value="' + v.AREA_CODE + '">' + v.AREA_NAME + '</option>').appendTo($("#" + cid));
            });
        }
    });
    $.ajaxSetup({ async: true });
}

/**************************************************************************************/

$(function (t) {
    $('select[dic]').each(function (k, v) {
        var dicfun = $(this).attr("dic");
        var cid = $(this).attr("id");

        if (dicfun) {
            if (dicfun.indexOf("(") > 0 && dicfun.indexOf(")") > 0) {
                eval(dicfun);
            } else {
                eval(dicfun + "('" + cid + "')");
            }
        }
    });
});

/*引用方式举例

DicHBFPArea('0', 'sheng');
DicHBFPArea('130000', 'shi');
        $("#" + cid + " option").each(function (k, v) {
            if ($(this).attr("value")) $(this).remove();
        });
        $.ajaxSetup({async: false});
        ajaxPost("/tpage/GetAreaCode", {"value": pvalue}, function (uts) {
            if (!!uts.data) {
                $.each(uts.data, function (i, v) {
                    $('<option value="' + v.AREA_CODE + '">' + v.AREA_NAME + '</option>').appendTo($("#" + cid));
                });
            }
        });
        $.ajaxSetup({async: true});
*/
