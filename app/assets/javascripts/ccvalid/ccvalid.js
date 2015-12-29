//var ccNumber = "4342-5620-9946-2994"

function isValid(ccNumber) {
	//console.log(ccNumber);   //show original cc number
	ccNumber = ccNumber.replace(/[^\d]/g, ''); //remove non-numbers
	//alert(ccNumber.length != 19 ? 'must be 19 numbers' : 'awesome');
	var i, l, ccNumRev;        //set variables
	sum = 0;                         
	ccNumRev = ccNumber.split("").reverse().join("");//reverse string
	//console.log(ccNumRev + "   Reversed!!!");//show cc number reversed
	for (i = 0, l = ccNumRev.length; i < l; i++) {
		num = ccNumRev[i];       //assign index to numbers
		num = +num;
		if (i % 2) {             //if index even, then * value by 2
			num *= 2;					           
			if (num < 10) {				 //adds numbers together if less than 10
			sum += num;						 //if more than 10...add number and subtract
			} else {							 //so individual digits are added ex:
				sum += num - 9;			 //3+12 should be -> 3+1+2
				} 									 //3+12-9= is the same as 3+1+2=6
			} else {
				sum += num;
			}//console.log(num); //checks if evens were multiplied
		}
		if (sum % 10 === 0 && ccNumber[0] === "4") {
			alert("This is a valid Visa number")
		  } else if (sum % 10 === 0 && ccNumber[0] === "5") {
			alert("This is a valid Mastercard number")
			} else if (sum % 10 === 0 && ccNumber[0] === "3") {
			alert("This is a valid American Express number")
			} else if (sum % 10 === 0 && ccNumber[0] === "6") {
			alert("This is a valid Discover Card number")
		  } else if (sum % 10 === 0) {
			alert("This is a valid credit card number")
		  } else {
			alert("Sorry, not a valid number")
		}

};

$(document).on('ready', function() {
 
	$('#check').click(function() {
		isValid($('#formValue').val());
	})

});	
