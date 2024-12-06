

final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
final RegExp emailRegex = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

class AppStrings {
  // App Name
  static const String appName = "Books Online";

  // Titles
  // static const String titleHome = "Home";
  // static const String titleCategories = "Categories";
  // static const String titleMyOrders = "My orders";
  // static const String titleAccount = "Account";
  //
  // //Login
  // static const String loginSignup = "Login / Signup";
  // static const String sendVerification = "Send Verification Code";
  // static const String text91 = "+91";
  // static const String mobileNumber = "Mobile Number";
  // static const String byContinuingYou = "By continuing, you agree to the ";
  // static const String termsOfUse = "Terms of use";
  static const String amp = " & ";
  // static const String privacyPolicy = "Privacy policy";
  // static const String havingTrouble = "Having trouble? ";
  // static const String getHelp = "Get help";
  // static const String verifyOtp = "Verify OTP";
  // static const String verifyContinue = "Verify & Continue";
  // static const String oneTimePasswordSent = "One time password has been sent to your mobile number";
  // static const String enteredIncorrectNumber = "Entered an incorrect number?";
  // static const String changeNumber = "Change number";
  //
  // // register page
  // static const String sendOrderStatusOffersOnWhatsapp = "Send order status, offers on whatsapp";
  // static const String createAccount = "Create account";
  // static const String userName = "User name";
  // static const String email = "Email";
  // static const String gender = "Gender";
  // static const String male = "Male";
  // static const String female = "Female";
  // static const String registerAccount = "Register Account";
  // static const String exampleGmailCom = "example@gmail.com";
  //
  // //Home
  // static const String itemsInCart = "items in cart";
  static const String rupeeSymbol = "₹";
  // static const String yourLocation = "Your location";
  // static const String searchForFruits = "Search for Fruits & Vegetables";
  // static const String shopByCategories = "Shop by categories";
  // static const String viewAll = "View all";
  // static const String selectYourLocation = "Select your location";
  //
  // //address
  // static const String selectedLocation = "Selected Location";
  // static const String selectFromSavedAddress = "Select from saved address";
  // static const String change = "Change";
  // static const String oops = "Oops!";
  // static const String weAreCurrentlyNotDeliveringAtThisLocation = "We are currently not delivering at this location.";
  // static const String beBackSoon = "We will be back soon!";
  // static const String saveAndConfirm = "Save and Confirm";
  // static const String address = "Address";
  // static const String enterFullAddress = "Enter full address";
  // static const String pleaseSearchForYour = "Please search for your location";
  // static const String accurateLocation = "Accurate location will helps us deliver your order faster.";
  // static const String addNewAddress = "Add New Address";
  // static const String currentPincode = "Current pincode";
  // static const String enterDeliveryAddress = "Enter delivery address";
  // static const String landmark = "Landmark";
  // static const String nearbyLandmark = "Nearby landmark";
  // static const String cityState = "City / State";
  // static const String egChennaiTamilNadu = "Eg : Chennai, Tamil nadu";
  // static const String country = "Country";
  // static const String state = "State";
  // static const String city = "City";
  // static const String saveAddressAs = "Save address as";
  // static const String makeThisAsDefaultAddress = "Make this as default address";
  // static const String savedAddress = "Saved Address";
  // static const String defaultTxt = "Default";
  // static const String delete = "Delete";
  // static const String setAsDefault = "Set as default";
  // static const String or = "Or";
  // static const String confirmation = "Confirmation";
  // static const String doYouWantToSetThisAddressAsDefault = "Do you want to set this address as default?";
  // static const String deliveryLocation = "Delivery Location";
  // static const String forDeliveringPurposeWeNeed = "For delivering purpose we need to know your location";
  // static const String doYouWantToDeleteThisAddress = "Do you want to delete this address?";
  //
  //
  // //product
  // static const String outOfStock = "Out of stock";
  // static const String ourStoresAre = "Our stores are";
  // static const String closedNow = "Closed Now";
  // static const String add = "Add";
  // static const String off = "OFF";
  // static const String exploreCategories = "Explore categories";
  // static const String inclusiveOfAllTaxes = "Inclusive of all taxes";
  // static const String productDetails = "Product Details";
  // static const String description = "Description";
  // static const String seller = "Seller";
  // static const String manufactureBy = "Manufacture by";
  // static const String safetyInformation = "Safety Information";
  // static const String directUsage = "Direct Usage";
  // static const String benefits = "Benefits";
  // static const String addToCart = "Add to cart";
  //
  //
  // // Cart & Orders
  // static const String noOfItems = "No of items : ";
  // static const String orderId = "Order ID : ";
  // static const String orderPlaced = "Order placed";
  // static const String orderStatus = "Order status";
  // static const String totalAmount = "Total amount ";
  // static const String discountOnRs = "Discount amount";
  // static const String roundOff = "Round off";
  // static const String selectPaymentMode = "Select payment mode";
  // static const String online = "ONLINE";
  // static const String cod = "COD";
  // static const String loyaltyPointsRedeemed = "Loyalty points redeemed";
  // static const String searchLocationManually = "Search location manually";
  // static const String reviewItems = "Review Items";
  // static const String removeAll = "Remove all";
  // static const String addMoreItems = "Add more items";
  // static const String pinCode = "Pin code";
  // static const String deliveryAddress = "Delivery address";
  // static const String expressDelivery = "Express Delivery";
  // static const String yourOrderWillBeDeliveredWithin45Minutes = "Your Order Will Be Delivered Within 45 minutes";
  // static const String redeem = "Redeem";
  // static const String loyaltyPoints = "loyalty Points";
  // static const String youCanRedeemOnly10OfOrderTotal = "You can redeem only 10% of Order Total";
  // static const String availableBalance = "Available Balance";
  // static const String packingCharge = "Packing Charge";
  // static const String deliveryCharge = "Delivery charge";
  // static const String amountToPay = "Amount Payable";
  // static const String allPricesWillBeInclusiveOfTax = "All prices will be inclusive of tax*";
  // static const String yourCartIsEmpty = "Your cart is empty";
  // static const String looksLikeYouHaventAddedAnythingToYourCart = "Looks like you haven’t added anything to your cart";
  // static const String continueShopping = "Continue Shopping";
  // static const String changePaymentMode = "Change Payment Mode";
  // static const String payNow = "Pay Now";
  // static const String dac = "Dac : ";
  // static const String viewBillSummary = "View bill summary";
  // static const String doYouWantToClearCart = "Do you want to clear cart?";
  // static const String paymentCompleted = "Payment Completed";
  // static const String paymentSuccessMsg = "We've sent you an email with all the details of your order & remember you can track your order using this app!";
  // static const String confirmationMsg = "Do you want to proceed with the payment?";
  // static const String creditCardDebitCardNetBankingUpi = "Credit Card, Debit Card, Net Banking, UPI";
  // static const String payCashAtTheTimeOfDelivery = "Pay cash at the time of delivery";
  //
  // //order details
  // static const String trackMyOrder = "Track my order";
  // static const String deliveryAuthenticationCode = "Delivery authentication code : ";
  // static const String orderConfirmed = "Order confirmed";
  // static const String processing = "Processing";
  // static const String invoice = "Invoice";
  // static const String shipped = "Shipped";
  // static const String delivered = "Delivered";
  // static const String selectedItems = "Selected items";
  // static const String qty = "Qty : ";
  // static const String alternativeNumber = "Alternative Number : ";
  // static const String paymentSummary = "Payment summary";
  // static const String modeOfPayment = "Mode of payment :";
  //
  // // my account
  // static const String accountSetting = "Account Setting";
  // static const String edit = "Edit";
  // static const String myAddress = "My address";
  // static const String addAddressForDelivering = "Add address for delivering sweets";
  static const String customerCareNumber1 = "9876543210";
  static const String customerCareNumber2 = "9876543210";
  // static const String customerCareTimings = "Customer Care Timings";
  // static const String customerCareNumber = "Customer Care Number";
  static const String customerCareTime = "10.00 AM - 7.00 PM";
  // static const String aboutUs = "About us";
  // static const String rateUsOnPlayStore = "Rate us on play store";
  // static const String signOut = "Sign out";
  // static const String doYouWantToSignOut = "Do you want to sign out?";
  //
  //
  // static const String editYourPersonalInfo = "Edit your personal info like user name, Email address Mobile number, Age and Gender";
  // static const String yourPersonalInfo = "Your personal info";
  // static const String dateOfBirth = "Date of birth";
  // static const String selectDateOfBirth = "Select date of birth";
  // static const String update = "Update";
  // static const String termsAndCondition = "Terms and Condition";
  //
  // static const String loginContent1 = "Online Fruits & Vegetables Shop";
  // static const String loginContent2 = "Delicious Products";
  // static const String loginContent3 = "Offers & Discounts";
  // static const String loginCont1Msg1 = "Order your favorite Fruits & Vegetables, and";
  // static const String loginCont1Msg2 = "we’ll deliver to your door step.";
  // static const String loginCont2Msg1 = "Get ready again to enjoy the authentic taste of";
  // static const String loginCont2Msg2 = "our Indian Fruits & Vegetables.";
  // static const String loginCont3Msg1 = "Enjoy unlimited discounts and offers for";
  // static const String loginCont3Msg2 = "every order";
  // static const String viewCart = "View Cart";

}
