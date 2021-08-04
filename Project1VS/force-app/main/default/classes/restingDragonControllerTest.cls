@isTest
public class restingDragonControllerTest {
	@isTest
	static void TestGoodDragonPage(){
		//tests the 'resting dragon' example page positively using a mock callout
        User uu = TestUtil.CreateTestUser();
		System.runAs(uu){
            PageReference drag = Page.restingDragon;
            Test.setCurrentPage(drag);
			Test.startTest();
            Test.setMock(HttpCalloutMock.class, new DnDAPIMock());
			restingDragonController dragCon = new restingDragonController();
		}
	}
    
	@isTest
	static void TestFailDragonPage(){
		//tests the 'resting dragon' example page negativly using a mock callout
        User uu = TestUtil.CreateTestUser();
		System.runAs(uu){
            PageReference drag = Page.restingDragon;
            Test.setCurrentPage(drag);
			Test.startTest();
            Test.setMock(HttpCalloutMock.class, new DnDAPIMock());
			restingDragonController dragCon = new restingDragonController();
		}
	}
    
}