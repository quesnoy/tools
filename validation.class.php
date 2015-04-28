<?php

    include "validation.php";

    class Validation {

        protected $values = array();
        protected $rules = array();

        //CONSTRUCTOR
        //$values : array
        // 'name' => 'tom'
        // 'age' => 24
        // 'email' => tom@yahoo.com
        //$rules : array(array(key, validation(, error message)))
        // 'age', 'isInt', '%s must be a number'
        public function __construct($values, $rules) {

            //VALUES
            foreach ( $values as $key => $value ) {
                $this->setValues($key, $value);
            }

            //RULES
            foreach ( $rules as $k => $rule ) {
                if ( ( empty($rule) ) || ( !isset($rule[0]) ) || ( !isset($rule[1]) ) ) {
                    echo "ERROR : NO RULES SET";
                    exit;
                }

                if ( isset($rule[2]) ) {//CHECK FOR ERROR MESSAGE
                    $this->setRules($rule[0], $rule[1], $rule[2]);
                } else {
                    $this->setRules($rule[0], $rule[1]);
                }
            }
        }

        //SETTER
        public function setValues($key, $value) {
            $this->values[$key] = $value;
        }
        public function setRules($key, $validation, $error=null) {
            $this->rules[] = array('key' => $key, 'validation' => $validation, 'error' => $error);
        }

        //GETTER
        public function getValues() {
            return $this->values;
        }
        public function getRules() {
            return $this->rules;
        }

        //VALIDATE
        public function validate() {
            $result = true;
            foreach ( $this->rules as $k => $rule ) {
                if ( call_user_func($rule['validation'], $this->values[$rule['key']]) === false ) {
                    $result = false;
                }
            }
            return $result;
        }

        //DESTRUCTOR
        public function __destruct() {
        }

    }
?>
