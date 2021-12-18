<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>free board</title>
<link rel="stylesheet" href="${path}/resources/css/board.css">
<link rel="stylesheet" href="${path}/resources/css/button.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" 
	integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	var editPopped = false;
	var delClicked = false;
	var lastId = 0;
	
	$(document).ready(function() {
		lastId = $("#last-id").attr("value");
		
		sort_view();
		order_icon();
		$(".form-container").hide();
		$("#create").click(function() { pop_addpost(true); });
		$("#close-addform").click(function() { pop_addpost(false); });
		$("#close-editform").click(function() { pop_editpost(false); });
		$("#close-showbox").click(function() { pop_showbox(false); });
		$(".list-logout").click(function() { logout_ok(); });
		$(".allow-sort").click(function() { order_icon(); $("#sort-submit").trigger("click"); });
		
		for (var i = 0; i < lastId; i++) fit_format(i + 1);
	});
	
	function fit_format(id) {
		var lengthLimit = 25;

		if ($("#ft-col-" + id).html() !== undefined) {
			var footTrafficStr = $("#ft-col-" + id).html();
			var postDateStr = $("#pd-col-" + id).html();
			
			if (footTrafficStr.length > lengthLimit)
				$("#ft-col-" + id).html(footTrafficStr.substring(0, lengthLimit) + " ...");
			$("#pd-col-" + id).html(postDateStr.substring(0, 10));
		}
	}
	
	function logout_ok() {
		location.href="../login/login";
		alert("로그아웃 되었습니다");
	}
	
	function pop_addpost(popup) {
		if (popup) $("#add-container").fadeIn(300);
		else $("#add-container").fadeOut(300);
	}
	
	function pop_editpost(popup) {
		if (popup) $("#edit-container").fadeIn(300); 
		else $("#edit-container").fadeOut(300);
		editPopped = popup;
	}
	
	function edit_ok(id, confirmedDate, residence, detailRes, footTraffic) {
		pop_editpost(true);
		$("#editform").attr("action", "editok/" + id);
		$("#confirmedDate").attr("value", confirmedDate);
		$("input:radio[name='residence']:radio[value='" + residence + "']").prop("checked", true);
		$("#detailRes").attr("value", detailRes);
		$("#footTraffic").html(footTraffic);
	}
	
	function delete_ok(id) {
		delClicked = true;
		var a = confirm("정말로 삭제하겠습니까?");
		if(a) location.href='deleteok/' + id;
	}

	function pop_showbox(popup) {
		if (popup) { 
			if (delClicked) $("#show-container").hide();
			else if (!editPopped) $("#show-container").fadeIn(300); 
			delClicked = false;
		}
		else $("#show-container").fadeOut(300);
	}
	
	function fill_showbox(id, writer, confirmedDate, residence, detailRes, footTraffic) {
		pop_showbox(true);
		$("#show-title").html(id + " - " + writer);
		$("#show-confirmedDate").html(confirmedDate);
		$("#show-residence").html(residence);
		$("#show-detailRes").html(detailRes);
		$("#show-footTraffic").html(footTraffic);
	}
	
	function order_icon() {
		$("#sort-id").click(function() { toggle_number("#sort-id", "id"); });
		$("#sort-writer").click(function() { toggle_number("#sort-writer", "writer"); });
		$("#sort-confirmedDate").click(function() { toggle_number("#sort-confirmedDate", "confirmedDate"); });
		$("#sort-footTraffic").click(function() { toggle_number("#sort-footTraffic", "footTraffic"); });
		$("#sort-residence").click(function() { toggle_number("#sort-residence", "residence"); });
		$("#sort-postDate").click(function() { toggle_number("#sort-postDate", "postDate"); });
	}
	
	function toggle_number(ident, header) {
		var col = $("#sort-col").attr("value");
		var dir = parseInt($("#sort-dir").attr("value"));
		
		if (isNaN(dir)) dir = 0;
		
		$("#sort-col").attr("value", header);
		$("#sort-dir").attr("value", (dir + 1) % 3); 
		
		show_sortIcons(header);
	}
	
	function hide_sortIcons() {
		hide_sortIcon("#label-id");
		hide_sortIcon("#label-writer");
		hide_sortIcon("#label-confirmedDate");
		hide_sortIcon("#label-footTraffic");
		hide_sortIcon("#label-residence");
		hide_sortIcon("#label-postDate");
	}
	
	function hide_sortIcon(ident) {
		$(ident).css("display", "none");
		$(ident).children(".fa-caret-up").css("display", "none");
		$(ident).children(".fa-caret-down").css("display", "none");
	}
	
	function show_sortIcons(header) {
		show_sortIcon("#label-" + header);
	}
	
	function show_sortIcon(ident) {
		if ($("#sort-dir").attr("value") !== "0") { 
			$(ident).css("display", "inline-block"); 
			if ($("#sort-dir").attr("value") === "1") {
				$(ident).children(".fa-caret-up").css("display", "flex");
				$(ident).children(".fa-caret-down").css("display", "none");
			}
			else {
				$(ident).children(".fa-caret-up").css("display", "none");
				$(ident).children(".fa-caret-down").css("display", "flex");
			}
		}
		else hide_sortIcon(ident);
	}
	
	function sort_view() {
		var col = $("#sort-col").attr("value");
		var dir = $("#sort-dir").attr("value");
		
		show_sortIcon("#label-" + col);
	}
	
</script>
</head>
<body>
<div class="board-container">
	<h1>CoVID Handong</h1>
	
	<input id="last-id" type="hidden" value="${lastId}"/>
	
	<div class="search-container">
		<form action="search">
			<table>
				<tr>
					<td><input type="text" placeholder="Search ..." id="search-ipt" name="toFind"/></td>
					<td>
						<div class="btn btn-gray btn-scale btn-edit">
							<label>
								<i id="search-icon" class='fas fa-search'></i>
								<input style="display: none;" type="submit">
							</label>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div class="list-logout btn btn-blue">LOGOUT</div>
	<div class="member-info">
		<em><i>${user.getUsername()}</i> 님 환영합니다</em>
	</div>
	
	<div class="sort-container">
		<form id="sortform" action="sort">
			<input id="sort-col" type="hidden" name="orderColumn" value="${orderColumn}">
			<input id="sort-dir" type="hidden" name="orderDir" value="${orderDir}">
			<input style="display: none;" id="sort-submit" type="submit"/>
		</form>
	</div>
	
	<table id="list">
	<tr>
		<th style="width: 15px;">
			<div class="btn btn-scale btn-create">
		      <input type="button" id="create">
		      <label for="create"><span></span></label>
		    </div>
		</th>
		<!-- <th class="allow-sort" id="sort-id">번호
			<label id="label-id"><i class="fas fa-caret-up"></i><i class="fas fa-caret-down"></i></label>
		</th> -->
		<th class="allow-sort" id="sort-writer">작성자
			<label id="label-writer"><i class="fas fa-caret-up"></i><i class="fas fa-caret-down"></i></label>
		</th>
		<th class="allow-sort" id="sort-confirmedDate">확진판정일
			<label id="label-confirmedDate"><i class="fas fa-caret-up"></i><i class="fas fa-caret-down"></i></label>
		</th>
		<th class="allow-sort" id="sort-footTraffic">동선
			<label id="label-footTraffic"><i class="fas fa-caret-up"></i><i class="fas fa-caret-down"></i></label>
		</th>
		<th class="allow-sort" id="sort-residence">거주지
			<label id="label-residence"><i class="fas fa-caret-up"></i><i class="fas fa-caret-down"></i></label>
		</th>
		<th class="allow-sort" id="sort-postDate">작성일
			<label id="label-postDate"><i class="fas fa-caret-up"></i><i class="fas fa-caret-down"></i></label>
		</th>
		<th>수정</th>
		<th>삭제</th>
	</tr>
	<c:forEach items="${list}" var="u">
		<tr id="show-${u.getId()}" onclick="fill_showbox('${u.getId()}', '${u.getWriter()}', '${u.getConfirmedDate()}', '${u.getResidence()}', '${u.getDetailRes()}', '${u.getFootTraffic()}')">
			<td style="width: 8%;" id="last-id">${u.getId()}</td>
			<%-- <td style="width: 8%;">${u.getNumber()}</td> --%>
			<td style="width: 8%;">${u.getWriter()}</td>
			<td style="width: 16%;">${u.getConfirmedDate()}</td>
			<td style="width: 24%;" id="ft-col-${u.getId()}">${u.getFootTraffic()}</td>
			<td style="width: 8%;">${u.getResidence()}</td>
			<td style="width: 16%;"id="pd-col-${u.getId()}">${u.getPostDate()}</td>
			<td style="width: 8%;">
				<c:if test="${user.getUsername() eq u.getWriter() or user.getUsername() eq 'admin'}">
					<div class="btn btn-blue btn-scale btn-edit" 
						onclick="edit_ok('${u.getId()}', '${u.getConfirmedDate()}', '${u.getResidence()}', '${u.getDetailRes()}', '${u.getFootTraffic()}')">
						<i class='far fa-edit'></i>
					</div>
				</c:if>
			</td>
			<td style="width: 8%;">
				<c:if test="${user.getUsername() eq u.getWriter() or user.getUsername() eq 'admin'}">	
					<div class="btn btn-scale btn-delete">
				      <input type="button" id="delete-${u.getId()}" onclick="delete_ok('${u.getId()}')">
				      <label for="delete-${u.getId()}"><span></span></label>
				    </div>
				</c:if>
		    </td>
		</tr>
	</c:forEach>
	</table>
</div>

<div id="add-container" class="form-container">
	<form action="addok" method="post">
		<h1>새 글쓰기</h1>
		<div class="btn btn-scale btn-delete btn-closeform">
			<input type="button" id="close-addform">
			<label for="close-addform"><span></span></label>
	    </div>
		<table id="add">
			<tr><th>작성자</th><td><input type="text" name="writer" value="${user.getUsername()}" readonly/></td></tr>
			<tr><th>확진일자</th><td><input type="date" name="confirmedDate" required/></td></tr>
			<tr><th>거주지</th>
				<td>
					<div class="radio-container">
						<input type="radio" id="add-dorm" name="residence" value="기숙사" checked>
						<label class="res-label" for="add-dorm"><span><span></span></span>기숙사</label>
						<input type="radio" id="add-out" name="residence" value="외부거주">
						<label class="res-label" for="add-out"><span><span></span></span>외부거주</label>
					</div>
				</td>
			</tr>
			<tr><th>상세거주지</th><td><input type="text" name="detailRes"/></td></tr>
			<tr><th>동선</th><td><textarea name="footTraffic"></textarea></td></tr>
		</table>
		<br>
		<div class="button-area">
			<input type="submit" id="submit-add"/>
			<label for="submit-add"><div>등록하기</div><span></span></label>
		</div>
	</form>
</div>

<div id="edit-container" class="form-container">
	<form id="editform" action="editok" method="post">
		<h1>글 수정</h1>
		<div class="btn btn-scale btn-delete btn-closeform">
			<input type="button" id="close-editform">
			<label for="close-editform"><span></span></label>
	    </div>
		<table id="edit">
			<tr><th>작성자</th><td><input type="text" name="writer" value="${user.getUsername()}" readonly/></td></tr>
			<tr><th>확진일자</th><td><input id="confirmedDate" type="date" name="confirmedDate" value="" required/></td></tr>
			<tr><th>거주지</th>
				<td>
					<div class="radio-container">
						<input type="radio" id="edit-dorm" name="residence" value="기숙사" checked>
						<label class="res-label" for="edit-dorm"><span><span></span></span>기숙사</label>
						<input type="radio" id="edit-out" name="residence" value="외부거주">
						<label class="res-label" for="edit-out"><span><span></span></span>외부거주</label>
					</div>
				</td>
			</tr>
			<tr><th>상세거주지</th><td><input id="detailRes" type="text" name="detailRes"/></td></tr>
			<tr><th>동선</th><td><textarea id="footTraffic" name="footTraffic"></textarea></td></tr>
		</table>
		<br>
		<div class="button-area">
			<input type="submit" id="submit-edit"/>
			<label for="submit-edit"><div>수정하기</div><span></span></label>
		</div>
	</form>
</div>

<div id="show-container" class="form-container">
	<form id="showbox" action="editok" method="post">
		<h1 id="show-title"></h1>
		<div class="btn btn-scale btn-delete btn-closeform">
			<input type="button" id="close-showbox">
			<label for="close-showbox"><span></span></label>
	    </div>
		<table id="show">
			<tr><th>확진일자</th><td colspan="3"><p id="show-confirmedDate"></p></td></tr>
			<tr>
				<th>거주지</th><td><p id="show-residence"></p></td>
				<th>상세거주지</th><td><p id="show-detailRes"></p></td>
			</tr>
			<tr><th id="ft-row">동선</th><td colspan="3"><p id="show-footTraffic"></p></td></tr>
		</table>
		<br>
	</form>
</div>
</body>
</html>