// Mocks generated by Mockito 5.0.15 from annotations
// in faturas/test/flow/payment_options_flow.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:faturas/Manager/network_manager.dart' as _i2;
import 'package:faturas/payment_options/model/payment_option/payment_option.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeUri_0 extends _i1.Fake implements Uri {}

/// A class which mocks [NetworkManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkManager extends _i1.Mock implements _i2.NetworkManager {
  MockNetworkManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Uri get url =>
      (super.noSuchMethod(Invocation.getter(#url), returnValue: _FakeUri_0())
          as Uri);
  @override
  _i3.Future<List<_i4.PaymentOption>> getData() =>
      (super.noSuchMethod(Invocation.method(#getData, []),
              returnValue:
                  Future<List<_i4.PaymentOption>>.value(<_i4.PaymentOption>[]))
          as _i3.Future<List<_i4.PaymentOption>>);
  @override
  String toString() => super.toString();
}