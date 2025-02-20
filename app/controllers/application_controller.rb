# frozen_string_literal: true

require "msip/application_controller"
class ApplicationController < Msip::ApplicationController
  # Sin definicion de autorizacion por ser utilidad

  protect_from_forgery with: :exception, prepend: true
end
