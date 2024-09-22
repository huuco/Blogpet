import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  cancel(event) {
    event.preventDefault()
    this.element.reset();
    const replyFormContainer = this.element.closest('.reply-form-container');
    if (replyFormContainer) {
      replyFormContainer.innerHTML = '';
    }
  }


  clear() {
    this.element.reset();
  }
}