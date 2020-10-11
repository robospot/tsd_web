import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsd_web/screens/dm_overview/cubit/dmoverview_cubit.dart';
import 'package:tsd_web/screens/ean_overview/cubit/ean_cubit.dart';
import 'package:tsd_web/screens/home/cubit/home_cubit.dart';
import 'package:tsd_web/screens/packingList/cubit/packinglist_cubit.dart';
import 'app.dart';

import 'screens/upload_file/cubit/uploadfile_cubit.dart';
import 'screens/vendors/cubit/company_cubit.dart';
import 'utils/authentication/authentication_repository.dart';
import 'utils/authentication/user_repository.dart';

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

