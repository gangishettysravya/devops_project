import org.iiitb.ooad.model.*;
import org.iiitb.ooad.services.User_Services;
import org.iiitb.ooad.services.ItemServices;
import org.iiitb.ooad.services.CategoryServices;

import static org.junit.Assert.*;
import org.junit.Test;

public class FirstTestCase {

	@Test
	public void testGetUserByEmailBuyer() {
		Buyer buyer = new Buyer();
		Buyer true_buyer = new Buyer();
		true_buyer.setEmail("G.Sravya@iiitb.org");
		true_buyer.setId(2);
		true_buyer.setDob("1997-06-11");
		true_buyer.setGender("F");
		true_buyer.setName("Sravya Gangishetty");
		true_buyer.setPassword("12345");
		true_buyer.setPhone_no("7730069061");
		true_buyer.setPic_location("images/buyer/2.jpg");
		buyer.setEmail("G.Sravya@iiitb.org");
		buyer.setPassword("12345");
		User_Services user_service = new User_Services();
		Buyer return_buyer = user_service.getUserByEmail(buyer);
		assertEquals(true_buyer.getDob(),user_service.getUserByEmail(buyer).getDob());
	}
	
	@Test
	public void testgetUserByMobile() {
		Buyer buyer = new Buyer();
		Buyer true_buyer = new Buyer();
		true_buyer.setEmail("G.Sravya@iiitb.org");
		true_buyer.setId(2);
		true_buyer.setDob("1997-06-11");
		true_buyer.setGender("F");
		true_buyer.setName("Sravya Gangishetty");
		true_buyer.setPassword("12345");
		true_buyer.setPhone_no("7730069061");
		true_buyer.setPic_location("images/buyer/2.jpg");
		buyer.setPhone_no("7730069061");
		buyer.setPassword("12345");
		User_Services user_service = new User_Services();
		Buyer return_buyer = user_service.getUserByMobile(buyer);
		assertEquals(true_buyer.getDob(),user_service.getUserByMobile(buyer).getDob());
	}
	
	@Test
	public void testUpdateQuantity() {
		Item item = new Item();
		item.setItem_id(1);
		item.setId("KC01");
		item.setName("Skinny Men Jeans");
		item.setColor("Blue");
		item.setDiscount(10);
		item.setSubcategory_id(1);
		item.setQuantity(12);
		item.setPrice(1200);
		item.setBrand("Wrangler");
		item.setDescription("Free size");
		item.setManufacture_date("2019-02-11");
		item.setSeller_id(1);
		ItemServices itemservice = new ItemServices();
		assertEquals("success",itemservice.updateQuantity(item));
	}
	
	@Test
	public void testgetItemByItemId() {
		Item item = new Item();
		item.setItem_id(1);
		item.setId("KC01");
		item.setName("Skinny Men Jeans");
		item.setColor("Blue");
		item.setDiscount(10);
		item.setSubcategory_id(1);
		item.setQuantity(12);
		item.setPrice(1200);
		item.setBrand("Wrangler");
		item.setDescription("Free size");
		item.setAttribute1(null);
		item.setManufacture_date("2019-02-11");
		item.setSeller_id(1);
		ItemServices itemservice = new ItemServices();
		assertEquals(item.getColor(),itemservice.getItemByItemId(1).getColor());
	}
	
	/*
	@Test
	public void testaddBrand() {
		Brand brand = new Brand();
		brand.setBrand("Puma");
		brand.setSubcategory_id(5);
		CategoryServices category = new CategoryServices();
		assertEquals("success",category.addBrand(brand));
		
	}*/
	
	@Test
	public void testgetSubCategoryById() {
		CategoryServices category = new CategoryServices();
		assertEquals("Clothing",category.getSubCategoryById(1).getName());
	}
	
	
	
	

	

}

