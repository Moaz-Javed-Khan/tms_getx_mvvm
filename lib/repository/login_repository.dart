import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/models/LoginRequestModel.dart';
import 'package:graphqlgetxexample/repository/BaseRepository.dart';

class LoginUserRepository extends BaseRepository {
  Future userLogin({required UserLoginRequest input}) async {
    try {
      GraphQLClient client = graphQLConfig.clientToQuery(null);
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(
            """
              mutation LoginUser(\$input: loginUserInput!) {
                loginUser(input: \$input) {
                email
                fullName {
                  ar 
                  en
                }  
                id
                profilePic
                role {
                  id 
                  name {
                    ar
                    en
                  }
                }
                token
                }
              }
              """,
          ),
          variables: {
            "input": {
              "deviceId": input.deviceId,
              "email": input.email,
              "loginIp": input.loginIp,
              "password": input.password
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
