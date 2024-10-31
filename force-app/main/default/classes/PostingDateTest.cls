@isTest
private class PostingDateTest {

    @isTest static void postingTest1(){
        PostingDate targetClass = new PostingDate();
        targetClass.Posting('2019/01/01');
        targetClass.Posting('2018/01/01');
        targetClass.Posting('1988/01/01');
    }
    
}