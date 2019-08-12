<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<html>
<link rel="stylesheet" href="css/index.css">
<body>
<div class="screen">
    <h4 class="header-panel">谁是卧底</h4>
    设置玩家人数:<input type="text" id="size" value=""/><br>
    设置第一个词语:<input type="text" id="first" value=""/><br>
    设置第二个词语:<input type="text" id="second" value=""/><br>
    <input class="buttons" type="button" onclick="create()" value="创建"/>
    <div id="displayAnti"></div>
    <br>
</div>
<div id="roomId"></div>
<div id="display"></div>
<script>
    displayAntis(0);

    function displayAntis(page) {
        var url = location.search;
        var openId = "";
        if (url.indexOf("?") != -1) {
            openId = url.substr(1).split("=")[0];
        }
        if (openId == null || openId == "")
            alert("请在微信登陆");
        var xhr = new XMLHttpRequest();
        xhr.open("post", "/spy/test/getAntistop?page=" + page + "&openId=" + openId, true);
        xhr.onreadystatechange = function () {
            if (xhr.status == 200) {
                if (xhr.readyState == 4) {

                    var result = JSON.parse(xhr.responseText);
                    document.getElementById("size").value = 5;
                    document.getElementById("first").value = result.data.first;
                    document.getElementById("second").value = result.data.second;
                    page = page + 1;
                    document.getElementById("displayAnti").innerHTML = "<input class='chang' type='button' value='换' onclick='displayAntis(" + page + ")'/>";
                } else {
                    alert("请求失败");
                }
            } else {
                alert("请求失败");
            }
        }
        xhr.send(null);
    }

    function create() {
        var url = location.search;
        var theRequest = new Object();
        var openId = "";
        if (url.indexOf("?") != -1) {
            openId = url.substr(1).split("=")[0];
        }
        var size = document.getElementById("size").value;
        var first = document.getElementById("first").value;
        var second = document.getElementById("second").value;
        var xhr = new XMLHttpRequest();
        xhr.open("post", "/spy/test/careate?size=" + size + "&openid=" + openId + "&fisrt=" + first + "&second=" + second, true);
        xhr.onreadystatechange = function () {
            if (xhr.status == 200) {
                if (xhr.readyState == 4) {
                    var result = JSON.parse(xhr.responseText);
                    if (result.status == 1) {
                        document.getElementById("roomId").innerText = "房间id:" + result.data[0];
                        document.getElementById("display").innerHTML = "房间二维码:<br>" + "<img  src=" + result.data[1] + ">";
                    } else {
                        document.getElementById("display").innerText = result.msg;
                    }

                }
            }
        }
        xhr.send(null);
    }
</script>
</body>
</html>
