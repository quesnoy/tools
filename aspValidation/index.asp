<!DOCTYPE html>
<!--#include file="validation.asp"-->
<html>
	<head>
		<meta charset="utf-8" />
		<title>ASP VALIDATION TEST</title>
	</head>
	<body>
		<form action="index.asp" method="post">
			NAME : <input type="text" name="name" /><br>
			PASSWORD : <input type="password" name="password" /><br>
			<input type="hidden" name="posted" value="1" /><input type="submit" value="OK" />
		</form>
		<%
			If Request.Form("posted") <> "" Then 
				Dim rules
				set rules = server.createObject("Scripting.Dictionary")

				Dim rula : set rula = New Rule : rula.setRule "name", "the name", "needed", "", " is very important"
				rules.add "1", rula

				Dim rulb : set rulb = New Rule : rulb.setRule "name", "the name", "isAlpha", "", ""
				rules.add "2", rulb

				Dim rulc : set rulc = New Rule : rulc.setRule "password", "the password", "needed", "", " is very very important"
				rules.add "3", rulc

				Dim ruld : set ruld = New Rule : ruld.setRule "password", "the password", "isAlphaNumeric", "", ""
				rules.add "4", ruld

				Dim myValidation
				set myValidation = New Validation
				myValidation.validate rules
			End If
		%>
	</body>
</html>
