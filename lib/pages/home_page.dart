import 'package:flutter/material.dart';
import 'package:appiot/blocs/authentication_bloc.dart';
import 'package:appiot/events/authentication_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/pages/bedroom_page.dart';
import '/pages/livingroom_page.dart';
import '/pages/kitchen_page.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLivingRoomSelected = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationEventLoggedOut());
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: 'Living room'),
            Tab(text: 'Kitchen'),
            Tab(text: 'Bedroom'),
            Tab(text: 'Bathroom'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            alignment: Alignment.center,
            child: LivingRoomPage(),
          ),
          Container(
            alignment: Alignment.center,
            child: KitchenPage(),
          ),
          Container(
            alignment: Alignment.center,
            child: BedRoomPage(),
          ),
          Container(
            alignment: Alignment.center,
            child: Text('Bathroom Content'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}