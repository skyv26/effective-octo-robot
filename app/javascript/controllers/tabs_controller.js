// app/javascript/controllers/tabs_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "content"]

  connect() {
    const urlParams = new URLSearchParams(window.location.search)
    const tabName = urlParams.get("tab") || this.tabTargets[0].dataset.tabsName

    this.showTab(tabName)
  }

  switch(event) {
    const tabName = event.currentTarget.dataset.tabsName

    this.showTab(tabName)
    this.updateQuery(tabName)
  }

  showTab(name) {
    this.tabTargets.forEach(tab => {
      tab.classList.toggle("border-blue-500", tab.dataset.tabsName === name)
      tab.classList.toggle("text-blue-500", tab.dataset.tabsName === name)
      tab.classList.toggle("text-gray-600", tab.dataset.tabsName !== name)
    })

    this.contentTargets.forEach(content => {
      content.classList.toggle("hidden", content.dataset.tabsName !== name)
    })
  }

  updateQuery(name) {
    const url = new URL(window.location)
    url.searchParams.set("tab", name)
    history.replaceState(null, "", url)
  }
}
