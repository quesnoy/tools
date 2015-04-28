<?php
    function isInt($value) {
        return is_int($value);
    }
    function isAlpha($value) {
        if ( preg_match('/^[a-zA-Z]*$/', $value) == 1 ) {
            return true;
        } else {
            return false;
        }
    }
?>
