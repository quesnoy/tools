<?php

    //CONSTANT
    define('LOG_PATH', '');//FOLDER PATH TO SAVE LOG
    define('LOG_NAME', '');//FOLDER PATH TO SAVE LOG, USE date('Y-m-d').'NAMEOFFILE' TO LOG DAILY ...
    define('DEBUG', FALSE);//FALSE FOR LOGGING ERROR, TRUE FOR DISPLAYING ERROR

    class Log {

        public static function logOrDebug($message_type, $message) {
            if ( DEBUG ) {
                echo date('Y-m-d H:i:s') . ' | ' . $message_type . ' | ' . $message;
            } else {
                file_put_contents(LOG_PATH . LOG_NAME, date('Y-m-d H:i:s') . ' | ' . $message_type . ' | ' . $message, FILE_APPEND);
            }
        }
    }

   //USAGE : Log::logOrDebug('WARNING', 'THIS IS A WARNING MESSAGE');
   //USAGE : Log::logOrDebug('ERROR', 'THIS IS A ERROR MESSAGE');
?>
