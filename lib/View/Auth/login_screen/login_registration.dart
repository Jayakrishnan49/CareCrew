import 'package:flutter/material.dart';
import 'package:project_2/view/auth/forgot_password/forgot_password.dart';
import 'package:project_2/view/bottom_nav/bottom_nav_screen.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/controllers/auth_provider/auth_provider.dart';
import 'package:project_2/Utilities/app_validators.dart';
import 'package:project_2/Widgets/custom_button.dart';
import 'package:project_2/Widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';
import '../auth_nav/auth_nav.dart';


class LoginRegistration extends StatelessWidget {
  const LoginRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    AppValidators formValidators=AppValidators();
    final userProvider = Provider.of<UserAuthProvider>(context, listen: false);

    return  Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 70,),
           
                const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'E-Mail ID',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            controller: emailController,
            prefixIcon: Icons.email,
            hintText: 'Enter Email',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: formValidators.validateEmail,
          ),
          SizedBox(height: 30,),

          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Enter Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            controller: passwordController,
            hintText: 'Enter Password',
            prefixIcon: Icons.lock,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: formValidators.validatePassword,
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  ////// location
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));
                },
                child: Text('Forgot Password?',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontStyle: FontStyle.italic
                  ),
                ),
              )
            ],
          ),
          
                const SizedBox(height: 30),
                CustomButton(
            width: 400,
            onTap: ()async {
                if (formKey.currentState!.validate()) {
                    try  {

                  await  userProvider.loginAccount(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        context
                        
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Successfully Logged In')),
                      );
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => AuthNavigation(),));
                    } 
                    catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    }
                }
            },
            
          text: 'Sign In',
          borderRadius: 15,
          ),
             
                SizedBox(height: 5,),

              ],
            ),
          );
        
      
  }
}
