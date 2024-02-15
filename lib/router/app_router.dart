import 'package:budget_buddy_2/models/expense/expense.dart';
import 'package:budget_buddy_2/router/app_router_constants.dart';
import 'package:budget_buddy_2/screens/expense_screen/expense_page.dart';
import 'package:budget_buddy_2/screens/finance_buddy/finance_buddy.dart';
import 'package:budget_buddy_2/screens/splash/splash_screen.dart';
import 'package:budget_buddy_2/screens/user_authentication/sign_in.dart';
import 'package:budget_buddy_2/screens/user_authentication/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter{
  GoRouter router  = GoRouter(routes: [
    GoRoute(
      name: AppRouterConstants.splashScreen,
      path: "/",
      pageBuilder: (context,state)=>MaterialPage(child: SplashScreen())
    ),
    GoRoute(
      name: AppRouterConstants.signInScreen,
      path: "/signIn",
      pageBuilder: (context,state)=>MaterialPage(child: SignInScreen())
    ),
    GoRoute(
      name: AppRouterConstants.signUpScreen,
      path: "/signUp",
      pageBuilder: (context,state)=>MaterialPage(child: SignUpScreen())
    ),
    GoRoute(
      name:AppRouterConstants.expenseScreen,
      path: "/expense",
      pageBuilder: (context,state)=>MaterialPage(child: ExpensePage(expenseList: expenseList, winLossDataList: [1,1,1,-1,1,1-1,-1,]))
    ),
    GoRoute(
      name: AppRouterConstants.buddyScreen,
      path: "/buddy",
      pageBuilder: (context,state)=>const MaterialPage(child: FinanceBuddy())
    )
  ]);
}
