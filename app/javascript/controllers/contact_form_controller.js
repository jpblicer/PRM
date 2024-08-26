import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["businessCard", "extractButton"]

  connect() {
    this.toggleExtractButton();
  }

  toggleExtractButton() {
    if (this.businessCardTarget.files.length > 0) {
      this.extractButtonTarget.style.display = 'block';
    } else {
      this.extractButtonTarget.style.display = 'none';
    }
  }

  change() {
    this.toggleExtractButton();
  }
}
