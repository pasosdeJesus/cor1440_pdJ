# encoding: UTF-8

require 'cor1440_gen/concerns/models/actividadpf'

module Cor1440Gen
  class Actividadpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Actividadpf

    belongs_to :heredade, class_name: 'Cor1440Gen::Actividadpf',
      foreign_key: :heredade_id, optional: true

    belongs_to :formulario, 
      class_name: 'Mr519Gen::Formulario',
      foreign_key: 'formulario_id', 
      optional: true

    flotante_localizado :valorfijohora

  end
end
