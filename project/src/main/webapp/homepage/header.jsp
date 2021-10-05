<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<br>
<div id="logo">
	<a href="/project/homepage/index.jsp"><img
		src="/project/homepage/images/index/logo.png" id="logo"></a>
</div>
<br>

<div class="navi">

	<ul class="menu">
		<li><span id="menu_notice"><a href="/project/homepage/menu/notice/notice.jsp">공지사항</a></span></li>
		<li><span id="menu_process"><a href="/project/homepage/menu/process/process.jsp">진행교육과정</a></span></li>
		<li><span id="menu_recruit"><a href="/project/homepage/menu/recruit/recruit.jsp">모집중인과정</a></span></li>
		<li><span id="menu_board"><a href="/project/homepage/menu/board/board.jsp">게시판</a></span></li>
		<li><span id="menu_ad"><a href="/project/homepage/menu/ad/ad.jsp">구인정보</a></span></li>
		<li><span id="menu_enter"><a href="/project/homepage/menu/enter/enter.jsp">문의사항</a></span></li>
		<li><span id="menu_introduce"><a href="/project/homepage/menu/introduce/introduce.jsp">교육원소개</a></span></li>
		<li><span id="menu_road"><a href="/project/homepage/menu/road/road.jsp">찾아오는길</a></span></li>
	</ul>

</div>

<hr>

<script>
/* ===========================================header menu css================================================ */

$("#menu_notice").on({
    "mouseover": function () {
        $("#menu_notice").css({ "font-size": "18px" });
    },
    "mouseleave": function () {
        $("#menu_notice").css({ "font-size": "16px" });
    }
});

$("#menu_process").on({
    "mouseover": function () {
        $("#menu_process").css({ "font-size": "18px" });
    },
    "mouseleave": function () {
        $("#menu_process").css({ "font-size": "16px" });
    }
});

$("#menu_recruit").on({
    "mouseover": function () {
        $("#menu_recruit").css({ "font-size": "18px" });
    },
    "mouseleave": function () {
        $("#menu_recruit").css({ "font-size": "16px" });
    }
});

$("#menu_board").on({
    "mouseover": function () {
        $("#menu_board").css({ "font-size": "18px" });
    },
    "mouseleave": function () {
        $("#menu_board").css({ "font-size": "16px" });
    }
});

$("#menu_ad").on({
    "mouseover": function () {
        $("#menu_ad").css({ "font-size": "18px" });
    },
    "mouseleave": function () {
        $("#menu_ad").css({ "font-size": "16px" });
    }
});

$("#menu_enter").on({
    "mouseover": function () {
        $("#menu_enter").css({ "font-size": "18px" });
    },
    "mouseleave": function () {
        $("#menu_enter").css({ "font-size": "16px" });
    }
});

$("#menu_introduce").on({
    "mouseover": function () {
        $("#menu_introduce").css({ "font-size": "18px" });
    },
    "mouseleave": function () {
        $("#menu_introduce").css({ "font-size": "16px" });
    }
});

$("#menu_road").on({
    "mouseover": function () {
        $("#menu_road").css({ "font-size": "18px" });
    },
    "mouseleave": function () {
        $("#menu_road").css({ "font-size": "16px" });
    }
});

/* ======================================================================================================= */
</script>