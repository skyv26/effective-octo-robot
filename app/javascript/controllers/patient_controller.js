// app/javascript/controllers/patient_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "modalContent", "modalTitle"]

  connect() {
    console.log("Patient controller connected")
  }

  new(event) {
    const id = event.currentTarget.dataset.id
    this.modalTitleTarget.textContent = "New Patient"
    fetch(`/patient/new`, { headers: { Accept: "text/vnd.turbo-stream.html" } })
      .then((r) => r.text())
      .then((html) => {
        this.modalContentTarget.innerHTML = html
        this.modalTarget.classList.remove("hidden")
        this.modalTarget.classList.add("flex")
      })
  }

  view(event) {
    const id = event.currentTarget.dataset.id
    this.modalTitleTarget.textContent = "Patient Details"
    fetch(`/patients/${id}`, { headers: { Accept: "text/vnd.turbo-stream.html" } })
      .then((r) => r.text())
      .then((html) => {
        this.modalContentTarget.innerHTML = html
        this.modalTarget.classList.remove("hidden")
        this.modalTarget.classList.add("flex")
      })
  }

  edit(event) {
    const id = event.currentTarget.dataset.id
    this.modalTitleTarget.textContent = "Edit Patient"
    fetch(`/patients/${id}/edit`, { headers: { Accept: "text/vnd.turbo-stream.html" } })
      .then((r) => r.text())
      .then((html) => {
        this.modalContentTarget.innerHTML = html
        this.modalTarget.classList.remove("hidden")
        this.modalTarget.classList.add("flex")
      })
  }

  closeModal() {
    this.modalTarget.classList.remove("flex")
    this.modalTarget.classList.add("hidden")
    this.modalContentTarget.innerHTML = ""
    this.modalTitleTarget.textContent = ""
  }
}
