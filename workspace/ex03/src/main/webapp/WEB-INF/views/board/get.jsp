<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board Read</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">Board Read Page</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<div class="form-group">
						<label>Bno</label><input class="form-control" name="bno"
							value="<c:out value='${board.bno}'/>" readonly="readonly">
						<div class="form-group">
							<label>Title</label><input class="form-control" name="title"
								value="<c:out value='${board.title}'/>" readonly="readonly">
						</div>

						<div class="form-group">
							<label>Text area</label>
							<textarea class="form-control" rows="3" name='content'
								readonly="readonly"><c:out value="${board.content}" /></textarea>
						</div>
						<div class="form-group">
							<label>Writer</label><input class="form-control" name="writer"
								value="<c:out value='${board.writer}'/>" readonly="readonly">
						</div>
						<%-- <button data-oper='modify' class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno }"/>'">Modify</button> --%>
						<!-- <button data-oper='list' class="btn btn-info" onclick="location.href='/board/list'">List</button> -->
						<button data-oper='modify' class="btn btn-default">Modify</button>
						<button data-oper='list' class="btn btn-info">List</button>
						
						<form action="/board/modify" id="operForm" method="get">
							<input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno }'/>">
							<%-- <input type="hidden" name="pageNum" value="${cri.pageNum}"> 
							<input type="hidden" name="amount" value="${cri.amount}"> --%>
							<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum }'/>"> 
							<input type="hidden" name="amount" value="<c:out value='${cri.amount }'/>">
							<input type="hidden" name="keyword" value="<c:out value='${cri.keyword }'/>">
							<input type="hidden" name="type" value="<c:out value='${cri.type }'/>">
						</form>
						
					</div>
					<!-- end panel body -->
				</div>
				<!-- end panel body -->
			</div>
			<!-- end panel -->
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
			
			<!-- /.panel -->
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i> Reply
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<ul class="chat">
						<!-- start reply -->
						<li class="left clearfix" data-rno='114'>
						 <div>
							<div class="header">
								<strong class="primary-font">user00</strong>
								<small class="pull-right text-muted">2018-01-01 13:13</small>
							</div>
							<p>Good job!</p>
						</div>
						</li>
						<!-- end reply -->
					</ul>
					<!-- ./ end ul -->
				</div>
				<!-- /.panel .chat-panel -->
			</div>
			</div>
			<!-- ./ end row -->
		</div>
		<script type="text/javascript" src ="/resources/js/reply.js"></script>
		<script type="text/javascript">
		$(document).ready(function() {
			var bnoValue = '<c:out value="${board.bno}"/>';
			var replyUL = $(".chat");
			// 페이지 파라미터값이 없는 경우 자동으로 1페이지가 되도록 설정
			showList(1);
			function showList(page) {
				console.log("page1: " + page);
				// 만일 1페이지가 아닌경우
				replyService.getList({bno : bnoValue, page : page || 1 }, function(list) {
					console.log("page2: " + page);
					var str ="";
					if (list == null || list.length ==0) {
						replyUL.html("");
						return;
					}
					for (var i=0, len = list.length || 0; i<len; i++){
						str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
						str += " <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
						str += " <small class='pull-right text muted'>" + list[i].replyDate+"</small></div>";
						str += " <p>"+list[i].reply+"</p></div></li>";
					}
					replyUL.html(str);
					
				});	//end function
			}	// end showList
		});
		</script>
		<script type="text/javascript">
		
			// reply.js파일에서 replyService 객체를 출력
			console.log("===========");
			console.log("JS TEST");
			
			var bnoValue = '<c:out value="${board.bno}"/>';
			
			console.log("bnoValue: " + bnoValue);
			
			// for replyService add test
			/* replyService.add(
				{reply:"JS TEST", replyer:"tester", bno:bnoValue},
				function(result) {
					alert("RESULT: " + result);
				}
					
			); */
			
			// reply List Test
			replyService.getList({bno:bnoValue, page:1}, function(list) {
				
				for (var i = 0, len = list.length || 0; i<len; i++) {
					console.log(list[i]);			
				}
			});
			
			// 116번 댓글 삭제 테스트
			/*
			replyService.remove(115, function(count) {
				
				console.log(count);
				alert(count);
				
				if (count === "success") {
					alert("REMOVED");
				}
			}, function(err) {
				alert("ERROR...");
			});
			*/
			
			// 114번 댓글 수정
			/*
			replyService.update({
				rno : 114,
				bno : bnoValue,
				reply : "Modified Reply..."
			}, function(result) {
				alert("수정 완료...");
			});
			*/
			
			//get 테스트
			/*
			replyService.get(114, function(data) {
				
				console.log(data);
			});
			*/
		</script>
		<script type="text/javascript">
			$(document).ready(function() {
				//alert("test");
				var openForm = $("#operForm");
				$("button[data-oper='modify']").on("click", function(e) {
					openForm.attr("action", "/board/modify").submit();
				});
				$("button[data-oper='list']").on("click", function(e) {
					openForm.find("#bno").remove();
					openForm.attr("action", "/board/list");
					openForm.submit();
				});
			});
		</script>

		<%@include file="../includes/footer.jsp"%>
</body>
</html>