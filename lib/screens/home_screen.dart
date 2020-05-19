import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerenciarlojaapp/blocs/user_bloc.dart';
import 'package:gerenciarlojaapp/tabs/users_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _page = 0;
  
  UserBloc _userBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _userBloc = UserBloc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.purple,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.white54),
              ),
        ),
        child: BottomNavigationBar(
          currentIndex: _page,
          onTap: (p) {
            _pageController.animateToPage(p,
                duration: Duration(microseconds: 400), curve: Curves.ease);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Clientes'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Pedidos'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Produtos'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: BlocProvider<UserBloc>(
          bloc: _userBloc,
          child: PageView(
            controller: _pageController,
            onPageChanged: (p) {
              setState(() {
                _page = p;
              });
            },
            children: <Widget>[
              UsersTab(),
              Container(color: Colors.lightBlueAccent),
              Container(color: Colors.deepOrange),
            ],
          ),
        ),
      ),
    );
  }
}
