part of 'pages.dart';

class RestaurantSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            ListTile(
              title: Text('Dark Theme'),
              trailing: Switch(
                value: provider.isDarkTheme,
                onChanged: (value) {
                  provider.enableDarkTheme(value);
                },
              ),
            ),
            ListTile(
              title: Text('Daily Restommendation'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch(
                    value: provider.isDailyRestommendationActive,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        showCupertinoDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text('Sorry :('),
                              content: Text('Not Supported in iOS'),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigation.back();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        scheduled.scheduledResto(value);
                        provider.enableDailyRestommendation(value);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    ));
  }
}
