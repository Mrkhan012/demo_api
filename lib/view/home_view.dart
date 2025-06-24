import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/view/user_add_view.dart';
import 'package:flutter_application_1/view/user_detail_view.dart';
import 'package:flutter_application_1/widgets/user_title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart'; // for themeProvider

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userListProvider);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              final current = ref.read(themeProvider);
              ref.read(themeProvider.notifier).state =
                  current == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddUserScreen()),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) => ref.read(userListProvider.notifier).search(value),
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
      ),
      body: users.isEmpty
          ? const Center(child: Text('No users found or failed to load.'))
          : LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isWide ? 3 : 1,
                    childAspectRatio: isWide ? 2.5 : 3.2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: users.length,
                  itemBuilder: (_, index) {
                    final user = users[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => UserDetailScreen(user: user)),
                      ),
                      child: UserTile(user: user),
                    );
                  },
                );
              },
          ));}}