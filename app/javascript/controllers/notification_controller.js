import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.refresh()
    this.interval = setInterval(() => this.refresh(), 5000) // Refresh every 5 seconds
  }

  disconnect() {
    clearInterval(this.interval)
  }

  refresh() {
    fetch('/notifications/count')
      .then(response => response.json())
      .then(data => {
        if (data.count > 0) {
          this.countTarget.textContent = data.count
           // Ensure badge is shown
          this.countTarget.classList.remove('d-none')
        } else {
          // Hide badge if no notifications
          this.countTarget.classList.add('d-none')
        }
      })
  }


}
