<%

	Function needed ( value, arg )	
		If value <> "" Then needed = True Else needed = False End If
	End Function

	Function isAlpha ( value, arg ) 
		Dim re : Set re = New RegExp : re.Pattern = "^[A-Za-z]+$"
		If re.Test(value) Then isAlpha = True Else isAlpha = False End If
	End Function

	Function isAlphaNumeric ( value, arg ) 
		Dim re : Set re = New RegExp : re.Pattern = "^[A-Za-z0-9]+$"
		If re.Test(value) Then isAlphaNumeric = True Else isAlphaNumeric = False End If
	End Function

	Class Rule 

		Private element
		Private name
		Private check
		Private params
		Private message
		Private defaultMessages

		Public Property Get getElement(  )
			getElement = element
		End Property

		Public Property Get getName(  )
			getName = name
		End Property

		Public Property Get getCheck(  )
			getCheck = check
		End Property

		Public Property Get getParams(  )
			getParams = params
		End Property

		Public Property Get getMessage(  )
			getMessage = message
		End Property

		Private Sub Class_Initialize (  )
			set defaultMessages = CreateObject("Scripting.Dictionary")
			defaultMessages.Add "needed", " is not optional"
			defaultMessages.Add "isAlpha", " must be alphabet characters only"
			defaultMessages.Add "isAlphaNumeric", " must be alphabet and numeric characters only"
		End Sub

		Private Sub clearRule () 
			element = ""
			name = "" 
			check = ""
			params = "" 
			message = "" 
		End Sub

		Public Sub setRule ( el, na, ch, pa, mes )
			clearRule
			element = el
			name = na
			check = ch
			params = pa
			If mes <> "" Then 
				message = mes
			Else
				message = defaultMessages.Item(check)
			End If
		End Sub
	
		Private Sub Class_Terminate (  )
		End Sub

	End Class

	Class Validation

		Private Sub Class_Initialize (  )
		End Sub

		Public Sub validate ( rules )
			Dim a
			Dim i
			a = rules.Items
			For i = 0 To rules.Count - 1
				Dim myFunction : Set myFunction = GetRef(a(i).getCheck)
				If myFunction( Request.Form(a(i).getElement), a(i).getParams ) <> True Then 
					Response.Write("<p style=""color:red;"">" & a(i).getName & a(i).getMessage & "</p>")
				End If
			Next 
		End Sub

		Private Sub Class_Terminate (  )
		End Sub

	End Class
%>
