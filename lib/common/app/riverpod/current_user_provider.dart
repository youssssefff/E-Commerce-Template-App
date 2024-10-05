import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop/common/models/user.dart';

part 'current_user_provider.g.dart';



@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser{

  @override
  User? build()  {return null;}

  void setUser(User? user){
    if(state != user){
      state = user;
    }
  }
}