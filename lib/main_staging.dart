// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:blog_post/app/app.dart';
import 'package:blog_post/bootstrap.dart';
import 'package:blog_post/utils/_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlogConfig(
    values: BlogValues(
      baseUrl: 'https://621ff28ece99a7de194c95b9.mockapi.io',
    ),
  );
  bootstrap(
    () => MultiBlocProvider(
      providers: Singletons.registerCubit(),
      child: const App(),
    ),
  );
}
