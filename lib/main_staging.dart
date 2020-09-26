import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MyShoppingList/app/app.dart';
import 'package:MyShoppingList/common/bloc/simple_bloc_observer.dart';
import 'package:MyShoppingList/common/constant/env.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(App(env: EnvValue.staging));
}