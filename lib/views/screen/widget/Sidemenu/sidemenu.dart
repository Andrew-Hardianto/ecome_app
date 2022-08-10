import 'package:ecome_app/provider/user_provider.dart';
import 'package:ecome_app/views/screen/home/home_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecome_app/utils/extension.dart';

class SidemenuNavigation extends StatelessWidget {
  // const SidemenuNavigation({Key? key}) : super(key: key);
  final homeService = HomeService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.deepOrange.shade300],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.5, 0.9],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // user.profilePicture != null || user.profilePicture != ''
                    user.profilePicture != null
                        ? CircleAvatar(
                            backgroundColor: Colors.white70,
                            minRadius: 60.0,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                                  NetworkImage(user.profilePicture!),
                            ),
                          )
                        : Container(
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              color: homeService.randomColor == null
                                  ? '#121212'.toColor()
                                  : '${homeService.randomColor}'.toColor(),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                                child: Text(
                              user.alias == null ? '-' : user.alias!,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 48),
                            )),
                          ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  user.fullName != null ? user.fullName! : '-',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  user.employeeNo != null ? user.employeeNo! : '-',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 270,
                  child: ListView(children: [
                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title: Text('Data'),
                      onTap: () {},
                    ),
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
