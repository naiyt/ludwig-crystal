.row
  .col-sm-11
    h2 Readings
  .col-sm-1
    a.btn.btn-success.btn-sm href="/readings/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th Value
        th Actions
    tbody
      - readings.each do |reading|
        tr
          td = reading.value
          td
            span
              == link_to("read", "/readings/#{reading.id}", class: "btn btn-primary btn-sm")
              == link_to("edit", "/readings/#{reading.id}/edit", class: "btn btn-success btn-sm")
              == link_to("delete", "/readings/#{ reading.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
