import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['people', 'cart']

  connect() {
    var women_list = document.getElementsByClassName('women-list');
    var men_list = document.getElementsByClassName('men-list');
    var shopping_cart = document.getElementsByClassName('shopping-cart');

    toggle(this.peopleTargets[0], women_list);
    toggle(this.peopleTargets[1], men_list);
    toggle(this.cartTarget, shopping_cart);

    function toggle(target, element) {
      target.addEventListener("click", function(){

        if(element[0].classList.contains("hidden")){
          element[0].classList.remove("hidden")
        }else{
          element[0].classList.add("hidden")
        }
      })
    }
  }
}
