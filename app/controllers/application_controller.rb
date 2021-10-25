require 'sip/application_controller'
class ApplicationController < Sip::ApplicationController

  # Sin definicion de autorizacion por ser utilidad

  protect_from_forgery with: :exception
end

