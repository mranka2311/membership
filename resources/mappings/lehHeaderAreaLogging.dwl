%dw 2.0
output application/json
var x = payload.LocateEligHistResponse
var z = vars.lehHeaderAreaStore
---
z + {
	"headerArea": {			
		("systemEnvironmentCode": vars.sysEnvCode)if(vars.sysEnvCode != null),
		"messageId": vars.originalPayload.headerArea.messageId,
		systemMessage: [{
			source: x.RespHeaderArea.SystemMessage.Source,
			code: x.RespHeaderArea.SystemMessage.Code,
			subCode: x.RespHeaderArea.SystemMessage.SubCode,
			additionalInfo: x.RespHeaderArea.SystemMessage.additionalInfo
		}]
	}
}