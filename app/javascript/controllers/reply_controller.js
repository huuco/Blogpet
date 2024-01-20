import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  showForm(event){
    let comment_reply_id = document.getElementById("comment_reply_" + event.target.dataset.commentId)
    if(comment_reply_id.classList.contains("hidden")) {
      comment_reply_id.classList.remove("hidden")
    }else {
      comment_reply_id.classList.add("hidden")
    }
  }
}
