// controllers/navigation_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link"]

  navigate(event) {
    event.preventDefault()

    // Remove active-nav from all links
    this.linkTargets.forEach(link => link.classList.remove("active-nav"))

    // Add active-nav to the clicked link
    event.currentTarget.classList.add("active-nav")

    // Dynamically load the href into the turbo-frame
    const url = event.currentTarget.getAttribute("href")
    document.getElementById("main-content").src = url
  }
}
