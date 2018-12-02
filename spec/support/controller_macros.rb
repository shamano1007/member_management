module ControllerMacros
  def expect_model(model, params, keys = nil)
    keys ||= params.keys
    keys.each { |key| expect(model.public_send(key)).to eq params[key] }
  end
end
