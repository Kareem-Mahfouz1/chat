import 'package:chat/constants.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:chat/core/widgets/custom_loading_indicator.dart';
import 'package:chat/features/settings/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kCardBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 80,
        width: double.infinity,
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserFailure) {
              return Center(child: Text(state.errMessage));
            } else if (state is UserSucess) {
              return Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(Assets.stockAvatar),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.user.displayName,
                        style: Styles.textStyle20
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        state.user.phoneNumber,
                        style: Styles.textStyle14Regular
                            .copyWith(color: Colors.black87),
                      ),
                    ],
                  )
                ],
              );
            } else if (state is UserLoading) {
              return const CustomLoadingIndicator();
            } else {
              return const Center(child: Text('initial'));
            }
          },
        ),
      ),
    );
  }
}
