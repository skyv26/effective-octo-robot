import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["modal", "loginBtn", "dashboardBtn"];

  connect() {
    console.log("Login Modal Controller connected!");
  }

  openModal() {
    this.modalTarget.classList.remove("hidden");
  }

  closeModal() {
    this.modalTarget.classList.add("hidden");
  }

  loginSuccess() {
    // Hide login button and show dashboard button after successful login
    this.loginBtnTarget.classList.add("hidden");
    this.dashboardBtnTarget.classList.remove("hidden");

    // Close the modal after login
    this.modalTarget.classList.add("hidden");
  }
}
