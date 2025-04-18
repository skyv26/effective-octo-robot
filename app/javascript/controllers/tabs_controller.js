import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "content"]

  connect() {
    this.showTab("profile")
  }

  switch(event) {
    const selected = event.currentTarget.dataset.tabsName
    this.showTab(selected)
  }

  showTab(name) {
    this.tabTargets.forEach(tab => {
      const isActive = tab.dataset.tabsName === name
      tab.classList.toggle("border-blue-500", isActive)
      tab.classList.toggle("text-blue-500", isActive)
      tab.classList.toggle("text-gray-600", !isActive)
    })

    this.contentTargets.forEach(content => {
      content.classList.toggle("hidden", content.dataset.tabsName !== name)
    })
  }
}
