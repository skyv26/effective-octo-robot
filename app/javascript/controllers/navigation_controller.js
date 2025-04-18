// controllers/navigation_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link"]

  connect() {
    this.setActiveLink()

    window.addEventListener("turbo:load", () => {
      this.setActiveLink()
    })
  }

  setActiveLink() {
    const currentPath = window.location.pathname

    this.linkTargets.forEach(link => {
      const linkPath = new URL(link.href).pathname
      if (linkPath === currentPath) {
        link.classList.add("active-nav")
      } else {
        link.classList.remove("active-nav")
      }
    })
  }
}
