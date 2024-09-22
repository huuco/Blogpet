import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['star']
  static classes = ['hover']
  static values = { rating: Number }

  connect() {
    this.ratingValue = 0
  }

  reset() {
    this._clearStars()
    this.element.querySelector('form').reset()
  }

  enter({ params: { starIndex } }) {
    this._fillStars(starIndex)
    this._setRating(starIndex)
  }

  rating({ params: { starIndex } }) {
    this._fillStars(starIndex)
    this._setRating(starIndex)
  }

  leave({ type, params: { starIndex } }) {
    if (type === 'pointerleave' && starIndex === "1") {
      this._fillStars(this.ratingValue)
    }
  }

  _setRating(star) {
    this.ratingValue = parseInt(star)
    this.element.querySelector("#review_rating").value = this.ratingValue
  }

  _fillStars(star) {
    const starIndex = parseInt(star)
    this.starTargets.forEach((target, index) => {
      target.classList.toggle(this.hoverClass, index < starIndex)
    })
  }

  _clearStars() {
    this.starTargets.forEach(target => target.classList.remove(this.hoverClass))
  }
}
