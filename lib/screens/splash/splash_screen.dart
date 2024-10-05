/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop/common/app/cache_helper.dart';
import 'package:shop/screens/auth/presentation/adapter/auth_adapter.dart';

import '../../services/injection_container/main.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
            (_) {
          ref.read(authAdapterProvider().notifier).verifyToken('token');
            }
    );
  }

  @override
  Widget build(BuildContext context) {

    ref.listen(authAdapterProvider(),(prev, next) async {
      if(next is TokenVerified){
        if(next.isValid){
          //get User data
        } else {
          await sl<CacheHelper>().resetSession();
        }
      }
    });
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            color: Colors.white,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ));
  }
}*/
