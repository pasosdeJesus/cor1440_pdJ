# encoding: UTF-8

require 'cor1440_gen/concerns/models/proyectofinanciero'

module Cor1440Gen
  class Proyectofinanciero < ActiveRecord::Base

    include Cor1440Gen::Concerns::Models::Proyectofinanciero
    include ApplicationHelper

    @current_usuario = nil
    attr_accessor :current_usuario

    flotante_localizado :monto
    flotante_localizado :valorhora

  end
end

