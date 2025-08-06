// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:project_2/Constants/app_color.dart';
import 'package:project_2/Controllers/Auth%20Provider/auth_provider.dart';
import 'package:project_2/Utilities/form_validators.dart';
import 'package:project_2/View/Home%20screen/home_screen.dart';
import 'package:project_2/Widgets/custom_button.dart';
import 'package:project_2/Widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';


class LoginRegistration extends StatelessWidget {
  const LoginRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    FormValidators formValidators=FormValidators();
    final userProvider = Provider.of<AuthProvider>(context, listen: false);

    return  Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                // TextFormField(
                //   controller: emailController,
                //   decoration: const InputDecoration(
                //     label: Text('Email'),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(15)),
                //     ),
                //   ),
                //   validator: (value) =>
                //       value == null || value.isEmpty ? 'Enter email' : null,
                // ),
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
                // TextFormField(
                //   controller: passwordController,
                //   decoration: const InputDecoration(
                //     label: Text('Password'),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(15)),
                //     ),
                //   ),
                //   obscureText: true,
                //   validator: (value) =>
                //       value == null || value.length < 6
                //           ? 'Password must be at least 6 characters'
                //           : null,
                // ),
                const SizedBox(height: 30),
                CustomButton(
            width: 400,
            onTap: ()async {
                if (formKey.currentState!.validate()) {
                    try  {
                  await  userProvider.loginAccount(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Successfully Logged In')),
                      );
                      Navigator.of(context).push(MaterialPageRoute(builder:(context) => HomeScreen(),));
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
                // ElevatedButton(
                //   onPressed: () async {
                //     if (formKey.currentState!.validate()) {
                //       try {
                //         await Provider.of<AuthProvider>(
                //           context,
                //           listen: false,
                //         ).loginAccount(
                //           emailController.text.trim(),
                //           passwordController.text.trim(),
                //         );
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           const SnackBar(content: Text('Account created')),
                //         );
                //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                //         // Optionally navigate to home
                //       } catch (e) {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(content: Text('Error: ${e.toString()}')),
                //         );
                //       }
                //     }
                //   },
                //   child: const Text('Submit'),
                // ),
                SizedBox(height: 10,),

              //           InkWell(
              // onTap: () {
                
              //   Navigator.of(context).push(MaterialPageRoute(builder:(context) => SignupMain(),));
              // },
              // child: Text('Create a new  acoount Sign Up'))
              ],
            ),
          );
        
      
  }
}
