# encoding: UTF-8

require 'cor1440_gen/concerns/models/actividadpf'

module Cor1440Gen
  class Actividadpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Actividadpf

    belongs_to :implicaactividadpf, class_name: 'Cor1440Gen::Actividadpf',
      foreign_key: :implicaactividadpf_id, optional: true

    flotante_localizado :valorfijohora

  end
end
