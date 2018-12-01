# A naive simple implementation of a strong_params style param
# validation thing. Currently all I care about is validating
# that only allowed params are set on a model. I'm not a fan
# of the Amber param validation framework, and it seems a bit
# broken currently.

def strong_params(params : JSON::Any, allowed_params : Hash(String, String))
  params = params.as_h
  permitted_params = {} of String => (String | Int32 | Float64)

  allowed_params.each do |param_key, database_key|
    if params[param_key].as_i?
      permitted_params[database_key] = params[param_key].as_i
    elsif params[param_key].as_f?
      permitted_params[database_key] = params[param_key].as_f
    elsif params[param_key].as_s?
      permitted_params[database_key] = params[param_key].as_s
    end
  end

  permitted_params
end
