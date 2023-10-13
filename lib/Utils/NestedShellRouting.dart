import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:graphqlgetxexample/models/RoleLovResponseModel.dart';
import 'package:graphqlgetxexample/views/account/profile_update_view.dart';
import 'package:graphqlgetxexample/views/account/profile_view.dart';
import 'package:graphqlgetxexample/views/auth/create_new_password_view.dart';
import 'package:graphqlgetxexample/views/auth/forget_password_view.dart';
import 'package:graphqlgetxexample/views/auth/otp_view.dart';
import 'package:graphqlgetxexample/views/auth/sign_in_view.dart';
import 'package:graphqlgetxexample/views/auth/sign_up_view.dart';
import 'package:graphqlgetxexample/views/dashboard/dashboard.dart';
import 'package:graphqlgetxexample/views/manageRole/addRoleScreen.dart';
import 'package:graphqlgetxexample/views/manageRole/manageRoleLovScreen.dart';
import 'package:graphqlgetxexample/views/manageRole/updateRoleScreen.dart';
import 'package:graphqlgetxexample/views/notification/notification_view.dart';
import 'package:graphqlgetxexample/views/splash/splash_view.dart';
import 'package:graphqlgetxexample/views/taskActivity/task_activity_view.dart';
import 'package:graphqlgetxexample/views/teamboard/teamboard.dart';
import 'package:graphqlgetxexample/views/userManagement/allUsersScreen.dart';
import 'package:graphqlgetxexample/views/userManagement/usersLovScreen.dart';
import 'package:graphqlgetxexample/widgets/scaffoldWithNestedNavigation.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');
final _shellNavigatorEKey = GlobalKey<NavigatorState>(debugLabel: 'shellE');
final _shellNavigatorFKey = GlobalKey<NavigatorState>(debugLabel: 'shellF');
final _shellNavigatorGKey = GlobalKey<NavigatorState>(debugLabel: 'shellG');
final _shellNavigatorHKey = GlobalKey<NavigatorState>(debugLabel: 'shellH');

const String SPLASH = "/splash";
const String SIGNIN = "/signin";
const String SIGNUP = "/signup";
const String FORGET_PASSWORD = "/forgetPassword";
const String OTP = "/otp";
const String CREATE_NEW_PASSWORD = "/createNewPassword";

final goRouter = GoRouter(
  initialLocation: SPLASH,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: SPLASH, // '/',
      builder: (BuildContext context, GoRouterState state) {
        return SplashView();
      },
    ),
    GoRoute(
      path: SIGNIN,

      builder: (BuildContext context, GoRouterState state) {
        return SignInView();
      },
      // pageBuilder: ((context, state) {
      //   return CustomTransitionPage(
      //     transitionDuration: const Duration(seconds: 2),
      //     // key: state.pageKey,
      //     child: SignInView(),
      //     transitionsBuilder: ((context, animation, secondaryAnimation, child) {
      //       return FadeTransition(
      //         opacity:
      //             CurveTween(curve: Curves.easeInOutCirc).animate(animation),
      //         child: child,
      //       );
      //     }),
      //   );
      // }),
    ),
    GoRoute(
      path: SIGNUP,
      pageBuilder: ((context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          // key: state.pageKey,
          child: SignUpView(),
          transitionsBuilder: ((context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          }),
        );
      }),
    ),
    GoRoute(
      path: FORGET_PASSWORD,
      // builder: (BuildContext context, GoRouterState state) {
      //   return ForgetPasswordView();
      // },
      pageBuilder: ((context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          // key: state.pageKey,
          child: const ForgetPasswordView(),
          transitionsBuilder: ((context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          }),
        );
      }),
    ),
    GoRoute(
      path: OTP,
      builder: (BuildContext context, GoRouterState state) {
        return OTPView(
          email: state.extra.toString(),
        );
      },
    ),
    GoRoute(
      path: '$CREATE_NEW_PASSWORD/:email/:otp',
      name: 'newPass',
      builder: (BuildContext context, GoRouterState state) {
        return CreateNewPasswordView(
          email: state.pathParameters['email']!,
          otp: state.pathParameters['otp']!,
        );
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: '/notification',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: NotificationView(),
              ),
              // routes: [
              // GoRoute(
              //   path: 'userLov',
              //   builder: (context, state) => UsersLovScreen(),
              // ),
              // GoRoute(
              //   path: 'allUsers',
              //   builder: (context, state) => AllUsersScreen(),
              // ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: '/dashboard',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: Dashboard(),
              ),
              // routes: [
              // GoRoute(
              //   path: 'details',
              //   builder: (context, state) => DetailsScreen(label: 'B'),
              // ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/teamboard',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: Teamboard(),
              ),
              // routes: [
              // GoRoute(
              //   path: 'details',
              //   builder: (context, state) => DetailsScreen(label: 'B'),
              // ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDKey,
          routes: [
            GoRoute(
              path: '/activity',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: TaskActivityView(),
              ),
              // routes: [
              // GoRoute(
              //   path: 'details',
              //   builder: (context, state) => DetailsScreen(label: 'B'),
              // ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorEKey,
          routes: [
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) => NoTransitionPage(
                child: ProfileView(),
              ),
              routes: [
                GoRoute(
                  path: 'updateProfile',
                  builder: (context, state) => ProfileUpdateView(),
                ),
                GoRoute(
                  path: 'manageRole',
                  builder: (context, state) => ManageRolesLovScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFKey,
          routes: [
            GoRoute(
              path: '/addRole',
              pageBuilder: (context, state) => NoTransitionPage(
                child: AddRoleScreen(),
              ),
              // routes: [
              //   GoRoute(
              //     path: 'userLov',
              //     builder: (context, state) => UsersLovScreen(),
              //   ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorGKey,
          routes: [
            GoRoute(
              path: '/updateRole',
              pageBuilder: (context, state) {
                RoleLovResponse update = state.extra as RoleLovResponse;
                return NoTransitionPage(
                  child: UpdateRoleScreen(update: update),
                );
              },
              // pageBuilder: (context, state) => NoTransitionPage(
              //   child: UpdateRoleScreen(update: ),
              // ),
              // routes: [
              //   GoRoute(
              //     path: 'userLov',
              //     builder: (context, state) => UsersLovScreen(),
              //   ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHKey,
          routes: [
            GoRoute(
              path: '/userLov',
              pageBuilder: (context, state) => NoTransitionPage(
                child: UsersLovScreen(),
              ),
              // routes: [
              //   GoRoute(
              //     path: 'userLov',
              //     builder: (context, state) => UsersLovScreen(),
              //   ),
              // ],
            ),
            GoRoute(
              path: '/allUsers',
              pageBuilder: (context, state) => NoTransitionPage(
                child: AllUsersScreen(),
              ),
              // routes: [
              //   GoRoute(
              //     path: 'userLov',
              //     builder: (context, state) => UsersLovScreen(),
              //   ),
              // ],
            ),
          ],
        ),
      ],
    ),
  ],
);
