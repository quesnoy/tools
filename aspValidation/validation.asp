<%
	Class Rule 

		Private element
		Private check
		Private params
		Private message

		Private Sub Class_Initialize (  )
		End Sub

		Public Sub setRule ( el, ch, pa, me )
			element = el
			check = ch
			params = pa
			message = me
		End Sub
	
		Private Sub Class_Terminate (  )
		End Sub

	End Class

	Class Validation

		Private defaultMessage

		Private Sub Class_Initialize (  )
			Set defaultMessage = CreateObject("Scripting.Dictionary") 
			defaultMessage.Add "needed", " is not optional"
			defaultMessage.Add "isAlpha", " should only contain alphabet characters"
			defaultMessage.Add "isAlphaNumeric", " should only contain alphabet and numeric characters"
		End Sub

		Public Property Get getDefaultMessage( arg )
			getDefaultMessage = defaultMessage.Item(arg)
		End Property

		Public Function validate ( rules )
		End Function

		Private Sub Class_Terminate (  )
		End Sub

	End Class
%>
