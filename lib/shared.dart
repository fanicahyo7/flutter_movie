import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String apiKey = "4c4e9013017f051f1b88b3714932929e";
String baseURL = "https://api.themoviedb.org/3/movie/";
String imageBaseURL = "https://image.tmdb.org/t/p/original";
String trailerBaseURL = "https://www.youtube.com/watch?v=";

Color kBlackColor = const Color(0xff1F1449);
Color kGreyColor = const Color(0xff9698A9);

TextStyle blackTextStyle = GoogleFonts.poppins(color: kBlackColor);
TextStyle greyTextStyle = GoogleFonts.poppins(color: kGreyColor);

FontWeight light = FontWeight.w300;
FontWeight reguler = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semibold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extrabold = FontWeight.w800;
FontWeight black = FontWeight.w900;

double defaultMargin = 24.0;

