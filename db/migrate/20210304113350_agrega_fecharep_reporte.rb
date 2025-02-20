# frozen_string_literal: true

class AgregaFecharepReporte < ActiveRecord::Migration[6.1]
  def change
    add_column(:cor1440_gen_actividad, :fecharep, :date)
    add_column(:cor1440_gen_actividad, :urlcaso, :string, limit: 2048)
  end
end
