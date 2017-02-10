//
//  Constants.h
//  GenyzPay
//
//  Created by Roman Bigun on 3/28/16.
//  Copyright © 2016 Roman Bigun. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


#endif /* Constants_h */

#define APPDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]
/*
#define kUrlMainSeerverPath @"http://genyzdev.gotests.com/"

#define kUrlMainSeerverPath @"http://genyztest.gotests.com/"
#define kUrlMainSeerverPath @"http://genyz.gotests.com/"
*/

#define kUrlMainSeerverPath @"http://genyzdev.gotests.com/"

#define kPostfixBackendLogin @"api/logins"
#define kPostfixBackendUserProfile @"api/profile"
#define kPostfixBackendRegister @"api/registers"
#define kPostfixBackendGetRecipientById @"api/donorrecipient/getbyid"
#define kPostfixBackendGetRecipientsList @"api/recipients/nearby"
#define kPostfixBackendSetFavourite @"api/donorrecipients/adds"
#define kPostfixBackendMakeNewCard @"api/addcards"
#define kPostfixBackendGetReccuringPayments @"api/peyments/getall"
#define kPostfixBackendMakePayment @"api/addpayments"
#define kPostfixBackendGetFavourite @"api/donorrecipient/getfavorite"
#define kPostfixBackendForgotPassword @"api/forgotpasswords"
#define kPostfixBackendGetMessages @"api/messages"
#define kPostfixBackendGetMessageById @"api/messages/getbyid"
//Object Keys
#define kObjectKeyName @"username"
#define kObjectKeySimpleName @"name"
#define kObjectKeyRestToken @"restToken"
#define kObjectKeyRecRegistered @"is_registered"
#define kObjectKeyFirstName @"firstname"
#define kObjectKeyPassword @"password"
#define kObjectKeyLastName @"lastname"
#define kObjectKeyMessageId @"message_id"
#define kObjectKeyAddress @"address"
#define kObjectKeyId @"user_id"
#define kObjectKeyJustId @"id"
#define kObjectKeyRecipientId @"recipient_id"
#define kObjectKeyCity @"country"
#define kObjectKeyAvatarURL @"img"
#define kObjectKeyAccessToken @"token"
#define kObjectKeyDOB @"dob"
#define kObjectKeyDescription @"description"
#define kObjectKeyEmail @"email"
#define kObjectKeyIsFavorite @"isFavorite"
#define kObjectKeyCompagines @"campaigns"
#define kObjectKeyAmounts @"amounts"
#define kObjectKeyData @"data"
#define kObjectKeyPhone @"phone"
#define kObjectKeyLocation @"location"
#define kObjectKeyLatitude @"latitude"
#define kObjectKeyLongitude @"longtitude"
#define kObjectKeyType @"type"
#define kObjectKeyDistance @"distance"
#define kObjectKeyPaginationLimit @"limit"
#pragma mark Credit Card
#define kCardKeyCardNumber @"cardNumber"
#define kObjectKeyCampaignId @"campaign_id"


//ANNOTATION SETTINGS

#define kNameAnnotationColor [UIColor blueColor]
#define kAddressAnnotationColor [UIColor grayColor]
#define kAddressAnnotationFont [UIFont systemFontOfSize:11]
#define kNameAnnotationFont [UIFont systemFontOfSize:13]

//Other defines

#define  countriesList [NSArray arrayWithObjects:@"Afghanistan", @"Akrotiri", @"Albania", @"Algeria", @"American Samoa", @"Andorra", @"Angola", @"Anguilla", @"Antarctica", @"Antigua and Barbuda", @"Argentina", @"Armenia", @"Aruba", @"Ashmore and Cartier Islands", @"Australia", @"Austria", @"Azerbaijan", @"The Bahamas", @"Bahrain", @"Bangladesh", @"Barbados", @"Bassas da India", @"Belarus", @"Belgium", @"Belize", @"Benin", @"Bermuda", @"Bhutan", @"Bolivia", @"Bosnia and Herzegovina", @"Botswana", @"Bouvet Island", @"Brazil", @"British Indian Ocean Territory", @"British Virgin Islands", @"Brunei", @"Bulgaria", @"Burkina Faso", @"Burma", @"Burundi", @"Cambodia", @"Cameroon", @"Canada", @"Cape Verde", @"Cayman Islands", @"Central African Republic", @"Chad", @"Chile", @"China", @"Christmas Island", @"Clipperton Island", @"Cocos (Keeling) Islands", @"Colombia", @"Comoros", @"Democratic Republic of the Congo", @"Republic of the Congo", @"Cook Islands", @"Coral Sea Islands", @"Costa Rica", @"Cote d'Ivoire", @"Croatia", @"Cuba", @"Cyprus", @"Czech Republic", @"Denmark", @"Dhekelia", @"Djibouti", @"Dominica", @"Dominican Republic", @"Ecuador", @"Egypt", @"El Salvador", @"Equatorial Guinea", @"Eritrea", @"Estonia", @"Ethiopia", @"Europa Island", @"Falkland Islands (Islas Malvinas)", @"Faroe Islands", @"Fiji", @"Finland", @"France", @"French Guiana", @"French Polynesia", @"French Southern and Antarctic Lands", @"Gabon", @"The Gambia", @"Gaza Strip", @"Georgia", @"Germany", @"Ghana", @"Gibraltar", @"Glorioso Islands", @"Greece", @"Greenland", @"Grenada", @"Guadeloupe", @"Guam", @"Guatemala", @"Guernsey", @"Guinea", @"Guinea-Bissau", @"Guyana", @"Haiti", @"Heard Island and McDonald Islands", @"Holy See (Vatican City)", @"Honduras", @"Hong Kong", @"Hungary", @"Iceland", @"India", @"Indonesia", @"Iran", @"Iraq", @"Ireland", @"Isle of Man", @"Israel", @"Italy", @"Jamaica", @"Jan Mayen", @"Japan", @"Jersey", @"Jordan", @"Juan de Nova Island", @"Kazakhstan", @"Kenya", @"Kiribati", @"North Korea", @"South Korea", @"Kuwait", @"Kyrgyzstan", @"Laos", @"Latvia", @"Lebanon", @"Lesotho", @"Liberia", @"Libya", @"Liechtenstein", @"Lithuania", @"Luxembourg", @"Macau", @"Macedonia", @"Madagascar", @"Malawi", @"Malaysia", @"Maldives", @"Mali", @"Malta", @"Marshall Islands", @"Martinique", @"Mauritania", @"Mauritius", @"Mayotte", @"Mexico", @"Federated States of Micronesia", @"Moldova", @"Monaco", @"Mongolia", @"Montserrat", @"Morocco", @"Mozambique", @"Namibia", @"Nauru", @"Navassa Island", @"Nepal", @"Netherlands", @"Netherlands Antilles", @"New Caledonia", @"New Zealand", @"Nicaragua", @"Niger", @"Nigeria", @"Niue", @"Norfolk Island", @"Northern Mariana Islands", @"Norway", @"Oman", @"Pakistan", @"Palau", @"Panama", @"Papua New Guinea", @"Paracel Islands", @"Paraguay", @"Peru", @"Philippines", @"Pitcairn Islands", @"Poland", @"Portugal", @"Puerto Rico", @"Qatar", @"Reunion", @"Romania", @"Russia", @"Rwanda", @"Saint Helena", @"Saint Kitts and Nevis", @"Saint Lucia", @"Saint Pierre and Miquelon", @"Saint Vincent and the Grenadines", @"Samoa", @"San Marino", @"Sao Tome and Principe", @"Saudi Arabia", @"Senegal", @"Serbia", @"Montenegro", @"Seychelles", @"Sierra Leone", @"Singapore", @"Slovakia", @"Slovenia", @"Solomon Islands", @"Somalia", @"South Africa", @"South Georgia and the South Sandwich Islands", @"Spain", @"Spratly Islands", @"Sri Lanka", @"Sudan", @"Suriname", @"Svalbard", @"Swaziland", @"Sweden", @"Switzerland", @"Syria", @"Taiwan", @"Tajikistan", @"Tanzania", @"Thailand", @"Tibet", @"Timor-Leste", @"Togo", @"Tokelau", @"Tonga", @"Trinidad and Tobago", @"Tromelin Island", @"Tunisia", @"Turkey", @"Turkmenistan", @"Turks and Caicos Islands", @"Tuvalu", @"Uganda", @"Ukraine", @"United Arab Emirates", @"United Kingdom", @"United States", @"Uruguay", @"Uzbekistan", @"Vanuatu", @"Venezuela", @"Vietnam", @"Virgin Islands", @"Wake Island", @"Wallis and Futuna", @"West Bank", @"Western Sahara", @"Yemen", @"Zambia", @"Zimbabwe", nil]
