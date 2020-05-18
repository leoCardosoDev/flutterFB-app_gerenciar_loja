import 'package:flutter/material.dart';
import 'package:gerenciarlojaapp/blocs/login_bloc.dart';
import 'package:gerenciarlojaapp/screens/home_screen.dart';
import 'package:gerenciarlojaapp/widgets/input_fields.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
          break;
        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Erro'),
                    content: Text('Você não tem permissão para acessar esta área!'),
                  ));
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
        default:
      }
    });
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _loginBloc.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          initialData: LoginState.LOADING,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case LoginState.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.purple),
                  ),
                );
                break;
              case LoginState.FAIL:
              case LoginState.IDLE:
              case LoginState.SUCCESS:
              default:
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(),
                    SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Icon(
                              Icons.store_mall_directory,
                              color: Colors.purple,
                              size: 160,
                            ),
                            InputFields(
                              icon: Icons.person_outline,
                              hint: "E-mail",
                              obscure: false,
                              stream: _loginBloc.outEmail,
                              onChanged: _loginBloc.changeEmail,
                            ),
                            InputFields(
                              icon: Icons.lock_outline,
                              hint: "Senha",
                              obscure: true,
                              stream: _loginBloc.outPassword,
                              onChanged: _loginBloc.changePassword,
                            ),
                            SizedBox(height: 32),
                            StreamBuilder<bool>(
                                stream: _loginBloc.outSubmitValid,
                                builder: (context, snapshot) {
                                  return SizedBox(
                                    height: 50,
                                    child: RaisedButton(
                                      color: Colors.purple,
                                      child: Text(
                                        'Entrar',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      textColor: Colors.white,
                                      onPressed: snapshot.hasData ? _loginBloc.submit : null,
                                      disabledColor: Colors.purple.withAlpha(140),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
                break;
            }
          }),
    );
  }
}
