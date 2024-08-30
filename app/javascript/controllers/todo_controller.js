import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todo"
export default class extends Controller {
  submit() {
    // this.element.submit()
    // Turbo.navigator.submitForm(this.element)
  }
}
