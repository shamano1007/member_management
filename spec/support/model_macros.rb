module ModelMacros
  def expect_model(model, params, keys)
    keys.each { |key| expect(model.public_send(key)).to eq params[key] }
  end
end
