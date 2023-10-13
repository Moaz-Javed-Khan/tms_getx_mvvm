import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/repository/BaseRepository.dart';

class DeleteRoleRepository extends BaseRepository {
  Future deleteRole({required String token, required int roleId}) async {
    try {
      GraphQLClient client = graphQLConfig.clientToQuery(null);
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(
            """
            mutation DeleteRole(\$deleteRoleId: Int!) {
              deleteRole(id: \$deleteRoleId) {
                message
              }
            }
            """,
          ),
          variables: {"deleteRoleId": roleId},
        ),
      );

      if (result.hasException) {
        print("Deleted?: ${result.data}");
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
