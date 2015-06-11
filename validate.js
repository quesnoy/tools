//CONSTRUCTOR NEED THE FORM TO VALIDATE
//VALIDATE METHOD NEED RULES AND MESSAGES 
function formValidate ( theForm ) {

	//FORM TO CHECK
	this.form = theForm;
	//FILLED WITH ERROR MESSAGE ON ERROR
	this.errorMessages = {};
	//DEFAULT ERROR MESSAGE
	this.defaultMessages = {
			'needed' : ' is not optional', 
			'isAlpha' : ' should contain only alphabet characters', 
			'isAlphaNumeric' : ' should contain only alphabet or numeric characters'
	}

	//VALIDATION METHOD
	//NEEDED : REQUIRED, NEED INPUT (NO PARAM)
	this.needed = function ( el, param ) {
		return this.form.elements.namedItem(el).value != '' ? true : this.defaultMessages['needed'];
	}
	//ISALPHA : A-Za-z CHARACTER ONLY (NO PARAM)
	this.isAlpha = function ( el, param ) {
		return /^[A-Za-z]+$/.test(this.form.elements.namedItem(el).value) ? true : this.defaultMessages['isAlpha'];
	}
	//ISALPHANUMERIC : A-Za-z0-9 CHARACTER ONLY (NO PARAM)
	this.isAlphaNumeric = function ( el, param ) {
		return /^[A-Za-z0-9]+$/.test(this.form.elements.namedItem(el).value) ? true : this.defaultMessages['isAlphaNumeric'];
	}
	
	//REPLACE DEFAULT MESSAGE IF PRESENT
	this.setMessages = function ( messages ) {
		for ( var key in messages ) {
			if ( messages.hasOwnProperty(key) && this.defaultMessages.hasOwnProperty(key) ) {
				this.defaultMessages[key] = messages[key];
			}
		}
	}

	//DISPLAY ERRROR MESSAGE ( ALERT )
	this.displayErrors = function () {
		if ( !isObjEmpty(this.errorMessages) ) {
			for ( var k in this.errorMessages ) {
		  		if (this.errorMessages.hasOwnProperty(k)) {
					for (index = 0; index < this.errorMessages[k].length; index++) {
						alert(this.errorMessages[k][index]);
					}
				}
			}
		}
	}

	//VALIDATE THE FORM
	//LOOP TROUGHT THE RULES, AND VALIDATE EACH ONE, THEN RETURN ERROR MESSAGE IF FALSE
	this.validate = function ( rules, messages ) {
	
		//SET MESSAGES
		this.setMessages(messages);
	
		for (var key in rules) {
			if (rules.hasOwnProperty(key)) {
			        for ( var rule in rules[key] ) {
					if (rules[key].hasOwnProperty(rule)) {
			      			var check = this[rule](key, rules[key][rule]);
			      			if (  check !== true ) {
			      				if ( typeof this.errorMessages[key] === 'undefined' ) {
			      					this.errorMessages[key] = [];
			      				}
			      				this.errorMessages[key].push(messages[key] + check);
			      			}	
			      		}
			        }
			}
		}
		//DISPLAY
		this.displayErrors();
	}
}

function isObjEmpty(obj) {
    for(var prop in obj) {
        if(obj.hasOwnProperty(prop)) return false;
    }
    return true;
}
