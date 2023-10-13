import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/models/GetAllUsersRequestModel.dart';
import 'package:graphqlgetxexample/repository/BaseRepository.dart';

class GetAllUsersRepository extends BaseRepository {
  Future getAllUsers(
      {required String token, required GetAllUsersRequest input}) async {
    try {
      GraphQLClient client = graphQLConfig.clientToQuery(null);
      QueryResult result = await client.query(
        QueryOptions(
          document: gql(
            """
              query GetAllUser(\$input: allUsersInput!) {
              getAllUser(input: \$input) {
                pageStart
                limit
                totalCount
                userRole {
                  name
                  roleCount
                }
                users {
                  id
                  email
                  fullName {
                    en
                    ar
                  }
                  profilePic
                  phoneNumber
                  active
                  role {
                    id
                    name {
                      en
                      ar
                    }
                    active
                  }
                  status
                }
              }
              """,
          ),
          variables: {
            "input": {
              "pageStart": input.pageStart,
              "status": input.status,
              "fullName": {
                "en": input.fullName!.en,
                "ar": input.fullName!.ar,
              },
              "roleId": input.roleId,
              "active": input.active,
            }
          },
        ),
      );

      if (result.hasException) {
        print("Data in result all Users: ${result.data}");
        throw Exception(
          Code.fromJson(
            jsonDecode(result.exception!.graphqlErrors.first.message),
          ),
        );
      } else {
        print("Data in result by ID: ${result.data}");
        return result.data;
      }
    } catch (error) {
      throw Exception(error).toString();
    }
  }
}
