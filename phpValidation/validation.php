<?php
	function required ($value) {
		return ( $value != '' ? true : false );
	}
    function isInt ($value) {
        return ( preg_match('/^[0-9]*$/', $value) == 1 ? true : false );
    }
    function isAlpha ($value) {
		return ( preg_match('/^[a-zA-Z]*$/', $value) == 1 ? true : false );
    }
	function isEmail ($value) {
		return ( preg_match('/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i', $value) == 1 ? true : false );	
	}
?>

