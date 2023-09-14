import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recipe"
export default class extends Controller {
  connect() {
    console.log(this.element)
  }

  toggle_public(e) {
    const id = e.target.dataset.id
    const csrfToken = document.querySelector("[name='csrf-token']").content

    fetch(`/recipe/${id}/toggle_public`, {
        method: 'POST', 
        mode: 'cors', 
        cache: 'no-cache',
        credentials: 'same-origin',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({ public: e.target.checked }) // body data type must match "Content-Type" header
    })
    .then(response => response.json())
    .then(data => { alert(data.message) })
  }
}
