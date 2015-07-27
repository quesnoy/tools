<?php

    include "validation.php";

	define('RULE_KEY', 0);
	define('RULE_KEY_NAME', 1);
	define('RULE_METHOD', 2);
	define('RULE_ERROR_MESSAGE', 3);
	
    class Validation {

        protected $values = array();
        protected $rules = array();
		protected $errors = array();
		
		protected $defaultErrors = array(
					'required' => '%s is needed!', 
					'isAlpha' => '%s must be alphabet only!', 
					'isInt' => '%s must be a integer only!', 
					'isEmail' => '%s must be a valid email!', 
		);

        //CONSTRUCTOR
        //$values : array
        // 'name' => 'tom'
        // 'age' => 24
        // 'email' => tom@yahoo.com
        //$rules : array(array(key, key name, method(, error message)))
        // 'age', 'isInt', 'the age', '%s must be a number'(printf format)
        public function __construct($values, $rules) {

            //VALUES
            foreach ( $values as $key => $value ) {
                $this->setValues($key, $value);
            }

            //RULES
            foreach ( $rules as $k => $rule ) {
                if ( ( empty($rule) ) || ( !isset($rule[RULE_KEY]) )|| ( !isset($rule[RULE_KEY_NAME]) ) || ( !isset($rule[RULE_METHOD]) ) ) {
                    echo "ERROR : NO RULES SET";
                    exit;
                }

                if ( isset($rule[RULE_ERROR_MESSAGE]) ) {//CHECK FOR ERROR MESSAGE
                    $this->setRules($rule[RULE_KEY], $rule[RULE_KEY_NAME], $rule[RULE_METHOD], $rule[RULE_ERROR_MESSAGE]);
                } else {
                    $this->setRules($rule[RULE_KEY], $rule[RULE_KEY_NAME], $rule[RULE_METHOD]);
                }
            }
        }

        //SETTER
        public function setValues($key, $value) {
            $this->values[$key] = $value;
        }
        public function setRules($key, $name, $method, $error=null) {
            $this->rules[] = array('key' => $key, 'name' => $name, 'method' => $method, 'error' => $error);
        }

        //GETTER
        public function getValues() {
            return $this->values;
        }
        public function getRules() {
            return $this->rules;
        }
		public function getErrors() {
            return $this->errors;
        }

        //VALIDATE
        public function validate() {
            $result = true;
            foreach ( $this->rules as $k => $rule ) {
                if ( call_user_func($rule['method'], $this->values[$rule['key']]) === false ) {
                    $result = false;
					$this->errors[$rule['key']][] = ( isset($rule['error']) ? sprintf($rule['error'], $rule['name']) : sprintf($this->defaultErrors[$rule['method']], $rule['name']) );
                }
            }
            return $result;
        }

        //DESTRUCTOR
        public function __destruct() {
        }

    }
?>
