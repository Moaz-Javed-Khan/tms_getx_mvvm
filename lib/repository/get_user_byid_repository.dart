import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/repository/BaseRepository.dart';

class GetUserByIdRepository extends BaseRepository {
  Future getUserById({required int userId, required String token}) async {
    try {
      GraphQLClient client = graphQLConfig.clientToQuery(null);
      QueryResult result = await client.query(
        QueryOptions(
          document: gql(
            """
              query GetUserById(\$getUserByIdId: Int!) {
                getUserById(id: \$getUserByIdId) {
                  active
                  address {
                    ar
                    en
                  }
                  deviceId
                  email
                  fullName {
                    ar
                    en
                  }
                  gender
                  id
                  phoneNumber
                  profilePic
                  role {
                    id
                    name {
                      ar
                      en
                    }
                  }
                  status
                }
              }
              """,
          ),
          variables: {
            "getUserByIdId": userId,
          },
        ),
      );

      if (result.hasException) {
        print("Data in result by ID: ${result.data}");
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
