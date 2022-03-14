 %dw 2.0
 import java!java::util::Base64
 import java!java::lang::System
 import java!java::lang::String
 import java!java::util::Calendar
 import java!java::util::TimeZone
 import isNumeric from dw::core::Strings
 
fun trimUpper(element) = upper(trim(element))
fun emptyToNull(element) = if(isEmpty(trim(element))) null else element 
fun getStandardAppName(appName) = appName[0 to (find(appName, "-")[0]-1)] default appName

fun validateTheDate (dtVal) = do {
	// function to check if a given string is valid date
	var len = sizeOf(dtVal) 
	var onlyDate = if (len >= 16) dtVal[0 to -7] else dtVal
	var isNumbers = isNumeric(onlyDate replace  "-" with "")

	var parts = if (isNumbers) onlyDate splitBy  ("-") else ""
	
	var year = if (parts !=  "") parts[0] as Number else 999
	var isLPYear = if ((year mod 4) == 0) (
                    if ((year mod 100) == 0) (
                        if ((year mod 400) == 0) true
                        else false
                    ) else true
                ) else false
                
   
	var month = if (parts !=  "") parts[1] else ""
	var monthBool = if (parts !=  "") ((sizeOf(parts[1]) == 2) and (parts[1] as Number >= 1) and (parts[1] as Number <= 12)) else false
	
	var dtBool = if (parts !=  "") 
            (
                if ((parts[1] == "02") and isLPYear and (sizeOf(parts[2]) == 2))
                    ((parts[2] as Number >= 1) and (parts[2] as Number <= 29))
                else if ((parts[1] == "02") and ! isLPYear and (sizeOf(parts[2]) == 2))
                    ((parts[2] as Number >= 1) and (parts[2] as Number <= 28))    
                else if ((["01","03","05","07","08","10","12"] contains month)
                            and (sizeOf(parts[2]) == 2)) 
                    ((parts[2] as Number >= 1) and (parts[2] as Number <= 31))
                else ((sizeOf(parts[2]) == 2) and (parts[2] as Number >= 1) and (parts[2] as Number <= 30))
            ) else false
	var yearBool = if ((year > 9999) and monthBool and dtBool ) onlyDate as Date {format:"yyyy-MM-dd"} as String else true      
	---
	if  (yearBool and monthBool and dtBool and (year>999)) onlyDate else null
}


 