- if reading.errors
  ul.errors
    - reading.errors.each do |error|
      li = error.to_s

== form(action: "/readings/#{reading.id.to_s}", method: reading.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == text_field(name: "value", value: reading.value, placeholder: "Value", class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/readings", class: "btn btn-light btn-sm")
