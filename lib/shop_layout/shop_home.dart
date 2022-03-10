
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/shop_layout/cubit/shop_layout_state.dart';
import 'package:shop_app/shared/models/categories_model.dart';
import 'package:shop_app/shared/models/home_model.dart';
import 'package:shop_app/shared/const.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutstate>(
      listener: (context, state) {
        if(state is ShopChangeSuccessFavouriteState){
          if(!state.model.status!){
            showMsg(msg: state.model.message, color: colorMsg.error);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return ConditionalBuilder(
          condition:
              cubit.homeModuel != null && cubit.categoriesModel != null,
          builder: (context) =>
              homeProduct(cubit.homeModuel, cubit.categoriesModel, context),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget homeProduct(
      HomeModuel? moduel, CategoriesModel? categories, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: SizedBox.fromSize(
                child: CarouselSlider(
                    items: moduel!.data!.banners
                        .map((e) => CachedNetworkImage(
                      imageUrl: "${e.image}",width: double.infinity,fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                    ),)
                        .toList(),
                    options: CarouselOptions(
                        height: 250,
                        initialPage: 0,
                        viewportFraction: 1.0,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(seconds: 1))),
              ),
            )
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                 SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Categories',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildProduct(categories!.dataModel!.data[index],context),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                      itemCount: categories!.dataModel!.data.length),
                ),
                const SizedBox(
                  height: 15,
                ),
                 SizedBox(
                  width: double.infinity,
                  child: Text(
                    'New Products',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.7,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                  moduel.data!.product.length,
                  (index) =>
                      buildGrid(moduel.data!.product[index], context)))
        ],
      ),
    );
  }

  Widget buildGrid(Products? productmoduel,BuildContext? context) => Card(
    elevation: 5,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15)
    ),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                width: 150,height: 150,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.blueGrey.withOpacity(0.5),
                    width: 0,
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: "${productmoduel!.image}",
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                ),),
              if (productmoduel.discount != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.red,
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${productmoduel.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context!).textTheme.bodyText1,
                ),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    Text(
                      '${productmoduel.price.round()}',
                      style: const TextStyle(
                          fontSize: 17,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (productmoduel.discount != 0)
                      Text(
                        '${productmoduel.oldPrice.round()}',
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
                      backgroundColor: ShopLayoutCubit.get(context)
                          .favouriteMap[productmoduel.id]!
                          ? Colors.red
                          : Colors.grey[300],
                      child: IconButton(
                        onPressed: () {
                          ShopLayoutCubit.get(context).changeFavourite(productmoduel.id);
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

  Widget buildProduct(DataModel? model,context) => Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15), // Image border
            child: SizedBox.fromSize(
              size: const Size.fromRadius(50), // Image radius
              child: CachedNetworkImage(
                imageUrl: "${model!.image}",fit:BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          SizedBox(
              width: 97.0,
              child: Text(
                '${model.name}',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2,
              ))
        ],
      );
}
