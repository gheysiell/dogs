import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dogs/core/constants.dart';
import 'package:dogs/core/enums.dart';
import 'package:dogs/features/dogs/data/dtos/dogs_dto.dart';
import 'package:dogs/features/dogs/data/dtos/dogs_response_dto.dart';
import 'package:http/http.dart' as http;

abstract class DogsDataSourceRemoteHttp {
  Future<DogResponseDto> getDogs(String search);
}

class DogsDataSourceRemoteHttpImpl implements DogsDataSourceRemoteHttp {
  @override
  Future<DogResponseDto> getDogs(String search) async {
    final DogResponseDto dogResponseDto = DogResponseDto(
      dogsDto: [],
      responseStatus: ResponseStatus.success,
    );
    final Uri uri = Uri.parse('${Constants.apiUrl}breeds');
    final Map<String, String> header = {
      'x-api-key': Constants.apiKey,
    };

    try {
      final response = await http.get(uri, headers: header).timeout(Constants.timeoutDurationRemoteHttp);

      if (response.statusCode != 200) {
        log('${response.statusCode} | ${json.decode(response.body)}');
        throw Exception();
      }

      List dogsResponse = json.decode(response.body);
      List dogsFormatted = [];

      if (search.isNotEmpty) {
        for (var dog in dogsResponse) {
          if (dog['name'].toString().toLowerCase().contains(search.toLowerCase())) dogsFormatted.add(dog);
        }
      } else {
        dogsFormatted = dogsResponse;
      }

      dogResponseDto.dogsDto = dogsFormatted.map((dogResponse) => DogDto.fromMap(dogResponse)).toList();
    } on TimeoutException {
      log('${Constants.timeoutExceptionMessage} DogsDataSourceRemoteHttpImpl.getDogs');
      dogResponseDto.responseStatus = ResponseStatus.timeout;
    } catch (e) {
      log('${Constants.genericExceptionMessage} DogsDataSourceRemoteHttpImpl.getDogs', error: e);
      dogResponseDto.responseStatus = ResponseStatus.error;
    }

    return dogResponseDto;
  }
}
