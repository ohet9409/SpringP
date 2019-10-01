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
					<form action="/board/modify" role="form" method="post">
					<!-- 추가 -->
							<%-- <input type="hidden" name="pageNum" value="${cri.pageNum}"> 
							<input type="hidden" name="amount" value="${cri.amount}"> --%>
							<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum }'/>"> 
							<input type="hidden" name="amount" value="<c:out value='${cri.amount }'/>">
							<input type="hidden" name="keyword" value="<c:out value='${cri.keyword }'/>">
							<input type="hidden" name="type" value="<c:out value='${cri.type }'/>">
						<div class="form-group">
							<label>Bno</label><input class="form-control" name="bno"
								value="<c:out value='${board.bno}'/>" readonly="readonly">
							<div class="form-group">
								<label>Title</label><input class="form-control" name="title"
									value="<c:out value='${board.title}'/>" >
							</div>

							<div class="form-group">
								<label>Text area</label>
								<textarea class="form-control" rows="3" name='content'
									><c:out value="${board.content}" /></textarea>
							</div>
							<div class="form-group">
								<label>Writer</label><input class="form-control" name="writer"
									value="<c:out value='${board.writer}'/>" readonly="readonly">
							</div>
							<button data-oper='modify' class="btn btn-default" type="submit">Modify</button>
								<button data-oper='remove' class="btn btn-danger" type="submit">Remove</button>
							<button data-oper='list' class="btn btn-info">List</button>
					</form>
				</div>
				<!-- end panel body -->
			</div>
			<!-- end panel body -->
		</div>
		<!-- end panel -->
	</div>
	<!-- /.row -->
	<%@include file="../includes/footer.jsp"%>
	<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form");
		$('button').on("click", function(e) {
			e.preventDefault();
			/* button data-oper='modify' */
			var operation = $(this).data("oper");
			//console.log(operation);
			//alert(operation);
			if (operation === 'remove') {
				/* form태그의 action값 변경 */
				formObj.attr("action","/board/remove");
			}else if (operation === 'list') {
				// move to list
				/* self.location="/board/list";
				return; */
				formObj.attr("action", "/board/list").attr("method","get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
			}
			formObj.submit();
		});
	});
	</script>
</body>
</html>