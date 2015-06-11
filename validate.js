function formValidate ( theForm ) {

	this.form = theForm;
	this.errorMessages = {};

	this.needed = function ( el, param ) {
		if ( this.form.elements.namedItem(el).value != '' ) {
			return true;
		} else {
			return ' is not optional';
		}
	}
	this.isAlpha = function ( el, param ) {
		if ( /^[A-Za-z]+$/.test(this.form.elements.namedItem(el).value) === true ) { 
			return true;
		} else { 
			return ' should contain only alphabet characters';
		}
	}
	this.isAlphaNumeric = function ( el, param ) {
		if ( /^[A-Za-z0-9]+$/.test(this.form.elements.namedItem(el).value) === true ) { 
			return true;
		} else { 
			return ' should contain only alphabet or numeric characters';
		}
	}

	this.validate = function ( rules, messages ) {
		for (var key in rules) {
		  if (rules.hasOwnProperty(key)) {
			  for ( var rule in rules[key] ) {
		  		if (rules[key].hasOwnProperty(rule)) {
					var check = this[rule](key, rules[key][rule]);
					if (  check !== true ) {
							//alert(key + ' | ' + rule + ' : ' + rules[key][rule] + ' => FALSE ');
							if ( typeof this.errorMessages[key] === 'undefined' ) {
								this.errorMessages[key] = [];
							}
							this.errorMessages[key].push(messages[key] + check);
					}	
				}
			  }
		  }
		}
		if ( Object.getOwnPropertyNames(this.errorMessages).length > 0 ) {
			for ( var k in this.errorMessages ) {
		  		if (this.errorMessages.hasOwnProperty(k)) {
					for (index = 0; index < this.errorMessages[k].length; index++) {
						alert(this.errorMessages[k][index]);
					}
				}
			}
		}
	}
}
