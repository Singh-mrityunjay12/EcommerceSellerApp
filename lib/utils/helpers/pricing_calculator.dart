// ignore: non_constant_identifier_names
class MPricingCalculator {
  MPricingCalculator._();

//Calculate Price based on tax and shipping

  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    double shippingCost = getShippingCost(productPrice, location);
    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  //calculate shipping cost
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(productPrice, location);
    return shippingCost.toStringAsFixed(2);
  }

  //calculate tax
  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    //Lookup the tax rate for the given location from a tax rate database or API
    //Return the Appropriate tax rate
    return 0.10; //Example tax rate is 10%
  }

  static double getShippingCost(double productPrice, String location) {
    //Lookup the tax rate for the given location using a shipping rate API
    //calculate the  shipping cost based on various factor like distance,weight etc
    if (productPrice == 0.0) {
      return 0.0;
    }
    return 5.00; //Example shipping cost of $5
  }
}
