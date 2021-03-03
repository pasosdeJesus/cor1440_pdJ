class AgregaDuracionvolActividad < ActiveRecord::Migration[6.1]
  def change
    add_column :cor1440_gen_actividad, :duracionvol, :decimal
  end
end
