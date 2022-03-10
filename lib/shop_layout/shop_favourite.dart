import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/const.dart';
import 'package:shop_app/shared/models/favourite_model.dart';
import 'cubit/shop_layout_cubit.dart';
import 'cubit/shop_layout_state.dart';

class FavoriteLayout extends StatelessWidget {
  const FavoriteLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutstate>(
      listener: (context, state) {
        if (state is ShopChangeSuccessFavouriteState) {
          if (!state.model.status!) {
            showMsg(msg: state.model.message, color: colorMsg.error);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return ConditionalBuilder(
            condition: state is! ShopLoadingFavourtieSuccessesState,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildListProduct(
                    cubit.model!.dataFavourite!.data![index].dataProduct,
                    context),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 30,
                    ),
                itemCount: cubit.model!.dataFavourite!.data!.length),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget buildListProduct(Product? model, context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15), // Image border
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
                if (model.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${model.name}',maxLines: 2,overflow: TextOverflow.ellipsis,),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: const TextStyle(
                            fontSize: 17,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice}',
                          style: const TextStyle(
                              fontSize: 13,
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            ShopLayoutCubit.get(context).favouriteMap[model.id]!
                                ? Colors.red
                                : Colors.grey[300],
                        child: IconButton(
                          onPressed: () {
                            ShopLayoutCubit.get(context)
                                .changeFavourite(model.id);
                          },
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 19,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
