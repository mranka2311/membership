%dw 2.0
output application/json
var x = vars.ldsResp
var t = vars.originalPayload.payloadArea.eid
---
group: x filter ($.eid == t) map (grp) -> {
                                //"eid":grp.eid,
                              "number":grp.groupNumber,
                              "suffix":grp.groupSuffix,
                              "contract":{
                                 "number":grp.contractNumber,
                                 "alphaPrefix":grp.membershipCardNumber[0 to 2],
                                 "extent":if (!isEmpty(grp.extent))grp.extent else "0000",
                                 "subscriber":{
                                    "ssn":grp.subscriberSSN
                                 },
                                 "idCardNum":grp.membershipCardNumber,
                                 "memberId":"memberId",
                                 "relationshipCode":grp.relationshipCode,
                                 "activeCoverageInd":grp.eidContractActiveIndicator,
                                 "coveragePeriod":{
                                    "effectiveDate":"notfound",
                                    "expirationDate":"notfound"
                                 },
                                 "privacyInd":"notfound"
                              }
}