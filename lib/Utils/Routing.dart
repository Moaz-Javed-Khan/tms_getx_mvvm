// import 'package:flutter/cupertino.dart';
// import 'package:go_router/go_router.dart';
// import 'package:graphqlgetxexample/models/RoleLovResponseModel.dart';
// import 'package:graphqlgetxexample/views/account/profile_update_view.dart';
// import 'package:graphqlgetxexample/views/account/profile_view.dart';
// import 'package:graphqlgetxexample/views/auth/create_new_password_view.dart';
// import 'package:graphqlgetxexample/views/auth/forget_password_view.dart';
// import 'package:graphqlgetxexample/views/auth/otp_view.dart';
// import 'package:graphqlgetxexample/views/auth/sign_in_view.dart';
// import 'package:graphqlgetxexample/views/auth/sign_up_view.dart';
// import 'package:graphqlgetxexample/views/dashboard/dashboard.dart';
// import 'package:graphqlgetxexample/views/home/home_screen.dart';
// import 'package:graphqlgetxexample/views/manageRole/addRoleScreen.dart';
// import 'package:graphqlgetxexample/views/manageRole/manageRoleLovScreen.dart';
// import 'package:graphqlgetxexample/views/manageRole/updateRoleScreen.dart';
// import 'package:graphqlgetxexample/views/notification/notification_view.dart';
// import 'package:graphqlgetxexample/views/splash/splash_view.dart';
// import 'package:graphqlgetxexample/views/taskActivity/task_activity_view.dart';
// import 'package:graphqlgetxexample/views/teamboard/teamboard.dart';
// import 'package:graphqlgetxexample/views/userManagement/allUsersScreen.dart';
// import 'package:graphqlgetxexample/views/userManagement/usersLovScreen.dart';
// import 'package:graphqlgetxexample/widgets/bottom_nav_bar.dart';

// const String SPLASH = "/splash";
// const String SIGNIN = "/signin";
// const String SIGNUP = "/signup";
// const String FORGET_PASSWORD = "/forgetPassword";
// const String OTP = "/otp";
// const String CREATE_NEW_PASSWORD = "/createNewPassword";
// const String HOME = "/home";
// const String NOTIFICATION_VIEW = "/notificatioView";
// const String DASHBOARD = "/dashboard";
// const String TEAMBOARD = "/teamboard";
// const String TEAM_ACTIVITY = "/teamActivity";
// const String PROFILE = "/profile";
// const String USER_LOV = "/userLov";
// const String ALL_USER = "/allUser";
// const String PROFILE_UPDATE = "/profileUpdate";
// const String MANAGE_ROLE = "/manageRole";
// const String ADD_ROLE = "/addRole";
// const String UPDATE_ROLE = "/updateRole";

// // final _rootNavigatorKey = GlobalKey<NavigatorState>();
// // final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
// // final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

// class Routes {
//   // final goRouter = GoRouter(
//   //   initialLocation: SPLASH,
//   // navigatorKey: _rootNavigatorKey,
//   // routes: [
//   //   // Stateful nested navigation based on:
//   //   // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
//   //   StatefulShellRoute.indexedStack(
//   //     builder: (context, state, navigationShell) {
//   //       // the UI shell
//   //       return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
//   //     },
//   //     branches: [
//   //       // first branch (A)
//   //       StatefulShellBranch(
//   //         navigatorKey: _shellNavigatorAKey,
//   //         routes: [
//   //           // top route inside branch
//   //           GoRoute(
//   //             path: '/profile',
//   //             pageBuilder: (context, state) => NoTransitionPage(
//   //               child: ProfileView(),
//   //             ),
//   //             routes: [
//   //               // child route
//   //               GoRoute(
//   //                 path: "manageRole",
//   //                 builder: (context, state) => ManageRolesLovScreen(),
//   //               ),
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   // second branch (B)
//   // StatefulShellBranch(
//   //   navigatorKey: _shellNavigatorBKey,
//   //   routes: [
//   //     // top route inside branch
//   //     // GoRoute(
//   //     //   path: '/b',
//   //     //   pageBuilder: (context, state) => const NoTransitionPage(
//   //     //     child: RootScreen(label: 'B', detailsPath: '/b/details'),
//   //     //   ),
//   //     //   routes: [
//   //     //     // child route
//   //     //     // GoRoute(
//   //     //     //   path: 'details',
//   //     //     //   builder: (context, state) =>
//   //     //     //       const DetailsScreen(label: 'B'),
//   //     //     // ),
//   //     //   ],
//   //     // ),
//   //   ],
//   // ),
//   // ],
//   //     ),
//   //   ],
//   // );

//   final GoRouter router = GoRouter(
//     initialLocation: SPLASH,
//     routes: <RouteBase>[
//       //   GoRoute(
//       //     path: HOME,
//       //     builder: (context, state) => HomeScreen(),
//       GoRoute(
//         path: SPLASH, // '/',
//         builder: (BuildContext context, GoRouterState state) {
//           return SplashView();
//         },
//       ),
//       ShellRoute(
//         builder: (context, state, child) => BottomNavShell(child: child),
//         // builder: (context, state, child) => HomeScreen(
//         //   child: child,
//         // ),

//         routes: [
//           GoRoute(
//             path: SIGNIN,
//             pageBuilder: ((context, state) {
//               return CustomTransitionPage(
//                 transitionDuration: const Duration(seconds: 2),
//                 key: state.pageKey,
//                 child: SignInView(),
//                 transitionsBuilder:
//                     ((context, animation, secondaryAnimation, child) {
//                   return FadeTransition(
//                     opacity: CurveTween(curve: Curves.easeInOutCirc)
//                         .animate(animation),
//                     child: child,
//                   );
//                 }),
//               );
//             }),
//           ),
//           GoRoute(
//             path: SIGNUP,
//             pageBuilder: ((context, state) {
//               return CustomTransitionPage(
//                 transitionDuration: const Duration(seconds: 1),
//                 key: state.pageKey,
//                 child: SignUpView(),
//                 transitionsBuilder:
//                     ((context, animation, secondaryAnimation, child) {
//                   const begin = Offset(0.0, 1.0);
//                   const end = Offset.zero;
//                   const curve = Curves.ease;

//                   var tween = Tween(begin: begin, end: end)
//                       .chain(CurveTween(curve: curve));

//                   return SlideTransition(
//                     position: animation.drive(tween),
//                     child: child,
//                   );
//                 }),
//               );
//             }),
//           ),
//           GoRoute(
//             path: FORGET_PASSWORD,
//             // builder: (BuildContext context, GoRouterState state) {
//             //   return ForgetPasswordView();
//             // },
//             pageBuilder: ((context, state) {
//               return CustomTransitionPage(
//                 transitionDuration: const Duration(seconds: 1),
//                 key: state.pageKey,
//                 child: const ForgetPasswordView(),
//                 transitionsBuilder:
//                     ((context, animation, secondaryAnimation, child) {
//                   const begin = Offset(0.0, 1.0);
//                   const end = Offset.zero;
//                   const curve = Curves.ease;

//                   var tween = Tween(begin: begin, end: end)
//                       .chain(CurveTween(curve: curve));

//                   return SlideTransition(
//                     position: animation.drive(tween),
//                     child: child,
//                   );
//                 }),
//               );
//             }),
//           ),
//           GoRoute(
//             path: OTP,
//             builder: (BuildContext context, GoRouterState state) {
//               return OTPView(
//                 email: state.extra.toString(),
//               );
//             },
//           ),
//           GoRoute(
//             path: '$CREATE_NEW_PASSWORD/:email/:otp',
//             builder: (BuildContext context, GoRouterState state) {
//               return CreateNewPasswordView(
//                 email: state.pathParameters['email']!,
//                 otp: state.pathParameters['otp']!,
//               );
//             },
//           ),
//           GoRoute(
//             path: HOME,
//             // builder: (BuildContext context, GoRouterState state) {
//             //   return const HomeScreen();
//             // },
//             pageBuilder: ((context, state) {
//               return CustomTransitionPage(
//                 transitionDuration: const Duration(seconds: 1),
//                 key: state.pageKey,
//                 child: const HomeScreen(),
//                 transitionsBuilder:
//                     ((context, animation, secondaryAnimation, child) {
//                   const begin = Offset(0.0, 1.0);
//                   const end = Offset.zero;
//                   const curve = Curves.ease;

//                   var tween = Tween(begin: begin, end: end)
//                       .chain(CurveTween(curve: curve));

//                   return SlideTransition(
//                     position: animation.drive(tween),
//                     child: child,
//                   );
//                 }),
//               );
//             }),
//           ),
//           GoRoute(
//             path: NOTIFICATION_VIEW,
//             builder: (BuildContext context, GoRouterState state) {
//               return const NotificationView();
//             },
//           ),
//           GoRoute(
//             path: DASHBOARD,
//             builder: (BuildContext context, GoRouterState state) {
//               return const Dashboard();
//             },
//           ),
//           GoRoute(
//             path: TEAMBOARD,
//             builder: (BuildContext context, GoRouterState state) {
//               return const Teamboard();
//             },
//           ),
//           GoRoute(
//             path: TEAM_ACTIVITY,
//             builder: (BuildContext context, GoRouterState state) {
//               return const TaskActivityView();
//             },
//           ),
//           GoRoute(
//             path: PROFILE,
//             builder: (BuildContext context, GoRouterState state) {
//               return ProfileView();
//             },
//           ),
//           GoRoute(
//             path: USER_LOV,
//             builder: (BuildContext context, GoRouterState state) {
//               return UsersLovScreen();
//             },
//           ),
//           GoRoute(
//             path: ALL_USER,
//             builder: (BuildContext context, GoRouterState state) {
//               return AllUsersScreen();
//             },
//           ),
//           GoRoute(
//             path: PROFILE_UPDATE,
//             builder: (BuildContext context, GoRouterState state) {
//               return ProfileUpdateView();
//             },
//           ),
//           GoRoute(
//             path: MANAGE_ROLE,
//             builder: (BuildContext context, GoRouterState state) {
//               return ManageRolesLovScreen();
//             },
//           ),
//           GoRoute(
//             path: ADD_ROLE,
//             builder: (BuildContext context, GoRouterState state) {
//               return AddRoleScreen();
//             },
//           ),
//           GoRoute(
//             path: UPDATE_ROLE,
//             builder: (BuildContext context, GoRouterState state) {
//               RoleLovResponse update = state.extra as RoleLovResponse;

//               // final RoleLovResponse? roleLovResponse =
//               //     ModalRoute.of(context)?.settings.arguments as RoleLovResponse?;

//               return UpdateRoleScreen(
//                 update: update,
//               );
//             },
//           ),
//         ],
//       ),
//       // )
//     ],
//   );
// }
