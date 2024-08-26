import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select";
import { post } from '@rails/request.js'

// Connects to data-controller="tom-select"
export default class extends Controller {
  static values = { options: Object }
  static targets = ['item']

  connect() {
    new TomSelect(
      this.element,
      {
        create: (input, callback) => {
          if(prompt('New Company', input)) {
            post(`/companies?name=${input}`, { responseKind: 'turbo-stream' })
          } else {
            callback(false)
          }
        },
        optionClass: 'option',
	      itemClass: 'item',
      }
    );
  }
  itemTargetConnected(element) {
    console.log("Item target called")
    this.element.tomselect.sync()
    this.element.tomselect.setValue(element.value)
  }
}
