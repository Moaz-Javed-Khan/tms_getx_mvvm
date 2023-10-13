import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqlgetxexample/extentions/constants.dart';

class GraphQLConfig {
  Link? main_link;
  static HttpLink httpLink = HttpLink("${END_POINT}graphql");

  GraphQLClient clientToQuery(String? token) {
    if (token != null) {
      final AuthLink authLink = AuthLink(
        getToken: () => token,
      );

      main_link = authLink.concat(httpLink);
    } else {
      main_link = httpLink;
    }

    return GraphQLClient(
      cache: GraphQLCache(),
      link: main_link!,
    );
  }
}
