@isTest
public class GetAccountInfoRestTests{

    private static testMethod void processIncomingDataTest1(){ 
        Case testCase = new Case();
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        Insert testCase;
        Test.startTest(); 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetAccountInfo';
        String JSONMsg = '{';
        JSONMsg +='"gCode" : "xxxxx",';
        JSONMsg +='"gyoumu_Id" : "'+testCase.Id +'",';
        JSONMsg +='"shoken_No" : "1234567890",';
        JSONMsg +='"hkn_Shiki" : "20111201",';
        JSONMsg +='"hkn_Shuki" : "20211201",';
        JSONMsg +='"keiyakusha_Knj"  : "契約者",';
        JSONMsg +='"keiyakusha_Kana" : "ケイヤクシャ",';
        JSONMsg +='"keiyakusha_Tel" : "111122223333",';
        JSONMsg +='"keiyakusha_Yubin_No" : "123-4567",';
        JSONMsg +='"keiyakusha_Jusho_Knj" : "住所１２３４５",';
        JSONMsg +='"dairiten_Cd"  : "12345678901",';
        JSONMsg +='"shokanten_Cd" : "12-456",';
        JSONMsg +='"tsuhan_Umu"  : " ",';
        JSONMsg +='"shudan_Cd" : "1234567",';
        JSONMsg +='"shudan_Name" : "集団名",';
        JSONMsg +='"jiko_Umu" : " ",';
        JSONMsg +='"soshiki_Cd" : "123456",';
        JSONMsg +='"hkn_Shurui" : "種類テキスト",';
        JSONMsg +='"gokei_HknRyo" : "00000123456",';
        JSONMsg +='"keiyakusha_Birth" : "20010301",';
        JSONMsg +='"keiyakusha_Nenrei" : "20",';
        JSONMsg +='"keiyakusha_Seibetsu" : "女",';
        JSONMsg +='"shisha_Cd" : "123456",';
        JSONMsg +='"cif_Cd" : "123456789012345",';
        JSONMsg +='"renrakusaki" : "111122223333",';
        JSONMsg +='"haraikomi" : "払い込み方法",';
        JSONMsg +='"keiyakusha_Jusho_Kana" : "ジュウショカナ"}';
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetAccountInfoRest.processIncomingData();

        Test.stopTest();
    }

    private static testMethod void processIncomingDataTest2(){ 
        Account testAccount = new Account();
        RecordType personType = [Select Id From RecordType Where SObjectType = 'Account' And Name = '顧客'].get(0);
        testAccount.LastName = 'テストAccount';
        testAccount.RecordTypeId = personType.Id;
        String tel = '123412341234';
        testAccount.PhoneNumber__c = tel;
        testAccount.PhoneNumber__pc = tel;
        Insert testAccount;
        Test.startTest(); 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetAccountInfo';
        String JSONMsg = '{';
        JSONMsg +='"gCode" : "xxxxx",';
        JSONMsg +='"gyoumu_Id" : "'+testAccount.Id +'",';
        JSONMsg +='"shoken_No" : "1234567890",';
        JSONMsg +='"hkn_Shiki" : "20111201",';
        JSONMsg +='"hkn_Shuki" : "20211201",';
        JSONMsg +='"keiyakusha_Knj"  : "契約者",';
        JSONMsg +='"keiyakusha_Kana" : "ケイヤクシャ",';
        JSONMsg +='"keiyakusha_Tel" : "111122223333",';
        JSONMsg +='"keiyakusha_Yubin_No" : "123-4567",';
        JSONMsg +='"keiyakusha_Jusho_Knj" : "住所１２３４５",';
        JSONMsg +='"dairiten_Cd"  : "12345678901",';
        JSONMsg +='"shokanten_Cd" : "12-456",';
        JSONMsg +='"tsuhan_Umu"  : " ",';
        JSONMsg +='"shudan_Cd" : "1234567",';
        JSONMsg +='"shudan_Name" : "集団名",';
        JSONMsg +='"jiko_Umu" : " ",';
        JSONMsg +='"soshiki_Cd" : "123456",';
        JSONMsg +='"hkn_Shurui" : "種類テキスト",';
        JSONMsg +='"gokei_HknRyo" : "00000123456",';
        JSONMsg +='"keiyakusha_Birth" : "20010301",';
        JSONMsg +='"keiyakusha_Nenrei" : "20",';
        JSONMsg +='"keiyakusha_Seibetsu" : "女",';
        JSONMsg +='"shisha_Cd" : "123456",';
        JSONMsg +='"cif_Cd" : "123456789012345",';
        JSONMsg +='"renrakusaki" : "111122223333",';
        JSONMsg +='"haraikomi" : "払い込み方法",';
        JSONMsg +='"keiyakusha_Jusho_Kana" : "ジュウショカナ"}';
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetAccountInfoRest.processIncomingData();

        Test.stopTest();
    }

    //レコードタイプ：火新異動
    private static testMethod void processIncomingDataTest_Fire(){
        //Account
        account a1 = new Account();
        a1.Name = 'N0000001';
        a1.PhoneNumber__c = '1234567890';
        a1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Agent').getRecordTypeId();
        insert a1;

        //Contact
        Contact con1 = new Contact();
        con1.AccountId = a1.Id;
        con1.FirstName = '太郎';
        con1.LastName = 'テスト';
        con1.PhoneNumber__c = '1234567890';
        insert con1;

        Case testCase = new Case();
        testCase.ReferenceAccount__c = a1.Id;
        testCase.contactId = con1.Id;
        testCase.PolicyIdentificationMethod__c = '証券番号';
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        testCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Fire').getRecordTypeId(); //火新異動
        Insert testCase;
        
        Test.startTest(); 
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetAccountInfo';
        String JSONMsg = '{';
        JSONMsg +='"gCode" : "xxxxx",';
        JSONMsg +='"gyoumu_Id" : "'+testCase.Id +'",';
        JSONMsg +='"shoken_No" : "1234567890",';
        JSONMsg +='"hkn_Shiki" : "20111201",';
        JSONMsg +='"hkn_Shuki" : "20211201",';
        JSONMsg +='"keiyakusha_Knj"  : "契約者",';
        JSONMsg +='"keiyakusha_Kana" : "ケイヤクシャ",';
        JSONMsg +='"keiyakusha_Tel" : "111122223333",';
        JSONMsg +='"keiyakusha_Yubin_No" : "123-4567",';
        JSONMsg +='"keiyakusha_Jusho_Knj" : "住所１２３４５",';
        JSONMsg +='"dairiten_Cd"  : "12345678901",';
        JSONMsg +='"shokanten_Cd" : "12-456",';
        JSONMsg +='"tsuhan_Umu"  : " ",';
        JSONMsg +='"shudan_Cd" : "1234567",';
        JSONMsg +='"shudan_Name" : "集団名",';
        JSONMsg +='"jiko_Umu" : " ",';
        JSONMsg +='"soshiki_Cd" : "123456",';
        JSONMsg +='"hkn_Shurui" : "個人用火災総合保険",'; //保険種目２（火新異動）
        JSONMsg +='"gokei_HknRyo" : "00000123456",';
        JSONMsg +='"keiyakusha_Birth" : "20010301",';
        JSONMsg +='"keiyakusha_Nenrei" : "20",';
        JSONMsg +='"keiyakusha_Seibetsu" : "女",';
        JSONMsg +='"shisha_Cd" : "123456",';
        JSONMsg +='"cif_Cd" : "123456789012345",';
        JSONMsg +='"renrakusaki" : "111122223333",';
        JSONMsg +='"haraikomi" : "払い込み方法",';
        JSONMsg +='"keiyakusha_Jusho_Kana" : "ジュウショカナ"}';
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetAccountInfoRest.processIncomingData();

        Test.stopTest();
    }

    //JAシニア／安心倶楽部*（標準傷害保険）
    private static testMethod void processIncomingDataTest_Hyojun_JASenior(){
        //Account
        account a1 = new Account();
        a1.Name = 'N0000001';
        a1.PhoneNumber__c = '1234567890';
        a1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Agent').getRecordTypeId();
        insert a1;

        //Contact
        Contact con1 = new Contact();
        con1.AccountId = a1.Id;
        con1.FirstName = '太郎';
        con1.LastName = 'テスト';
        con1.PhoneNumber__c = '1234567890';
        insert con1;

        Case testCase = new Case();
        testCase.ReferenceAccount__c = a1.Id;
        testCase.contactId = con1.Id;
        testCase.PolicyIdentificationMethod__c = '証券番号';
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        testCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Auto_ContinuationStop').getRecordTypeId(); //自動継続停止
        Insert testCase;
        
        Test.startTest(); 
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetAccountInfo';
        String JSONMsg = '{';
        JSONMsg +='"gCode" : "xxxxx",';
        JSONMsg +='"gyoumu_Id" : "'+testCase.Id +'",';
        JSONMsg +='"shoken_No" : "12345678901234567",'; //17桁
        JSONMsg +='"hkn_Shiki" : "20111201",';
        JSONMsg +='"hkn_Shuki" : "20211201",';
        JSONMsg +='"keiyakusha_Knj"  : "契約者",';
        JSONMsg +='"keiyakusha_Kana" : "ケイヤクシャ",';
        JSONMsg +='"keiyakusha_Tel" : "111122223333",';
        JSONMsg +='"keiyakusha_Yubin_No" : "123-4567",';
        JSONMsg +='"keiyakusha_Jusho_Knj" : "住所１２３４５",';
        JSONMsg +='"dairiten_Cd"  : "12345678901",';
        JSONMsg +='"shokanten_Cd" : "12-456",';
        JSONMsg +='"tsuhan_Umu"  : " ",';
        JSONMsg +='"shudan_Cd" : "8630001",'; //頭3桁863
        JSONMsg +='"shudan_Name" : "集団名",';
        JSONMsg +='"jiko_Umu" : " ",';
        JSONMsg +='"soshiki_Cd" : "123456",';
        JSONMsg +='"hkn_Shurui" : "標準傷害保険",'; //標準傷害保険を設定
        JSONMsg +='"gokei_HknRyo" : "00000123456",';
        JSONMsg +='"keiyakusha_Birth" : "20010301",';
        JSONMsg +='"keiyakusha_Nenrei" : "20",';
        JSONMsg +='"keiyakusha_Seibetsu" : "女",';
        JSONMsg +='"shisha_Cd" : "123456",';
        JSONMsg +='"cif_Cd" : "123456789012345",';
        JSONMsg +='"renrakusaki" : "111122223333",';
        JSONMsg +='"haraikomi" : "払い込み方法",';
        JSONMsg +='"keiyakusha_Jusho_Kana" : "ジュウショカナ"}';
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetAccountInfoRest.processIncomingData();

        Test.stopTest();
    }

    //窓販シニア*（標準傷害保険）
    private static testMethod void processIncomingDataTest_Hyojun_MadohanSenior(){
        //Account
        account a1 = new Account();
        a1.Name = 'N0000001';
        a1.PhoneNumber__c = '1234567890';
        a1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Agent').getRecordTypeId();
        insert a1;

        //Contact
        Contact con1 = new Contact();
        con1.AccountId = a1.Id;
        con1.FirstName = '太郎';
        con1.LastName = 'テスト';
        con1.PhoneNumber__c = '1234567890';
        insert con1;

        Case testCase = new Case();
        testCase.ReferenceAccount__c = a1.Id;
        testCase.contactId = con1.Id;
        testCase.PolicyIdentificationMethod__c = '証券番号';
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        testCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Auto_ContinuationStop').getRecordTypeId(); //自動継続停止
        Insert testCase;
        
        Test.startTest(); 
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetAccountInfo';
        String JSONMsg = '{';
        JSONMsg +='"gCode" : "xxxxx",';
        JSONMsg +='"gyoumu_Id" : "'+testCase.Id +'",';
        JSONMsg +='"shoken_No" : "12345678901234567",'; //17桁
        JSONMsg +='"hkn_Shiki" : "20111201",';
        JSONMsg +='"hkn_Shuki" : "20211201",';
        JSONMsg +='"keiyakusha_Knj"  : "契約者",';
        JSONMsg +='"keiyakusha_Kana" : "ケイヤクシャ",';
        JSONMsg +='"keiyakusha_Tel" : "111122223333",';
        JSONMsg +='"keiyakusha_Yubin_No" : "123-4567",';
        JSONMsg +='"keiyakusha_Jusho_Knj" : "住所１２３４５",';
        JSONMsg +='"dairiten_Cd"  : "12345678901",';
        JSONMsg +='"shokanten_Cd" : "12-456",';
        JSONMsg +='"tsuhan_Umu"  : " ",';
        JSONMsg +='"shudan_Cd" : "8620001",'; //頭3桁862
        JSONMsg +='"shudan_Name" : "集団名",';
        JSONMsg +='"jiko_Umu" : " ",';
        JSONMsg +='"soshiki_Cd" : "123456",';
        JSONMsg +='"hkn_Shurui" : "標準傷害保険",'; //標準傷害保険を設定
        JSONMsg +='"gokei_HknRyo" : "00000123456",';
        JSONMsg +='"keiyakusha_Birth" : "20010301",';
        JSONMsg +='"keiyakusha_Nenrei" : "20",';
        JSONMsg +='"keiyakusha_Seibetsu" : "女",';
        JSONMsg +='"shisha_Cd" : "123456",';
        JSONMsg +='"cif_Cd" : "123456789012345",';
        JSONMsg +='"renrakusaki" : "111122223333",';
        JSONMsg +='"haraikomi" : "払い込み方法",';
        JSONMsg +='"keiyakusha_Jusho_Kana" : "ジュウショカナ"}';
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetAccountInfoRest.processIncomingData();

        Test.stopTest();
    }

    //しんきんシニア*（標準傷害保険）
    private static testMethod void processIncomingDataTest_Hyojun_ShinkinSenior(){
        //Account
        account a1 = new Account();
        a1.Name = 'N0000001';
        a1.PhoneNumber__c = '1234567890';
        a1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Agent').getRecordTypeId();
        insert a1;

        //Contact
        Contact con1 = new Contact();
        con1.AccountId = a1.Id;
        con1.FirstName = '太郎';
        con1.LastName = 'テスト';
        con1.PhoneNumber__c = '1234567890';
        insert con1;

        Case testCase = new Case();
        testCase.ReferenceAccount__c = a1.Id;
        testCase.contactId = con1.Id;
        testCase.PolicyIdentificationMethod__c = '証券番号';
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        testCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Auto_ContinuationStop').getRecordTypeId(); //自動継続停止
        Insert testCase;
        
        Test.startTest(); 
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetAccountInfo';
        String JSONMsg = '{';
        JSONMsg +='"gCode" : "xxxxx",';
        JSONMsg +='"gyoumu_Id" : "'+testCase.Id +'",';
        JSONMsg +='"shoken_No" : "12345678901234567",'; //17桁
        JSONMsg +='"hkn_Shiki" : "20111201",';
        JSONMsg +='"hkn_Shuki" : "20211201",';
        JSONMsg +='"keiyakusha_Knj"  : "契約者",';
        JSONMsg +='"keiyakusha_Kana" : "ケイヤクシャ",';
        JSONMsg +='"keiyakusha_Tel" : "111122223333",';
        JSONMsg +='"keiyakusha_Yubin_No" : "123-4567",';
        JSONMsg +='"keiyakusha_Jusho_Knj" : "住所１２３４５",';
        JSONMsg +='"dairiten_Cd"  : "12345678901",';
        JSONMsg +='"shokanten_Cd" : "12-456",';
        JSONMsg +='"tsuhan_Umu"  : " ",';
        JSONMsg +='"shudan_Cd" : "8640001",'; //頭3桁864
        JSONMsg +='"shudan_Name" : "集団名",';
        JSONMsg +='"jiko_Umu" : " ",';
        JSONMsg +='"soshiki_Cd" : "123456",';
        JSONMsg +='"hkn_Shurui" : "標準傷害保険",'; //標準傷害保険を設定
        JSONMsg +='"gokei_HknRyo" : "00000123456",';
        JSONMsg +='"keiyakusha_Birth" : "20010301",';
        JSONMsg +='"keiyakusha_Nenrei" : "20",';
        JSONMsg +='"keiyakusha_Seibetsu" : "女",';
        JSONMsg +='"shisha_Cd" : "123456",';
        JSONMsg +='"cif_Cd" : "123456789012345",';
        JSONMsg +='"renrakusaki" : "111122223333",';
        JSONMsg +='"haraikomi" : "払い込み方法",';
        JSONMsg +='"keiyakusha_Jusho_Kana" : "ジュウショカナ"}';
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetAccountInfoRest.processIncomingData();

        Test.stopTest();
    }

    //窓販シニア*
    private static testMethod void processIncomingDataTest_MadohanSenior(){
        //Account
        account a1 = new Account();
        a1.Name = 'N0000001';
        a1.PhoneNumber__c = '1234567890';
        a1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Agent').getRecordTypeId();
        insert a1;

        //Contact
        Contact con1 = new Contact();
        con1.AccountId = a1.Id;
        con1.FirstName = '太郎';
        con1.LastName = 'テスト';
        con1.PhoneNumber__c = '1234567890';
        insert con1;

        Case testCase = new Case();
        testCase.ReferenceAccount__c = a1.Id;
        testCase.contactId = con1.Id;
        testCase.PolicyIdentificationMethod__c = '証券番号';
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        testCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Auto_ContinuationStop').getRecordTypeId(); //自動継続停止
        Insert testCase;
        
        Test.startTest(); 
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetAccountInfo';
        String JSONMsg = '{';
        JSONMsg +='"gCode" : "xxxxx",';
        JSONMsg +='"gyoumu_Id" : "'+testCase.Id +'",';
        JSONMsg +='"shoken_No" : "12345678901234567",'; //17桁
        JSONMsg +='"hkn_Shiki" : "20111201",';
        JSONMsg +='"hkn_Shuki" : "20211201",';
        JSONMsg +='"keiyakusha_Knj"  : "契約者",';
        JSONMsg +='"keiyakusha_Kana" : "ケイヤクシャ",';
        JSONMsg +='"keiyakusha_Tel" : "111122223333",';
        JSONMsg +='"keiyakusha_Yubin_No" : "123-4567",';
        JSONMsg +='"keiyakusha_Jusho_Knj" : "住所１２３４５",';
        JSONMsg +='"dairiten_Cd"  : "12345678901",';
        JSONMsg +='"shokanten_Cd" : "12-456",';
        JSONMsg +='"tsuhan_Umu"  : " ",';
        JSONMsg +='"shudan_Cd" : "1234567",';
        JSONMsg +='"shudan_Name" : "集団名",';
        JSONMsg +='"jiko_Umu" : " ",';
        JSONMsg +='"soshiki_Cd" : "123456",';
        JSONMsg +='"hkn_Shurui" : "普通傷害保険",'; //普通傷害保険を設定
        JSONMsg +='"gokei_HknRyo" : "00000123456",';
        JSONMsg +='"keiyakusha_Birth" : "20010301",';
        JSONMsg +='"keiyakusha_Nenrei" : "20",';
        JSONMsg +='"keiyakusha_Seibetsu" : "女",';
        JSONMsg +='"shisha_Cd" : "123456",';
        JSONMsg +='"cif_Cd" : "123456789012345",';
        JSONMsg +='"renrakusaki" : "111122223333",';
        JSONMsg +='"haraikomi" : "払い込み方法",';
        JSONMsg +='"keiyakusha_Jusho_Kana" : "ジュウショカナ"}';
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetAccountInfoRest.processIncomingData();

        Test.stopTest();
    }

    //しんきんシニア*
    private static testMethod void processIncomingDataTest_ShinkinSenior(){
        //Account
        account a1 = new Account();
        a1.Name = 'N0000001';
        a1.PhoneNumber__c = '1234567890';
        a1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Agent').getRecordTypeId();
        insert a1;

        //Contact
        Contact con1 = new Contact();
        con1.AccountId = a1.Id;
        con1.FirstName = '太郎';
        con1.LastName = 'テスト';
        con1.PhoneNumber__c = '1234567890';
        insert con1;

        Case testCase = new Case();
        testCase.ReferenceAccount__c = a1.Id;
        testCase.contactId = con1.Id;
        testCase.PolicyIdentificationMethod__c = '証券番号';
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        testCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Auto_ContinuationStop').getRecordTypeId(); //自動継続停止
        Insert testCase;
        
        Test.startTest(); 
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetAccountInfo';
        String JSONMsg = '{';
        JSONMsg +='"gCode" : "xxxxx",';
        JSONMsg +='"gyoumu_Id" : "'+testCase.Id +'",';
        JSONMsg +='"shoken_No" : "12345678901234567",'; //17桁
        JSONMsg +='"hkn_Shiki" : "20111201",';
        JSONMsg +='"hkn_Shuki" : "20211201",';
        JSONMsg +='"keiyakusha_Knj"  : "契約者",';
        JSONMsg +='"keiyakusha_Kana" : "ケイヤクシャ",';
        JSONMsg +='"keiyakusha_Tel" : "111122223333",';
        JSONMsg +='"keiyakusha_Yubin_No" : "123-4567",';
        JSONMsg +='"keiyakusha_Jusho_Knj" : "住所１２３４５",';
        JSONMsg +='"dairiten_Cd"  : "12345678901",';
        JSONMsg +='"shokanten_Cd" : "12-456",';
        JSONMsg +='"tsuhan_Umu"  : " ",';
        JSONMsg +='"shudan_Cd" : "1234567",';
        JSONMsg +='"shudan_Name" : "集団名",';
        JSONMsg +='"jiko_Umu" : " ",';
        JSONMsg +='"soshiki_Cd" : "123456",';
        JSONMsg +='"hkn_Shurui" : "安心生活総合（普傷）",'; //安心生活総合（普傷）を設定
        JSONMsg +='"gokei_HknRyo" : "00000123456",';
        JSONMsg +='"keiyakusha_Birth" : "20010301",';
        JSONMsg +='"keiyakusha_Nenrei" : "20",';
        JSONMsg +='"keiyakusha_Seibetsu" : "女",';
        JSONMsg +='"shisha_Cd" : "123456",';
        JSONMsg +='"cif_Cd" : "123456789012345",';
        JSONMsg +='"renrakusaki" : "111122223333",';
        JSONMsg +='"haraikomi" : "払い込み方法",';
        JSONMsg +='"keiyakusha_Jusho_Kana" : "ジュウショカナ"}';
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetAccountInfoRest.processIncomingData();

        Test.stopTest();
    }

    //まごネット*
    private static testMethod void processIncomingDataTest_Magonet(){
        //Account
        account a1 = new Account();
        a1.Name = 'N0000001';
        a1.PhoneNumber__c = '1234567890';
        a1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Agent').getRecordTypeId();
        insert a1;

        //Contact
        Contact con1 = new Contact();
        con1.AccountId = a1.Id;
        con1.FirstName = '太郎';
        con1.LastName = 'テスト';
        con1.PhoneNumber__c = '1234567890';
        insert con1;

        Case testCase = new Case();
        testCase.ReferenceAccount__c = a1.Id;
        testCase.contactId = con1.Id;
        testCase.PolicyIdentificationMethod__c = '証券番号';
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        testCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Auto_ContinuationStop').getRecordTypeId(); //自動継続停止
        Insert testCase;
        
        Test.startTest(); 
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetAccountInfo';
        String JSONMsg = '{';
        JSONMsg +='"gCode" : "xxxxx",';
        JSONMsg +='"gyoumu_Id" : "'+testCase.Id +'",';
        JSONMsg +='"shoken_No" : "12345678901234567",'; //17桁
        JSONMsg +='"hkn_Shiki" : "20111201",';
        JSONMsg +='"hkn_Shuki" : "20211201",';
        JSONMsg +='"keiyakusha_Knj"  : "契約者",';
        JSONMsg +='"keiyakusha_Kana" : "ケイヤクシャ",';
        JSONMsg +='"keiyakusha_Tel" : "111122223333",';
        JSONMsg +='"keiyakusha_Yubin_No" : "123-4567",';
        JSONMsg +='"keiyakusha_Jusho_Knj" : "住所１２３４５",';
        JSONMsg +='"dairiten_Cd"  : "12345678901",';
        JSONMsg +='"shokanten_Cd" : "12-456",';
        JSONMsg +='"tsuhan_Umu"  : " ",';
        JSONMsg +='"shudan_Cd" : "1234567",';
        JSONMsg +='"shudan_Name" : "集団名",';
        JSONMsg +='"jiko_Umu" : " ",';
        JSONMsg +='"soshiki_Cd" : "123456",';
        JSONMsg +='"hkn_Shurui" : "こども総合保険",'; //こども総合保険を設定
        JSONMsg +='"gokei_HknRyo" : "00000123456",';
        JSONMsg +='"keiyakusha_Birth" : "20010301",';
        JSONMsg +='"keiyakusha_Nenrei" : "20",';
        JSONMsg +='"keiyakusha_Seibetsu" : "女",';
        JSONMsg +='"shisha_Cd" : "123456",';
        JSONMsg +='"cif_Cd" : "123456789012345",';
        JSONMsg +='"renrakusaki" : "111122223333",';
        JSONMsg +='"haraikomi" : "払い込み方法",';
        JSONMsg +='"keiyakusha_Jusho_Kana" : "ジュウショカナ"}';
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetAccountInfoRest.processIncomingData();

        Test.stopTest();
    }

    //JA自転車倶楽部*
    private static testMethod void processIncomingDataTest_JAJitensya(){
        //Account
        account a1 = new Account();
        a1.Name = 'N0000001';
        a1.PhoneNumber__c = '1234567890';
        a1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Agent').getRecordTypeId();
        insert a1;

        //Contact
        Contact con1 = new Contact();
        con1.AccountId = a1.Id;
        con1.FirstName = '太郎';
        con1.LastName = 'テスト';
        con1.PhoneNumber__c = '1234567890';
        insert con1;

        Case testCase = new Case();
        testCase.ReferenceAccount__c = a1.Id;
        testCase.contactId = con1.Id;
        testCase.PolicyIdentificationMethod__c = '証券番号';
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        testCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Auto_ContinuationStop').getRecordTypeId(); //自動継続停止
        Insert testCase;
        
        Test.startTest(); 
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetAccountInfo';
        String JSONMsg = '{';
        JSONMsg +='"gCode" : "xxxxx",';
        JSONMsg +='"gyoumu_Id" : "'+testCase.Id +'",';
        JSONMsg +='"shoken_No" : "12345678901234567",'; //17桁
        JSONMsg +='"hkn_Shiki" : "20111201",';
        JSONMsg +='"hkn_Shuki" : "20211201",';
        JSONMsg +='"keiyakusha_Knj"  : "契約者",';
        JSONMsg +='"keiyakusha_Kana" : "ケイヤクシャ",';
        JSONMsg +='"keiyakusha_Tel" : "111122223333",';
        JSONMsg +='"keiyakusha_Yubin_No" : "123-4567",';
        JSONMsg +='"keiyakusha_Jusho_Knj" : "住所１２３４５",';
        JSONMsg +='"dairiten_Cd"  : "12345678901",';
        JSONMsg +='"shokanten_Cd" : "12-456",';
        JSONMsg +='"tsuhan_Umu"  : " ",';
        JSONMsg +='"shudan_Cd" : "1234567",';
        JSONMsg +='"shudan_Name" : "集団名",';
        JSONMsg +='"jiko_Umu" : " ",';
        JSONMsg +='"soshiki_Cd" : "123456",';
        JSONMsg +='"hkn_Shurui" : "交通事故傷害保険",'; //交通事故傷害保険を設定
        JSONMsg +='"gokei_HknRyo" : "00000123456",';
        JSONMsg +='"keiyakusha_Birth" : "20010301",';
        JSONMsg +='"keiyakusha_Nenrei" : "20",';
        JSONMsg +='"keiyakusha_Seibetsu" : "女",';
        JSONMsg +='"shisha_Cd" : "123456",';
        JSONMsg +='"cif_Cd" : "123456789012345",';
        JSONMsg +='"renrakusaki" : "111122223333",';
        JSONMsg +='"haraikomi" : "払い込み方法",';
        JSONMsg +='"keiyakusha_Jusho_Kana" : "ジュウショカナ"}';
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetAccountInfoRest.processIncomingData();

        Test.stopTest();
    }

    //しんきんフルタイム24*
    private static testMethod void processIncomingDataTest_ShinkinFulltime(){
        //Account
        account a1 = new Account();
        a1.Name = 'N0000001';
        a1.PhoneNumber__c = '1234567890';
        a1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Agent').getRecordTypeId();
        insert a1;

        //Contact
        Contact con1 = new Contact();
        con1.AccountId = a1.Id;
        con1.FirstName = '太郎';
        con1.LastName = 'テスト';
        con1.PhoneNumber__c = '1234567890';
        insert con1;

        Case testCase = new Case();
        testCase.ReferenceAccount__c = a1.Id;
        testCase.contactId = con1.Id;
        testCase.PolicyIdentificationMethod__c = '証券番号';
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        testCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Auto_ContinuationStop').getRecordTypeId(); //自動継続停止
        Insert testCase;
        
        Test.startTest(); 
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetAccountInfo';
        String JSONMsg = '{';
        JSONMsg +='"gCode" : "xxxxx",';
        JSONMsg +='"gyoumu_Id" : "'+testCase.Id +'",';
        JSONMsg +='"shoken_No" : "1234567890",'; //10桁
        JSONMsg +='"hkn_Shiki" : "20111201",';
        JSONMsg +='"hkn_Shuki" : "20211201",';
        JSONMsg +='"keiyakusha_Knj"  : "契約者",';
        JSONMsg +='"keiyakusha_Kana" : "ケイヤクシャ",';
        JSONMsg +='"keiyakusha_Tel" : "111122223333",';
        JSONMsg +='"keiyakusha_Yubin_No" : "123-4567",';
        JSONMsg +='"keiyakusha_Jusho_Knj" : "住所１２３４５",';
        JSONMsg +='"dairiten_Cd"  : "12345678901",';
        JSONMsg +='"shokanten_Cd" : "12-456",';
        JSONMsg +='"tsuhan_Umu"  : " ",';
        JSONMsg +='"shudan_Cd" : "1234567",';
        JSONMsg +='"shudan_Name" : "集団名",';
        JSONMsg +='"jiko_Umu" : " ",';
        JSONMsg +='"soshiki_Cd" : "123456",';
        JSONMsg +='"hkn_Shurui" : "普通傷害保険",'; //普通傷害保険を設定
        JSONMsg +='"gokei_HknRyo" : "00000123456",';
        JSONMsg +='"keiyakusha_Birth" : "20010301",';
        JSONMsg +='"keiyakusha_Nenrei" : "20",';
        JSONMsg +='"keiyakusha_Seibetsu" : "女",';
        JSONMsg +='"shisha_Cd" : "123456",';
        JSONMsg +='"cif_Cd" : "123456789012345",';
        JSONMsg +='"renrakusaki" : "111122223333",';
        JSONMsg +='"haraikomi" : "払い込み方法",';
        JSONMsg +='"keiyakusha_Jusho_Kana" : "ジュウショカナ"}';
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetAccountInfoRest.processIncomingData();

        Test.stopTest();
    }

    //しんくみ標準傷害*
    private static testMethod void processIncomingDataTest_ShinkumiHyojunShogai(){
        //Account
        account a1 = new Account();
        a1.Name = 'N0000001';
        a1.PhoneNumber__c = '1234567890';
        a1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Agent').getRecordTypeId();
        insert a1;

        //Contact
        Contact con1 = new Contact();
        con1.AccountId = a1.Id;
        con1.FirstName = '太郎';
        con1.LastName = 'テスト';
        con1.PhoneNumber__c = '1234567890';
        insert con1;

        Case testCase = new Case();
        testCase.ReferenceAccount__c = a1.Id;
        testCase.contactId = con1.Id;
        testCase.PolicyIdentificationMethod__c = '証券番号';
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        testCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Auto_ContinuationStop').getRecordTypeId(); //自動継続停止
        Insert testCase;
        
        Test.startTest(); 
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetAccountInfo';
        String JSONMsg = '{';
        JSONMsg +='"gCode" : "xxxxx",';
        JSONMsg +='"gyoumu_Id" : "'+testCase.Id +'",';
        JSONMsg +='"shoken_No" : "1234567890",'; //10桁
        JSONMsg +='"hkn_Shiki" : "20111201",';
        JSONMsg +='"hkn_Shuki" : "20211201",';
        JSONMsg +='"keiyakusha_Knj"  : "契約者",';
        JSONMsg +='"keiyakusha_Kana" : "ケイヤクシャ",';
        JSONMsg +='"keiyakusha_Tel" : "111122223333",';
        JSONMsg +='"keiyakusha_Yubin_No" : "123-4567",';
        JSONMsg +='"keiyakusha_Jusho_Knj" : "住所１２３４５",';
        JSONMsg +='"dairiten_Cd"  : "12345678901",';
        JSONMsg +='"shokanten_Cd" : "12-456",';
        JSONMsg +='"tsuhan_Umu"  : " ",';
        JSONMsg +='"shudan_Cd" : "7701000",'; //7701000を設定
        JSONMsg +='"shudan_Name" : "集団名",';
        JSONMsg +='"jiko_Umu" : " ",';
        JSONMsg +='"soshiki_Cd" : "123456",';
        JSONMsg +='"hkn_Shurui" : "標準傷害保険",'; //標準傷害保険を設定
        JSONMsg +='"gokei_HknRyo" : "00000123456",';
        JSONMsg +='"keiyakusha_Birth" : "20010301",';
        JSONMsg +='"keiyakusha_Nenrei" : "20",';
        JSONMsg +='"keiyakusha_Seibetsu" : "女",';
        JSONMsg +='"shisha_Cd" : "123456",';
        JSONMsg +='"cif_Cd" : "123456789012345",';
        JSONMsg +='"renrakusaki" : "111122223333",';
        JSONMsg +='"haraikomi" : "払い込み方法",';
        JSONMsg +='"keiyakusha_Jusho_Kana" : "ジュウショカナ"}';
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetAccountInfoRest.processIncomingData();

        Test.stopTest();
    }

    //しんきん標準傷害*
    private static testMethod void processIncomingDataTest_ShinkinHyojunShogai(){
        //Account
        account a1 = new Account();
        a1.Name = 'N0000001';
        a1.PhoneNumber__c = '1234567890';
        a1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Agent').getRecordTypeId();
        insert a1;

        //Contact
        Contact con1 = new Contact();
        con1.AccountId = a1.Id;
        con1.FirstName = '太郎';
        con1.LastName = 'テスト';
        con1.PhoneNumber__c = '1234567890';
        insert con1;

        Case testCase = new Case();
        testCase.ReferenceAccount__c = a1.Id;
        testCase.contactId = con1.Id;
        testCase.PolicyIdentificationMethod__c = '証券番号';
        testCase.InquiryDetails__c = 'テスト問い合わせ詳細';
        testCase.Remarks__c = 'テスト対応依頼票転記内容あいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくえこあいうえおかきくけこ';
        testCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Auto_ContinuationStop').getRecordTypeId(); //自動継続停止
        Insert testCase;
        
        Test.startTest(); 
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/GetAccountInfo';
        String JSONMsg = '{';
        JSONMsg +='"gCode" : "xxxxx",';
        JSONMsg +='"gyoumu_Id" : "'+testCase.Id +'",';
        JSONMsg +='"shoken_No" : "1234567890",'; //10桁
        JSONMsg +='"hkn_Shiki" : "20111201",';
        JSONMsg +='"hkn_Shuki" : "20211201",';
        JSONMsg +='"keiyakusha_Knj"  : "契約者",';
        JSONMsg +='"keiyakusha_Kana" : "ケイヤクシャ",';
        JSONMsg +='"keiyakusha_Tel" : "111122223333",';
        JSONMsg +='"keiyakusha_Yubin_No" : "123-4567",';
        JSONMsg +='"keiyakusha_Jusho_Knj" : "住所１２３４５",';
        JSONMsg +='"dairiten_Cd"  : "12345678901",';
        JSONMsg +='"shokanten_Cd" : "12-456",';
        JSONMsg +='"tsuhan_Umu"  : " ",';
        JSONMsg +='"shudan_Cd" : "1234567",'; //7701000以外を設定
        JSONMsg +='"shudan_Name" : "集団名",';
        JSONMsg +='"jiko_Umu" : " ",';
        JSONMsg +='"soshiki_Cd" : "123456",';
        JSONMsg +='"hkn_Shurui" : "標準傷害保険",'; //標準傷害保険を設定
        JSONMsg +='"gokei_HknRyo" : "00000123456",';
        JSONMsg +='"keiyakusha_Birth" : "20010301",';
        JSONMsg +='"keiyakusha_Nenrei" : "20",';
        JSONMsg +='"keiyakusha_Seibetsu" : "女",';
        JSONMsg +='"shisha_Cd" : "123456",';
        JSONMsg +='"cif_Cd" : "123456789012345",';
        JSONMsg +='"renrakusaki" : "111122223333",';
        JSONMsg +='"haraikomi" : "払い込み方法",';
        JSONMsg +='"keiyakusha_Jusho_Kana" : "ジュウショカナ"}';
        req.requestBody = Blob.valueof(JSONMsg);
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response= res;
        GetAccountInfoRest.processIncomingData();

        Test.stopTest();
    }
}