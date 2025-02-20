# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/usuarios_controller"

class UsuariosController < Msip::ModelosController
  # Sin definicion de autorización por ser requerida por no autenticados

  include Cor1440Gen::Concerns::Controllers::UsuariosController
end
