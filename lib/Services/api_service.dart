import 'package:currency_App/models/Conversion.dart';
import 'package:currency_App/models/Currencies.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://api.fastforex.io")
abstract class DataService {
  factory DataService(Dio dio, {String baseUrl}) = _DataService;

  @GET("/currencies")
  Future<CurrenciesResponse> fetchCurrencies(@Query("api_key") String apiKey);

  @GET("/convert")
  Future<Map<String, dynamic>> convertCurrency(
    @Query("from") String from,
    @Query("to") String to,
    @Query("amount") double amount,
    @Query("api_key") String apiKey,
  );
}
