import 'package:flutter/material.dart';
import 'package:shoppy/constant.dart';

class Userdrawer extends StatelessWidget {
  const Userdrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 35),
        const CircleAvatar(
          radius: 45,
          child: Icon(Icons.person_outline, size: 40),
        ),
        const SizedBox(height: 10),
        Text(
          'Kenneth Kolawole',
          style: style.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          'kenneth@gmail.com',
          style: style.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const Spacer(),
        ListTile(
          onTap: () {},
          leading: Text(
            'Take a break',
            style: style.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          trailing: const Icon(Icons.exit_to_app),
        )
      ],
    );
  }
}
