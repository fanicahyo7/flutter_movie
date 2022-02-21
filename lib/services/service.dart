import 'package:dio/dio.dart';
import 'package:flutter_movie/models/nowplaying_model.dart';
import 'package:flutter_movie/models/popular_model.dart';
import 'package:flutter_movie/models/toprated_model.dart';
import 'package:flutter_movie/models/upcoming_model.dart';
import 'package:flutter_movie/shared.dart';

class Service {
  final Dio _dio = Dio();
  Future<NowPlayingModel> getNowPlaying() async {
    try {
      Response response = await _dio
          .get(baseURL + "now_playing?language=en-US&page=1&api_key=" + apiKey);
      return NowPlayingModel.fromJson(response.data);
    } on DioError catch (e) {
      return NowPlayingModel.fromJson(e.response?.data);
    }
  }

  Future<TopRatedModel> getTopRated() async {
    try {
      Response response = await _dio
          .get(baseURL + "top_rated?language=en-US&page=1&api_key=" + apiKey);
      return TopRatedModel.fromJson(response.data);
    } on DioError catch (e) {
      return TopRatedModel.fromJson(e.response?.data);
    }
  }

  Future<UpComingModel> getUpComing() async {
    try {
      Response response = await _dio
          .get(baseURL + "upcoming?language=en-US&page=1&api_key=" + apiKey);
      return UpComingModel.fromJson(response.data);
    } on DioError catch (e) {
      return UpComingModel.fromJson(e.response?.data);
    }
  }

  Future<PopularModel> getPopular() async {
    try {
      Response response = await _dio.get(baseURL +
          "popular?language=en-US&page=1&region=id&api_key=" +
          apiKey);
      return PopularModel.fromJson(response.data);
    } on DioError catch (e) {
      return PopularModel.fromJson(e.response?.data);
    }
  }
}
