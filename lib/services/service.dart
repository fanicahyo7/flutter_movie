import 'package:dio/dio.dart';
import 'package:flutter_movie/models/detail_model.dart';
import 'package:flutter_movie/models/nowplaying_model.dart';
import 'package:flutter_movie/models/popular_model.dart';
import 'package:flutter_movie/models/search_model.dart';
import 'package:flutter_movie/models/toprated_model.dart';
import 'package:flutter_movie/models/upcoming_model.dart';
import 'package:flutter_movie/models/video_model.dart';
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

  Future<DetailModel> getDetail(String id) async {
    try {
      Response response = await _dio.get(baseURL +
          id.toString() + "&language=en-US?api_key=" +
          apiKey);
      return DetailModel.fromJson(response.data);
    } on DioError catch (e) {
      return DetailModel.fromJson(e.response?.data);
    }
  }

  Future<VideoModel> getVideo(String id) async {
    try {
      Response response = await _dio.get(baseURL +
          id.toString() + "/videos?api_key=" +
          apiKey + "&language=en-US");
      return VideoModel.fromJson(response.data);
    } on DioError catch (e) {
      return VideoModel.fromJson(e.response?.data);
    }
  }

  Future<SearchModel> searchVideo(String query) async {
    try {
      print("https://api.themoviedb.org/3/search/movie?api_key=" +
          apiKey + "&query="+ query + "&page=1");
      Response response = await _dio.get("https://api.themoviedb.org/3/search/movie?api_key=" +
          apiKey + "&query="+ query + "&page=1");
          
      return SearchModel.fromJson(response.data);
    } on DioError catch (e) {
      print(e.error);
      return SearchModel.fromJson(e.response?.data);
    }
  }
}
