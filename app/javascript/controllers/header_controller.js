import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['people', 'cart', 'sign_in']

  connect() {
    let women_list = document.getElementsByClassName('women-list');
    let men_list = document.getElementsByClassName('men-list');
    let shopping_cart = document.getElementsByClassName('shopping-cart');
    let form_login = document.getElementsByClassName('body-form-login');

    toggle(this.peopleTargets[0], women_list);
    toggle(this.peopleTargets[1], men_list);
    toggle(this.cartTarget, shopping_cart);
    toggle(this.sign_inTarget, form_login);

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
