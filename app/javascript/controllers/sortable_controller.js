// import { Controller } from "@hotwired/stimulus"
// import Sortable from "sortablejs"

// export default class extends Controller {
//   connect() {
//     this.sortable = Sortable.create(this.element, {
//       animation: 150,
//       onEnd: this.reorder.bind(this)
//     })
//   }

//   reorder(event) {
//     const ids = [...this.element.children].map(el => el.dataset.id)

//     fetch("/tasks/sort", {
//       method: "POST",
//       headers: {
//         "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
//         "Content-Type": "application/json"
//       },
//       body: JSON.stringify({ task_ids: ids })
//     })
//   }
// }
