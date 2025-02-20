# frozen_string_literal: true

class AgregaValorfijoactividad < ActiveRecord::Migration[6.1]
  def change
    add_column(:cor1440_gen_actividadpf, :valorfijohora, :decimal)
    add_column(:cor1440_gen_actividadpf, :implicaactividadpf_id, :integer)
    add_foreign_key(
      :cor1440_gen_actividadpf,
      :cor1440_gen_actividadpf,
      column: :implicaactividadpf_id,
    )
  end
end
