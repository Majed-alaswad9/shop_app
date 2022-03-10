import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:shop_app/shared/models/categories_model.dart';

import 'cubit/shop_layout_cubit.dart';
import 'cubit/shop_layout_state.dart';

class CategoriesLayout extends StatelessWidget {
  const CategoriesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutstate>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCategories(
                cubit.categoriesModel!.dataModel!.data[index], context),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemCount: cubit.categoriesModel!.dataModel!.data.length);
      },
    );
  }

  Widget buildCategories(DataModel? model, context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10), // Image border
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(50), // Image radius
                  child: CachedNetworkImage(
                    imageUrl: "${model!.image}",
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${model.name}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(MaterialCommunityIcons.arrow_right))
            ],
          ),
        ),
      );
}
