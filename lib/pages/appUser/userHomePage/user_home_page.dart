import 'package:app_book/manage/controllers/book_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../manage/controllers/slider_controller.dart';
import '../../../models/book_model.dart';
import '../../../models/slider.dart';
import '../../../widgets/item_featured_book.dart';
import '../../../widgets/item_user_book.dart';

class UserHomePage extends GetView<BookController> {
  UserHomePage({super.key});
  final SliderController sliderController = Get.put(SliderController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            children: [
              Icon(
                Icons.book,
                size: 35,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Home Page",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Hello: ${controller.userInfo.userName}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  controller.transToSearchPage();
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 15),
                      Icon(Icons.search),
                      Text(
                        "Search Your Book",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // InkWell(
              //   onTap: controller.transToSearchPage,
              //   child: SearchBook(
              //     contentSearch: "Search your book",
              //     icon: Icons.search,
              //   ),
              // ),
              const SizedBox(height: 10),
              Text(
                "Sliders",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Obx(() {
                List<SliderImage> sliders = sliderController.sliderImages;
                return CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                  ),
                  items: sliders.map((slider) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.network(
                              slider.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              }),
              const SizedBox(height: 20),
              Text(
                "Featured Book",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              Obx(
                () {
                  return AspectRatio(
                    aspectRatio: 1 / 0.8,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container(
                          width: 20,
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.state.featuredBooks.length,
                      itemBuilder: (context, index) {
                        Book book = controller.state.featuredBooks[index];
                        return InkWell(
                          onTap: () {
                            controller.transToDetailBook(book);
                          },
                          child: AspectRatio(
                            aspectRatio: 1 / 1.5,
                            child: ItemFeaturedBook(
                              idCategory: book.idCategory,
                              bookName: book.bookName,
                              authorName: book.authorName,
                              desc: book.desc,
                              idBook: book.id,
                              image: book.photoUrl,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Text(
                "Popular Book",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              Obx(
                () => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1 / 1.9,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.state.listBook.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<Book> listBook = controller.state.listBook;
                    return InkWell(
                      onTap: () {
                        controller.transToDetailBook(listBook[index]);
                      },
                      child: ItemUserBook(
                        idCategory: listBook[index].idCategory,
                        bookName: listBook[index].bookName,
                        authorName: listBook[index].authorName,
                        desc: listBook[index].desc,
                        idBook: listBook[index].id,
                        image: listBook[index].photoUrl,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
