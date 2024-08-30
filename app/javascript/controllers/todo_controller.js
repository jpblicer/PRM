import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todo"
export default class extends Controller {
  submit(event) {
    event.preventDefault();
    this.element.requestSubmit();
    // this.element.submit()
    // Turbo.navigator.submitForm(this.element)

    //  // Reload the page after form submission
    //  this.element.addEventListener("ajax:success", () => {
    //   window.location.reload(); // Reload the entire page
    // });
  }
}
