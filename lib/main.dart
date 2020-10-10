import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsd_web/screens/dm_overview/cubit/dmoverview_cubit.dart';
import 'package:tsd_web/screens/ean_overview/cubit/ean_cubit.dart';
import 'package:tsd_web/screens/home/cubit/home_cubit.dart';
import 'package:tsd_web/screens/packingList/cubit/packinglist_cubit.dart';
import 'app.dart';
import 'screens/company/cubit/company_cubit.dart';
import 'screens/upload_file/cubit/uploadfile_cubit.dart';
import 'utils/authentication_repository.dart';
import 'utils/user_repository.dart';

// class SimpleBlocDelegate extends BlocDelegate {
//   @override
//   void onTransition(Transition transition) {
//     print(transition.toString());
//   }
// }

void main() {
  // BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<UploadfileCubit>(
          create: (BuildContext context) => UploadfileCubit()),
      BlocProvider<DmoverviewCubit>(
          create: (BuildContext context) => DmoverviewCubit()),
      BlocProvider<CompanyCubit>(
          create: (BuildContext context) => CompanyCubit()),
      BlocProvider<HomeCubit>(create: (BuildContext context) => HomeCubit()),
      BlocProvider<EanCubit>(create: (BuildContext context) => EanCubit()),
      BlocProvider<PackinglistCubit>(
          create: (BuildContext context) => PackinglistCubit()),
          
    ],
    child: App(
       authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
    ),
  ));
}

// class App extends StatefulWidget {
//   // This widget is the root of your application.
  
//   @override
//   _AppState createState() => _AppState();
// }

// class _AppState extends State<App> {
//   @override
//     @override
//   void initState() {
//     super.initState();
//     context.bloc<AuthenticationCubit>().appStarted(userRepository);

//   }

//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (BuildContext context) => AuthenticationCubit(),
//         child: MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'Flutter Demo',
//             theme: ThemeData(
//               primarySwatch: Colors.blue,
//               visualDensity: VisualDensity.adaptivePlatformDensity,
//             ),
//             // home: MyHomePage(title: 'Flutter Demo Home Page'),
//             // initialRoute: '/',
//             // routes: {
//             //   '/': (context) => LoginForm(),

//             // }
//             home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
//               builder: (context, state) {
//                 if (state is AuthenticationUninitialized) {
//                   return Container();
//                 }
//                 if (state is AuthenticationAuthenticated) {
//                   return HomeScreen();
//                 }
//                 if (state is AuthenticationUnauthenticated) {
//                   return LoginForm();
//                 }
//                 if (state is AuthenticationLoading) {
//                   return Container(child: CircularProgressIndicator());
//                 }
//               },
//             )));
//   }
// }
