import 'package:get/get.dart';
import 'package:yearbook_maker/pages/admin/admin_edit_user/admin_edit_user.dart';
import 'package:yearbook_maker/pages/admin/admin_edit_user/admin_edit_user_controller.dart';
import 'package:yearbook_maker/pages/admin/admin_edit_yearbook/admin_edit_yearbook.dart';
import 'package:yearbook_maker/pages/admin/admin_edit_yearbook/admin_edit_yearbook_controller.dart';
import 'package:yearbook_maker/pages/admin/admin_homepage/admin_homepage.dart';
import 'package:yearbook_maker/pages/admin/admin_homepage/admin_homepage_controller.dart';
import 'package:yearbook_maker/pages/admin/admin_users_list/admin_users_list.dart';
import 'package:yearbook_maker/pages/admin/admin_users_list/admin_users_list_controller.dart';
import 'package:yearbook_maker/pages/admin/admin_yearbook_preview/admin_yearbook_preview.dart';
import 'package:yearbook_maker/pages/admin/admin_yearbook_preview/admin_yearbook_preview_controller.dart';
import 'package:yearbook_maker/pages/admin/admin_yearbook_students/admin_yearbook_students.dart';
import 'package:yearbook_maker/pages/admin/admin_yearbook_students/admin_yearbook_students_controller.dart';
import 'package:yearbook_maker/pages/admin/admin_yearbook_teachers/admin_yearbook_teachers.dart';
import 'package:yearbook_maker/pages/admin/admin_yearbook_teachers/admin_yearbook_teachers_controller.dart';
import 'package:yearbook_maker/pages/admin/admin_yearbooks_list/admin_yearbooks_list.dart';
import 'package:yearbook_maker/pages/admin/admin_yearbooks_list/admin_yearbooks_list_controller.dart';
import 'package:yearbook_maker/pages/login_screen/login_screen.dart';
import 'package:yearbook_maker/pages/login_screen/login_screen_controller.dart';
import 'package:yearbook_maker/pages/splash_screen/splash_screen.dart';
import 'package:yearbook_maker/pages/splash_screen/splash_screen_controller.dart';
import 'package:yearbook_maker/pages/user/user_edit_profile/user_edit_profile.dart';
import 'package:yearbook_maker/pages/user/user_edit_profile/user_edit_profile_controller.dart';
import 'package:yearbook_maker/pages/user/user_homepage/user_homepage.dart';
import 'package:yearbook_maker/pages/user/user_homepage/user_homepage_controller.dart';
import 'package:yearbook_maker/pages/user/user_users_list/user_users_list.dart';
import 'package:yearbook_maker/pages/user/user_users_list/user_users_list_controller.dart';
import 'package:yearbook_maker/pages/user/user_yearbooks_list/user_yearbooks_list.dart';
import 'package:yearbook_maker/pages/user/user_yearbooks_list/user_yearbooks_list_controller.dart';

abstract class Routes {
  static List<GetPage> getRoutes() {
    return [
      GetPage(
        name: '/splash_screen',
        page: () => SplashScreen(),
        binding: BindingsBuilder.put(() => SplashScreenController()),
      ),
      GetPage(
        name: '/login_screen',
        page: () => LoginScreen(),
        binding: BindingsBuilder.put(() => LoginScreenController()),
      ),
      GetPage(
        name: '/admin/homepage',
        page: () => AdminHomepage(),
        binding: BindingsBuilder.put(() => AdminHomepageController()),
      ),
      GetPage(
        name: '/admin/users_list',
        page: () => AdminUsersList(),
        binding: BindingsBuilder.put(() => AdminUsersListController()),
      ),
      GetPage(
        name: '/admin/edit_user/:id',
        page: () => AdminEditUser(),
        binding: BindingsBuilder.put(() => AdminEditUserController()),
      ),
      GetPage(
        name: '/admin/yearbooks_list',
        page: () => AdminYearbooksList(),
        binding: BindingsBuilder.put(() => AdminYearbooksListController()),
      ),
      GetPage(
        name: '/admin/edit_yearbook/:id',
        page: () => AdminEditYearbook(),
        binding: BindingsBuilder.put(() => AdminEditYearbookController()),
      ),
      GetPage(
        name: '/admin/yearbook_students/:id',
        page: () => AdminYearbookStudents(),
        binding: BindingsBuilder.put(() => AdminYearbookStudentsController()),
      ),
      GetPage(
        name: '/admin/yearbook_teachers/:id',
        page: () => AdminYearbookTeachers(),
        binding: BindingsBuilder.put(() => AdminYearbookTeachersController()),
      ),
      GetPage(
        name: '/admin/yearbook_preview/:id',
        page: () => AdminYearbookPreview(),
        binding: BindingsBuilder.put(() => AdminYearbookPreviewController()),
      ),
      GetPage(
        name: '/user/homepage',
        page: () => UserHomepage(),
        binding: BindingsBuilder.put(() => UserHomepageController()),
      ),
      GetPage(
        name: '/user/users_list',
        page: () => UserUsersList(),
        binding: BindingsBuilder.put(() => UserUsersListController()),
      ),
      GetPage(
        name: '/user/edit_profile',
        page: () => UserEditProfile(),
        binding: BindingsBuilder.put(() => UserEditProfileController()),
      ),
      GetPage(
        name: '/user/yearbooks_list',
        page: () => UserYearbooksList(),
        binding: BindingsBuilder.put(() => UserYearbooksListController()),
      ),
    ];
  }
}
