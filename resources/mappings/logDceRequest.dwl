%dw 2.0
output application/xml skipNullOn="everywhere"
ns urn urn:deterctrctelig2_1.elig.schema.bcbsm.com
ns urn1 urn:meta1_1.schema.bcbsm.com
ns urn2 urn:mbr2_1.schema.bcbsm.com
ns urn3 urn:common2_0.schema.bcbsm.com
var lehResp = payload
var initialReq = vars.originalPayload
var ldsResp = vars.ldsPayload
var currDate = now() as Date

---



{
	urn#DeterEligibilityRequest : {
		urn1#ReqHeaderArea @(systemEnvironmentCode: vars.sysEnvCode): {
            
				urn1#VersionInfo: {
				urn1#ServiceVersion: p('dce.serviceVersion'),
				urn1#SchemaVersion:p('dce.schemaVersion')
},
urn1#CreationDateTime: now(),
urn1#MessageID:vars.messageId,
urn1#Consumer:{
    urn1#ID:vars.originatingAppId
//    urn1#Name:""
}},
urn#PayloadArea:{
			
				urn#Contract:{
                    urn2#Number:lehResp.contract.contractNumber,
                    urn2#AlphaPrefix:lehResp.contract.alphaPrefix,
                    urn2#Extent:lehResp.contract.extent
                },
                urn#BusinessChannel:if(lehResp.source == "IKA")"MA" else lehResp.source,
                //urn#EligibilityPeriod:{
                  //  urn3#StartDate:lehResp.effectiveDate
                   // urn3#EndDate:if(lehResp.source != "IKA")lehResp.expirationDate else ""
                //},
                (if((currDate < lehResp.effectiveDate[0 to 9]) or (currDate > lehResp.expirationDate[0 to 9]))
                (urn#EligibilityPeriod:{
                    urn3#StartDate:lehResp.effectiveDate
                }) else null),
                
                (if(lehResp.source == "IKA")
                (urn#EligibilityPeriod:{
                    urn3#StartDate:lehResp.effectiveDate
                }) else null),
                
                
                ((urn#LOBIndicator:if(initialReq.payloadArea.rosterFlag == "Y") "Y" else null)if(initialReq.payloadArea.rosterFlag == "Y")),
               (if (initialReq.payloadArea.rosterFlag == "Y")(urn#RosterOption:{
				urn#Indicator:if(initialReq.payloadArea.rosterFlag == "Y") "Y" else null
				}) else null) ,
                (if (initialReq.payloadArea.rosterFlag == "Y")(urn#InclNonactiveMbrCoverage: if (lehResp.source != "BCN") "Y" else null) else null),

                (if (initialReq.payloadArea.rosterFlag != "Y")(urn#MemberInfoType:{
                    urn2#PersonInfo:{
                        urn3#Name:{
                            urn3#First:ldsResp.payloadArea.personInfo[0].person[0].first

                        },
                        urn3#DateOfBirth:{
                            urn3#Year:ldsResp.payloadArea.personInfo[0].person[0].dateOfBirth[0 to 3],
                            urn3#Month:ldsResp.payloadArea.personInfo[0].person[0].dateOfBirth[5 to 6],
                            urn3#Day:ldsResp.payloadArea.personInfo[0].person[0].dateOfBirth[8 to 9]

                        }

                    }
                }) else null),
                urn#PlanCode: "710"

				 
			
		
	}
}}