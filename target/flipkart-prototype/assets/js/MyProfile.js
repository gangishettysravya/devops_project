jQuery(document).ready(function($){
		
	var cookie_data = getCookie("Buyer_data");
	if(cookie_data!="" && cookie_data!=null){
		var buyer_data = JSON.parse(cookie_data);
		console.log(buyer_data.id);
		//var buyer_id;
		
		if(buyer_data!="" && buyer_data!=null){
			$("#email").val(buyer_data.email);   //Email in Order Summary
			$("#name").val(buyer_data.name);
			$("#radio").val(buyer_data.gender);
			$("#mobile").val(buyer_data.phone_no);
            $("#fullname").text(buyer_data.name);
            if(buyer_data.dob==null){
            	$("#dob").val('');
            	$("#dob").hide();
            	$("#addDob").show();
            	$("#addDobInput").show();
            }
            else{
            	var dob = buyer_data.dob;
            	var date = dob.split("-");
            	if(date[0].length>2){
            		dob = date[2]+"-"+date[1]+"-"+date[0];
            	}
            	$("#dob").val(dob);
            	$("#addDob").hide();
            	$("#addDobInput").hide();
            	$("#dob").prop('disabled', true);
            }
            //$("#balance").val(buyer_data.balance);
            
            $.ajax({
            url: "webapi/payment/getbuyerbalance/"+buyer_data.id,
            type: "GET",
            success: function(data) {
                    var balance=data;
                    console.log(data);
                    $("#balance").val(balance);
			    },

    	    });
			
		}
    }	
	
	$("#addDob").on('click', function(){
		
		var dob = $("#addDobInput").val();
		console.log(dob);
		if(dob==null || dob==""){
			alert("Choose Valid Date");
			return;
		}
        
        buyer_data.dob=dob;
        
        var update={
                id:buyer_data.id,
                dob:dob,
        }
        
        console.log(buyer_data.id)
        setCookie("Buyer_data", JSON.stringify(buyer_data), 1);

        $.ajax({
            url: "webapi/user/editbuyerdetails/"+"dob",
            data: JSON.stringify(update),
            type: "POST",
            contentType:'application/json',
            success: function(data) {
        	
				    if(data=="success"){
				        alert("Added Successfully");
				        location.reload();
				    }
				    else	{
					    alert("Error");
				    }
			    },
        });

    });
	

    $("#personalinfoedit").on('click', function(){
        $("#name").prop('disabled', false);
        $("#PIsave").css("display", "block");
        $("#PIsave").click(function(){
            //$("#name").val(person);
            $("#PIsave").css("display", "none");
            $("#name").prop('disabled', true);
            
            name = $("#name").val();
            buyer_data.name=name;
            $("#fullname").text(buyer_data.name);
            
            var update={
                id:buyer_data.id,
                name:name,
            }
            console.log(buyer_data.id)
            setCookie("Buyer_data", JSON.stringify(buyer_data), 1);

            $.ajax({
            url: "webapi/user/editbuyerdetails/"+"name",
            data: JSON.stringify(update),
            type: "POST",
            contentType:'application/json',
            success: function(data) {
        	
				    if(data=="success"){
				        alert("Added Successfully");
				        location.reload();
				    }
				    else	{
					    alert("Error");
				    }
			    },

    	    });
        });

        });

        $("#editemail").on('click', function(){
        $("#email").prop('disabled', false);
        $("#emailsave").css("display", "block");
        $("#emailsave").click(function(){
            //$("#name").val(person);
            $("#emailsave").css("display", "none");
            $("#email").prop('disabled', true);
            email = $("#name").val();
            buyer_data.email=email;
            
            var update={
                id:buyer_data.id,
                email:email,
            }
            console.log(update)
            setCookie("Buyer_data", JSON.stringify(buyer_data), 1);

            $.ajax({
            url: "webapi/user/editbuyerdetails/"+"email",
            data: JSON.stringify(update),
            type: "POST",
            contentType:'application/json',
            success: function(data) {
        	
				    if(data=="success"){
				        alert("Added Successfully");
				        location.reload();
				    }
				    else	{
					    alert("Error");
				    }
			    },

    	    });
        });

        });

        $("#editmobile").on('click', function(){
        $("#mobile").prop('disabled', false);
        $("#mobilesave").css("display", "block");
        $("#mobilesave").click(function(){
            //$("#name").val(person);
            $("#mobilesave").css("display", "none");
            $("#mobilesave").prop('disabled', true);
            mobile = $("#mobile").val();
            buyer_data.name=name;
            
            var update={
                id:buyer_data.id,
                mobile:mobile,
            }
            console.log(update)
            setCookie("Buyer_data", JSON.stringify(buyer_data), 1);

            $.ajax({
            url: "webapi/user/editbuyerdetails/"+"phone_no",
            data: JSON.stringify(update),
            type: "POST",
            contentType:'application/json',
            success: function(data) {
        	
				    if(data=="success"){
				        alert("Added Successfully");
				        location.reload();
				    }
				    else	{
					    alert("Error");
				    }
			    },

    	    });
        });

        });

        $("#editbalance").on('click', function(){
        $("#balance").prop('disabled', false);
        $("#balancesave").css("display", "block");
        $("#balancesave").click(function(){
            //$("#name").val(person);
            $("#balancesave").css("display", "none");
            $("#balance").prop('disabled', true);
            balance = $("#balance").val();
            buyer_data.balance=balance;
            
            var update={
                buyer_id:buyer_data.id,
                balance:balance,
            }
            console.log(buyer_data.id)
            console.log(update)
            setCookie("Buyer_data", JSON.stringify(buyer_data), 1);

            $.ajax({
            url: "webapi/payment/editbuyerbalance",
            data: JSON.stringify(update),
            type: "POST",
            contentType:'application/json',
            success: function(data) {
        	
				    if(data=="success"){
				        alert("Added Successfully");
				        location.reload();
				    }
				    else	{
					    alert("Error");
				    }
			    },

    	    });
        });

        });
    });
		 	
