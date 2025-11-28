class PromotionBanner {
  final String id;
  final String? imageUrl;
  final String? url;

  PromotionBanner({
    required this.id,
    required this.imageUrl,
    required this.url,
  });

  factory PromotionBanner.fromJSON(Map<String, dynamic> json) {
    return PromotionBanner(
      id: json['id'],
      imageUrl: json['image_url'],
      url: json['url'],
    );
  }
}
