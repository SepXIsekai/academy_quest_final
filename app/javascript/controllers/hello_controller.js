import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "text"]

  toggle() {
    const checked = this.checkboxTarget.checked

    // Toggle class line-through
    if (checked) {
      this.textTarget.classList.add("line-through", "text-gray-400")
    } else {
      this.textTarget.classList.remove("line-through", "text-gray-400")
    }

    // Submit the form to backend
    this.checkboxTarget.form.requestSubmit()
  }
}
