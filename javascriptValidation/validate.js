//CONSTRUCTOR NEED THE FORM TO VALIDATE
//VALIDATE METHOD NEED RULES AND MESSAGES 
function formValidate ( theForm ) {

	//FORM TO CHECK
	this.form = theForm;
	//FILLED WITH ERROR MESSAGE ON ERROR
	this.errorMessages = {};
	//DEFAULT ERROR MESSAGE
	this.defaultMessages = {};
	this.setDefaultMessage = function () {
		this.defaultMessages = {
				'needed' : ' is not optional', 
				'isAlpha' : ' should contain only alphabet characters', 
				'isAlphaNumeric' : ' should contain only alphabet or numeric characters'
		}		
	}
	//DEFAULT ERROR TAG
	this.defaultTag = '<br><span style="color:red;">ERROR_MESSAGE</span>';

	//VALIDATION METHOD
	//NEEDED : REQUIRED, NEED INPUT (NO PARAM)
	//EL : ELEMENT NAME
	//PARAM : PARAM
	this.needed = function ( el, param ) {
		return this.form.elements.namedItem(el).value != '' ? true : this.defaultMessages['needed'];
	}
	//ISALPHA : A-Za-z CHARACTER ONLY (NO PARAM)
	//EL : ELEMENT NAME
	//PARAM : PARAM
	this.isAlpha = function ( el, param ) {
		return /^[A-Za-z]+$/.test(this.form.elements.namedItem(el).value) ? true : this.defaultMessages['isAlpha'];
	}
	//ISALPHANUMERIC : A-Za-z0-9 CHARACTER ONLY (NO PARAM)
	//EL : ELEMENT NAME
	//PARAM : PARAM
	this.isAlphaNumeric = function ( el, param ) {
		return /^[A-Za-z0-9]+$/.test(this.form.elements.namedItem(el).value) ? true : this.defaultMessages['isAlphaNumeric'];
	}
	
	//REPLACE DEFAULT MESSAGE IF PRESENT
	//MESSAGES : MESSAGES TO SET
	this.setMessages = function ( messages ) {
		for ( var key in messages ) {
			if ( messages.hasOwnProperty(key) && this.defaultMessages.hasOwnProperty(key) ) {
				this.defaultMessages[key] = messages[key];
			}
		}
	}

	//REPLACE DEFAULT ERROR TAG FOR DISPLAY => '<tag>ERROR_MESSAGE</tag>' FORMAT  
	//TAG : TAG TO SET
	this.setTag = function ( tag ) {
		this.defaultTag = tag;
	}

	//DISPLAY ERRROR MESSAGE 
	this.displayErrors = function () {
		if ( !isObjEmpty(this.errorMessages) ) {
			for ( var k in this.errorMessages ) {
		  		if (this.errorMessages.hasOwnProperty(k)) {
					for (index = 0; index < this.errorMessages[k].length; index++) {
						this.form.elements.namedItem(k).outerHTML += this.defaultTag.replace('ERROR_MESSAGE', this.errorMessages[k][index]);
					}
				}
			}
		}
	}

	//CHECK ONE RULE AND SET ERROR MESSAGE ON ERROR
	// RULE : VALIDATION METHOD NAME
	//ELEMENT : ELEMENT NAME
	//PARAM : VALIDATION METHOD PARAM
	//NAMING : NAME FOR THE ELEMENT
	this.checkRule = function (rule, element, param, naming) {
		var check = this[rule](element, param);
		if (  check !== true ) {
			if ( typeof this.errorMessages[element] === 'undefined' ) {
				this.errorMessages[element] = [];
			}
			this.errorMessages[element].push(naming + ' ' + check);
		}		
	}
	
	//LOOP TROUGH EACH RULE AND SET ERROR MESSAGE ON ERROR
	//ELEMENT : ELEMENT NAME
	//RULES : ARRAY OF VALIDATION NAME
	//NAMING : NAME FOR THE ELEMENT
	this.loopTroughRules = function (element, rules, naming) {
		for (var rule in rules) {
			if (rules.hasOwnProperty(rule)) {
				this.checkRule(rule, element, rules[rule], naming);
			}
		}		
	}
	
	//VALIDATE THE FORM
	//LOOP TROUGHT THE RULES, AND VALIDATE EACH ONE, THEN RETURN ERROR MESSAGE IF FALSE
	//ELEMENTS : ELEMENTS RULES
	this.validate = function ( elements ) {
		for (var element in elements) {
			if (elements.hasOwnProperty(element)) {
				this.setDefaultMessage();
				this.setMessages(elements[element].messages);
				this.loopTroughRules(element, elements[element].rules, elements[element].naming);
			}
		}
		//DISPLAY
		this.displayErrors();
		return false;
	}
}

function isObjEmpty(obj) {
    for(var prop in obj) {
        if(obj.hasOwnProperty(prop)) return false;
    }
    return true;
}

