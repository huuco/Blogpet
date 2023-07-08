import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  addToCart(){
    console.log("ItemController");

    // document.getElementsByClassName('shopping-cart')[0].classList.remove('hidden');
  }
}
