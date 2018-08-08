class AgregaDuracionActividad < ActiveRecord::Migration[5.2]
  def change
    add_column :cor1440_gen_actividad, :duracion, :decimal

    # Valores posibles del siguiente en ApplicationHelper::DURACION
    add_column :cor1440_gen_actividad, :medduracion, :char
  end
end
