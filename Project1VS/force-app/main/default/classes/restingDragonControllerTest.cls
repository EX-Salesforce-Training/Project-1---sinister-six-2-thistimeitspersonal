@isTest
public class restingDragonControllerTest {
	@isTest
	static void TestDragonPage(){
		User uu = TestUtil.CreateTestUser();

		System.runAs(uu){
			PageReference drag = Page.restingDragon;
			Test.setMock(HttpCalloutMock.class, new DnDAPIMock());
			Test.setCurrentPage(drag);

			restingDragonController dragCon = new restingDragonController();

			system.debug(dragCon.finClassList);

		}
	}
    
    
}