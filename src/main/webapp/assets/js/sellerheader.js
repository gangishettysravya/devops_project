/**
 * 
 */
jQuery(document).ready(function($){
	$("#warning_email_new").hide();
	$("#warning_phone_new").hide();
	$("#registerNow").click(function(event){
		window.location = "sellerRegistration.html";
	});
	$("#login_btn").click(function(event){
		var email = $("#email").val();
		var password = $("#password").val();
		var userData = JSON.stringify({
	    	"email":email,
	    	"password":password
	    	});
		$.ajax({
			type:'POST',
			contentType : 'application/json',
			url: "webapi/user/authenticateSellerEmail",
			data : userData,
			success : function(user){
				if($.isEmptyObject(user))
					alert("Email Not Registered");
				else if(user.id==0)
					alert("incorrect password");
				else
				{
					setCookie("seller_data",JSON.stringify(user), 30);
					window.location.href = "SellerPage.html?nav_ref=home";
					
				}

			}
			
		});

	});
	
})