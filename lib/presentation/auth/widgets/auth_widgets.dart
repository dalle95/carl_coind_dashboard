import 'package:flutter/material.dart';

import '/core/configs/assets/app_images.dart';

Widget buildLogo({required BuildContext context}) {
  return Column(
    children: [
      SizedBox(
        height: 170,
        width: double.infinity,
        child: Image.asset(
          AppImages.logo,
          fit: BoxFit.contain,
        ),
      ),
      const SizedBox(
        height: 24,
      ),
      Text(
        'Dashboard Linee di Produzione',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              letterSpacing: 1.2,
              fontSize: 48,
              color: Theme.of(context).colorScheme.secondary,
            ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget buildForm({
  required BuildContext context,
  required TextEditingController emailController,
  required TextEditingController passwordController,
}) {
  return Column(
    children: [
      TextField(
        controller: emailController,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.surface,
        ),
        decoration: InputDecoration(
          labelText: 'Username',
          labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
          floatingLabelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.w600,
              ),
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
        ),
      ),
      const SizedBox(height: 16),
      // Campo password con lo stesso stile
      TextField(
        controller: passwordController,
        obscureText: true,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.surface,
        ),
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
          floatingLabelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.w600,
              ),
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
        ),
      ),
    ],
  );
}

Widget buildPulsante({
  required BuildContext context,
  required String lable,
  required void Function()? onPress,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ),
    onPressed: onPress,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        lable,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    ),
  );
}
