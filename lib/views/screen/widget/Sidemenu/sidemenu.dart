import 'package:ecome_app/provider/user_provider.dart';
import 'package:ecome_app/views/screen/home/home_service.dart';
import 'package:ecome_app/views/screen/widget/Sidemenu/sidemenu_service.dart';
import 'package:ecome_app/views/screen/widget/tooltip-profile/tooltip_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecome_app/utils/extension.dart';

class SidemenuNavigation extends StatelessWidget {
  // const SidemenuNavigation({Key? key}) : super(key: key);
  final homeService = HomeService();
  final sidemenuService = SidemenuService();

  openTooltip(BuildContext context, user) {
    return showDialog(
        context: context,
        builder: (context) {
          return TooltipProfile(
            user: user,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.green.shade200],
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
                            backgroundImage: NetworkImage(user.profilePicture!),
                            // child: CircleAvatar(
                            //   radius: 50.0,
                            // ),
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
                InkWell(
                  onTap: () {
                    openTooltip(context, user);
                  },
                  child: Text(
                    user.fullName != null ? user.fullName! : '-',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: ListView(
                    children: sidemenuService.menuList.map((e) {
                      return ListTile(
                        leading: e.menuIcon,
                        title: Text(
                          e.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            e.url,
                            arguments: {'type': e.name},
                          );
                        },
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Logout'),
                onPressed: () {
                  sidemenuService.logout(context);
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
            ),
          )
        ],
      ),
    );
  }
}
