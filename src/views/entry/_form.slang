- if entry.errors
  ul.errors
    - entry.errors.each do |error|
      li = error.to_s

== form(action: "/entries/#{entry.id.to_s}", method: entry.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == text_field(name: "device", value: entry.device, placeholder: "Device", class: "form-control")
  .form-group
    == text_field(name: "date_string", value: entry.date_string, placeholder: "Date_string", class: "form-control")
  .form-group
    == text_field(name: "sgv", value: entry.sgv, placeholder: "Sgv", class: "form-control")
  .form-group
    == text_field(name: "delta", value: entry.delta, placeholder: "Delta", class: "form-control")
  .form-group
    == text_field(name: "direction", value: entry.direction, placeholder: "Direction", class: "form-control")
  .form-group
    == text_field(name: "filtered", value: entry.filtered, placeholder: "Filtered", class: "form-control")
  .form-group
    == text_field(name: "unfiltered", value: entry.unfiltered, placeholder: "Unfiltered", class: "form-control")
  .form-group
    == text_field(name: "rssi", value: entry.rssi, placeholder: "Rssi", class: "form-control")
  .form-group
    == text_field(name: "noise", value: entry.noise, placeholder: "Noise", class: "form-control")
  .form-group
    == text_field(name: "sys_time", value: entry.sys_time, placeholder: "Sys_time", class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/entries", class: "btn btn-light btn-sm")
