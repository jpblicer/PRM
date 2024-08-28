import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-arrow"
export default class extends Controller {
  static targets = ["icon"]

  toggle() {
    const icon = this.iconTarget;

    if (icon.classList.contains('fa-chevron-down')) {
      icon.classList.remove('fa-chevron-down');
      icon.classList.add('fa-chevron-up');
    } else {
      icon.classList.remove('fa-chevron-up');
      icon.classList.add('fa-chevron-down');
    }
  }
}
