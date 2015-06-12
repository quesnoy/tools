<!DOCTYPE html>
<!--#include file="paging.asp"-->
<html>
	<head>
		<meta charset="utf-8" />
		<title>ASP PAGING TEST</title>
	</head>
	<body>
		<%
			Dim objPaging
			Set objPaging = New Paging
			objPaging.setTotalPage = 29 
			objPaging.setLeftNumberPage = 5
			objPaging.setRightNumberPage = 5
			objPaging.setFirstPage = 0
			objPaging.setDefaultTag = "<b class=""aaa""> INDICE </b>" 
			objPaging.setPageGetName = "page_id" 
			Response.Write(objPaging.GetPaging())
		%>
	</body>
</html>
