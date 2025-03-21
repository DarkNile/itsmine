import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsmine/checkout/controllers/checkout_controller.dart';
import 'package:itsmine/checkout/view/checkout_tabs/order_summary_page.dart';
import 'package:itsmine/checkout/view/checkout_tabs/payment_method_page.dart';
import 'package:itsmine/checkout/view/checkout_tabs/shipping_address_page.dart';
import 'package:itsmine/checkout/view/checkout_tabs/shipping_method_page.dart';
import 'package:itsmine/checkout/view/payment_webview_screen.dart';
import 'package:itsmine/checkout/view/thank_you_screen.dart';
import 'package:itsmine/constants/colors.dart';
import 'package:itsmine/profile/controllers/profile_controller.dart';
import 'package:itsmine/widgets/custom_body_title.dart';
import 'package:itsmine/widgets/custom_header.dart';
import 'package:itsmine/widgets/custom_text.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>
    with TickerProviderStateMixin {
  final _checkoutController = Get.put(CheckoutController());
  final _profileController = Get.put(ProfileController());
  late TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _profileController.getAddress(context: context);
      _profileController.getCountries();
      _profileController.getZones();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _tabIndex == 3 ? null : Colors.white,
      appBar: CustomHeader(
        onTapBack: () {
          if (_tabIndex == 0) {
            Get.back();
          } else {
            setState(() {
              _tabIndex = _tabIndex - 1;
            });
            _tabController.animateTo(_tabIndex);
          }
        },
        title: _tabIndex == 0
            ? 'shippingAddress'.tr
            : _tabIndex == 1
                ? 'shippingMethod'.tr
                : _tabIndex == 2
                    ? 'paymentMethod'.tr
                    : 'orderSummary'.tr,
      ),
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: width,
                height: 1,
                color: darkGrey,
              ),
              IgnorePointer(
                child: TabBar(
                  indicator: const BoxDecoration(),
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  tabs: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _tabIndex > 0
                            ? jadeGreen
                            : _tabIndex == 0
                                ? almostBlack
                                : Colors.white,
                        border: _tabIndex == 0 || _tabIndex > 0
                            ? null
                            : Border.all(color: darkGrey),
                      ),
                      child: _tabIndex > 0
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                          : CustomText(
                              text: '1',
                              textAlign: TextAlign.center,
                              color: _tabIndex == 0 ? Colors.white : warmGrey,
                            ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _tabIndex > 1
                            ? jadeGreen
                            : _tabIndex == 1
                                ? almostBlack
                                : Colors.white,
                        border: _tabIndex == 1 || _tabIndex > 1
                            ? null
                            : Border.all(color: darkGrey),
                      ),
                      child: _tabIndex > 1
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                          : CustomText(
                              text: '2',
                              textAlign: TextAlign.center,
                              color: _tabIndex == 1 ? Colors.white : warmGrey,
                            ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _tabIndex > 2
                            ? jadeGreen
                            : _tabIndex == 2
                                ? almostBlack
                                : Colors.white,
                        border: _tabIndex == 2 || _tabIndex > 2
                            ? null
                            : Border.all(color: darkGrey),
                      ),
                      child: _tabIndex > 2
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                          : CustomText(
                              text: '3',
                              textAlign: TextAlign.center,
                              color: _tabIndex == 2 ? Colors.white : warmGrey,
                            ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _tabIndex > 3
                            ? jadeGreen
                            : _tabIndex == 3
                                ? almostBlack
                                : Colors.white,
                        border: _tabIndex == 3 || _tabIndex > 3
                            ? null
                            : Border.all(color: darkGrey),
                      ),
                      child: _tabIndex > 3
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                          : CustomText(
                              text: '4',
                              textAlign: TextAlign.center,
                              color: _tabIndex == 3 ? Colors.white : warmGrey,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomBodyTitle(
            title: _tabIndex == 0
                ? 'shippingAddress'.tr
                : _tabIndex == 1
                    ? 'shippingMethod'.tr
                    : _tabIndex == 2
                        ? 'paymentMethod'.tr
                        : 'orderSummary'.tr,
          ),
          if (_tabIndex != 3)
            const SizedBox(
              height: 16,
            ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                Obx(() {
                  if (_profileController.isAddressLoading.value ||
                      _profileController.isCountriesLoading.value ||
                      _profileController.isZonesLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ShippingAddressPage(
                    checkoutController: _checkoutController,
                    profileController: _profileController,
                    onNextTap: (checkedIndex) async {
                      final isSuccess =
                          await _checkoutController.addShippingAddress(
                        context: context,
                        addressId: int.parse(
                          _profileController.addresses[checkedIndex].id,
                        ),
                      );
                      if (isSuccess) {
                        if (context.mounted) {
                          _checkoutController.getShippingMethods(
                              context: context);
                        }
                        setState(() {
                          _tabIndex = 1;
                        });
                        _tabController.animateTo(1);
                      }
                    },
                  );
                }),
                Obx(() {
                  if (_checkoutController.isShippingMethodsLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ShippingMethodPage(
                    checkoutController: _checkoutController,
                    onNextTap: (checkedIndex) async {
                      final isSuccess =
                          await _checkoutController.addShippingMethod(
                        context: context,
                        shippingMethodCode: _checkoutController
                            .shippingMethods[checkedIndex].quote.first.code,
                      );
                      if (isSuccess) {
                        if (context.mounted) {
                          _checkoutController.getPaymentMethods(
                              context: context);
                        }
                        setState(() {
                          _tabIndex = 2;
                        });
                        _tabController.animateTo(2);
                      }
                    },
                  );
                }),
                Obx(() {
                  if (_checkoutController.isPaymentMethodsLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return PaymentMethodPage(
                      checkoutController: _checkoutController,
                      onNextTap: (checkedIndex) async {
                        final isSuccess =
                            await _checkoutController.addPaymentMethod(
                          context: context,
                          paymentMethodCode: _checkoutController
                              .paymentMethods[checkedIndex].code,
                        );
                        if (isSuccess) {
                          if (context.mounted) {
                            _checkoutController.confirmOrder(context: context);
                          }
                          setState(() {
                            _tabIndex = 3;
                          });
                          _tabController.animateTo(3);
                        }
                      });
                }),
                Obx(() {
                  if (_checkoutController.isConfirmOrderLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return OrderSummaryPage(
                    checkoutController: _checkoutController,
                    onEditPurchasesTap: () {
                      Get.back();
                    },
                    onEditAddressTap: () {
                      setState(() {
                        _tabIndex = 0;
                      });
                      _tabController.animateTo(0);
                    },
                    onEditShippingTap: () {
                      setState(() {
                        _tabIndex = 1;
                      });
                      _tabController.animateTo(1);
                    },
                    onEditPaymentTap: () {
                      setState(() {
                        _tabIndex = 2;
                      });
                      _tabController.animateTo(2);
                    },
                    onConfirmOrderTap: () async {
                      if (_checkoutController.order!.paymentCode! ==
                          'payfort_fort') {
                        Get.to(() => PaymentWebviewScreen(
                              orderId: _checkoutController.order!.orderId!,
                              email: _checkoutController.order!.email!,
                              checkoutController: _checkoutController,
                            ));
                      } else {
                        final isSuccess =
                            await _checkoutController.saveOrderToDatabase();
                        if (isSuccess) {
                          Get.off(() => ThankYouScreen(
                                orderId: _checkoutController.order!.orderId!,
                                email: _checkoutController.order!.email!,
                              ));
                        }
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
