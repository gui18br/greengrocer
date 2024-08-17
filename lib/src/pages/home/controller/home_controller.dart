import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/repository/home_repository.dart';
import 'package:greengrocer/src/pages/home/result/home_result.dart';
import 'package:greengrocer/src/services/utils_service.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final homeRepository = HomeRepository();
  final utilsServices = UtilsServices();

  bool isCategoryLoading = false;
  bool isProductLoading = true;
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;
  List<ItemModel> get allProducts => currentCategory?.items ?? [];

  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) return true;

    return currentCategory!.pagination * itemsPerPage > allProducts.length;
  }

  void setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();

    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();

    // if (currentCategory!.items.isNotEmpty) return;

    getAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoading(true, isProduct: true);
    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();

    setLoading(false, isProduct: false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);

        if (allCategories.isEmpty) return;

        selectCategory(allCategories.first);
      },
      error: (msg) {
        utilsServices.showToast(
          message: msg,
          isError: true,
        );
      },
    );
  }

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isProduct: true);
    }

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      "ItemsPerPage": itemsPerPage,
    };

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);

    setLoading(false);

    result.when(
      success: (data) {
        currentCategory!.items = data;
      },
      error: (msg) {
        utilsServices.showToast(message: msg, isError: true);
      },
    );
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;

    getAllProducts(canLoad: false);
  }
}
