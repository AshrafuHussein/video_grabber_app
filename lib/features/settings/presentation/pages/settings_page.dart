import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/settings_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(SettingsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            return ListView(
              children: [
                ListTile(
                  title: const Text('Auto-save to Gallery'),
                  subtitle: const Text('Automatically save downloaded videos to your photos/gallery'),
                  trailing: Switch(
                    value: state.settings.autoSaveToGallery,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(AutoSaveToggled(value));
                    },
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text('Instagram Login'),
                  subtitle: const Text('Manage your Instagram session for downloads'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/instagram-login'),
                ),
                const Divider(),
                const ListTile(
                  title: Text('Version'),
                  subtitle: Text('1.0.0'),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
