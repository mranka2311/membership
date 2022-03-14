%dw 2.0
output application/xml skipNullOn = 'everywhere'
ns urn urn:locateelig2_1.elig.schema.bcbsm.com
ns urn1 urn:meta1_1.schema.bcbsm.com
ns urn2 urn:mbr2_1.schema.bcbsm.com
ns urn3 urn:common2_0.schema.bcbsm.com
var dateOfBirth = (vars.ldsPayload.payloadArea.personInfo[0].person[0].dateOfBirth as String default "")
var month = dateOfBirth as Date as String {format:"MM"} default 0
var day = dateOfBirth as Date as String {format:"dd"} default 0
---
{
urn#LocateEligHistRequest: {
urn1#ReqHeaderArea @(systemEnvironmentCode:vars.sysEnvCode): {

urn1#VersionInfo: {
urn1#ServiceVersion: p('leh.serviceVersion'),
urn1#SchemaVersion: p('leh.schemaVersion')
},
urn1#CreationDateTime:now(),
urn1#MessageID:vars.messageId,
urn1#Consumer:{
urn1#ID:vars.originatingAppId
}},
urn#Payload: {
urn#Contract:{
urn2#Number:payload.contractNumber,
},
urn#BusinessChannel:if ((payload.sourceId) == "1") "NASCO" 
else if ((payload.sourceId) == "2") "LOCAL" 
else if ((payload.sourceId) == "3") "BCN" 
else if ((payload.sourceId) == "4") "MA" 
else if ((payload.sourceId) == "5") "MBCC" 
else payload.sourceId,
urn#Member:{
urn#SequenceNumber:vars.sequenceNumber,
urn#Name:{
urn3#First: vars.ldsPayload.payloadArea.personInfo[0].person[0].first,



},
urn#DateOfBirth:{
urn3#Year: dateOfBirth as Date as String {format:"yyyy"} default null,
urn3#Month: (if (sizeOf(month) < 2) ("0" ++ month) else month) default null,
urn3#Day: (if (sizeOf(day) < 2) ("0" ++ day) else day) default null,
}
},
urn#EligibilityPeriod:{
urn3#StartDate: vars.originalPayload.payloadArea.startDate default null,
urn3#EndDate: vars.originalPayload.payloadArea.endDate default null
},
urn#UseCacheInd: vars.ldsPayload.payloadArea.personInfo[0].person[0].useCacheInd default null
}

}
}