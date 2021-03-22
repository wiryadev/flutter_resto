part of 'providers.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  ResultState _state;
  String _message = '';
  DetailResponse _detailResult;

  ResultState get state => _state;
  String get message => _message;
  DetailResponse get detailResult => _detailResult;

  RestaurantDetailProvider({
    @required this.apiService,
    String id,
  }) {
    getDetailRestaurant(id);
  }

  void getDetailRestaurant(String id) {
    _state = ResultState.Loading;
    notifyListeners();

    Future<dynamic> result;
    result = _getDetailRestaurant(id);

    result.then((value) {
      _detailResult = value;
    });
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
