part of blog_models;

@freezed
class BlogDataDTO with _$BlogDataDTO {
  const factory BlogDataDTO({
    required String title,
    required String details,
    required String image,
  }) = _BlogDataDTO;

  factory BlogDataDTO.fromJson(Map<String, dynamic> json) =>
      _$BlogDataDTOFromJson(json);
}

@freezed
class BlogData with _$BlogData {
  const factory BlogData({
    required int id,
    required String title,
    required String details,
    required String image,
  }) = _BlogData;

  factory BlogData.fromJson(Map<String, dynamic> json) =>
      _$BlogDataFromJson(json);
}

@freezed
class BlogDataList with _$BlogDataList {
  const factory BlogDataList(List<BlogData> data) = _BlogDataList;

  factory BlogDataList.fromJson(Map<String, dynamic> json) =>
      _$BlogDataListFromJson(json);
}
