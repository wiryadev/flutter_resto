part of 'pages.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const String searchTabTitle = 'Search';

  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: SizedBox(
              height: 16,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Consumer<RestaurantProvider>(
              builder: (context, provider, _) {
                return TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search restaurant',
                    labelStyle: TextStyle(
                      color: secondaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: secondaryColor,
                    ),
                  ),
                  onChanged: (String query) {
                    provider.getRestaurantsByQuery(query);
                    isSearching = true;
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<RestaurantProvider>(
              builder: (context, provider, _) {
                return provider.isSearching
                    ? showSearchResult()
                    : showSearchGuide(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    searchController.dispose();
  }

  Widget showSearchResult() {
    return Consumer<RestaurantProvider>(
      builder: (context, provider, _) {
        switch (provider.state) {
          case ResultState.Loading:
            return Center(child: CircularProgressIndicator());
            break;
          case ResultState.HasData:
            return ListView.builder(
              shrinkWrap: true,
              itemCount: provider.searchResult.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = provider.searchResult.restaurants[index];
                print('Show search result' + restaurant.name);
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
                          Constants.errorMessage,
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
    );
  }

  Widget showSearchGuide(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(
                height: 48,
              ),
              SvgPicture.asset(
                'assets/search_illustration.svg',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                'Try to search your favorite restaurant',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
