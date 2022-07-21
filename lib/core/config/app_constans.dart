import 'package:mr_fix/data/models/list_options/list_options_model.dart';

const String rol = 'client';

const double paddingBottomAppBarTabs = 6;
const String keyIdentificationTypes = 'identificationType';
const String keyCollectionKey = "keys";
const String keyEncryption = "encryptionKey";
const String secretKeyDefault = "mrfixexpert";

//#region Status Purchase
const int availableStatus = 0;
const int confirmedStatus = 1;
const int inProgressStatus = 2;
const int finishStatus = 3;
const int canceledStatus = 4;
//endregion

//#region Status Payment
const int paidStatus = 0;
const int rejectedStatus = 1;
//endregion

// API KEY NOTIFICATION FIREBASE
const String urlNotificationSend = "https://fcm.googleapis.com/fcm/send";
const String serverKey =
    "AAAA0tHHXA8:APA91bGLHVxZUNTOidyUN_40v9Ab3zmTxvO_wwcQphBHTEBFScIjWR02TEm3ZKdedg-rLTAGQymmC-faSpUj6vw1NL4gkcAOkg41YupkTB9TBeVndvpvnjAheq4IozxdXHY5zjpLpFcu";
const String keyOtherUser =
    "dLesKMQDSESWNmQ6MRAYu4:APA91bEZUFpEFNzaIMxg-I_NdhRsQKkwrSBFjbgzhxtOJ_dQ1Y4YFcXdOmkU0SjfMiYp4f69ebQvTwAeX4g2wRpFLdWh0LsMYUcBze2P-MjOOHYKXj3WNhCaztvXk_FlQOnK0RFFzLWm";

// API KEY GOOGLE MAPS
const String apiKeyGMapsAndroid = "AIzaSyAKwbon3C0ScspsV7eYqRWmsSAAHnrXf4A";
const String apiKeyGMapsIOS = "AIzaSyBjatsC26dikbs-crAftEhqR7Izx-V38Fo";

// URL GOOGLE MAPS
const String urlGooglePlaces = "https://maps.googleapis.com";
const String urlPlacesDetails = "maps/api/place/details/json";
const String urlPlacesAutocomplete = "maps/api/place/autocomplete/json";

//  DESCRIPTION MODAL OF RATING
const String titleRating = "¿Como estuvo tu servicio con ";

// Dues
final List<ListOptionsModel> numberDues = List.generate(
  12,
  (index) {
    final value = index + 1;
    return ListOptionsModel(label: value.toString(), value: value);
  },
);

const List<ListOptionsModel> listStatusPurchase = [
  ListOptionsModel(label: 'Pendientes', value: 0),
  ListOptionsModel(label: 'Confirmados', value: 1),
  ListOptionsModel(label: 'Finalizados', value: 3),
  ListOptionsModel(label: 'Cancelados', value: 4),
];
