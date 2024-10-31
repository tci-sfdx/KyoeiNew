@isTest
public class GetAccountInfoControllerTests{

	@isTest
    static void processIncomingDataTest(){ 
        Contact c = new Contact(LastName = 'test',PhoneNumber__c='1112223333');
        RecordType ParsonType = [SELECT Id, Name, SobjectType FROM RecordType Where SobjectType = 'Contact' And Name = '顧客'];
        c.RecordTypeId = ParsonType.Id;
        Insert c;
        PageReference getAccountInfoPage = Page.getAccountInfo;

        getAccountInfoPage.getParameters().put('gyoumu_Id',c.Id);
        getAccountInfoPage.getParameters().put('shoken_No','1234567890');
        getAccountInfoPage.getParameters().put('hkn_Shiki','20200101');
        getAccountInfoPage.getParameters().put('hkn_Shuki','20200102');
        getAccountInfoPage.getParameters().put('keiyakusha_Knj','契約者名');
        getAccountInfoPage.getParameters().put('keiyakusha_Kana','カナメイ');
        getAccountInfoPage.getParameters().put('keiyakusha_Tel','111-2222-3333');
        getAccountInfoPage.getParameters().put('keiyakusha_Yubin_No','123-1234');
        getAccountInfoPage.getParameters().put('keiyakusha_Jusho_Knj','住所');
        getAccountInfoPage.getParameters().put('dairiten_Cd','12345678901');
        getAccountInfoPage.getParameters().put('shokanten_Cd','12345');
        getAccountInfoPage.getParameters().put('tsuhan_Umu','1');
        getAccountInfoPage.getParameters().put('shudan_Cd','1');
        getAccountInfoPage.getParameters().put('shudan_Name','集団名');
        getAccountInfoPage.getParameters().put('jiko_Umu','1');
        getAccountInfoPage.getParameters().put('soshiki_Cd','123456');
        getAccountInfoPage.getParameters().put('hkn_Shurui','保険種目');
        getAccountInfoPage.getParameters().put('gokei_HknRyo','123');
        getAccountInfoPage.getParameters().put('keiyakusha_Birth','20200103');
        getAccountInfoPage.getParameters().put('keiyakusha_Nenrei','100');
        getAccountInfoPage.getParameters().put('keiyakusha_Seibetsu','女');
        getAccountInfoPage.getParameters().put('shisha_Cd','123-12');
        getAccountInfoPage.getParameters().put('cif_Cd','1');
        getAccountInfoPage.getParameters().put('renrakusaki','123');
        getAccountInfoPage.getParameters().put('haraikomi','123');
        getAccountInfoPage.getParameters().put('keiyakusha_Jusho_Kana','ジュウショカナ');
        Test.startTest();

        // テスト対象ページのカレントページ化
        Test.setCurrentPage(getAccountInfoPage);
        {
          GetAccountInfoController TestController = new GetAccountInfoController();
          TestController.processIncomingData();
        }

        Test.stopTest();
    }
}