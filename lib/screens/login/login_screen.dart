import 'package:flutter/material.dart';
import 'package:tsd_web/screens/home/home_screen.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _restoreController = TextEditingController();
  final loginformKey = GlobalKey<FormState>();
  final registerformKey = GlobalKey<FormState>();
  final restoreformKey = GlobalKey<FormState>();
  int _index = 0;
  bool loginScreenVisibility = true;
  bool registerScreenVisibility = false;
  bool restoreScreenVisibility = false;

  final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text("Input fields mustn't be empty"));

  @override
  Widget build(BuildContext context) {
    // return BlocListener<LoginBloc, LoginState>(
    //   listener: (context, state) {
    //     if (state is LoginFailure) {
    //       Scaffold.of(context).showSnackBar(
    //         SnackBar(
    //           content: Text('${state.error}'),
    //           backgroundColor: Colors.red,
    //         ),
    //       );
    //     }
    //   },
    //   child: BlocBuilder<LoginBloc, LoginState>(
    //     builder: (context, state) {
    return Scaffold(
      body: Container(
        color: Color(0xffEBF1FA),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
                //  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                // height: SizeConfig.blockSizeVertical * 60,
                height: 361,
                width: 681,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    elevation: 5.0,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset(
                              'assets/logo.png',
                              fit: BoxFit.contain,
                            ),
                          )),
                        ),
                        Expanded(
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 45, top: 16, bottom: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: IndexedStack(
                                    index: _index,
                                    children: <Widget>[
                                      loginScreen(),
                                      registerScreen(),
                                      restorePasswordScreen()
                                    ],
                                  ),
                                ),
                                RaisedButton(
                                  color: Color(0xff5580C1),
                                  shape: Border.all(
                                      width: 0, style: BorderStyle.none),
                                  autofocus: true,
                                  // onPressed: state is! LoginLoading
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomeScreen())),
                                  // ? onLoginButtonPressed
                                  // : null,
                                  child: Text(
                                    _index == 0
                                        ? 'Войти'
                                        : _index == 1
                                            ? 'Создать учетную запись'
                                            : 'Сбросить пароль',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ButtonBar(
                                  buttonMinWidth: 106,
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    FlatButton(
                                      shape: Border.all(
                                          width: 0, style: BorderStyle.none),
                                      child: Text(
                                        _index == 0
                                            ? "Создать учетную запись"
                                            : _index == 1
                                                ? "Войти"
                                                : "Войти",
                                        style: TextStyle(
                                            color: Color(0xff494F59),
                                            fontSize: 13,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      onPressed: () => setState(() {
                                        if (_index == 0) {
                                          _index = 1;
                                          restoreScreenVisibility = false;
                                          loginScreenVisibility = false;
                                          registerScreenVisibility = true;
                                        } else {
                                          _index = 0;
                                          restoreScreenVisibility = false;
                                          loginScreenVisibility = true;
                                          registerScreenVisibility = false;
                                        }
                                      }),
                                    ),
                                    FlatButton(
                                      shape: Border.all(
                                          width: 0, style: BorderStyle.none),
                                      child: Text(
                                        "Забыли пароль?",
                                        style: TextStyle(
                                            color: Color(0xff494F59),
                                            fontSize: 13,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      onPressed: () => setState(() {
                                        _index = 2;
                                        restoreScreenVisibility = true;
                                        loginScreenVisibility = false;
                                        registerScreenVisibility = false;
                                      }),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }

  onLoginButtonPressed() async {
    switch (_index) {
      case 0: //login
        if (_usernameController.text.isEmpty ||
            _passwordController.text.isEmpty) {
          Scaffold.of(context).showSnackBar(snackBar);
        }
        if (loginformKey.currentState.validate()) {
          // BlocProvider.of<LoginBloc>(context).add(
          //   LoginButtonPressed(
          //     username: _usernameController.text,
          //     password: _passwordController.text,
          //   ),
          // );
        }
        break;
      case 1: //register
        if (_emailController.text.isEmpty ||
            _nameController.text.isEmpty ||
            _usernameController.text.isEmpty ||
            _passwordController.text.isEmpty) {
          Scaffold.of(context).showSnackBar(snackBar);
        }
        if (registerformKey.currentState.validate()) {
          // int response = await Fetcher().createUser(
          //     _emailController.text,
          //     _nameController.text,
          //     'Basic',
          //     _usernameController.text,
          //     _passwordController.text,
          //     null);
          // if (response == 200) {
          //   Scaffold.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text('Account successfully created'),
          //       // backgroundColor: Colors.black,
          //     ),
          //   );
          //   setState(() {
          //     _index = 0;
          //     restoreScreenVisibility = false;
          //     loginScreenVisibility = true;
          //     registerScreenVisibility = false;
          //   });
          // } else {
          //   Scaffold.of(context).showSnackBar(
          //     SnackBar(
          //       backgroundColor: Colors.red,
          //       content: Text('Username or email already exists '),
          //       // backgroundColor: Colors.black,
          //     ),
          //   );
          // }
        }
        break;
      case 2: //restore pass
        if (_restoreController.text.isEmpty) {
          Scaffold.of(context).showSnackBar(snackBar);
        } // word
      // if (restoreformKey.currentState.validate()) {
      //   String result =
      //       await Fetcher().restorePassword(_restoreController.text);
      //   if (result == null) {
      //     Scaffold.of(context).showSnackBar(
      //       SnackBar(
      //         content: Text('Username not found'),
      //         backgroundColor: Colors.red,
      //       ),
      //     );
      //   } else {
      //     Scaffold.of(context).showSnackBar(
      //       SnackBar(
      //         content: Text('Password has been updated. Check your email'),
      //         // backgroundColor: Colors.black,
      //       ),
      //     );
      //     setState(() {
      //       _index = 0;
      //       restoreScreenVisibility = false;
      //       loginScreenVisibility = true;
      //       registerScreenVisibility = false;
      //     });
      //   }
      // }
    }
  }

  Widget loginScreen() {
    return Visibility(
      visible: loginScreenVisibility,
      child: Form(
          key: loginformKey,
          child: Column(
            children: <Widget>[
              Spacer(),
              Container(
                height: 40,
                child: TextFormField(
                  autofocus: true,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Color(0xff5580C1)),
                    // helperText: ' ',
                    // icon: Icon(Icons.person),
                    labelText: 'Учетная запись',
                    labelStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                    ),
                    contentPadding: EdgeInsets.only(bottom: 5),
                  ),
                  autocorrect: false,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 40,
                //Login by Enter button
                child: TextFormField(
                  onFieldSubmitted: (val) => onLoginButtonPressed(),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xff5580C1),
                    ),
                    // icon: Icon(Icons.lock),
                    labelText: 'Пароль',
                    labelStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                    ),
                    contentPadding: EdgeInsets.only(bottom: 5),
                  ),
                  obscureText: true,
                  autocorrect: false,
                ),
              ),
              Spacer(),
            ],
          )),
    );
  }

  Widget registerScreen() {
    return Visibility(
      visible: registerScreenVisibility,
      child: Form(
          key: registerformKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 40,
                child: TextFormField(
                  autofocus: true,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Color(0xff5580C1)),
                    labelText: 'Учетная запись',
                    labelStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                    ),
                    contentPadding: EdgeInsets.only(bottom: 5),
                  ),
                  autocorrect: false,
                ),
              ),
              Container(
                  height: 40,
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Color(0xff5580C1)),
                      labelText: 'Пароль',
                      labelStyle: TextStyle(fontSize: 13),
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      contentPadding: EdgeInsets.only(bottom: 5),
                    ),
                    obscureText: true,
                    autocorrect: false,
                  )),
              Container(
                  height: 40,
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.face, color: Color(0xff5580C1)),
                      labelText: 'Имя Фамилия',
                      labelStyle: TextStyle(fontSize: 13),
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      contentPadding: EdgeInsets.only(bottom: 5),
                    ),
                    autocorrect: false,
                  )),
              Container(
                  height: 40,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Color(0xff5580C1)),
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 13),
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      contentPadding: EdgeInsets.only(bottom: 5),
                    ),
                    autocorrect: false,
                  )),
            ],
          )),
    );
  }

  Widget restorePasswordScreen() {
    return Visibility(
      visible: restoreScreenVisibility,
      child: Form(
          key: restoreformKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Spacer(),
              Text(
                "Введите ваш Email\n и мы вышлем вам новый пароль",
                style: TextStyle(
                  color: Color(
                    0xff5580C1,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 40,
                child: TextFormField(
                  autofocus: true,
                  controller: _restoreController,
                  decoration: InputDecoration(
                    // helperText: ' ',
                    prefixIcon: Icon(Icons.email, color: Color(0xff5580C1)),
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                    ),
                    contentPadding: EdgeInsets.only(bottom: 5),
                  ),
                  autocorrect: false,
                ),
              ),
              Spacer(),
            ],
          )),
    );
  }
}
