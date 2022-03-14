%dw 2.0
output application/json skipNullOn="everywhere"

//Filters object and arrays from its empty elements
fun skipOnEmpty(value) = value match {
    case is Object -> filterKeyValuePairs(value)
    case is Array -> $ map skipOnEmpty($) filter (not isEmpty($))
    else -> value
}

//Filters the empty key value pairs
fun filterKeyValuePairs(value) = value mapObject ((value,key) -> 
    using(filteredValue = skipOnEmpty(value))
    {
      ((key): filteredValue) if (not isEmpty(filteredValue))
    }
)
---
skipOnEmpty(payload)