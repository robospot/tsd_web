import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsd_web/models/company.dart';
import 'package:tsd_web/models/user.dart';
import 'package:tsd_web/screens/codeGenerator/codegenerator_screen.dart';
import 'package:tsd_web/screens/dm_overview/cubit/dmoverview_cubit.dart';
import 'package:tsd_web/screens/dm_overview/dmoverview_screen.dart';
import 'package:tsd_web/screens/ean_overview/cubit/ean_cubit.dart';
import 'package:tsd_web/screens/ean_overview/ean_screen.dart';
import 'package:tsd_web/screens/home/cubit/home_cubit.dart';
import 'package:tsd_web/screens/packingList/packingList_screen.dart';
import 'package:tsd_web/screens/upload_file/cubit/uploadfile_cubit.dart';
import 'package:tsd_web/screens/vendor_user/cubit/vendoruser_cubit.dart';
import 'package:tsd_web/screens/vendor_user/vendorUser_screen.dart';
import 'package:tsd_web/screens/vendors/company_screen.dart';
import 'package:tsd_web/screens/vendors/cubit/company_cubit.dart';
import 'package:tsd_web/utils/authentication/bloc/authentication_bloc.dart';
import 'package:tsd_web/utils/repository.dart';

import 'cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String appBarTitle = '';
  String company = '';
  onGroupChanged(String group) {
    company = group;
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.bloc<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state is Organizationscreen) appBarTitle = 'Организации';
      if (state is Dmscreen) appBarTitle = 'Коды маркировки';
      if (state is Eanscreen) appBarTitle = 'Материалы';
      if (state is PackListscreen) appBarTitle = 'Упаковочные листы';
      if (state is VendorUserscreen) appBarTitle = 'Сотрудники';
      if (state is CodeGeneratorscreen) appBarTitle = 'Генератор штрих-кодов';

      return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          actions: [
            //Добавить компанию
            Visibility(
              visible:
                  (state is Organizationscreen || state is VendorUserscreen)
                      ? true
                      : false,
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () => state is Organizationscreen
                    ? addCompany(context)
                    : addUser(context),
              ),
            ),
            //Обновить
            Visibility(
              visible: (state is Dmscreen || state is Eanscreen) ? true : false,
              child: IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () => refreshDm(context),
              ),
            ),
            //Загрузить файл
            Visibility(
              visible: (state is Dmscreen || state is Eanscreen) ? true : false,
              child: IconButton(
                icon: Icon(Icons.file_upload),
                onPressed: () => state is Dmscreen
                    ? uploadSscc(context)
                    : uploadEan(context),
              ),
            ),
            //Сохранить файл
            Visibility(
              visible:
                  (state is Dmscreen || state is PackListscreen) ? true : false,
              child: IconButton(
                icon: Icon(Icons.file_download),
                onPressed: () => state is Dmscreen
                    ? downloadSsccFile(context)
                    : downloadPackListFile(context),
              ),
            ),

            //Очистить таблицу
            Visibility(
              visible: state is Dmscreen ? true : false,
              child: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () => clearDmTable(context),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: new ListView(
            children: <Widget>[
              new DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                  return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Color(0xff445E75)),
                    accountName: Text('${state.user?.name}'),
                    accountEmail: Text("${state.user?.email}"),
                    // currentAccountPicture: Container(
                    //     decoration: BoxDecoration(
                    //   shape: BoxShape.rectangle,
                    //   color: Color(0xff2196F3),
                    // )),
                  );
                }),
              ),
              ListTile(
                  title: new Text("Организации"),
                  leading: Icon(Icons.business_center),
                  onTap: () => homeCubit.setCompanyScreen()),
              ListTile(
                  title: new Text("Сотрудники"),
                  leading: Icon(Icons.person),
                  onTap: () => homeCubit.setVendorUserScreen()),
              ListTile(
                  title: new Text("Материалы"),
                  leading: Icon(Icons.style),
                  onTap: () => homeCubit.setEanScreen()),
              ListTile(
                  title: new Text("Коды маркировки"),
                  leading: Icon(Icons.qr_code),
                  onTap: () => homeCubit.setDmScreen()),
              ListTile(
                  title: new Text("Упаковочные листы"),
                  leading: Icon(Icons.unarchive),
                  onTap: () => homeCubit.setPackListScreen()),
              ListTile(
                  title: new Text("Генератор штрих-кодов"),
                  leading: Icon(Icons.qr_code_scanner_sharp),
                  onTap: () => homeCubit.setCodeGeneratorScreen()),
              ListTile(
                title: new Text("ВЫХОД"),
                leading: Icon(Icons.exit_to_app),
                onTap: () => context
                    .bloc<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested()),
              )
            ],
          ),
        ),
        body: body(state),
      );
    });
  }

  Widget body(HomeState state) {
    if (state is Organizationscreen) {
      return CompanyScreen();
    }

    if (state is Dmscreen) {
      return DatamatrixOverview();
    }
    if (state is Eanscreen) {
      return EanScreen();
    }
    if (state is PackListscreen) {
      return PackingListScreen();
    }
    if (state is VendorUserscreen) {
      return VendorUserScreen();
    }
    if (state is CodeGeneratorscreen) {
      return CodeGenerator();
    }
  }
}

addCompany(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  final Company newCompany = Company();
  return showDialog<String>(
    context: context,
    barrierDismissible:
        false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Новая организация',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        content: Container(
            width: 500,
            height: 180,
            child: Form(
                key: formKey,
                child: ListView(children: <Widget>[
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Короткое наименование организации',
                          helperText: ''),
                      onChanged: (val) => newCompany.shortName = val,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Поле не может быть пустым';
                        } else
                          return null;
                      }),
                  // SizedBox(height: 8,),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Полное наименование организации',
                        helperText: ''),
                    onChanged: (val) => newCompany.fullName = val,
                    validator: (value) {
                        if (value.isEmpty) {
                          return 'Поле не может быть пустым';
                        } else
                          return null;
                      }
                  ),
                ]))),
        actions: [
          FlatButton(
            minWidth: 100,
            child: Text(
              'Отмена',
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            minWidth: 100,
            color: Color(0xff5580C1),
            child: Text('Сохранить'),
            onPressed: () {
              if (formKey.currentState.validate()) {
                context.bloc<CompanyCubit>().addCompany(newCompany);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

addUser(BuildContext context) {
  final formKey = GlobalKey<FormState>();

  final User newUser = User();
  // int vendororgid = 1;
  onGroupChanged(int company) {
    newUser.vendororgid = company;
  }

  return showDialog<String>(
    context: context,
    barrierDismissible:
        false, // dialog is dismissible with a tap on the barrier
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(
          'Новый пользователь',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        content: Container(
            width: 300,
            height: 420,
            child: Form(
                key: formKey,
                child: ListView(children: <Widget>[
                  SelectVendorOrganization(groupCallback: onGroupChanged),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Учетная запись', helperText: ''),
                    onChanged: (val) => newUser.username = val,
                     validator: (value) {
                        if (value.isEmpty) {
                          return 'Поле не может быть пустым';
                        } else
                          return null;
                      }
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Пароль', helperText: ''),
                    onChanged: (val) => newUser.password = val,
                    validator: (value) {
                        if (value.isEmpty) {
                          return 'Поле не может быть пустым';
                        } else
                          return null;
                      }
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Имя Фамилия', helperText: ''),
                    onChanged: (val) => newUser.name = val,
                    validator: (value) {
                        if (value.isEmpty) {
                          return 'Поле не может быть пустым';
                        } else
                          return null;
                      }
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Email', helperText: ''),
                    onChanged: (val) => newUser.email = val,
                    validator: (value) {
                        if (value.isEmpty) {
                          return 'Поле не может быть пустым';
                        } else
                          return null;
                      }
                  ),
                ]))),
        actions: [
          FlatButton(
            minWidth: 100,
            child: Text(
              'Отмена',
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            minWidth: 100,
            color: Color(0xff5580C1),
            child: Text('Сохранить'),
            onPressed: () {
              if (formKey.currentState.validate()) {
                context.bloc<VendoruserCubit>().addUser(newUser);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

uploadSscc(BuildContext context) async {
  FilePickerResult result = await FilePicker.platform.pickFiles();

  if (result != null) {
    final uploadFileCubit = context.bloc<UploadfileCubit>();
    uploadFileCubit.uploadFile(result, context);
  }
}

uploadEan(BuildContext context) async {
  FilePickerResult result = await FilePicker.platform.pickFiles();

  if (result != null) {
    final uploadEanCubit = context.bloc<EanCubit>();
    uploadEanCubit.uploadFile(result, context);
  }
}

downloadSsccFile(BuildContext context) async {
  final uploadFileCubit = context.bloc<UploadfileCubit>();
  uploadFileCubit.downloadFile();
}

downloadPackListFile(BuildContext context) async {
  final uploadFileCubit = context.bloc<UploadfileCubit>();
  uploadFileCubit.downloadPackListFile();
}

refreshDm(BuildContext context) {
  context.bloc<DmoverviewCubit>().getAllDm();
}

clearDmTable(BuildContext context) async {
  await DataRepository().clearDmTable();
  context.bloc<DmoverviewCubit>().getAllDm();
}

//Выпадающий список, выбор организаций

class SelectVendorOrganization extends StatefulWidget {
  final ValueChanged<int> groupCallback;

  SelectVendorOrganization({Key key, this.groupCallback}) : super(key: key);

  @override
  _SelectVendorOrganizationState createState() =>
      _SelectVendorOrganizationState();
}

class _SelectVendorOrganizationState extends State<SelectVendorOrganization> {
  List<Company> companyList;
  int dropdownValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        if ((state is CompanyLoading) || (state is CompanyInitial)) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is CompanyLoaded) {
          companyList = state.companyList;
          dropdownValue = null;

          return Container(
            // height: 40,
            child: DropdownButtonFormField<int>(
              decoration: InputDecoration(
                  helperText: '',
                  labelText: 'Организация',
                  contentPadding: EdgeInsets.all(12)),
              style: Theme.of(context).textTheme.bodyText2,
              isExpanded: true,
              onChanged: (int newValue) {
                widget.groupCallback(newValue);
                dropdownValue = newValue;
                setState(() {});
              },
              value: dropdownValue,
              items: companyList.map<DropdownMenuItem<int>>((Company company) {
                return DropdownMenuItem<int>(
                  value: company.id,
                  child: Text(company.shortName),
                );
              }).toList(),
               validator: (value) {
                        if (value == null) {
                          return 'Поле не может быть пустым';
                        } else
                          return null;
                      }
            ),
          );
        }
      },
    );
  }
}
