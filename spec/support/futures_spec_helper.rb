def allow_basic(en=:en,lt="not_login_land")
  allow(I18n).to receive(:locale).and_return(en)
  allow_any_instance_of(ApplicationController).to receive(:switch_layout) {lt}
end