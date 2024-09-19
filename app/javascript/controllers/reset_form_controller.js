import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  cancel(event) {
    event.preventDefault()
    this.element.reset()
    this.element.closest('.reply-form-container').innerHTML = ''
  }
}