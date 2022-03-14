%dw 2.0
output application/json
---
{
   "headerArea":{
      "systemEnvironmentCode":vars.sysEnvCode,
      "messageId":vars.messageId,
      "systemMessage":[
         {
            "source":"Membership",
            "code":"SUC",
            "additionalInfo":"Successful Completion"
         }
      ]
   },
   "payloadArea":{
      "personPayload":{
         "personInfo":vars.ldsPayload.payloadArea.personInfo,
         "lehPayload": vars.completeLeh
      }
   }
}