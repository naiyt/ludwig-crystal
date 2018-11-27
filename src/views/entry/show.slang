h1 Show Entry
p = entry.device
p = entry.date_string
p = entry.sgv
p = entry.delta
p = entry.direction
p = entry.filtered
p = entry.unfiltered
p = entry.rssi
p = entry.noise
p = entry.sys_time
p
  == link_to("back", "/entries", class: "btn btn-light btn-sm")
  == link_to("edit", "/entries/#{entry.id}/edit", class: "btn btn-success btn-sm")
  == link_to("delete", "/entries/#{entry.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
