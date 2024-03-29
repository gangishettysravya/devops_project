/**
 * 
 */
jQuery(document).ready(function($){
	
	var buyer_id=0;
	//get buyer data from cookies
	var cookie_data = checkCookie("Buyer_data");
	buyer_id = cookie_data.id;
	console.log(buyer_id);
	
	$("#logo").click(function(){
		$(location).attr('href', "Homepage.html");
	});
	
	//Initial page setting
	var url="webapi/wishlist/getWishlistByBuyerID/"+buyer_id;
	$.ajax({
		type : 'GET',
		cache : false,
		contentType : false,
		processData : false,
		url : url,
		success : function(wishlist){
			//console.log(wishlist);
			if(wishlist!=null){
				//orders = JSON.parse(data);
				for(var i=0;i<wishlist.length;i++){
					
					//console.log(orders[i]);
					var id = wishlist[i].id;
					var item_id=wishlist[i].item_id;
					var itemid=wishlist[i].itemid;
					var name=wishlist[i].name;
					var rating=wishlist[i].rating;
					var numrating=wishlist[i].numrating;
					var price=wishlist[i].price;
					var discount=wishlist[i].discount;
					var offerprice=price-(price*discount/100.0);
					var imagelocation=wishlist[i].pic_location;
					
					var wishlist_card = 
						"<div id='wishlist_"+item_id+"' style='border: 2px solid #eee;'>"+
							"<div class='form-group row'>"+
								"<div style='padding: 5px; margin-left: 40px;'>"+
									"<img src='"+imagelocation+"' alt='Card image' style='margin-top:23px;width:120px;height:120px;float:left;' />"+
								"</div>"+
								"<div style='margin-top:15px;'>"+
									"<div class='form-group' style='margin-left:90px;'>"+
										"<div><a href='SingleProduct.html?itemid="+item_id+"' style='font-size: 20px; color: blue;'>"+name+"</a></div>"+
										"<div><label class='col-form-label' style='font-size: 15px; color: gray;'>ITEM ID: "+itemid+"</label></div>"+
										"<div class='row' style='margin-left: 3px;'>" +
											"<label class='col-form-label font-weight-bold' style='color: white; background-color: green; border-radius: 4px;'>"+rating+
							          			"<span class='fa fa-star' style='color:white'></span>"+
							          		"</label>" +
											"<label class='col-form-label' style='margin-left: 8px; font-size: 20px; color: gray;'> ("+numrating+")</label>" +
										"</div>"+
										"<div class='form-inline'>"+
						                	"<div><label class='col-form-label' style='font-size: 20px;'>Rs. "+offerprice+"</label></div>"+
						                	"<div><del class='col-form-label' style='margin-left: 20px; font-size: 14px; color: gray;'>Rs. "+price+"</del></div>"+
						                	"<div><label class='col-form-label' style='margin-left: 20px; font-size: 20px; color: green;'>"+discount+"% off</label></div>"+
								        "</div>"+
									"</div>"+
								"</div>"+
								"<div style='margin-left: 400px; margin-top: 15px;'>"+
									"<div><a id='delete_"+id+"' class='fa fa-trash' style='margin-left: 40px; font-size: 25px; color: gray; cursor: pointer;'></a></div>"+
									"<div><button id='move_"+item_id+"'class='btn' style='color: white; background-color: rgba(255,69,0, 0.8); border-radius: 0 !important; margin-top: 30px;'>Move to Cart</button></div>"+
								"</div>"+
							"</div>"+
						"</div>";
					$("#mywishlist").append(wishlist_card);
					$("#wishlist_"+item_id).show();
					$("#no_items").hide();
					onClick(item_id);
					onClickMove(item_id);
					onDelete(id);
				}
			}
			else{
				var no_items = "<div id='no_items' align='center' style='border: 2px solid #eee;'>"+
								  "<label class='col-form-label'>You have no items in Wishlist.</label>"+
							   "</div>";
				$("#mywishlist").append(no_items);
				$("#no_items").show();
			}
			
		},
		error: function(wishlist) {
			alert("Failed to fetch wishlist details!");
		}
	});
	
	function onClick(id){
		$('body').on("click", "#wishlist_"+id, function(){
			window.loaction = "SingleProduct.html?itemid="+id;
		});
	}

	function onDelete(id){
		$('body').on("click", "#delete_"+id, function(){
			var url="webapi/wishlist/deleteWishlistItemByID/"+id;
			$.ajax({
				type : 'POST',
				cache : false,
				contentType : false,
				processData : false,
				url : url,
				success : function(wishlist){
					location.reload();
				},
				error: function(wishlist) {
					alert("Problem Occured!");
				}
			});
		});
	}
	
	function onClickMove(item_id){
		$('body').on("click", "#move_"+item_id, function(){
			var data = JSON.stringify({
				item_id : item_id,
				buyer_id : buyer_id,
			});
			var url="webapi/wishlist/moveToCart";
			$.ajax({
				type : 'POST',
				contentType : 'application/json',
				url : url,
				data : data,
				success : function(response){
					window.location = "Cart.html";
				},
				error: function(response) {
					alert("Problem Occured!");
				}
			});
		});
	}
});