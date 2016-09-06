//random number 2647883937474900

$(document).on("ready", function() {
	
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
			sum += num;						 //if more than 10...add number and subtract 9
			} else {							 //so individual digits are added ex:
				sum += num - 9;			 //3+12 should be -> 3+1+2
				} 									 //3+12-9= is the same as 3+1+2=6
			} else {
				sum += num;
			}//console.log(num); //checks if evens were multiplied
		}
		if (ccNumber.length === 16 && sum % 10 === 0 && ccNumber[0] === "4") {
			$('#card').attr('src', 'https://s3-us-west-1.amazonaws.com/instograph-content/pic_storage/visa.png')
		} else if (ccNumber.length === 16 && sum % 10 === 0 && ccNumber[0] === "5") {
			$('#card').attr('src', 'https://s3-us-west-1.amazonaws.com/instograph-content/pic_storage/master.png')
		} else if (ccNumber.length === 15 && sum % 10 === 0 && ccNumber[0] === "3") {
			$('#card').attr('src', 'https://s3-us-west-1.amazonaws.com/instograph-content/pic_storage/discover.png')
		} else if (ccNumber.length === 16 && sum % 10 === 0 && ccNumber[0] === "6") {
			$('#card').attr('src', 'https://s3-us-west-1.amazonaws.com/instograph-content/pic_storage/americanex.png')
		} else if (sum % 10 === 0) {
			$('#card').attr('src', 'https://s3-us-west-1.amazonaws.com/instograph-content/pic_storage/generic.png')
		} else {
			$('#card').attr('src', 'https://s3-us-west-1.amazonaws.com/instograph-content/pic_storage/notcard.png')
		}

	};
	
	$('#check').click(function() {
		isValid($('#formValue').val());
	})

});	
