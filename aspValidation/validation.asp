<%

	'VALIDATION FUNCTIONS
	'NEEDED : REQUIRED, NEED INPUT (NO PARAM)
	Function needed ( value, arg )	
		If value <> "" Then needed = True Else needed = False End If
	End Function

	'ISALPHA : A-Za-z CHARACTER ONLY (NO PARAM)
	Function isAlpha ( value, arg ) 
		Dim re : Set re = New RegExp : re.Pattern = "^[A-Za-z]+$"
		If re.Test(value) Then isAlpha = True Else isAlpha = False End If
	End Function

	'ISALPHANUMERIC : A-Za-z0-9 CHARACTER ONLY (NO PARAM)
	Function isAlphaNumeric ( value, arg ) 
		Dim re : Set re = New RegExp : re.Pattern = "^[A-Za-z0-9]+$"
		If re.Test(value) Then isAlphaNumeric = True Else isAlphaNumeric = False End If
	End Function

	Class Rule 

		'INPUT ELEMENT NAME
		Private element
		'DISPLAY NAME
		Private name
		'VALIDATION FUNCTION NAME
		Private check
		'VALIDATION FUNCTION ARGUMENT
		Private params
		'ERROR MESSAGE
		Private message
		'DEFAULT ERROR MESSAGE
		Private defaultMessages

		'GETTER
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

		'CONSTRUCTOR
		'SET DEFAULT ERROR MESSAGE
		Private Sub Class_Initialize (  )
			set defaultMessages = CreateObject("Scripting.Dictionary")
			defaultMessages.Add "needed", " is not optional"
			defaultMessages.Add "isAlpha", " must be alphabet characters only"
			defaultMessages.Add "isAlphaNumeric", " must be alphabet and numeric characters only"
		End Sub

		'SET A RULE 
		'el : INPUT ELEMENT NAME ('name', 'email', 'phone', 'password')
		'na : DISPLAY NAME ('Username', 'Email', 'Your phone', 'The password')
		'ch : VALIDATION FUNCTION NAME ('needed', 'superiorThan', 'isTel', 'isMail')
		'pa : VALIDATION ARGUMENT ('', 10, '[A-Z]')
		'mes : ERROR MESSAGE IF NONE, DEFAULT ERROR MESSAGE IS USED (' must be shorter than 10', ' must be valid email')
		Public Sub setRule ( el, na, ch, pa, mes )
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

			Dim rulesArray
			Dim i
			rulesArray = rules.Items

			'LOOP TROUGH RULES
			For i = 0 To rules.Count - 1

				'SET VALIDATION FUNCTION NAME TO EXECUTE
				Dim myFunction : Set myFunction = GetRef(rulesArray(i).getCheck)

				'EXECUTE VALIDATION FUNCTION, DISPLAY ERROR MESSAGE ON FALSE
				If myFunction( Request.Form(rulesArray(i).getElement), rulesArray(i).getParams ) <> True Then 
					Response.Write("<p style=""color:red;"">" & rulesArray(i).getName & rulesArray(i).getMessage & "</p>")
				End If

			Next 
		End Sub

		Private Sub Class_Terminate (  )
		End Sub

	End Class
%>
