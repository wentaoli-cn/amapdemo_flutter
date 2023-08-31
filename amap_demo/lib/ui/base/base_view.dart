import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class BaseView<C extends GetxController> extends GetView<C> {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<C>(
      builder: (controller) => builder(
        context,
        controller,
      ),
      init: controller,
      initState: initState,
      dispose: dispose,
      didChangeDependencies: didChangeDependencies,
      didUpdateWidget: didUpdateWidget,
    );
  }

  @protected
  Widget builder(BuildContext context, C controller);

  @protected
  void initState(GetBuilderState<C> state) {}

  @protected
  void dispose(GetBuilderState<C> state) {}

  @protected
  void didChangeDependencies(GetBuilderState<C> state) {}

  @protected
  void didUpdateWidget(GetBuilder oldWidget, GetBuilderState<C> state) {}
}
