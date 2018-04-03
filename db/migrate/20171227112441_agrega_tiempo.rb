class AgregaTiempo < ActiveRecord::Migration[5.1]
  def change
    add_column :cor1440_gen_proyectofinanciero, :valorhora, :decimal, 
      precision: 20, scale: 2
  end
end
