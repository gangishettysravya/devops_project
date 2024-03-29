package org.iiitb.ooad.services;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.glassfish.jersey.media.multipart.FormDataContentDisposition;
import org.glassfish.jersey.media.multipart.FormDataParam;
import org.iiitb.ooad.dao.BuyerDAO;
import org.iiitb.ooad.dao.DealDAO;
import org.iiitb.ooad.dao.DealItemDAO;
import org.iiitb.ooad.dao.ItemDAO;
import org.iiitb.ooad.dao.ItemImagesDAO;
import org.iiitb.ooad.dao.ReviewDAO;
import org.iiitb.ooad.model.Buyer;
import org.iiitb.ooad.model.Deal;
import org.iiitb.ooad.model.DealItem;
import org.iiitb.ooad.model.Item;
import org.iiitb.ooad.model.ItemImages;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

@Path("/deal")
public class DealServices {
	
//	private String deals_folder = "/home/sowmya/Desktop/workspace/flipkart_proto/src/main/webapp/images/deal_images/";
	private String deals_folder = "/home/sravya/git/flipkart_proto/src/main/webapp/images/deal_images/";
	
	@Path("/getDealsOfItem/{id}")
	@GET
	@Produces("application/json")
	public String getDealsOfItem(@PathParam("id") int item_id) throws JSONException, ParseException{
		DealItemDAO didao = new DealItemDAO();
		DealDAO ddao = new DealDAO();
		
		List<DealItem> deals = didao.getDealsOfItem(item_id);
		JSONArray result = new JSONArray();
		
		if(deals!=null) {
			for(int i=0;i<deals.size();i++) {
				JSONObject deal_desc = new JSONObject();
				
				DealItem deal = deals.get(i);
				int deal_id = deal.getDeal_id();
				
				Deal deal_details = ddao.getDealDetailsByID(deal_id);
				if(deal_details!=null) {
					deal_desc.put("deal_id", deal_details.getDeal_id());
					deal_desc.put("name", deal_details.getName());
					deal_desc.put("description", deal_details.getDescription());
					deal_desc.put("deal_discount", deal_details.getDeal_discount());
					
					//System.out.println("The Original date is : " + deal_details.getDate_ended());
					//Check Number of days available
					//System.out.println("The date is : " + format.parse(deal_details.getDate_ended()));
					String[] datetime = deal_details.getDate_ended().split(" ");
					String[] date = datetime[0].split("-");
					//System.out.println("Date: " + time[0]);
					deal_desc.put("validity", date[2]+"-"+date[1]+"-"+date[0]+" "+datetime[1].substring(0, 8));
					result.put(deal_desc);
				}
			}
			return result.toString();
		}
		return "fail";
	}

	@POST
	@Path("/getAllDeals")
	@Consumes("application/json")
	@Produces("application/json")	
	public String getAllDeals() throws JSONException, ParseException{
		DealDAO ddao = new DealDAO();
		
		List<Deal> allDeals = ddao.getAllValidDeals();
		JSONArray result = new JSONArray();
		
		try {
			for(int i=0;i<allDeals.size();i++) {
				JSONObject deal_object = new JSONObject();
				Deal deal_details=allDeals.get(i);
				
				deal_object.append("id", deal_details.getDeal_id());
				deal_object.append("path", deal_details.getDeal_img());
				if(deal_details.getName().equals("Birthday Offer")){
				}
				else {
					result.put(deal_object);
				}
			}
			return result.toString();
		}
		catch(Exception e) {	
			e.printStackTrace();
			return null;
		}
		
	}
	
	@POST
	@Path("/getDealsByBuyerId")
	@Consumes("application/json")
	@Produces("application/json")
	public String getDealsByBuyerId(String buyer_details)  throws JSONException, ParseException{
		
//		DealItemDAO didao = new DealItemDAO();
		DealDAO ddao = new DealDAO();
		JSONObject details = new JSONObject(buyer_details);
		int buyer_id = details.getInt("buyer_id");
		
		List<Deal> allDeals = ddao.getAllValidDeals();
		JSONArray result = new JSONArray();
		
		try {
			for(int i=0;i<allDeals.size();i++) {
				JSONObject deal_object = new JSONObject();
				Deal deal_details=allDeals.get(i);
				
				deal_object.append("id", deal_details.getDeal_id());
				deal_object.append("path", deal_details.getDeal_img());
				if(deal_details.getName().equals("Birthday Offer")){
					BuyerDAO buyer_dao = new BuyerDAO();
					DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
					LocalDateTime now = LocalDateTime.now();
					String [] today_datetime = dtf.format(now).split(" ");
					String today = today_datetime[0];
					String today_day = today.substring(5,today.length());
					Buyer buyer = buyer_dao.getUserById(buyer_id);
					String buyer_dob = buyer.getDob();
					if(buyer_dob!=null || buyer_dob!="") {
						if(buyer_dob.substring(5,today.length()).equals(today_day)){
							result.put(deal_object);
						}
					}
				}
				else {
					result.put(deal_object);
				}
			}
			return result.toString();
		}
		catch(Exception e) {	
			e.printStackTrace();
			return null;
		}
	}

	
	@Path("/getDealsForUser")
	@POST
	@Consumes("application/json")
	@Produces("application/json")
	public String getDealsForUser(String deal_item_details) throws JSONException, ParseException{
		DealItemDAO didao = new DealItemDAO();
		DealDAO ddao = new DealDAO();
		
		JSONObject details = new JSONObject(deal_item_details);
		int item_id = details.getInt("item_id");
		int buyer_id = details.getInt("buyer_id");
		
		List<DealItem> deals = didao.getDealsOfItem(item_id);
		JSONArray result = new JSONArray();
		
		if(deals!=null) {
			for(int i=0;i<deals.size();i++) {
				JSONObject deal_desc = new JSONObject();
				
				DealItem deal = deals.get(i);
				int deal_id = deal.getDeal_id();
				
				Deal deal_details = ddao.getDealDetailsByID(deal_id);
				if(deal_details!=null) {
					deal_desc.put("deal_id", deal_details.getDeal_id());
					deal_desc.put("name", deal_details.getName());
					deal_desc.put("description", deal_details.getDescription());
					deal_desc.put("deal_discount", deal_details.getDeal_discount());
					
					String[] datetime = deal_details.getDate_ended().split(" ");
					String[] date = datetime[0].split("-");
					deal_desc.put("validity", date[2]+"-"+date[1]+"-"+date[0]+" "+datetime[1].substring(0, 8));
	
					if(deal_details.getName().equals("Birthday Offer")){
						BuyerDAO buyer_dao = new BuyerDAO();
						DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
						LocalDateTime now = LocalDateTime.now();
						String [] today_datetime = dtf.format(now).split(" ");
						String today = today_datetime[0];
						String today_day = today.substring(5,today.length());
						Buyer buyer = buyer_dao.getUserById(buyer_id);
						String buyer_dob = buyer.getDob();
						if(buyer_dob!=null || buyer_dob!="")
						if(buyer_dob.substring(5,today.length()).equals(today_day)){
							result.put(deal_desc);
						}
					}
					else
						result.put(deal_desc);
				}
			}
			return result.toString();
		}
		return "fail";
	}

	public String getValidity(String date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");

		Date d1 = new Date();
		Date d2 = null;

		try {
			d2 = format.parse(date);

			//in milliseconds
			long diff = d1.getTime() - d2.getTime();
			//System.out.println("......................."+diff);

			long ss = diff / 1000 % 60;
			long mm = diff / (60 * 1000) % 60;
			long hh = diff / (60 * 60 * 1000) % 24;
			long dd = diff / (24 * 60 * 60 * 1000);

			String validity = "";
			
			if(dd>0) {
				validity+=dd+" day(s) ";
			}
			if(hh>0) {
				validity+=hh+" hour(s) ";
			}
			if(mm>0) {
				validity+=mm+" minute(s) ";
			}
			if(ss>0) {
				validity+=ss+" second(s) ";
			}
			
			return validity;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "fail";
	}
	
	@Path("/getDealsNotAddedToItem/{item_id}")
	@GET
	@Produces("application/json")
	public List<Deal> getDealsNotAddedToItem(@PathParam("item_id") int item_id){
		
			DealItemDAO didao = new DealItemDAO();
			List<DealItem> item_deals = didao.getDealsOfItem(item_id);
			
			List<Deal> item_extra_deals = new ArrayList<Deal>();

			DealDAO deal_dao = new DealDAO();

			List<Integer> present_deals_ids = new ArrayList<Integer>();
			for(int i=0;i<item_deals.size();i++){	
				present_deals_ids.add(item_deals.get(i).getDeal_id());
			}
			
			if(present_deals_ids.size()==0) {
				item_extra_deals = deal_dao.getAllValidDeals();
			}
			
			else{
				item_extra_deals = deal_dao.getAllExtraValidDeals((ArrayList<Integer>) present_deals_ids);				
			}
			
			for(int i=0;i<item_extra_deals.size();i++){				
				String end_date = item_extra_deals.get(i).getDate_ended();
				String[] datetime = end_date.split(" ");
				String[] date = datetime[0].split("-");
				item_extra_deals.get(i).setDate_ended(date[2]+"-"+date[1]+"-"+date[0]+" "+datetime[1].substring(0, 8));
			}
			
			return item_extra_deals;
	}
	
	@Path("/addItemToDeals")
	@POST
	@Consumes("application/json")
	public String addItemToDeals(List<DealItem> deal_items){
		
		DealItemDAO dao = new DealItemDAO();
		
		for(int i=0;i<deal_items.size();i++){
			int id = dao.addDealItem(deal_items.get(i));
			if(id==-1){
				return "fail";
			}
		}
		return "success";
	}
	
	@Path("/removeDealItem")
	@POST
	@Consumes("application/json")
	public String deleteDealItem(DealItem dealItem){
		
		DealItemDAO dao = new DealItemDAO();
		return dao.deleteDealItem(dealItem);
	}
	
	@Path("addDeal")
	@POST
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	@Produces(MediaType.TEXT_PLAIN)
	public String addDeal( @FormDataParam("image") InputStream uploadedInputStream,
            @FormDataParam("image") FormDataContentDisposition fileDetail,
            @FormDataParam("dealname") String dealname,
            @FormDataParam("description") String description,
            @FormDataParam("discount") Float discount,
            @FormDataParam("startdate") String startdate,
            @FormDataParam("enddate") String enddate) {
		
			System.out.println(dealname);
		try {
			
			
			String images_location = deals_folder;
			String pattern = "(?!^)\\.(?=[^.]*$)|(?<=^\\.[^.]{0,1000})$";
			
			if(fileDetail!=null) {
				String[] filename =fileDetail.getFileName().split(pattern,-1);
				String modifiedfilename = filename[0]+"_"+System.currentTimeMillis()+"."+filename[1];
				System.out.println(modifiedfilename);
				String actual_image_location = images_location + modifiedfilename;
				String image_location = "images/deal_images/"+modifiedfilename;
				writeToFile(uploadedInputStream, actual_image_location);
				
				DealDAO dao = new DealDAO();
				
				Deal deal = new Deal(dealname, description,discount,startdate,enddate,image_location);
				int id=dao.addDeal(deal);
				if(id!=-1) {
					return "success";
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			return "fail";
		}
		return "fail";
		
	}

	private void writeToFile(InputStream uploadedInputStream, String uploadedFileLocation){
		try
            {
                    OutputStream out = new FileOutputStream(new File(uploadedFileLocation));
                    int read = 0;
                    byte[] bytes = new byte[1024];

                    out = new FileOutputStream(new File(uploadedFileLocation));
                    while ((read = uploadedInputStream.read(bytes)) != -1)
                    {
                            out.write(bytes, 0, read);
                    }
                    out.flush();
                    out.close();
            }catch (IOException e)
            {

                    e.printStackTrace();
            }

    }
	
	@Path("/getDeal/{deal_id}")
	@POST
	@Produces("application/json")
	public Deal getDeals(@PathParam("deal_id") int deal_id){
		
		DealDAO dao = new DealDAO();
		return dao.getDealDetailsByID(deal_id);
	}
	
	@POST
	@Path("/getAllItemsByDealId/{id}")
	@Consumes("application/json")
	@Produces("application/json")
	public String getDealItemsByDealId(@PathParam("id")int deal_id) throws JSONException
	{

		ItemDAO dao = new ItemDAO();
		ItemImagesDAO itemImagesDao = new ItemImagesDAO();
		DealItemDAO itemdao = new DealItemDAO();
		List<Integer> dealitems = itemdao.getItemIdByDealId(deal_id);
		if(dealitems.size()!=0) {
			List<Item> items = dao.getItemsbyItemIdList(dealitems);
			JSONArray allItems = new JSONArray();
			try {
				
				for(int i=0;i< items.size();i++) {
				
					Item item = items.get(i);
					
					JSONObject item_details= new JSONObject();
					item_details.append("itemid",item.getItem_id());
					item_details.append("name",item.getName());
					item_details.append("price",item.getPrice());
					item_details.append("brand",item.getBrand());
					item_details.append("discount",item.getDiscount());
					item_details.append("manufacture_date",item.getManufacture_date());
					item_details.append("color",item.getColor());
					
					int item_id = item.getItem_id();
					ReviewDAO reviewdao = new ReviewDAO();
					
					Double rating = reviewdao.averageRatingOfItem(item_id);
					item_details.append("rating",rating);
					
					long count = reviewdao.totalItemRatings(item_id);
					item_details.append("rating_count",count);
					
					System.out.println("Item_id: " + item_id);
					
					ItemImages itemImage = itemImagesDao.getItemImagesByItemId(item_id).get(0);
					item_details.append("image",itemImage.getImage_location());
					
					allItems.put(item_details);
					
				}
				return allItems.toString();
			}
			
			catch(Exception e) {	
				e.printStackTrace();
				return null;
			}
		}
		
		return "no items";
	}
}
