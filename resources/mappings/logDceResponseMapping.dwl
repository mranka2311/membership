%dw 2.0
output application/json skipNullOn="everywhere"
fun convDate(x) = if (x != null)(if ((sizeOf(x)) > 10 ) x[0 to 9] else x) else null
var y = vars.response_dce.DeterEligibilityResponse.PayloadArea
var i = vars.response_dce.DeterEligibilityResponse.PayloadArea.*MemberDemographics
var x = vars.tempDceStore
---
(x + {
                     "contractExistIndicator":y.ContractExistIndicator,
                     "contractActiveIndicator":y.ContractActiveIndicator,
                     "lastEligible":{
                        "effectiveDate":convDate(y.LastEligible.EffectiveDate),
                        "expirationDate":convDate(y.LastEligible.ExpirationDate)
                     },
                     "agentID":y.AgentID,
                     "maxMemberMatchRating":y.MaxMemberMatchRating,
                     "memberFoundIndicator":y.MemberFoundIndicator,
                     "memberActiveIndicator":y.MemberActiveIndicator,
                     "multipleMembersFoundIndicator":y.MaxMemberMatchRating,
                     "routeCode":y.RouteCode,
                     "subscriberDemographics":[
                        {
                           "name":{
                              "first":y.SubscriberDemographics.Name.First,
                              "last":y.SubscriberDemographics.Name.Last,
                              "middle":y.SubscriberDemographics.Name.Middle
                           },
                           "dateOfBirth":y.SubscriberDemographics.DateOfBirth.Year ++ "-" ++ y.SubscriberDemographics.DateOfBirth.Month ++ "-" ++ y.SubscriberDemographics.DateOfBirth.Day,
                           "genderIndicator":y.SubscriberDemographics.GenderIndicator,
                           "subscriberAddress":{
                              "street":y.SubscriberDemographics.*SubscriberAddress.*Street,
                              "city":y.SubscriberDemographics.SubscriberAddress.City,
                              "stateProvince":y.SubscriberDemographics.SubscriberAddress.StateProvince,
                              "postalCode":y.SubscriberDemographics.SubscriberAddress.PostalCode
                           },
                           "subscriberPhone":{
                              "areaCode":y.SubscriberDemographics.SubscriberPhone.AreaCode,
                              "exchange":y.SubscriberDemographics.SubscriberPhone.Exchange,
                              "number":y.SubscriberDemographics.SubscriberPhone.Number,
                              "extension":y.SubscriberDemographics.SubscriberPhone.Extension
                           },
                           "badAddressInd":y.SubscriberDemographics.BadAddressInd,
                           "subscriberMismatch":y.SubscriberDemographics.SubscriberMismatch,
                           "billLevel":y.SubscriberDemographics.BillLevel
                        }
                     ],
                     "memberDemographics": i map (md) -> 
                        {
							//"memberId":md.MemberID,
                           "memberId":if(md.MemberID != null and (sizeOf(md.MemberID) > 2)) (md.MemberID[-2 to -1]) else md.MemberID,
                           "personInfo":{
                              "name":{
                                 "first":md.PersonInfo.Name.First,
                                 "last":md.PersonInfo.Name.Last,
                                 "middle":md.PersonInfo.Name.Middle
                              },
                              "dateOfBirth":md.PersonInfo.DateOfBirth.Year ++ "-" ++ md.PersonInfo.DateOfBirth.Month ++ "-" ++ md.PersonInfo.DateOfBirth.Day,
                              "genderIndicator":md.PersonInfo.GenderIndicator
                           },
                           "relationshipCode":md.RelationshipCode,
                           "phone":{
                              "areaCode":md.Phone.AreaCode,
                              "exchange":md.Phone.Exchange,
                              "number":md.Phone.Number,
                              "extension":md.Phone.Extension
                           },
                           "alternateAddress":{
                              "street":md.AlternateAddress.*Street,
                              "city":md.AlternateAddress.City,
                              "county":md.AlternateAddress.County,
                              "country":md.AlternateAddress.Country,
                              "stateProvince":md.AlternateAddress.StateProvince,
                              "postalCode":md.AlternateAddress.PostalCode
                           },
                           "address":{
                              "street":md.Address.*Street,
                              "city":md.Address.City,
                              "county":md.Address.County,
                              "country":md.Address.Country,
                              "stateProvince":md.Address.StateProvince,
                              "postalCode":md.Address.PostalCode
                           },
                           "memberStatus":md.MemberStatus,
                           "memberPrivacyIndicator":md.MemberPrivacyIndicator,
                           "memberMatchRating":md.MemberMatchRating,
                           "memberBenefitLevel":md.MemberBenefitLevel,
                           "membersTier":md.MembersTier,
                           "memberActiveDates": md.*MemberActiveDates map (mad) ->
                              {
                                 "effectiveDate":convDate(mad.EffectiveDate),
                                 "expirationDate":convDate(mad.ExpirationDate),
                                 "effectiveCode":mad.EffectiveCode,
                                 "paidToDates":convDate(mad.PaidToDate),
                                 "graceCode":mad.GraceCode,
                                 "gracePeriod":mad.GracePeriod,
                                 "productEffectiveDate":convDate(mad.ProductEffectiveDate),
                                 "enrollmentCode":mad.EnrollmentCode,
                                 "preExistingWaitingPeriodDate":mad.PreExistingWaitingPeriodDate,
                                 "benefitWaitingPeriodDate":mad.BenefitWaitingPeriodDate,
                                 "lobIndicator":mad.*LOBIndicator map (lmap) ->
                                    {
                                       "systemCode":lmap.@systemCode,
                                       "productClass":lmap.@productClass,
                                       "productDescription":lmap.@productDescription,
                                       "productId":lmap.@productID,
                                       "value":lmap
                                    },
                                 "itsBenefitKey":{
                                    "commonKey":mad.ITSBenefitKey.CommonKey,
                                    "crossKey":mad.ITSBenefitKey.CrossKey,
                                    "shieldKey":mad.ITSBenefitKey.ShieldKey,
                                    "benefitKey":mad.ITSBenefitKey.BenefitString,
                                    "benefitPackageId":mad.ITSBenefitKey.BenefitPackageIdentifier
                                 },
                                 "secondaryGroupNumber":mad.SecondaryGroupNumber
                              }
                           ,
                           
                           
                           
                           
                           
                           
                           "memberMedicareIndicator":{
                              "medicareAIndicator":md.MemberMedicareIndicator.MedicareAIndicator,
                              "medicareAexpEffDate":convDate(md.MemberMedicareIndicator.MedicareAExpirable.EffectiveDate),
                              "medicareAexpExpDate":convDate(md.MemberMedicareIndicator.MedicareAExpirable.ExpirationDate),
                              "medicareBIndicator":md.MemberMedicareIndicator.MedicareBIndicator,
                              "medicareBexpEffDate":convDate(md.MemberMedicareIndicator.MedicareBExpirable.EffectiveDate),
                              "medicareBexpExpDate":convDate(md.MemberMedicareIndicator.MedicareBExpirable.ExpirationDate)
                           },
                           "medicareHIBNumber":md.MedicareHIBNumber,
                           "maContractIndicator":md.MAContractIndicator,
                           "cdhIndicator":md.CDHIndicator,
                           "facAdmissionVerif":md.FacAdmissionVerif,
                           "profAdmissionVerif":md.ProfAdmissionVerif,
                           "qualifier":md.*Qualifier map (qual) ->
                              {
                                 "code":qual.Code,
                                 "effDate":convDate(qual.EffectiveDate),
                                 "expDate":convDate(qual.ExpirationDate)
                              }
                           ,
                           "comment": md.*Comment map (comm) -> 
                              {
                                 "type":comm.CommentType,
                                 "desc":comm.Description
                              }
                           ,
                           "employeeStatus":md.EmployeeStatus,
                           "custodialParent":{
                              "effDate":md.CustodialParent.EffectiveDate,
                              "expDate":md.CustodialParent.ExpirationDate,
                              "name":{
                                 "suffix":md.CustodialParent.Name.Suffix,
                                 "first":md.CustodialParent.Name.First,
                                 "last":md.CustodialParent.Name.Last,
                                 "middle":md.CustodialParent.Name.Middle
                              },
                              "address":{
                                 "street":md.CustodialParent.Address.*Street,
                                 "city":md.CustodialParent.Address.City,
                                 "county":md.CustodialParent.Address.County,
                                 "country":md.CustodialParent.Address.Country,
                                 "stateProvince":md.CustodialParent.Address.StateProvince,
                                 "postalCode":md.CustodialParent.Address.PostalCode
                              }
                           },
                           "alternateInfo":{
                              "effDate":convDate(md.AlternateInfo.EffectiveDate),
                              "expDate":convDate(md.AlternateInfo.ExpirationDate),
                              "name":{
                                 "suffix":md.AlternateInfo.Name.Suffix,
                                 "first":md.AlternateInfo.Name.First,
                                 "last":md.AlternateInfo.Name.Last,
                                 "middle":md.AlternateInfo.Name.Middle
                              },
                              "address":{
                                 "street":md.AlternateInfo.Address.*Street,
                                 "city":md.AlternateInfo.Address.City,
                                 "county":md.AlternateInfo.Address.County,
                                 "country":md.AlternateInfo.Address.Country,
                                 "stateProvince":md.AlternateInfo.Address.StateProvince,
                                 "postalCode":md.AlternateInfo.Address.PostalCode
                              },
                              "phone":{
                                 "areaCode":md.AlternateInfo.Phone.AreaCode,
                                 "exchange":md.AlternateInfo.Phone.Exchange,
                                 "number":md.AlternateInfo.Phone.Number,
                                 "extension":md.AlternateInfo.Phone.Extension
                              }
                           },
                           "authorizedRepEffDate":convDate(md.AuthorizedRep.EffectiveDate),
                           "authorizedRepExpDate":convDate(md.AuthorizedRep.ExpirationDate),
                           "authorizedRepDesignation":md.AuthorizedRep.Designation,
                           "personRepEffDate":convDate(md.PersonalRep.EffectiveDate),
                           "personRepExpfDate":convDate(md.PersonalRep.ExpirationDate),
                           "personRepDesignation":md.PersonalRep.Designation,
                           "employeePayCode":md.EmployeePayCode,
                           "groupInfo":{
                              "number":md.GroupInfo.Number,
                              "suffix":md.GroupInfo.Suffix,
                              "name":md.GroupInfo.Name,
                              "contractNumber":md.GroupInfo.Contract.Number,
                              "contractAlphaPrefix":md.GroupInfo.Contract.AlphaPrefix,
                              "contractExtent":md.GroupInfo.Contract.Extent,
                              "rawExtent":md.GroupInfo.RawExtent,
                              "productIndicator":md.GroupInfo.ProductIndicator,
                              "productCode":md.GroupInfo.ProductCode,
                              "productDescription":md.GroupInfo.ProductDescription,
                              "productEffectiveDays":md.GroupInfo.ProductEffectiveDays,
                              "maaContract":md.GroupInfo.MAAltContract,
                              "maCoverageCategory":md.GroupInfo.MACoverageCategory,
                              "maProductInd":md.GroupInfo.MAProductIndicator,
                              "subHomePlan":md.GroupInfo.SubHomePlan,
                              "subPlanCd":md.GroupInfo.SubPlanCd,
                              "subHomeSystem":md.GroupInfo.SubHomeSystem,
                              "package":md.GroupInfo.Package,
                              "benefitKey":{
                                 "commonKey":md.GroupInfo.BenefitKey.CommonKey,
                                 "crossKey":md.GroupInfo.BenefitKey.CrossKey,
                                 "shieldKey":md.GroupInfo.BenefitKey.ShieldKey,
                                 "benefitString":md.GroupInfo.BenefitKey.BenefitString,
                                 "benefitPackageInd":md.GroupInfo.BenefitKey.BenefitPackageIdentifier
                              },
                              "contractActiveDates": md.GroupInfo.*ContractActiveDates map (cad) ->
                                 {
                                    "effDate":convDate(cad.EffectiveDate),
                                    "expDate":convDate(cad.ExpirationDate),
                                    "effectiveCode":cad.EffectiveCode,
                                    "paidToDate":convDate(cad.PaidToDate),
                                    "graceCode":cad.GraceCode,
                                    "gracePeriod":cad.GracePeriod
                                 }
                              ,
                              "insuranceType":md.GroupInfo.InsuranceType,
                              "insuranceCode":md.GroupInfo.InsuranceCode,
                              "autoNationalInd":md.GroupInfo.AutoNationalIndicator,
                              "sourceName":md.GroupInfo.SourceName,
                              "contractPrivacyInd":md.GroupInfo.ContractPrivacyIndicator,
                              "aptcInd":md.GroupInfo.APTCIndicator,
                              "delinquencyInd":md.GroupInfo.DelinquencyIndicator,
                              "productId":md.GroupInfo.ProductID,
                              "subProductId":md.GroupInfo.SubProductID,
                              "limitString":md.GroupInfo.LimitString,
                              "pcpName":{
                                 "prefix":md.GroupInfo.PCPName.Prefix,
                                 "first":md.GroupInfo.PCPName.First,
                                 "last":md.GroupInfo.PCPName.Last,
                                 "middle":md.GroupInfo.PCPName.Middle
                              },
                              "memberPcpPin":md.GroupInfo.MemberPCPPIN,
                              "memberPcpNpi":md.GroupInfo.MemberPCPNPI,
                              "memberPcpgNpi":md.GroupInfo.MemberPCPGNPI,
                              "deptNbr":md.GroupInfo.DeptNbr,
                              "policyType":md.GroupInfo.PolicyType
                           },
                           "oclInd":md.OCLIndicator,
                           "cobInd":md.COBIndicator,
                           "contractPrimacyInd":md.ContractPrimacyIndicator,
                           "billType":md.BillType,
                           "medicareBNotRegisteredInd":md.MedicareBNotRegisteredIndicator,
                           "hireDate":convDate(md.HireDate),
                           "originalEffDate":convDate(md.OriginalEffDate),
                           "memClassId":md.MemClassID
                        
 }
                  })
               