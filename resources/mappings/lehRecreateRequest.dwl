%dw 2.0
output application/xml skipNullOn = 'everywhere'
ns urn urn:locateelig2_1.elig.schema.bcbsm.com
ns urn1 urn:meta1_1.schema.bcbsm.com
ns urn2 urn:mbr2_1.schema.bcbsm.com
ns urn3 urn:common2_0.schema.bcbsm.com


var dateOfBirth = vars.ldsPayload.payloadArea.personInfo[0].person[0].dateOfBirth as String
var month =  dateOfBirth as Date as String {format:"MM"} default 0
var day = dateOfBirth as Date as String {format:"dd"} default 0

---

{
	urn#LocateEligHistRequest: {
		urn1#ReqHeaderArea @(systemEnvironmentCode:""): {
            
				urn1#VersionInfo: {
				ServiceVersion: "2.1",
				SchemaVersion:"2.1.2"
},
urn1#CreationDateTime:now(),
urn1#MessageID:vars.messageId,
urn1#Consumer:{
    urn1#ID:vars.originatingAppId,
    urn1#Name:""
}},
			urn#Payload: {
				urn#Contract:{
                    urn2#Number:payload.contractNumber,
                    urn2#AlphaPrefix:"",
                    urn2#Extent:""
                },
                urn#BusinessChannel:payload.sourceId,
                urn#Group:{
                    urn2#Number:"",
                    urn2#Suffix:""
                },
                urn#Member:{
                    urn#SequenceNumber:vars.sequenceNumber,
                    urn#Name:{
                        urn3#Prefix:"",
                        urn3#First: vars.ldsPayload.payloadArea.personInfo[0].person[0].first,
                        urn3#Last:"",
                        urn3#Middle:"",
                        urn3#Suffix:"",

                    },
                    urn#DateOfBirth:{
                        urn3#Year: dateOfBirth as Date as String {format:"yyyy"} default null,
                        urn3#Month: (if (sizeOf(month) < 2) ("0" ++ month) else month) default null,
                        urn3#Day: (if (sizeOf(day) < 2) ("0" ++ day) else month) default null,
                    }
                },
                urn#EligibilityPeriod:{
                    urn3#StartDate: vars.originatingPayload.startDate as Date as DateTime{},
                    urn3#EndDate: vars.originatingPayload.endDate
                },
                urn#UseCacheInd: vars.ldsPayload.payloadArea.personInfo[0].person[0].useCacheInd,
				 
			}
		
	}
}