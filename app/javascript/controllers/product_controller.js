import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  remove(){
    console.log("ProductController");
    
    this.sub_total();
    this.element.remove();
  }
  
  sub_total(){
    let sub_total = parseInt(document.getElementById("sub_total").innerText.split("$")[1])
    let total_element = parseInt(this.element.dataset.price);
    sub_total = sub_total - total_element
    document.getElementById("sub_total").innerText = '$' + sub_total
  }
}
