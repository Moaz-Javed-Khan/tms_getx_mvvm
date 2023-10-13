import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/repository/BaseRepository.dart';

import '../models/UpdateUser.dart';

class UpdateUserProfileRepository extends BaseRepository {
  Future updateUserProfile({
    required UpdateProfileDetailInput input,
    required String token,
  }) async {
    try {
      MultipartFile? multipart;
      if (input.profilePic != null) {
        var databyte = File(input.profilePic!).readAsBytesSync();
        multipart = MultipartFile.fromBytes(
          "profilePic",
          databyte,
          filename: '${DateTime.now()}.jpg',
          contentType: MediaType("image", "jpg"),
        );
        print(multipart);
      }

      GraphQLClient client = graphQLConfig.clientToQuery(token);
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(
            """
           mutation UpdateProfileDetail(\$profilePic: Upload, \$input: updateProfileInput!) {
              updateProfileDetail(profilePic: \$profilePic, input: \$input) {
                message
              }
            }
            """,
          ),
          variables: {
            "profilePic": (input.profilePic != null) ? multipart : null,
            "input": {
              "address": input.address,
              "fullName": input.fullName,
              "gender": input.gender,
              "phoneNumber": input.phoneNumber,
            }
          },
        ),
      );

      if (result.hasException) {
        print("Data in result: ${result.data}");
        throw Exception(
          Code.fromJson(
            jsonDecode(result.exception!.graphqlErrors.first.message),
          ),
        );
      } else {
        print("Data in result: ${result.data}");
        return result.data;
      }
    } catch (error) {
      throw Exception(error).toString();
    }
  }
}
