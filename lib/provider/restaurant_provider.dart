part of 'providers.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantResponse _result;
  SearchResponse _searchResult;
  DetailResponse _detailResult;
  String _message = '';
  ResultState _state;

  RestaurantResponse get result => _result;
  SearchResponse get searchResult => _searchResult;
  DetailResponse get detailResult => _detailResult;
  String get message => _message;
  ResultState get state => _state;
  bool isSearching = false;

  RestaurantProvider({@required this.apiService}) {
    getRestaurants();
  }

  void getRestaurants() {
    _state = ResultState.Loading;
    notifyListeners();

    isSearching = false;
    Future<dynamic> result;
    result = _getRestaurantList();

    result.then((value) {
      _result = value;
    });
  }

  void getRestaurantsByQuery(String query) {
    _state = ResultState.Loading;
    notifyListeners();

    isSearching = true;
    Future<dynamic> result;
    result = _searchRestaurant(query);

    result.then((value) {
      _searchResult = value;
    });
  }

  void getDetailRestaurant(String id) {
    _state = ResultState.Loading;
    notifyListeners();

    isSearching = false;
    Future<dynamic> result;
    result = _getDetailRestaurant(id);

    result.then((value) {
      _detailResult = value;
    });
  }

  Future<dynamic> _getRestaurantList() async {
    try {
      final restaurantResponse = await apiService.getRestaurantList();
      if ((restaurantResponse.count == 0) ||
          (restaurantResponse.restaurants.isEmpty)) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return restaurantResponse;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _searchRestaurant(String query) async {
    print('Ini di search restaurant ' + query);
    try {
      final searchResponses = await apiService.searchRestaurant(query);
      if ((searchResponses.founded == 0) ||
          (searchResponses.restaurants.isEmpty)) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        print('ini di HasData ');
        searchResponses.restaurants.forEach((x) => print(x.name));
        return searchResponses;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _getDetailRestaurant(String id) async {
    print('Ini di detail restaurant ' + id);
    try {
      final detailResponses = await apiService.getDetailRestaurant(id);
      if (detailResponses.error) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        print('ini di HasData ');
        return detailResponses;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
