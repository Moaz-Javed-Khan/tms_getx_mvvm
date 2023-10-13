import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/models/CreateUserInputModel.dart';
import 'package:graphqlgetxexample/repository/BaseRepository.dart';

class CreateUserRepository extends BaseRepository {
  Future createUser({required CreateUserInput input}) async {
    try {
      GraphQLClient client = graphQLConfig.clientToQuery(null);
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(
            """
              mutation CreateUser(\$input: createUserInput!) {
                createUser(input: \$input) {
                  message
                }
              }
              """,
          ),
          variables: {
            "input": {
              "address": input.address!,
              "deviceId": input.deviceId,
              "email": input.email,
              "fullName": input.fullName!,
              "password": input.password,
              "phoneNumber": input.phoneNumber
            }
          },
        ),
      );

      if (result.hasException) {
        throw Exception(Code.fromJson(
            jsonDecode(result.exception!.graphqlErrors.first.message)));
      } else {
        return result.data;
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
