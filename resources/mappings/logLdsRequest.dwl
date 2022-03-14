
%dw 2.0
output application/json skipNullOn = 'everywhere'
---
{
  "headerArea": {
    "systemEnvironmentCode": vars.sysEnvCode,
    "messageId": vars.originalPayload.headerArea.messageId default correlationId
  },
  "payloadArea": {
    "eventPayload": {
      "attribute": [
        {
          "eid": vars.originalPayload.payloadArea.eid,
          "startDate": vars.originalPayload.payloadArea.startDate
        }
      ]
    }
  }
}