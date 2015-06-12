<%
	Class Paging
	
		Private currentPage
		Private totalPage
		Private leftNumberPages 'NUMBER OF PAGES DISPLAYING ON THE LEFT SIDE OF THE CURRENT PAGE
		Private rightNumberPages 'NUMBER OF PAGES DISPLAYING ON THE RIGHT SIDE OF THE CURRENT PAGE
		Private totalDisplayedPages
		Private firstPage
		Private defaultTag 'PAGINATION HTML TAG
		Private pageGetName 'GET QUERY PAGE NAME
	
		'CONSTRUCTOR : SET DEFAULT VALUE
		Private Sub Class_Initialize (  )
			leftNumberPages = 2
			rightNumberPages = 2
			totalDisplayedPages = leftNumberPages + rightNumberPages + 1 'CURRENT PAGE
			firstPage = 1
			defaultTag = "<span>INDICE</span>"
			pageGetName = "page"
		End Sub
	
		'SET NUMBER TOTAL OF PAGES (REQUIRED)
		Public Property Let setTotalPage ( arg )
			totalPage = arg
		End Property
	
		'SET NUMBER OF PAGES DISPLAYING ON THE LEFT SIDE OF THE CURRENT PAGE
		'DEFAULT 2
		' 2 => X X CURRENTPAGE
		' 4 => X X X X CURRENTPAGE
		Public Property Let setLeftNumberPage ( arg )
			leftNumberPages = arg
		End Property
	
		'SET NUMBER OF PAGES DISPLAYING ON THE RIGHT SIDE OF THE CURRENT PAGE
		'DEFAULT 2
		' 2 => CURRENTPAGE X X
		' 4 => CURRENTPAGE X X X X
		Public Property Let setRightNumberPage ( arg )
			rightNumberPages = arg
		End Property
	
		'SET FIRST PAGE NUMBER
		'DEFAULT 1
		'EXAMPLE 0
		Public Property Let setFirstPage ( arg )
			firstPage = arg
		End Property

		'SET PAGINATION TAG
		'DEFAULT <span>INDICE</span>
		'INDICE REPLACED BY PAGE NUMBER (CURRENT PAGE = 5 => <span>5</span>
		'EXAMPLE : <b>INDICE</b>
		'EXAMPLE : <span class="myPageClass">INDICE</span>
		Public Property Let setDefaultTag ( arg )
			defaultTag = arg
		End Property

		'SET GET QUERY PAGE PARAMETER NAME
		'DEFAULT page
		'EXAMPLE : page_id, page_no ...
		Public Property Let setPageGetName ( arg )
			pageGetName = arg
		End Property

		'GET CURRENT PAGE FROM GET QUERY OR DEFAULT TO FIRST PAGE
		Private Sub GetCurrentPage ( ) 
			If ( Len(Request.QueryString(pageGetName)) > 0 ) Then 
				currentPage = CInt(Request.QueryString(pageGetName))
			Else 
				currentPage = firstPage
			End If
		End Sub
	
		'SET PAGE URL WITH GET QUERY STRING
		Private Function setUrl ( pageIndice )

			Dim url
			url = "?"

			If ( Len(Request.QueryString(pageGetName)) > 0 ) Then 
				url = url & Replace(Request.ServerVariables("QUERY_STRING"), pageGetName & "=" & currentPage, pageGetName & "=" & pageIndice)
			Else
				url = url & pageGetName & "=" & pageIndice & "&" & Request.ServerVariables("QUERY_STRING")
			End If

			setUrl = url

		End Function

		Public Function GetPaging ( ) 
	
			Dim pagingText
			Dim pageStart
			Dim pageEnd
			Dim i
			Dim getParams

			pagingText = ""
			getParams = Request.ServerVariables("QUERY_STRING")

			'CURRENT PAGE
			GetCurrentPage
	
			'FIRST PAGE
			If ( currentPage > firstPage ) AND ( totalPage > firstPage ) Then 
				pagingText = pagingText & Replace(defaultTag, "INDICE", "<a href=""" & setUrl(firstPage) & """> &lt;&lt; FIRST </a>")
			End If

			'PREVIOUS PAGE
			If ( currentPage > firstPage ) Then 
				pagingText = pagingText & Replace(defaultTag, "INDICE", "<a href=""" & setUrl(currentPage - 1) & """> &lt; PREVIOUS </a>")
			End If
	
			'START PAGE
			If ( ( currentPage - leftNumberPages ) > firstPage ) Then 
				pageStart = currentPage - leftNumberPages
			Else 
				pageStart = firstPage
			End If 
	
			'END PAGE
			If ( ( currentPage + rightNumberPages ) < totalPage ) Then 
				pageEnd = currentPage + rightNumberPages
			Else 
				pageEnd = totalPage
			End If
	
			For i = pageStart To pageEnd 
				If ( i = currentPage ) Then 
					pagingText = pagingText & Replace(defaultTag, "INDICE", " " & i & " ")
				Else 
					pagingText = pagingText & Replace(defaultTag, "INDICE", "<a href=""" & setUrl(i) & """> " & i & " </a>")
				End If
			Next

			'NEXT PAGE
			If ( currentPage < totalPage ) Then 
				pagingText = pagingText & Replace(defaultTag, "INDICE", "<a href=""" & setUrl(currentPage + 1) & """> NEXT &gt; </a>")
			End If
	
			'LAST PAGE
			If ( currentPage <> totalPage ) Then
				pagingText = pagingText & Replace(defaultTag, "INDICE", "<a href=""" & setUrl(totalPage) & """> LAST &gt;&gt; </a>")
			End If
	
			GetPaging = pagingText	
	
		End Function
	
		Private Sub Class_Terminate (  )
		End Sub
	End Class
%>
