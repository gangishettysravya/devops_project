import java.util.concurrent.TimeUnit;

import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import static io.github.bonigarcia.wdm.DriverManagerType.CHROME;

import io.github.bonigarcia.wdm.WebDriverManager;

public class AppTest {
private static ChromeDriver driver;
WebElement element;

@BeforeClass
public static void openBrowser(){
	ChromeOptions ChromeOptions = new ChromeOptions();
	ChromeOptions.addArguments("--headless", "window-size=1024,768", "--no-sandbox");
	WebDriverManager.getInstance(CHROME).setup();
	driver = new ChromeDriver(ChromeOptions);
    driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
}

@Test
public void testWebsite() throws InterruptedException{
    System.out.println("Starting test " + new Object(){}.getClass().getEnclosingMethod().getName());
    driver.get("http://localhost:8081/flipkart-prototype/Homepage.html");
    Assert.assertEquals("Flipkart:Home", driver.getTitle());
   System.out.println("Ending test " + new Object(){}.getClass().getEnclosingMethod().getName());
    
}

@Test
public void valid_UserCredential() throws InterruptedException {
	System.out.println("Starting test " + new Object(){}.getClass().getEnclosingMethod().getName());
	driver.get("http://localhost:8081/flipkart-prototype/Homepage.html");
	WebElement element = driver.findElement(By.id("idloginbutton"));

    ((JavascriptExecutor)driver).executeScript("arguments[0].click();",element);
	driver.findElement(By.id("email_or_mobile")).sendKeys("G.Sravya@iiitb.org");
    driver.findElement(By.id("password")).sendKeys("12345");
    WebElement element1 = driver.findElement(By.id("login_btn1"));

    ((JavascriptExecutor)driver).executeScript("arguments[0].click();",element1);
    System.out.println("Ending test " + new Object(){}.getClass().getEnclosingMethod().getName());

}

@Test
public void inValid_UserCredential() throws InterruptedException {
	System.out.println("Starting test " + new Object(){}.getClass().getEnclosingMethod().getName());
	driver.get("http://localhost:8081/flipkart-prototype/Homepage.html");
	WebElement element = driver.findElement(By.id("idloginbutton"));

    ((JavascriptExecutor)driver).executeScript("arguments[0].click();",element);
	driver.findElement(By.id("email_or_mobile")).sendKeys("G.Sravya@iiitb.org");
    driver.findElement(By.id("password")).sendKeys("1234");
    WebElement element1 = driver.findElement(By.id("login_btn1"));

    ((JavascriptExecutor)driver).executeScript("arguments[0].click();",element1);
    System.out.println("Ending test " + new Object(){}.getClass().getEnclosingMethod().getName());

}

@Test
public void testLogout() throws InterruptedException {
	System.out.println("Starting test " + new Object(){}.getClass().getEnclosingMethod().getName());
	driver.get("http://localhost:8081/flipkart-prototype/Homepage.html");
	WebElement element = driver.findElement(By.id("idlogoutbutton"));

    ((JavascriptExecutor)driver).executeScript("arguments[0].click();",element);
    System.out.println("Ending test " + new Object(){}.getClass().getEnclosingMethod().getName());
}

@Test
public void testSell() {
	System.out.println("Starting test " + new Object(){}.getClass().getEnclosingMethod().getName());
	driver.get("http://localhost:8081/flipkart-prototype/Homepage.html");
	WebElement element = driver.findElement(By.id("sell"));

    ((JavascriptExecutor)driver).executeScript("arguments[0].click();",element);
    System.out.println("Ending test " + new Object(){}.getClass().getEnclosingMethod().getName());
}


@AfterClass
public static void closeBrowser(){
    driver.quit();
}

}
