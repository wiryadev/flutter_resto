import 'package:flutter_resto/data/api/api_service.dart';
import 'package:flutter_resto/data/model/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Network Call Test', () {
    // arrange
    ApiService apiService;
    setUp(() {
      apiService = ApiService();
    });

    test('should return the true when checking the type of response', () async {
      // act
      var result = await apiService.getRestaurantList();

      // assert
      await expectLater(result.restaurants, isA<List<Restaurant>>());
    });

    test('should return the length of response when called', () async {
      // act
      var result = await apiService.getRestaurantList();

      // assert
      await expectLater(result.restaurants.length, 20);
    });

    test('should return true when searching by query', () async {
      // arrange
      String query = 'Senja';
      // act
      var result = await apiService.searchRestaurant(query);

      // assert
      expect(result.restaurants[0].name.contains(query), true);
    });

    test('should return the true when checking the type of response', () async {
      // act
      var result = await apiService.getDetailRestaurant('rqdv5juczeskfw1e867');

      // assert
      await expectLater(result.restaurant, isA<Restaurant>());
    });
  });
}
