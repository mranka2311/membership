%dw 2.0
output application/json skipNullOn="everywhere"
---
{
   "headerArea":{
      "systemEnvironmentCode":vars.sysEnvCode,
      "messageId":vars.messageId,
      "systemMessage": flatten(vars.sysMsg_lds ++ (if (!isEmpty(vars.propagatedSystemMessages)) vars.propagatedSystemMessages else if(!isEmpty(payload.systemMessage))payload.systemMessage 
	   else [vars.coreExceptionHandlingResponse.systemMessage[0] - "subCode"]))
   },
   "payloadArea":{
      "personPayload":{
         "personInfo":vars.ldsPayload.payloadArea.personInfo
      }
   }
}