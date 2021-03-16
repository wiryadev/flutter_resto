part of 'pages.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final Restaurant restaurant;

  DetailPage({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Consumer<RestaurantProvider>(
                  builder: (context, provider, _) {
                    provider.getDetailRestaurant(restaurant.id);
                    return Hero(
                      tag: restaurant.pictureId,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          Constants.baseImageUrl + restaurant.pictureId,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Consumer<DatabaseProvider>(
                        builder: (context, provider, _) {
                          return FutureBuilder<bool>(
                            future: provider.isAddedToFavorite(restaurant.id),
                            builder: (contex, snapshot) {
                              var isAddedToFavorite = snapshot.data ?? false;
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16.0,
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: secondaryColor,
                                      child: IconButton(
                                        color: primaryColor,
                                        icon: Icon(Icons.arrow_back),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 16.0,
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: secondaryColor,
                                      child: isAddedToFavorite
                                          ? IconButton(
                                              color: primaryColor,
                                              icon: Icon(
                                                Icons.favorite_rounded,
                                              ),
                                              onPressed: () =>
                                                  provider.removeFavorite(
                                                      restaurant.id),
                                            )
                                          : IconButton(
                                              color: primaryColor,
                                              icon: Icon(
                                                Icons.favorite_border_rounded,
                                              ),
                                              onPressed: () => provider
                                                  .addFavorite(restaurant),
                                            ),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Consumer<RestaurantProvider>(
              builder: (context, provider, _) {
                switch (provider.state) {
                  case ResultState.Loading:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  case ResultState.HasData:
                    var result = provider.detailResult.restaurant;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              margin: EdgeInsets.only(
                                top: 16.0,
                                bottom: 8.0,
                                left: 16.0,
                              ),
                              child: Text(
                                result.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 30.0,
                                ),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                right: 16.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    result.rating ?? '',
                                    style: TextStyle(fontSize: 18.0),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          result.city ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                        Text(
                                          result.address ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          child: Text(
                            result.description ?? '',
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 0.0,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: Text(
                            "Reviews",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0.0),
                          padding: EdgeInsets.symmetric(
                            vertical: 2.0,
                            horizontal: 16.0,
                          ),
                          height: 86,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: result.customerReviews.map((review) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: secondaryColor,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          review.review,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '-' + review.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                      ],
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
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildReviewList(BuildContext context, List<CustomerReview> reviews) {
  //   return ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: reviews.length,
  //     itemBuilder: (context, index) {
  //       var review = reviews[index];
  //       print(review.name);
  //       return Material(
  //         child: ListTile(
  //           title: Text(
  //             review.name,
  //             style: Theme.of(context)
  //                 .textTheme
  //                 .caption
  //                 .copyWith(color: Colors.white),
  //           ),
  //           subtitle: Text(review.review),
  //         ),
  //       );
  //     },
  //   );
  // }
}
