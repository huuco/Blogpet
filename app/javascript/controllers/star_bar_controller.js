import { Controller } from "@hotwired/stimulus"
let beforeValue = 0;

export default class extends Controller {
  static targets = ['star']
  static classes = ['hover']
  connect(){
    
  }

  reset() {
    this._clearToStar();
    this.element.children[0].reset()
  }

  enter(event){
    this._fillToStar(event.params.starIndex);
    this._setValueRating(event.params.starIndex);
  }

  rating(){
    this._fillToStar(event.params.starIndex);
    this._setValueRating(event.params.starIndex);
  }

  _setValueRating(star){
    document.getElementById("review_rating").value = star;
  }

  leave(event){
    if(event.type == 'pointerleave' && event.params.starIndex == "1"){
      // this.starTargets[0].classList.remove(this.hoverClass);
    }
  }
  _clickToStar(star){
    this.starTargets.forEach((target, index) => {
      if(index <= star){
        target.classList.add(this.hoverClass);
      }
    })
  }
  _fillToStar(star){
    // remove hover class before add

    if (star < beforeValue){
      this._clearToStar();
    }
    this.starTargets.slice(0,star).forEach((target, index) => {
      if(index <= star){
        target.classList.add(this.hoverClass);
        beforeValue = star
      }
    })
  }
  _clearToStar(){
    this.starTargets.forEach((target, index) => {
      target.classList.remove(this.hoverClass);
    })
  }
}
