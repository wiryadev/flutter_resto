import 'dart:convert';

import 'package:flutter_resto/data/model/models.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String _listEndpoint = 'list';
  static final String _searchEndpoint = '/search?q=';
  static final String _detailEndpoint = '/detail/';

  Future<RestaurantResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + _listEndpoint));

    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load restaurant list,\ntry to check your internet connection');
    }
  }

  Future<SearchResponse> searchRestaurant(String query) async {
    final response =
        await http.get(Uri.parse(_baseUrl + _searchEndpoint + query));

    if (response.statusCode == 200) {
      return SearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load search result,\ntry to check your internet connection');
    }
  }

  Future<DetailResponse> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detailEndpoint + id));

    if (response.statusCode == 200) {
      return DetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load search result,\ntry to check your internet connection');
    }
  }
}
