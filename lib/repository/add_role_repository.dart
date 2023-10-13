import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/models/AddRoleRequestModel.dart';
import 'package:graphqlgetxexample/repository/BaseRepository.dart';

class AddRoleRepository extends BaseRepository {
  Future addRole({required AddRoleModelRequest input}) async {
    try {
      GraphQLClient client = graphQLConfig.clientToQuery(null);
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(
            """
            mutation CreateRole(\$input: createRoleInput!) {
              createRole(input: \$input) {
                message
              }
            }
            """,
          ),
          variables: {
            "input": {
              "active": input.active,
              "name": {
                "ar": input.name!.ar,
                "en": input.name!.en,
              }
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
