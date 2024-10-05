import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["", "container"]
  static values = {
    id: Number
  }
 
  clear() {
    this.element.reset();
    this.hideForm();
  }
  showForm(event){
    document.getElementById(event.target.id).addEventListener('click', function() {
      document.getElementById(`reply_form_${event.target.id.split('_')[2]}`).style.display = '';
      
    })
  }
  hideForm() {
    document.getElementById(`reply_form_${this.idValue}`).style.display = 'none';
  }
}