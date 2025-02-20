# frozen_string_literal: true

class RenombraImplicaHeredade < ActiveRecord::Migration[6.1]
  def change
    rename_column(
      :cor1440_gen_actividadpf,
      :implicaactividadpf_id,
      :heredade_id,
    )
  end
end
