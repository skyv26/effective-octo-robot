// app/javascript/controllers/modal_controller.js

import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["modal"];

  open() {
    this.modalTarget.classList.remove("hidden");
  }

  close() {
    this.modalTarget.classList.add("hidden");
  }
}
