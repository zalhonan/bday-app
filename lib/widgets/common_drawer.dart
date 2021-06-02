import 'package:flutter/material.dart';

class CommonDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(color: Colors.blue),
            child: ListTile(
              leading: Icon(
                Icons.account_box_outlined,
                color: Colors.white,
              ),
              title: Text(
                'Никита Джигурда',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              dense: true,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ListTile(
                  leading: Icon(Icons.mail_outline),
                  title: Text('Восстановить пароль'),
                ),
                ListTile(
                  leading: Icon(Icons.lock_open),
                  title: Text('Сменить пароль'),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Выйти из системы'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
