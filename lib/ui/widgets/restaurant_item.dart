part of 'widgets.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantItem({Key key, @required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isAddedToFavorite(restaurant.id),
          builder: (context, snapshot) {
            var isAddedToFavorite = snapshot.data ?? false;
            return Material(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: restaurant.pictureId != null
                    ? Hero(
                        tag: restaurant.pictureId,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.network(
                            Constants.baseImageUrl + restaurant.pictureId,
                            width: 108,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        width: 108,
                        child: Icon(Icons.broken_image_rounded),
                      ),
                title: Text(
                  restaurant.name,
                ),
                subtitle: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.caption,
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.location_on,
                            size: 16.0,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: restaurant.city ?? '',
                      )
                    ],
                  ),
                ),
                trailing: isAddedToFavorite
                    ? IconButton(
                        icon: Icon(Icons.favorite_rounded),
                        onPressed: () => provider.removeFavorite(restaurant.id),
                      )
                    : IconButton(
                        icon: Icon(Icons.favorite_border_rounded),
                        onPressed: () => provider.addFavorite(restaurant),
                      ),
                onTap: () {
                  Navigation.intentWithData(
                    DetailPage.routeName,
                    restaurant,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
