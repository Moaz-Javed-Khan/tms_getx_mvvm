import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/repository/BaseRepository.dart';

class VerifyOTPRepository extends BaseRepository {
  Future verifyOTP({
    required String otp,
    required String email,
    String? password,
  }) async {
    try {
      GraphQLClient client = graphQLConfig.clientToQuery(null);
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(
            """
            mutation VerifyOTP(\$input: resetPasswordInput) {
              verifyOTP(input: \$input) {
                message
              }
            }
            """,
          ),
          variables: {
            "input": {
              "password": password,
              "otp": otp,
              "email": email,
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
