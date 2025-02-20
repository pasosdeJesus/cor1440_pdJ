# frozen_string_literal: true

class MigraTiempo < ActiveRecord::Migration[5.1]
  def up
    execute(<<-SQL)
      UPDATE cor1440_gen_proyectofinanciero SET valorhora=COALESCE(CAST(observaciones AS float),0) WHERE observaciones IS NOT NULL AND observaciones<>'';
      UPDATE cor1440_gen_actividadtipo SET porcentaje=COALESCE(CAST(observaciones AS float),0) WHERE observaciones IS NOT NULL AND observaciones<>'';
    SQL
  end

  def down
  end
end
