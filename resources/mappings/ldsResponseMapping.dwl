%dw 2.0
output application/json skipNullOn="everywhere"
fun skipOnEmpty(value) = value match {
    case is Object -> filterKeyValuePairs(value)
    case is Array -> $ map skipOnEmpty($) filter (not isEmpty($))
    else -> value
}
fun filterKeyValuePairs(value) = value mapObject ((value,key) -> 
    using(filteredValue = skipOnEmpty(value))
    {
      ((key): filteredValue) if (not isEmpty(filteredValue))
    }
)
var mVal = vars.medicaidGroupValue
var x = vars.ldsResp
var g = vars.uniqueRecordPairs
var t = vars.originalPayload.payloadArea.eid
var bc = vars.originalPayload.payloadArea.businessChannel
var groupPair = if (bc == "BCN") ((vars.uniqueRecordPairs..group) + (mVal default null)) filter ($.contract.source == bc) else ((vars.uniqueRecordPairs..group) + (mVal default null))
---
skipOnEmpty({"payloadArea":{
      "personInfo":
      [{
      	eid: vars.originalPayload.payloadArea.eid,
          person: (x filter ($.eid == t) map (item)-> {
                first: item.firstName,
                last: item.lastName,
                dateOfBirth: item.birthDate,
                genderIndicator: item.gender,
                ssn: item.memberSSN,
                medicaidId: vars.medicaidObject.medicaidId,
                medicaidStateCode: vars.medicaidObject.medicaidStateCode,
                membership:{
                    group: (groupPair map (item) ->
item  update  {
    case .contract.source -> null
})
                    
                    
                    
                    }

         }) distinctBy ($.eid)}]
}})
         
      