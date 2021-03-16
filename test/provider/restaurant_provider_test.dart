import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_resto/data/api/api_service.dart';
import 'package:flutter_resto/provider/providers.dart';

void main() {
  group('Restaurant Provider Searching Status Test', () {
    ApiService apiService;
    setUp(() {
      apiService = ApiService();
    });

    test('should return false when called without query', () {
      // arrange
      var restaurantProvider = RestaurantProvider(apiService: apiService);

      // act
      restaurantProvider.getRestaurants();

      // assert
      var result = restaurantProvider.isSearching;
      expect(result, false);
    });

    test('should return true when called with query', () {
      // arrange
      var restaurantProvider = RestaurantProvider(apiService: apiService);

      // act
      restaurantProvider.getRestaurantsByQuery('Makan');

      // assert
      var result = restaurantProvider.isSearching;
      expect(result, true);
    });
  });
}
