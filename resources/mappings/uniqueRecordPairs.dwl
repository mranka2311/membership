%dw 2.0
import * from dw::core::Strings
output application/json
var key = payload.eid ++ (payload.contractNumber) ++ (payload.extent default "0000") ++ (payload.groupNumber) ++ (payload.groupSuffix default "") ++ (payload.membershipCardNumber[0 to 2] default "") ++ (payload.contractEndDate default "") ++ (payload.memberId default "")

var b = vars.uniqueRecordPairs
---
b ++ {
    "$(key)":{
        group: {
                              "number":payload.groupNumber,
                              "suffix":payload.groupSuffix,
                              "contract":{
                                 "number":payload.contractNumber,
                                 "source":payload.sourceName,
                                 "alphaPrefix":payload.membershipCardNumber[0 to 2] default "",
                                 "extent":if (isEmpty(payload.extent)) "" else rightPad(payload.extent,4,0),
                                 "subscriber":{
                                    "ssn":payload.subscriberSSN
                                 },
                                 "idCardNum":payload.membershipCardNumber,
                                 "memberId":payload.memberId,
                                 "relationshipCode":payload.relationshipCode,
                                 "activeCoverageInd":payload.eidContractActiveIndicator
                              }
        }
    }
}