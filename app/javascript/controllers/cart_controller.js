import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['body']
  
  closeCart(){
    console.log("CartController");
    let shopping_cart_class_list = document.getElementsByClassName("shopping-cart")[0].classList;
    if(shopping_cart_class_list.contains("hidden")) {
      shopping_cart_class_list.remove("hidden");
    }else {
      shopping_cart_class_list.add("hidden");
    }
  }
}

