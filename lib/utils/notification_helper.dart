part of 'utils.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper _instance;
  int _randomNumber;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload);
    });
  }

  int random(int n) {
    var random = new Random();
    return random.nextInt(n);
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResponse restaurantResponse) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "dicoding resto";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    _randomNumber = random(restaurantResponse.restaurants.length - 1);
    var titleNotification = "<b>Restommendation</b>";
    var titleResto = restaurantResponse.restaurants[_randomNumber].name;
    print(titleResto);

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleResto,
      platformChannelSpecifics,
      payload: json.encode(
        {
          'random_number': _randomNumber,
          'data': restaurantResponse.toJson(),
        },
      ),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        print('Inside selectNotif, Payload: ' + payload + ' Route: ' + route);
        var data = RestaurantResponse.fromJson(json.decode(payload)['data']);
        var restaurant = data.restaurants[json.decode(payload)['random_number']];
        print(restaurant.name);

        Navigation.intentWithData('/detail_page', restaurant);
      },
    );
  }
}
