// app/javascript/controllers/sidebar_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "backdrop", "icon"]
  open = false

  toggle() {
    this.open = !this.open

    // Toggle menu visibility
    this.menuTarget.classList.toggle("-translate-x-full")
    this.menuTarget.classList.toggle("translate-x-0")

    // Toggle backdrop
    this.backdropTarget.classList.toggle("hidden")

    // Swap hamburger ↔ X
    this.iconTarget.innerHTML = this.open
      ? `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>`
      : `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>`
  }
}
