import org.iiitb.ooad.model.*;
import org.iiitb.ooad.services.User_Services;

import static org.junit.Assert.*;
import org.junit.Test;

public class User_TestCase {

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
		System.out.println(return_buyer.getPhone_no());
		assertEquals(true_buyer.getDob(),user_service.getUserByEmail(buyer).getDob());
		//fail("Not yet implemented");
	}

}

