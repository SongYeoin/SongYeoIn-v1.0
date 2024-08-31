<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>송파여성인력개발센터</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style>

/* CSS Reset */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

html, body {
	height: 1080px;
}

body {
	font-family: Arial, sans-serif;
	display: flex;
	flex-direction: column;
	/* min-height: 100vh; */
}

main {
	flex: 1;
	margin-left: 300px;
	margin-top: 110px;
	overflow-y: auto;
	height: 100%;
}

.input_wrap {
	padding: 5px 20px;
}

label {
	display: block;
	margin: 10px 0;
	font-size: 20px;
}

input {
	padding: 5px;
	font-size: 17px;
}

.large-input{
	width: 500px;
}

textarea {
	width: 800px;
	height: 95px;
	font-size: 15px;
	padding: 10px;
}

.btn {
	display: inline-block;
	font-size: 22px;
	padding: 6px 12px;
	background-color: #fff;
	border: 1px solid #ddd;
	font-weight: 600;
	width: 140px;
	height: 41px;
	line-height: 39px;
	text-align: center;
	margin-left: 30px;
	cursor: pointer;
}

.btn_wrap {
	padding-left: 80px;
	margin-top: 50px;
}
</style>
</head>
<body>

	<!-- 메뉴바 연결 -->
	<%@ include file="../../common/header.jsp"%>

	<!-- 사이드바 연결 -->
	<%@ include file="../aside.jsp"%>

	<main>
		<!-- Main content -->
		<div>
			<h1>조회 페이지</h1>
			<div class="input_wrap">
				<label>번호</label>
				<input name="rn" readonly="readonly" value='<c:out value="${param.rn }"/>'>
			</div>
			<div class="input_wrap">
				<label>작성자</label>
				<input name="memberName" readonly="readonly" value='<c:out value="${pageInfo.enroll.member.memberName }"/>'>
			</div>
			<div class="input_wrap">
				<label>참여자</label>
				<input name="join" readonly="readonly" class="large-input" value='<c:out value="${pageInfo.join}"/>'>
			</div>
			<div class="input_wrap">
				<label>내용</label>
				<textarea rows="3" name="content" readonly="readonly"><c:out value="${pageInfo.content}" /></textarea>
			</div>
			<div class="input_wrap">
				<label>승인상태</label>
				<input name="checkStatus" readonly="readonly"
					value="${pageInfo.checkStatus == 'W' ? '대기' :
                  (pageInfo.checkStatus == 'Y' ? '승인' :
                  (pageInfo.checkStatus == 'N' ? '미승인' : '알 수 없음'))}">
			</div>
                  
			<div class="input_wrap">
				<label>승인메시지</label>
				<input name="checkCmt" readonly="readonly" value='<c:out value="${pageInfo.checkCmt }"/>'>
			</div>
			<div class="input_wrap">
				<label>활동일</label>
				<input name="studyDate" readonly="readonly" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${pageInfo.studyDate }"/>'>
			</div>
			<div class="input_wrap">
				<label>작성일</label>
				<input name="regDate" readonly="readonly" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${pageInfo.regDate }"/>'>
			</div>
			
			<div class="input_wrap">
				<label>첨부파일</label>
				<c:choose>
				<c:when test="${pageInfo.fileName != null && !pageInfo.fileName.isEmpty() }">
				<input name="file" readonly="readonly" class="large-input" value='<c:out value="${pageInfo.fileName }"/>'>
				</c:when>
				<c:otherwise>
				<input name="file" readonly="readonly" value="첨부파일 없음">
				</c:otherwise>
			</c:choose>
			</div>
			
			<div class="btn_wrap">
				<a class="btn" id="list_btn">목록 페이지</a>
				<c:if test="${pageInfo.enroll.member.memberNo == sessionScope.loginMember.memberNo }">
				<c:if test="${pageInfo.checkStatus != 'N' }">
				<a class="btn" id="modify_btn">수정</a>
				<a class="btn" id="delete_btn">삭제</a>
				</c:if>
				</c:if>
			</div>
			<form id="infoForm" action="/member/club/modify" method="get">
				<input type="hidden" id="clubNo" name="clubNo" value='<c:out value="${pageInfo.clubNo }"/>'>
				<input type="hidden" id="keyword" name="keyword" value="${cri.keyword}">
				<input type="hidden" id="type" name="type" value="${cri.type}">
				<input type="hidden" id="rn" name="rn" value='<c:out value="${param.rn }"/>'>
				<input type="hidden" id="classNo" name="classNo" value="${param.classNo}">
			</form>
		</div>
	</main>

	<!-- 푸터 연결 -->
	<%@ include file="../../common/footer.jsp"%>

	<script>
		let form = $("#infoForm");

		$("#list_btn").on("click", function(e) {
			form.find("#clubNo").remove();
			form.find("#rn").remove();
			form.find("#keyword").remove();
			form.find("#type").remove();
			form.attr("action", "/member/club/list");
			form.submit();
		});

		$("#modify_btn").on("click", function(e) {
			form.find("#keyword").remove();
			form.find("#type").remove();
			form.attr("action", "/member/club/modify");
			form.submit();
		});
		
		$("#delete_btn").on("click", function(e){
			e.preventDefault(); // 폼의 기본 제출을 방지
	        if (confirm("정말로 삭제하시겠습니까?")) {
	            form.attr("action", "/member/club/delete");
	            form.attr("method", "post");
	            form.submit();
	        }
		});
		
	</script>

</body>
</html>