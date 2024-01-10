//
//  Model.swift
//  HW#43-World time Clock
//
//  Created by Da-wei Hao on 2024/1/6.
//

import UIKit

let timeZone = TimeZone.knownTimeZoneIdentifiers.description
let regions: [Locale.Region] = Locale.Region.isoRegions
let specificRegion = Locale.Region.taiwan

struct TimeInfo {
    let currentTime: String
    let jetLag:      String
    let cityName:    String
    let dateStatus:  String
}

var timeZoneNum = 0...421

func countNum () {
    for i in 0...421 {
        print(i)
    }
}
    
/*
 * Using this line of code to separate components from a string.
 >>> let components = cityName.split(separator: "/")
 EXPLAIN: seprate the cityName like "Europe/London" turns to "Europe London".
 
 * Using this line of code to get cityName.
 >>> guard components.count > 1 else { return cityName }
 EXPLAIN: To get "Europe London" to London.(components[0] is "Europe", components[1] is "London".
 
 * Using this line of code to store new variable .
 >>> var city = String(components[1])
 EXPLAIN: And store the components by Substring into the variable and transfer components[1] to string called "city".
 
 >>> if city.contains("_") {
     city = city.replacingOccurrences(of: "_", with: "")
    }
 return city
 }
 
 EXPLAIN: if city contains "_", it'll replace from "_" to " ".
 And return new variable called city.
 
 */

// Get City name from Components.
func getCityName(cityName: String) -> String {
    let components = cityName.split(separator: "/")
    guard components.count > 1 else { return cityName }
    
    var city = String(components[1])
    
    if city.contains("_") {
        city = city.replacingOccurrences(of: "_", with: "")
    }
    return city
}

// Get currentTime from now by using dateFormatter.
func getCurrentTime(city: String) -> String {
    let now                 = Date.now
    let dateFormatter       = DateFormatter()
    dateFormatter.timeStyle = .short
    dateFormatter.timeZone  = TimeZone(identifier: city)
    let currentTime         = dateFormatter.string(from: now)
    return currentTime
}

func reverseTimeZone(timeZone: String) -> String {
    let components = timeZone.split(separator: "/")
    guard components.count == 2 else {
        return timeZone
    }
    return "\(components[1])/\(components[0])"
}

// Get the date and define which day is
func calculateTheDate(city: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.timeZone   = .current
    
    let currentTime        = dateFormatter.string(from: Date())
    dateFormatter.timeZone = TimeZone(identifier: city)
    
    let comparedTimeZone = dateFormatter.string(from: Date())
    let calendar         = Calendar.current
    
    guard let currentTimeZoneDate = dateFormatter.date(from: currentTime),
          let comparedTimeZoneDate = dateFormatter.date(from: comparedTimeZone) else {
        return "Unable to conver date's data."
    }
    
    let dateComponentCurrentInfo  = calendar.dateComponents([.year, .month, .day], from: currentTimeZoneDate)
    let dateComponentCamparedInfo = calendar.dateComponents([.year, .month, .day], from: comparedTimeZoneDate)
    
    guard let daysDifference = calendar.dateComponents([.day], from: dateComponentCurrentInfo, to: dateComponentCamparedInfo).day else {
        return "Unable to calucate the daysDifference"
    }
    
    switch daysDifference {
    case 0 :
        return "Today,"
    case 1 :
        return "Tomorrow,"
    case -1:
        return "Yesterday,"
    default:
        return ""
    }
}

func calculateTimeDifference(city: String) -> String {
    guard let cityTimeZone = TimeZone(identifier: city) else {
        return "Unable to get city's timeZone."
    }
    let currentTime     = TimeZone.current
    let timeDifference  = cityTimeZone.secondsFromGMT() - currentTime.secondsFromGMT()
    let hoursDifference = timeDifference / 3600
    
    return String(format: "%+dHRS", hoursDifference)
}

var timeInfoData = [TimeInfo(currentTime: getCurrentTime(city: allTimeZone[0]),
                             jetLag: calculateTimeDifference(city: allTimeZone[0]),
                             cityName: getCityName(cityName: allTimeZone[0]), 
                             dateStatus: calculateTheDate(city: allTimeZone[0]))
                    ]


let allTimeZone: [String] = ["Africa/Abidjan", "Africa/Accra", "Africa/Addis_Ababa", "Africa/Algiers", "Africa/Asmara", "Africa/Bamako", "Africa/Bangui", "Africa/Banjul", "Africa/Bissau", "Africa/Blantyre", "Africa/Brazzaville", "Africa/Bujumbura", "Africa/Cairo", "Africa/Casablanca", "Africa/Ceuta", "Africa/Conakry", "Africa/Dakar", "Africa/Dar_es_Salaam", "Africa/Djibouti", "Africa/Douala", "Africa/El_Aaiun", "Africa/Freetown", "Africa/Gaborone", "Africa/Harare", "Africa/Johannesburg", "Africa/Juba", "Africa/Kampala", "Africa/Khartoum", "Africa/Kigali", "Africa/Kinshasa", "Africa/Lagos", "Africa/Libreville", "Africa/Lome", "Africa/Luanda", "Africa/Lubumbashi", "Africa/Lusaka", "Africa/Malabo", "Africa/Maputo", "Africa/Maseru", "Africa/Mbabane", "Africa/Mogadishu", "Africa/Monrovia", "Africa/Nairobi", "Africa/Ndjamena", "Africa/Niamey", "Africa/Nouakchott", "Africa/Ouagadougou", "Africa/Porto-Novo", "Africa/Sao_Tome", "Africa/Tripoli", "Africa/Tunis", "Africa/Windhoek", "America/Adak", "America/Anchorage", "America/Anguilla", "America/Antigua", "America/Araguaina", "America/Argentina/Buenos_Aires", "America/Argentina/Catamarca", "America/Argentina/Cordoba", "America/Argentina/Jujuy", "America/Argentina/La_Rioja", "America/Argentina/Mendoza", "America/Argentina/Rio_Gallegos", "America/Argentina/Salta", "America/Argentina/San_Juan", "America/Argentina/San_Luis", "America/Argentina/Tucuman", "America/Argentina/Ushuaia", "America/Aruba", "America/Asuncion", "America/Atikokan", "America/Bahia", "America/Bahia_Banderas", "America/Barbados", "America/Belem", "America/Belize", "America/Blanc-Sablon", "America/Boa_Vista", "America/Bogota", "America/Boise", "America/Cambridge_Bay", "America/Campo_Grande", "America/Cancun", "America/Caracas", "America/Cayenne", "America/Cayman", "America/Chicago", "America/Chihuahua", "America/Ciudad_Juarez", "America/Costa_Rica", "America/Creston", "America/Cuiaba", "America/Curacao", "America/Danmarkshavn", "America/Dawson", "America/Dawson_Creek", "America/Denver", "America/Detroit", "America/Dominica", "America/Edmonton", "America/Eirunepe", "America/El_Salvador", "America/Fort_Nelson", "America/Fortaleza", "America/Glace_Bay", "America/Godthab", "America/Goose_Bay", "America/Grand_Turk", "America/Grenada", "America/Guadeloupe", "America/Guatemala", "America/Guayaquil", "America/Guyana", "America/Halifax", "America/Havana", "America/Hermosillo", "America/Indiana/Indianapolis", "America/Indiana/Knox", "America/Indiana/Marengo", "America/Indiana/Petersburg", "America/Indiana/Tell_City", "America/Indiana/Vevay", "America/Indiana/Vincennes", "America/Indiana/Winamac", "America/Inuvik", "America/Iqaluit", "America/Jamaica", "America/Juneau", "America/Kentucky/Louisville", "America/Kentucky/Monticello", "America/Kralendijk", "America/La_Paz", "America/Lima", "America/Los_Angeles", "America/Lower_Princes", "America/Maceio", "America/Managua", "America/Manaus", "America/Marigot", "America/Martinique", "America/Matamoros", "America/Mazatlan", "America/Menominee", "America/Merida", "America/Metlakatla", "America/Mexico_City", "America/Miquelon", "America/Moncton", "America/Monterrey", "America/Montevideo", "America/Montreal", "America/Montserrat", "America/Nassau", "America/New_York", "America/Nipigon", "America/Nome", "America/Noronha", "America/North_Dakota/Beulah", "America/North_Dakota/Center", "America/North_Dakota/New_Salem", "America/Nuuk", "America/Ojinaga", "America/Panama", "America/Pangnirtung", "America/Paramaribo", "America/Phoenix", "America/Port-au-Prince", "America/Port_of_Spain", "America/Porto_Velho", "America/Puerto_Rico", "America/Punta_Arenas", "America/Rainy_River", "America/Rankin_Inlet", "America/Recife", "America/Regina", "America/Resolute", "America/Rio_Branco", "America/Santa_Isabel", "America/Santarem", "America/Santiago", "America/Santo_Domingo", "America/Sao_Paulo", "America/Scoresbysund", "America/Shiprock", "America/Sitka", "America/St_Barthelemy", "America/St_Johns", "America/St_Kitts", "America/St_Lucia", "America/St_Thomas", "America/St_Vincent", "America/Swift_Current", "America/Tegucigalpa", "America/Thule", "America/Thunder_Bay", "America/Tijuana", "America/Toronto", "America/Tortola", "America/Vancouver", "America/Whitehorse", "America/Winnipeg", "America/Yakutat", "America/Yellowknife", "Antarctica/Casey", "Antarctica/Davis", "Antarctica/DumontDUrville", "Antarctica/Macquarie", "Antarctica/Mawson", "Antarctica/McMurdo", "Antarctica/Palmer", "Antarctica/Rothera", "Antarctica/South_Pole", "Antarctica/Syowa", "Antarctica/Troll", "Antarctica/Vostok", "Arctic/Longyearbyen", "Asia/Aden", "Asia/Almaty", "Asia/Amman", "Asia/Anadyr", "Asia/Aqtau", "Asia/Aqtobe", "Asia/Ashgabat", "Asia/Atyrau", "Asia/Baghdad", "Asia/Bahrain", "Asia/Baku", "Asia/Bangkok", "Asia/Barnaul", "Asia/Beirut", "Asia/Bishkek", "Asia/Brunei", "Asia/Calcutta", "Asia/Chita", "Asia/Choibalsan", "Asia/Chongqing", "Asia/Colombo", "Asia/Damascus", "Asia/Dhaka", "Asia/Dili", "Asia/Dubai", "Asia/Dushanbe", "Asia/Famagusta", "Asia/Gaza", "Asia/Harbin", "Asia/Hebron", "Asia/Ho_Chi_Minh", "Asia/Hong_Kong", "Asia/Hovd", "Asia/Irkutsk", "Asia/Jakarta", "Asia/Jayapura", "Asia/Jerusalem", "Asia/Kabul", "Asia/Kamchatka", "Asia/Karachi", "Asia/Kashgar", "Asia/Kathmandu", "Asia/Katmandu", "Asia/Khandyga", "Asia/Krasnoyarsk", "Asia/Kuala_Lumpur", "Asia/Kuching", "Asia/Kuwait", "Asia/Macau", "Asia/Magadan", "Asia/Makassar", "Asia/Manila", "Asia/Muscat", "Asia/Nicosia", "Asia/Novokuznetsk", "Asia/Novosibirsk", "Asia/Omsk", "Asia/Oral", "Asia/Phnom_Penh", "Asia/Pontianak", "Asia/Pyongyang", "Asia/Qatar", "Asia/Qostanay", "Asia/Qyzylorda", "Asia/Rangoon", "Asia/Riyadh", "Asia/Sakhalin", "Asia/Samarkand", "Asia/Seoul", "Asia/Shanghai", "Asia/Singapore", "Asia/Srednekolymsk", "Asia/Taipei", "Asia/Tashkent", "Asia/Tbilisi", "Asia/Tehran", "Asia/Thimphu", "Asia/Tokyo", "Asia/Tomsk", "Asia/Ulaanbaatar", "Asia/Urumqi", "Asia/Ust-Nera", "Asia/Vientiane", "Asia/Vladivostok", "Asia/Yakutsk", "Asia/Yangon", "Asia/Yekaterinburg", "Asia/Yerevan", "Atlantic/Azores", "Atlantic/Bermuda", "Atlantic/Canary", "Atlantic/Cape_Verde", "Atlantic/Faroe", "Atlantic/Madeira", "Atlantic/Reykjavik", "Atlantic/South_Georgia", "Atlantic/St_Helena", "Atlantic/Stanley", "Australia/Adelaide", "Australia/Brisbane", "Australia/Broken_Hill", "Australia/Currie", "Australia/Darwin", "Australia/Eucla", "Australia/Hobart", "Australia/Lindeman", "Australia/Lord_Howe", "Australia/Melbourne", "Australia/Perth", "Australia/Sydney", "Europe/Amsterdam", "Europe/Andorra", "Europe/Astrakhan", "Europe/Athens", "Europe/Belgrade", "Europe/Berlin", "Europe/Bratislava", "Europe/Brussels", "Europe/Bucharest", "Europe/Budapest", "Europe/Busingen", "Europe/Chisinau", "Europe/Copenhagen", "Europe/Dublin", "Europe/Gibraltar", "Europe/Guernsey", "Europe/Helsinki", "Europe/Isle_of_Man", "Europe/Istanbul", "Europe/Jersey", "Europe/Kaliningrad", "Europe/Kiev", "Europe/Kirov", "Europe/Kyiv", "Europe/Lisbon", "Europe/Ljubljana", "Europe/London", "Europe/Luxembourg", "Europe/Madrid", "Europe/Malta", "Europe/Mariehamn", "Europe/Minsk", "Europe/Monaco", "Europe/Moscow", "Europe/Oslo", "Europe/Paris", "Europe/Podgorica", "Europe/Prague", "Europe/Riga", "Europe/Rome", "Europe/Samara", "Europe/San_Marino", "Europe/Sarajevo", "Europe/Saratov", "Europe/Simferopol", "Europe/Skopje", "Europe/Sofia", "Europe/Stockholm", "Europe/Tallinn", "Europe/Tirane", "Europe/Ulyanovsk", "Europe/Uzhgorod", "Europe/Vaduz", "Europe/Vatican", "Europe/Vienna", "Europe/Vilnius", "Europe/Volgograd", "Europe/Warsaw", "Europe/Zagreb", "Europe/Zaporozhye", "Europe/Zurich", "GMT", "Indian/Antananarivo", "Indian/Chagos", "Indian/Christmas", "Indian/Cocos", "Indian/Comoro", "Indian/Kerguelen", "Indian/Mahe", "Indian/Maldives", "Indian/Mauritius", "Indian/Mayotte", "Indian/Reunion", "Pacific/Apia", "Pacific/Auckland", "Pacific/Bougainville", "Pacific/Chatham", "Pacific/Chuuk", "Pacific/Easter", "Pacific/Efate", "Pacific/Enderbury", "Pacific/Fakaofo", "Pacific/Fiji", "Pacific/Funafuti", "Pacific/Galapagos", "Pacific/Gambier", "Pacific/Guadalcanal", "Pacific/Guam", "Pacific/Honolulu", "Pacific/Johnston", "Pacific/Kanton", "Pacific/Kiritimati", "Pacific/Kosrae", "Pacific/Kwajalein", "Pacific/Majuro", "Pacific/Marquesas", "Pacific/Midway", "Pacific/Nauru", "Pacific/Niue", "Pacific/Norfolk", "Pacific/Noumea", "Pacific/Pago_Pago", "Pacific/Palau", "Pacific/Pitcairn", "Pacific/Pohnpei", "Pacific/Ponape", "Pacific/Port_Moresby", "Pacific/Rarotonga", "Pacific/Saipan", "Pacific/Tahiti", "Pacific/Tarawa", "Pacific/Tongatapu", "Pacific/Truk", "Pacific/Wake", "Pacific/Wallis"]


let reserveRegionsName: [String] =
    ["Abidjan/Africa", "Accra/Africa", "Addis_Ababa/Africa", "Algiers/Africa", "Asmara/Africa", "Bamako/Africa", "Bangui/Africa", "Banjul/Africa", "Bissau/Africa", "Blantyre/Africa", "Brazzaville/Africa", "Bujumbura/Africa", "Cairo/Africa", "Casablanca/Africa", "Ceuta/Africa", "Conakry/Africa", "Dakar/Africa", "Dar_es_Salaam/Africa", "Djibouti/Africa", "Douala/Africa", "El_Aaiun/Africa", "Freetown/Africa", "Gaborone/Africa", "Harare/Africa", "Johannesburg/Africa", "Juba/Africa", "Kampala/Africa", "Khartoum/Africa", "Kigali/Africa", "Kinshasa/Africa", "Lagos/Africa", "Libreville/Africa", "Lome/Africa", "Luanda/Africa", "Lubumbashi/Africa", "Lusaka/Africa", "Malabo/Africa", "Maputo/Africa", "Maseru/Africa", "Mbabane/Africa", "Mogadishu/Africa", "Monrovia/Africa", "Nairobi/Africa", "Ndjamena/Africa", "Niamey/Africa", "Nouakchott/Africa", "Ouagadougou/Africa", "Porto-Novo/Africa", "Sao_Tome/Africa", "Tripoli/Africa", "Tunis/Africa", "Windhoek/Africa", "Adak/America", "Anchorage/America", "Anguilla/America", "Antigua/America", "Araguaina/America", "America/Argentina/Buenos_Aires", "America/Argentina/Catamarca", "America/Argentina/Cordoba", "America/Argentina/Jujuy", "America/Argentina/La_Rioja", "America/Argentina/Mendoza", "America/Argentina/Rio_Gallegos", "America/Argentina/Salta", "America/Argentina/San_Juan", "America/Argentina/San_Luis", "America/Argentina/Tucuman", "America/Argentina/Ushuaia", "Aruba/America", "Asuncion/America", "Atikokan/America", "Bahia/America", "Bahia_Banderas/America", "Barbados/America", "Belem/America", "Belize/America", "Blanc-Sablon/America", "Boa_Vista/America", "Bogota/America", "Boise/America", "Cambridge_Bay/America", "Campo_Grande/America", "Cancun/America", "Caracas/America", "Cayenne/America", "Cayman/America", "Chicago/America", "Chihuahua/America", "Ciudad_Juarez/America", "Costa_Rica/America", "Creston/America", "Cuiaba/America", "Curacao/America", "Danmarkshavn/America", "Dawson/America", "Dawson_Creek/America", "Denver/America", "Detroit/America", "Dominica/America", "Edmonton/America", "Eirunepe/America", "El_Salvador/America", "Fort_Nelson/America", "Fortaleza/America", "Glace_Bay/America", "Godthab/America", "Goose_Bay/America", "Grand_Turk/America", "Grenada/America", "Guadeloupe/America", "Guatemala/America", "Guayaquil/America", "Guyana/America", "Halifax/America", "Havana/America", "Hermosillo/America", "America/Indiana/Indianapolis", "America/Indiana/Knox", "America/Indiana/Marengo", "America/Indiana/Petersburg", "America/Indiana/Tell_City", "America/Indiana/Vevay", "America/Indiana/Vincennes", "America/Indiana/Winamac", "Inuvik/America", "Iqaluit/America", "Jamaica/America", "Juneau/America", "America/Kentucky/Louisville", "America/Kentucky/Monticello", "Kralendijk/America", "La_Paz/America", "Lima/America", "Los_Angeles/America", "Lower_Princes/America", "Maceio/America", "Managua/America", "Manaus/America", "Marigot/America", "Martinique/America", "Matamoros/America", "Mazatlan/America", "Menominee/America", "Merida/America", "Metlakatla/America", "Mexico_City/America", "Miquelon/America", "Moncton/America", "Monterrey/America", "Montevideo/America", "Montreal/America", "Montserrat/America", "Nassau/America", "New_York/America", "Nipigon/America", "Nome/America", "Noronha/America", "America/North_Dakota/Beulah", "America/North_Dakota/Center", "America/North_Dakota/New_Salem", "Nuuk/America", "Ojinaga/America", "Panama/America", "Pangnirtung/America", "Paramaribo/America", "Phoenix/America", "Port-au-Prince/America", "Port_of_Spain/America", "Porto_Velho/America", "Puerto_Rico/America", "Punta_Arenas/America", "Rainy_River/America", "Rankin_Inlet/America", "Recife/America", "Regina/America", "Resolute/America", "Rio_Branco/America", "Santa_Isabel/America", "Santarem/America", "Santiago/America", "Santo_Domingo/America", "Sao_Paulo/America", "Scoresbysund/America", "Shiprock/America", "Sitka/America", "St_Barthelemy/America", "St_Johns/America", "St_Kitts/America", "St_Lucia/America", "St_Thomas/America", "St_Vincent/America", "Swift_Current/America", "Tegucigalpa/America", "Thule/America", "Thunder_Bay/America", "Tijuana/America", "Toronto/America", "Tortola/America", "Vancouver/America", "Whitehorse/America", "Winnipeg/America", "Yakutat/America", "Yellowknife/America", "Casey/Antarctica", "Davis/Antarctica", "DumontDUrville/Antarctica", "Macquarie/Antarctica", "Mawson/Antarctica", "McMurdo/Antarctica", "Palmer/Antarctica", "Rothera/Antarctica", "South_Pole/Antarctica", "Syowa/Antarctica", "Troll/Antarctica", "Vostok/Antarctica", "Longyearbyen/Arctic", "Aden/Asia", "Almaty/Asia", "Amman/Asia", "Anadyr/Asia", "Aqtau/Asia", "Aqtobe/Asia", "Ashgabat/Asia", "Atyrau/Asia", "Baghdad/Asia", "Bahrain/Asia", "Baku/Asia", "Bangkok/Asia", "Barnaul/Asia", "Beirut/Asia", "Bishkek/Asia", "Brunei/Asia", "Calcutta/Asia", "Chita/Asia", "Choibalsan/Asia", "Chongqing/Asia", "Colombo/Asia", "Damascus/Asia", "Dhaka/Asia", "Dili/Asia", "Dubai/Asia", "Dushanbe/Asia", "Famagusta/Asia", "Gaza/Asia", "Harbin/Asia", "Hebron/Asia", "Ho_Chi_Minh/Asia", "Hong_Kong/Asia", "Hovd/Asia", "Irkutsk/Asia", "Jakarta/Asia", "Jayapura/Asia", "Jerusalem/Asia", "Kabul/Asia", "Kamchatka/Asia", "Karachi/Asia", "Kashgar/Asia", "Kathmandu/Asia", "Katmandu/Asia", "Khandyga/Asia", "Krasnoyarsk/Asia", "Kuala_Lumpur/Asia", "Kuching/Asia", "Kuwait/Asia", "Macau/Asia", "Magadan/Asia", "Makassar/Asia", "Manila/Asia", "Muscat/Asia", "Nicosia/Asia", "Novokuznetsk/Asia", "Novosibirsk/Asia", "Omsk/Asia", "Oral/Asia", "Phnom_Penh/Asia", "Pontianak/Asia", "Pyongyang/Asia", "Qatar/Asia", "Qostanay/Asia", "Qyzylorda/Asia", "Rangoon/Asia", "Riyadh/Asia", "Sakhalin/Asia", "Samarkand/Asia", "Seoul/Asia", "Shanghai/Asia", "Singapore/Asia", "Srednekolymsk/Asia", "Taipei/Asia", "Tashkent/Asia", "Tbilisi/Asia", "Tehran/Asia", "Thimphu/Asia", "Tokyo/Asia", "Tomsk/Asia", "Ulaanbaatar/Asia", "Urumqi/Asia", "Ust-Nera/Asia", "Vientiane/Asia", "Vladivostok/Asia", "Yakutsk/Asia", "Yangon/Asia", "Yekaterinburg/Asia", "Yerevan/Asia", "Azores/Atlantic", "Bermuda/Atlantic", "Canary/Atlantic", "Cape_Verde/Atlantic", "Faroe/Atlantic", "Madeira/Atlantic", "Reykjavik/Atlantic", "South_Georgia/Atlantic", "St_Helena/Atlantic", "Stanley/Atlantic", "Adelaide/Australia", "Brisbane/Australia", "Broken_Hill/Australia", "Currie/Australia", "Darwin/Australia", "Eucla/Australia", "Hobart/Australia", "Lindeman/Australia", "Lord_Howe/Australia", "Melbourne/Australia", "Perth/Australia", "Sydney/Australia", "Amsterdam/Europe", "Andorra/Europe", "Astrakhan/Europe", "Athens/Europe", "Belgrade/Europe", "Berlin/Europe", "Bratislava/Europe", "Brussels/Europe", "Bucharest/Europe", "Budapest/Europe", "Busingen/Europe", "Chisinau/Europe", "Copenhagen/Europe", "Dublin/Europe", "Gibraltar/Europe", "Guernsey/Europe", "Helsinki/Europe", "Isle_of_Man/Europe", "Istanbul/Europe", "Jersey/Europe", "Kaliningrad/Europe", "Kiev/Europe", "Kirov/Europe", "Kyiv/Europe", "Lisbon/Europe", "Ljubljana/Europe", "London/Europe", "Luxembourg/Europe", "Madrid/Europe", "Malta/Europe", "Mariehamn/Europe", "Minsk/Europe", "Monaco/Europe", "Moscow/Europe", "Oslo/Europe", "Paris/Europe", "Podgorica/Europe", "Prague/Europe", "Riga/Europe", "Rome/Europe", "Samara/Europe", "San_Marino/Europe", "Sarajevo/Europe", "Saratov/Europe", "Simferopol/Europe", "Skopje/Europe", "Sofia/Europe", "Stockholm/Europe", "Tallinn/Europe", "Tirane/Europe", "Ulyanovsk/Europe", "Uzhgorod/Europe", "Vaduz/Europe", "Vatican/Europe", "Vienna/Europe", "Vilnius/Europe", "Volgograd/Europe", "Warsaw/Europe", "Zagreb/Europe", "Zaporozhye/Europe", "Zurich/Europe", "GMT", "Antananarivo/Indian", "Chagos/Indian", "Christmas/Indian", "Cocos/Indian", "Comoro/Indian", "Kerguelen/Indian", "Mahe/Indian", "Maldives/Indian", "Mauritius/Indian", "Mayotte/Indian", "Reunion/Indian", "Apia/Pacific", "Auckland/Pacific", "Bougainville/Pacific", "Chatham/Pacific", "Chuuk/Pacific", "Easter/Pacific", "Efate/Pacific", "Enderbury/Pacific", "Fakaofo/Pacific", "Fiji/Pacific", "Funafuti/Pacific", "Galapagos/Pacific", "Gambier/Pacific", "Guadalcanal/Pacific", "Guam/Pacific", "Honolulu/Pacific", "Johnston/Pacific", "Kanton/Pacific", "Kiritimati/Pacific", "Kosrae/Pacific", "Kwajalein/Pacific", "Majuro/Pacific", "Marquesas/Pacific", "Midway/Pacific", "Nauru/Pacific", "Niue/Pacific", "Norfolk/Pacific", "Noumea/Pacific", "Pago_Pago/Pacific", "Palau/Pacific", "Pitcairn/Pacific", "Pohnpei/Pacific", "Ponape/Pacific", "Port_Moresby/Pacific", "Rarotonga/Pacific", "Saipan/Pacific", "Tahiti/Pacific", "Tarawa/Pacific", "Tongatapu/Pacific", "Truk/Pacific", "Wake/Pacific", "Wallis/Pacific"]
