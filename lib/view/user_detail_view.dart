import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username: ${user.username}', style: textTheme.titleLarge),
                SizedBox(height: 10),
                Text('Email: ${user.email}', style: textTheme.bodyMedium),
                SizedBox(height: 10),
                Text('Phone: ${user.phone}', style: textTheme.bodyMedium),
                SizedBox(height: 10),
                Text('Website: ${user.website}', style: textTheme.bodyMedium),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 10),
                Text('📍 Address', style: textTheme.titleLarge),
                Text('${user.address.street}, ${user.address.city}', style: textTheme.bodyMedium),
                Text('${user.address.zipcode}', style: textTheme.bodyMedium),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 10),
                Text('🏢 Company', style: textTheme.titleLarge),
                Text(user.company.name, style: textTheme.bodyMedium),
                Text(user.company.catchPhrase, style: textTheme.bodyMedium),
                Text(user.company.bs, style: textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ));}}