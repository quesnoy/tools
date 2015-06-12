<!DOCTYPE html>
<!--#include file="validation.asp"-->
<html>
	<head>
		<meta charset="utf-8" />
		<title>ASP VALIDATION TEST</title>
	</head>
	<body>
		<%
			Dim rule
			set rule = New Rule
			Dim rules
			set rules = server.createObject("Scripting.Dictionary")
			rule.setRule("name", "needed", "", "")
			rules.add "1", rule
			rule.setRule("name", "isAlpha", "", "")
			rules.add "2", rule
			rule.setRule("password", "needed", "", "")
			rules.add "3", rule
			rule.setRule("password", "isAlphaNumeric", "", "")
			rules.add "4", rule
			Dim validation
			set validation = New Validation
			validation.validate(rules)
		%>
	</body>
</html>
