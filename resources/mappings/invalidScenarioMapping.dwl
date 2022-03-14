%dw 2.0
output application/json
---
{
	systemEnvironmentCode: vars.sysEnvCode,
	messageId : vars.messageId,
	"systemMessage": vars.coreExceptionHandlingResponse.systemMessage map
      {
      	"source": $.source,
        "code": $.code,
      	additionalInfo: vars.validate.payloadValidator
      }
    
 }
