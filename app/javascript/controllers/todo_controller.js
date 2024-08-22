import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todo"
export default class extends Controller {
  static targets = ["checkbox", "text"]

  toggle(event) {
    const checked = event.target.checked
    if (checked) {
      this.textTarget.classList.add("text-decoration-line-through")
    } else {
      this.textTarget.classList.remove("text-decoration-line-through")
    }
  }
}
