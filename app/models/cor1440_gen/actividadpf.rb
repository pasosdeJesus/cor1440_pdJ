# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividadpf"

module Cor1440Gen
  class Actividadpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Actividadpf

    belongs_to :heredade,
      class_name: "Cor1440Gen::Actividadpf",
      optional: true

    belongs_to :formulario,
      class_name: "Mr519Gen::Formulario",
      optional: true

    flotante_localizado :valorfijohora
  end
end
