part of 'models.dart';

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.rating,
    this.customerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  String rating;
  List<CustomerReview> customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"] == null ? null : json["description"],
        city: json["city"] == null ? null : json["city"],
        address: json["address"] == null ? null : json["address"],
        pictureId: json["pictureId"] == null ? null : json["pictureId"],
        rating: (json["rating"] == null ? null : json["rating"]).toString(),
        customerReviews: json["customerReviews"] == null
            ? null
            : List<CustomerReview>.from(
                json["customerReviews"].map(
                  (x) => CustomerReview.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description == null ? null : description,
        "city": city == null ? null : city,
        "address": address == null ? null : address,
        "pictureId": pictureId == null ? null : pictureId,
        "rating": (rating == null ? null : rating).toString(),
        "customerReviews": customerReviews == null
            ? null
            : List<dynamic>.from(
                customerReviews.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}
