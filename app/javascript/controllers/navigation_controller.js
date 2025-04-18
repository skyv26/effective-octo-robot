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
      // Check if the current path starts with the link path for patients
      if (currentPath.startsWith(linkPath)) {
        link.classList.add("active-nav")
      } else {
        link.classList.remove("active-nav")
      }
    })
  }
}
