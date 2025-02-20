# frozen_string_literal: true

class ProyectoAgregaRepositorio < ActiveRecord::Migration[7.0]
  def change
    add_column(:cor1440_gen_proyectofinanciero, :idrep_gitlab, :integer)
  end
end
