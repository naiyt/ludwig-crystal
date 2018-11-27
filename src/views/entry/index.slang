.row
  .col-sm-11
    h2 Entries
  .col-sm-1
    a.btn.btn-success.btn-sm href="/entries/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th Device
        th Date_string
        th Sgv
        th Delta
        th Direction
        th Filtered
        th Unfiltered
        th Rssi
        th Noise
        th Sys_time
        th Actions
    tbody
      - entries.each do |entry|
        tr
          td = entry.device
          td = entry.date_string
          td = entry.sgv
          td = entry.delta
          td = entry.direction
          td = entry.filtered
          td = entry.unfiltered
          td = entry.rssi
          td = entry.noise
          td = entry.sys_time
          td
            span
              == link_to("read", "/entries/#{entry.id}", class: "btn btn-primary btn-sm")
              == link_to("edit", "/entries/#{entry.id}/edit", class: "btn btn-success btn-sm")
              == link_to("delete", "/entries/#{ entry.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
