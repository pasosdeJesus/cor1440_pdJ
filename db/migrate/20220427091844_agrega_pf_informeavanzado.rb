# frozen_string_literal: true

class AgregaPfInformeavanzado < ActiveRecord::Migration[7.0]
  def change
    add_column(:heb412_gen_informeavanzado, :proyectofinanciero_id, :integer)
    add_foreign_key(
      :heb412_gen_informeavanzado,
      :cor1440_gen_proyectofinanciero,
      column: :proyectofinanciero_id,
    )
  end
end
