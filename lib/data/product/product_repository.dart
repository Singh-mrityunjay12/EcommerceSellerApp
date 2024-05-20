import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../feature/shop/model/product_model.dart';

import '../../utils/constants/enums.dart';
import '../../utils/exception/firebase_auth_exception.dart';
import '../../utils/exception/formate_exceptions.dart';
import '../../utils/exception/platform_exceptions.dart';
import '../firebase_storage_service/firebase_storage_service.dart';

//Repository for managing product-related data and operations
class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  //Firebase instance for database interactions.
  final _db = FirebaseFirestore.instance;
  //variable
  final isLoading = false.obs;

  //Get limited featured products

  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      print("///////////////////////////////////////right1");
      print(snapshot.docs);
      final list =
          snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      print("///////////////////////////////////////wrong");
      throw 'Something went wrong .Please try again';
    }
  }

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      print("///////////////////////////////////////AAAAAAAAAAAAAAAAAAAa");
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();
      print("///////////////////////////////////////right1");
      print(snapshot.docs);
      final list =
          snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      print("///////////////////////////////////////wrong");
      throw 'Something went wrong .Please try again';
    }
  }

  //Get Product Based on the Brand

  Future<List<ProductModel>> fetchProductByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      print("///////////////////////////////////////wrong");
      throw 'Something went wrong .Please try again';
    }
  }

  //Get Product Based on the Brand

  Future<List<ProductModel>> getFavoriteProducts(
      List<String> productsIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productsIds)
          .get();

      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      print("///////////////////////////////////////wrong");
      throw 'Something went wrong .Please try again';
    }
  }

  Future<List<ProductModel>> getProductsForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();

      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      print("///////////////////////////////////////wrong");
      throw 'Something went wrong .Please try again';
    }
  }

  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('CategoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategory')
              .where('CategoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['ProductId'] as String)
          .toList();

      //Query to get all documents where the productId is in the list of productIds .FieldPath.documentId to query document in collection
      final productQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      List<ProductModel> products = productQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      print("///////////////////////////////////////wrong");
      throw 'Something went wrong .Please try again';
    }
  }

  //Upload dummy data to the Cloud Firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      isLoading.value = true;
      //Upload all the products along with their images
      final storage = Get.put(MFirebaseStorageService());

      //Loop through each product
      for (var product in products) {
        //Get image data link from local asset
        final thumbnail =
            await storage.getImageDataFromAssets(product.thumbnail);
        //Upload URL to product thumbnail attribute
        final url = await storage.uploadImageData(
            'Products/Images', thumbnail, product.thumbnail.toString());
        //Assign URL to product.thumbnail attribute
        product.thumbnail = url;

        //Product list of images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrl = [];
          for (var image in product.images!) {
            //Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            //Upload image and get its URL
            final url = await storage.uploadImageData(
                'Products/Images', assetImage, image);

            //Assign URL to product.thumbnail attribute
            imageUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imageUrl);
        }

        //Upload Variation Images
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            //Get image data link from local assets
            final assetImage =
                await storage.getImageDataFromAssets(variation.image);
            //Upload images and get its URL
            final url = await storage.uploadImageData(
                "Products/Images", assetImage, variation.image);
            //Assign URL to variations.image attribute
            variation.image = url;
          }
        }
        //Store Product in Firebase
        await _db.collection("Products").doc(product.id).set(product.toJson());
      }
      isLoading.value = false;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }
}
