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
	$(document).ready(function() {
		var lastId = $("#last-id").html();
		
		$(".form-container").hide();
		$("#create").click(function() { pop_addpost(true); });
		$("#close-addform").click(function() { pop_addpost(false); });
		$("#close-editform").click(function() { pop_editpost(false); });
		$("#close-showbox").click(function() { pop_showbox(false); });
		$(".list-logout").click(function() { logout_ok(); });
		
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
		var a = confirm("정말로 삭제하겠습니까?");
		if(a) location.href='deleteok/' + id;
	}

	function pop_showbox(popup) {
		if (popup) { if (!editPopped) $("#show-container").fadeIn(300); }
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
	
</script>
</head>
<body>
<div class="board-container">
	<h1>CoVID Handong</h1>
	<div class="list-logout btn btn-blue">LOGOUT</div>
	<div class="member-info">
		<em><i>${user.getUsername()}</i> 님 환영합니다</em>
	</div>
	
	<table id="list">
	<tr>
		<th style="width: 15px;">
			<div class="btn btn-scale btn-create">
		      <input type="button" id="create">
		      <label for="create"><span></span></label>
		    </div>
		</th>
		<th>번호</th>
		<th>작성자</th>
		<th>확진판정일</th>
		<th>동선</th>
		<th>거주지</th>
		<th>작성일</th>
		<th>수정</th>
		<th>삭제</th>
	</tr>
	<c:forEach items="${list}" var="u">
		<tr id="show-${u.getId()}" onclick="fill_showbox('${u.getId()}', '${u.getWriter()}', '${u.getConfirmedDate()}', '${u.getResidence()}', '${u.getDetailRes()}', '${u.getFootTraffic()}')">
			<td id="last-id">${u.getId()}</td>
			<td>${u.getNumber()}</td>
			<td>${u.getWriter()}</td>
			<td>${u.getConfirmedDate()}</td>
			<td id="ft-col-${u.getId()}">${u.getFootTraffic()}</td>
			<td>${u.getResidence()}</td>
			<td id="pd-col-${u.getId()}">${u.getPostDate()}</td>
			<td>
				<c:if test="${user.getUsername() eq u.getWriter() or user.getUsername() eq 'admin'}">
					<div class="btn btn-blue btn-scale btn-edit" 
						onclick="edit_ok('${u.getId()}', '${u.getConfirmedDate()}', '${u.getResidence()}', '${u.getDetailRes()}', '${u.getFootTraffic()}')">
						<i class='far fa-edit'></i>
					</div>
				</c:if>
			</td>
			<td>
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
			<tr><th>확진일자</th><td><input type="date" name="confirmedDate"/></td></tr>
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
			<tr><th>확진일자</th><td><input id="confirmedDate" type="date" name="confirmedDate" value=""/></td></tr>
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
		
		
		<div>
			
		</div>
		
		<br>
	</form>
</div>
</body>
</html>