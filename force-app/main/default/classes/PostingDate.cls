public class PostingDate {
    	//Posting
	    public string Posting(String nowDate){
            String ConvertednowYearW;
            
            List<String> ls  = nowDate.split('/');
            Integer nowDateYear =Integer.valueOf(ls.get(0));
            
            if(nowDateYear >= 2019){
            	ConvertednowYearW = 'R';
                nowDateYear -= 2018;
            }else if(nowDateYear <= 2018 && nowDateYear >= 1989){
            	ConvertednowYearW = 'H';
                nowDateYear -= 1988;
            }else if(nowDateYear <= 1988 && nowDateYear >= 1926){
            	ConvertednowYearW = 'S';
                nowDateYear -= 1925;
            }
            Integer nowDateMonth =Integer.valueOf(ls.get(1));
            Integer nowDateDay =Integer.valueOf(ls.get(2));
            
            String ConvertednowDate = ConvertednowYearW +nowDateYear + '/' + nowDateMonth + '/' + nowDateDay;
            return ConvertednowDate;
    }
    	
        public string PostingTime(String nowDate){
            List<String> ls  = nowDate.split('/');    
            String ConvertednowDateTime = ls.get(3);
            return ConvertednowDateTime;
        }
}