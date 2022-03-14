%dw 2.0
output application/json
var x = vars.ldsResp
var t = vars.originalPayload.payloadArea.eid
---
uniqueRecords: (x filter ($.eid == t) map (item)-> {
    contractNumber: item.contractNumber,
    contractIdCardNum: item.membershipCardNumber,
    contractRelCode: item.relationshipCode,
    contractMemberId:item.memberId,
    subscriber:{
        ssn: item.subscriberSSN
    },
    groupNumber: item.groupNumber,
    groupSuffix: item.groupSuffix,
    alphaPrefix: item.membershipCardNumber[0 to 2],
    extent:if (!isEmpty(item.extent))item.extent else "0000",
    activeCoverageInd: item.eidContractActiveIndicator
    }) distinctBy (($.contractNumber))