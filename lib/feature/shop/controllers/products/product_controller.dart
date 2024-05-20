import 'package:get/get.dart';

import '../../../../common/widgets/loaders/loadders.dart';
import '../../../../data/product/product_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../model/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      //Show loader while loadings Product

      print("///////////////////////////////////////absc1234");
      isLoading.value = true;
      print("///////////////////////////////////////1234567");

      //Fetch Products
      final products = await productRepository.getFeaturedProducts();
      print("///////////////////////////////////////78654678");

      //Assign Products
      featuredProducts.assignAll(products);
      print("///////////////////////////////////////nnnnnnnnnnnnnnnnn");
    } catch (e) {
      MLoader.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      //Fetch Products
      final products = await productRepository.getAllFeaturedProducts();

      return products;
    } catch (e) {
      MLoader.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }
  //Get the product price or price range for variations.

  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;
    //If no variations exist,return the simple price or sale price
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      //Calculate the smallest and largest prices among variations

      for (var variation in product.productVariations!) {
        //Determine the price to consider(sale price if available ,otherwise regular price)
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        //update smallest and largest prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      //if smallest and largest prices are the same, return single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        //OtherWise ,return a price range
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  //Calculate Discount Percentage

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) {
      return null;
    }
    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  //Check Product Stock status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
