import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddUserScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends ConsumerState<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '', email = '', phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New User')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (v) => name = v!,
                validator: (v) => v!.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (v) => email = v!,
                validator: (v) => v!.isEmpty ? 'Enter email' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                onSaved: (v) => phone = v!,
                validator: (v) => v!.isEmpty ? 'Enter phone' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newUser = User(
                      id: DateTime.now().millisecondsSinceEpoch,
                      name: name,
                      username: name.toLowerCase().replaceAll(' ', '_'),
                      email: email,
                      phone: phone,
                      website: 'example.com',
                      address: Address(
                        street: '123 Main St',
                        suite: 'Apt. 1',
                        city: 'Your City',
                        zipcode: '00000',
                        geo: Geo(lat: '0.0', lng: '0.0'),
                      ),
                      company: Company(
                        name: 'Demo Company',
                        catchPhrase: 'We build stuff',
                        bs: 'business solutions',
                      ),
                    );
                    ref.read(userListProvider.notifier).addUser(newUser);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
