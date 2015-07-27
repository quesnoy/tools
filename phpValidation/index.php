<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>PHP Validation Test</title>
		<style type="text/css">
			table {
				border:1px solid black;
				border-collapse:collapse;
			}
			th {
				border:1px solid black;
				padding:6px;
			}
			td {
				border:1px solid black;
				padding:6px;
			}
			.center {
				text-align:center;
			}
		</style>
	</head>
	<body>
		<form action="index.php" method="post">
			<table>
				<tr>
					<th>NAME :</th>
					<td><input type="text" name="name" /></td>
				</tr>
				<tr>
					<th>AGE :</th>
					<td><input type="text" name="age" /></td>
				</tr>
				<tr>
					<th>EMAIL :</th>
					<td><input type="text" name="email" /></td>
				</tr>
				<tr>
					<td colspan="2" class="center"><input type="submit" value="OK" /></td>
				</tr>
			</table>
		</form>
	</body>
</html>
<?php

	if ( !empty($_POST) ) {
		include "validation.class.php";
		$rules = array(
			array('name', 'the name', 'required', 'Hey, %s must be input!'), 
			array('name', 'the name', 'isAlpha'), 
			array('age', 'the age',  'isInt'), 
			array('email', 'the email',  'isEmail'), 
		);
		$myValidation = new Validation($_POST, $rules);
		$validationResult = $myValidation->validate();
		if ( $validationResult ) {
			echo "NO ERROR !!!!";
		} else {
			print_r($myValidation->getErrors());
		}
	}

?>
