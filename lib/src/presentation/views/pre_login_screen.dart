import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walkzero/src/presentation/views/dashboard.dart';
import 'package:walkzero/src/presentation/widgets/resuable_button.dart';
import 'package:walkzero/src/presentation/widgets/resuable_text_field.dart';
import 'package:walkzero/src/utils/constants/constants.dart';

import '../../config/router/bottom_nav.dart';
import '../../utils/extentions/validator.dart';
import '../cubits/signin_cubit.dart';
import '../widgets/bezierContainer.dart';

class PreLoginScreen extends StatefulWidget {
  PreLoginScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _PreLoginScreenState createState() => _PreLoginScreenState();
}

class _PreLoginScreenState extends State<PreLoginScreen> {
  bool isChecked = false;
  bool passToggle = true;
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left,
                  color: Colors.black, size: 25),
            ),
            Text('Back',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    var cubit = BlocProvider.of<SigninCubit>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: height,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              // Positioned(
              //     top: -height * .15,
              //     right: -MediaQuery.of(context).size.width * .4,
              //     child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.state.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height / 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Login to Walkzero',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        // _title(),
                        SizedBox(height: height / 25),
                        BlocBuilder<SigninCubit, SigninState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                CommonTextField(
                                  controller: state.emailController,
                                  labelText: 'Enter Email',
                                  inputAction: TextInputAction.next,
                                  validator: (text) => validateEmail(text),
                                ),
                              ],
                            );
                          },
                        ),

                        SizedBox(height: 25),
                        CommonButton(
                          onPressed: () => cubit.onLogin(context),
                          child:
                              Text('Continue', style: TextStyle(color: white)),
                        ),
                        // resuableButton(context, 'Continue', BottomNav(), ),
                        // _divider(),
                        // _facebookButton(),
                        SizedBox(height: height * .055),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ),
      ),
    ));
  }
}
