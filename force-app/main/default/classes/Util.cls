public class Util {

    public String ChangeToSCalender(String WDate){
        List<String> ls  = WDate.split('/');
        Integer SCalendarYear;
        String InvalidDate = System.Label.InvalidDateLabel;
        String WCalendarYear = WDate.left(1);
        String WCalendarYearNum = WDate.mid(1,ls.get(0).length() - 1 );        
        if(WCalendarYear == 'R'){
            SCalendarYear = 2018 + Integer.valueOf(WCalendarYearNum);
        }else if(WCalendarYear == 'H'){
            SCalendarYear = 1988 + Integer.valueOf(WCalendarYearNum);
        }else if(WCalendarYear == 'S'){
            SCalendarYear = 1925 + Integer.valueOf(WCalendarYearNum);
        }else if(WCalendarYear == 'T'){
            SCalendarYear = 1911 + Integer.valueOf(WCalendarYearNum);
        }else if(WCalendarYear == 'M'){
            SCalendarYear = 1867 + Integer.valueOf(WCalendarYearNum);
        }
        String SCalendar = String.valueOf(SCalendarYear) + '/' + ls.get(1) + '/' + ls.get(2).leftPad(2, '0');
        	try {  
            	Date SCalendarD = Date.parse(SCalendar);
            	return SCalendar;
        	}catch (TypeException e) {
            	return InvalidDate;
        	}
    }
    
    public String ChangeToSCalenderInsurance(String WDate){
        String ReplacedDate = WDate.replace(' ', '');
        String ConvertedWDate = ReplacedDate.replace('.', '/');
        String InvalidDate = System.Label.InvalidDateLabel;
        system.debug('------ConvertedWDate------------'+ConvertedWDate);
        List<String> ls  = ConvertedWDate.split('/');
        system.debug('-'+ls.get(0)+'-'+ls.get(1)+'-'+ls.get(2));
        Integer SCalendarYear;
        String WCalendarYear = ConvertedWDate.left(1);
        String WCalendarYearNum = ConvertedWDate.mid(1,ls.get(0).length() - 1 );        
        if(WCalendarYear == 'R'){
            SCalendarYear = 2018 + Integer.valueOf(WCalendarYearNum);
        }else if(WCalendarYear == 'H'){
            SCalendarYear = 1988 + Integer.valueOf(WCalendarYearNum);
        }else if(WCalendarYear == 'S'){
            SCalendarYear = 1925 + Integer.valueOf(WCalendarYearNum);
        }else if(WCalendarYear == 'T'){
            SCalendarYear = 1911 + Integer.valueOf(WCalendarYearNum);
        }else if(WCalendarYear == 'M'){
            SCalendarYear = 1867 + Integer.valueOf(WCalendarYearNum);
        }
        
        String SCalendar = String.valueOf(SCalendarYear) + '/' + ls.get(1) + '/' + ls.get(2).leftPad(2, '0');
        try {  
            	Date SCalendarD = Date.parse(SCalendar);
            	return SCalendar;
        	}catch (TypeException e) {
            	return InvalidDate;
        	}     
    }
}