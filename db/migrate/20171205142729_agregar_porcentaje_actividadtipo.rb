# frozen_string_literal: true

class AgregarPorcentajeActividadtipo < ActiveRecord::Migration[5.1]
  def change
    add_column(:cor1440_gen_actividadtipo, :porcentaje, :numeric)
  end
end
