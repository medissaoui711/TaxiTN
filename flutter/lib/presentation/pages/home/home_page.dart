import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مرحباً! 👋',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'TaxiTN',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: AppTheme.primaryColor,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 30.h),
              
              // Services Grid
              Text(
                'الخدمات',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: 20.h),
              
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
                childAspectRatio: 1.2,
                children: [
                  _ServiceCard(
                    icon: '🚕',
                    title: 'طلب تاكسي',
                    color: const Color(0xFFE8F9EE),
                    onTap: () => context.push('/ride/booking'),
                  ),
                  _ServiceCard(
                    icon: '🍔',
                    title: 'توصيل طعام',
                    color: const Color(0xFFFFF3E0),
                    onTap: () => context.push('/restaurants'),
                  ),
                  _ServiceCard(
                    icon: '🛒',
                    title: 'بقالة',
                    color: const Color(0xFFE3F2FD),
                    onTap: () {},
                  ),
                  _ServiceCard(
                    icon: '💳',
                    title: 'المحفظة',
                    color: const Color(0xFFF3E5F5),
                    onTap: () {},
                  ),
                ],
              ),
              
              SizedBox(height: 30.h),
              
              // Recent Rides
              Text(
                'رحلات سابقة',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: 16.h),
              
              _RecentRideCard(
                from: 'شارع الحبيب بورقيبة',
                to: 'مطار قرطاج الدولي',
                date: 'اليوم, 10:30 ص',
                price: '25 TND',
                status: 'مكتملة',
              ),
              
              _RecentRideCard(
                from: 'المدينة العتيقة',
                to: 'مرسى الكل',
                date: 'أمس, 08:15 ص',
                price: '18 TND',
                status: 'مكتملة',
              ),
              
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              icon,
              style: TextStyle(fontSize: 40.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentRideCard extends StatelessWidget {
  final String from;
  final String to;
  final String date;
  final String price;
  final String status;

  const _RecentRideCard({
    required this.from,
    required this.to,
    required this.date,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppTheme.primaryColor,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    from,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Icon(
                Icons.arrow_downward,
                color: Colors.grey,
                size: 16.sp,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppTheme.errorColor,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    to,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  price,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
