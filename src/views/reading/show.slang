h1 Show Reading
p = reading.value
p
  == link_to("back", "/readings", class: "btn btn-light btn-sm")
  == link_to("edit", "/readings/#{reading.id}/edit", class: "btn btn-success btn-sm")
  == link_to("delete", "/readings/#{reading.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
