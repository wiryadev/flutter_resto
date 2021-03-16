part of 'pages.dart';

class RestaurantFavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: SizedBox(
              height: 4,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 16,
              left: 16,
            ),
            child: Text(
              'Favorite',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Expanded(
            child: Consumer<DatabaseProvider>(
              builder: (context, provider, _) {
                switch (provider.state) {
                  case ResultState.Loading:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  case ResultState.HasData:
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.favorites.length,
                      itemBuilder: (context, index) {
                        var restaurant = provider.favorites[index];
                        return RestaurantItem(
                          restaurant: restaurant,
                        );
                      },
                    );
                    break;
                  case ResultState.NoData:
                    return Center(
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 32,
                              ),
                              SvgPicture.asset(
                                'assets/no_data.svg',
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  Constants.noDataMessage,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                    break;
                  case ResultState.Error:
                    return Center(
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 32,
                              ),
                              SvgPicture.asset(
                                'assets/not_found.svg',
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  provider.message,
                                  // Constants.errorMessage,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                    break;
                  default:
                    return Center(
                      child: Text(
                        Constants.defaultMessage,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
