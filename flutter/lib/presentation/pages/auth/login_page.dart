import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);
    
    // TODO: Implement actual login logic
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() => _isLoading = false);
    
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60.h),
              
              // Logo
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Center(
                  child: Text(
                    '🚕',
                    style: TextStyle(fontSize: 50.sp),
                  ),
                ),
              ),
              
              SizedBox(height: 30.h),
              
              // Title
              Text(
                'تسجيل الدخول',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: 8.h),
              
              Text(
                'أدخل رقم هاتفك للمتابعة',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
              
              SizedBox(height: 40.h),
              
              // Phone Field
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'رقم الهاتف',
                  prefixIcon: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '🇹🇳',
                          style: TextStyle(fontSize: 24.sp),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '+216',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          width: 1,
                          height: 24.h,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'كلمة المرور',
                  prefixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppTheme.textHintColor,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // Login Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('تسجيل الدخول'),
                ),
              ),
              
              SizedBox(height: 20.h),
              
              // Forgot Password
              TextButton(
                onPressed: () {},
                child: const Text('نسيت كلمة المرور؟'),
              ),
              
              SizedBox(height: 30.h),
              
              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ليس لديك حساب؟',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () => context.push('/register'),
                    child: const Text('سجل الآن'),
                  ),
                ],
              ),
              
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
