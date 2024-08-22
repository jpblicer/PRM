import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navigation"
export default class extends Controller {
  static targets = ["addMenu", "icon", "navbar", 'title']
  connect() {
  }

  toggleMenu(event) {
    event.preventDefault();
    this.iconTarget.classList.toggle('rotate-icon');
    this.addMenuTarget.classList.toggle('show');
    this.navbarTarget.classList.toggle('no-shadow');
    this.titleTarget.classList.toggle('hidden');
  }
}
