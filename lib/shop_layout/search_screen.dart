import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/shop_layout/cubit/shop_layout_state.dart';
import 'package:shop_app/login_signup/palette.dart';

import 'package:shop_app/shared/models/search_model.dart';

class SearchScreen extends StatelessWidget {
    SearchScreen({Key? key}) : super(key: key);

   var searchController=TextEditingController();
   var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>ShopLayoutCubit(),
    child: BlocConsumer<ShopLayoutCubit,ShopLayoutstate>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    validator: validate,
                    onChanged: (String? value){
                      ShopLayoutCubit.get(context).searchData(text: value!);
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Palette.iconColor,
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.textColor1),
                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.textColor1),
                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      ),
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'search',
                      hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  if(state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 20,),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildListProduct(
                            cubit.searchModel!.data!.data![index],context),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        itemCount: cubit.searchModel!.data!.data!.length),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
    );
  }
   Widget buildListProduct(SearchProduct? model,context) => Container(
     padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
     height: 100,
     child: Row(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Stack(
           alignment: Alignment.bottomLeft,
           children: [
             Image(
               image: NetworkImage('${model!.image}'),
               width: 100,
               height: 100,
               fit: BoxFit.cover,
             ),
             if (model.discount != 0)
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
         const SizedBox(
           width: 10,
         ),
         Expanded(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text('${model.name}'),
               const Spacer(),
               Row(
                 children: [
                   Text(
                     '${model.price}',
                     style:const TextStyle(
                         fontSize: 17,
                         height: 1.5,
                         fontWeight: FontWeight.bold,
                         color: Colors.blue),
                   ),
                   const SizedBox(
                     width: 5,
                   ),
                 ],
               ),
             ],
           ),
         )
       ],
     ),
   );

  String? validate(String? value){
    if(value!=null)return null;
    return 'Enter text to search';
  }
}
