import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['people', 'cart', 'sign_in', 'sign_up', 'logout']

  connect() {
    let women_list = document.getElementsByClassName('women-list');
    let men_list = document.getElementsByClassName('men-list');
    let shopping_cart = document.getElementsByClassName('shopping-cart');
    let form_login = document.getElementsByClassName('body-form-login');

    toggle(this.peopleTargets[0], women_list);
    toggle(this.peopleTargets[1], men_list);
    toggle(this.cartTarget, shopping_cart);
    this.targets.findTarget('sign_in') && toggle(this.sign_inTarget, form_login); // user signed in hidden link_to sign_in target

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
