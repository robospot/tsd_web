import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsd_web/screens/dm_overview/cubit/dmoverview_cubit.dart';
import 'package:tsd_web/screens/home/cubit/home_cubit.dart';
import 'package:tsd_web/screens/login/login_screen.dart';
import 'screens/company/cubit/company_cubit.dart';
import 'screens/upload_file/cubit/uploadfile_cubit.dart';

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
           BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginForm(),
         
        });
  }
}
