# frozen_string_literal: true

module Heb412Gen
  class Informeavanzado < ActiveRecord::Base
    include Msip::Modelo
    include Msip::Localizacion

    belongs_to :proyectofinanciero,
      class_name: "Cor1440Gen::Proyectofinanciero",
      validate: true,
      optional: false

    has_many :bloqueinfav,
      class_name: "Heb412Gen::Bloqueinfav",
      validate: true,
      dependent: :destroy
    accepts_nested_attributes_for :bloqueinfav,
      allow_destroy: true,
      reject_if: :all_blank

    validates :titulo, presence:  true, length: { maximum: 256 }

    campofecha_localizado :fechaini
    campofecha_localizado :fechafin
  end
end
