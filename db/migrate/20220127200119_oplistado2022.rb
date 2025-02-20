# frozen_string_literal: true

class Oplistado2022 < ActiveRecord::Migration[7.0]
  def up
    execute(<<-SQL)
      CREATE INDEX usuario_fechadeshabilitacion_ind ON#{" "}
        usuario (fechadeshabilitacion);#{" "}
      CREATE INDEX cor1440_gen_actividadpf_titulo_ind ON#{" "}
        cor1440_gen_actividadpf (titulo);#{" "}
      CREATE INDEX cor1440_gen_actividad_fecha_ind ON#{" "}
        cor1440_gen_actividad (fecha);#{" "}
      CREATE INDEX cor1440_gen_actividad_actividadpf_actividad_ind ON#{" "}
        cor1440_gen_actividad_actividadpf (actividad_id);#{" "}
      CREATE INDEX cor1440_gen_actividad_actividadpf_actividadpf_ind ON#{" "}
        cor1440_gen_actividad_actividadpf (actividadpf_id);#{" "}
      CREATE INDEX cor1440_gen_actividad_respuestafor_actividad_ind ON#{" "}
        cor1440_gen_actividad_respuestafor (actividad_id);#{" "}
      CREATE INDEX cor1440_gen_actividad_respuestafor_respuesta_ind ON#{" "}
        cor1440_gen_actividad_respuestafor (respuestafor_id);#{" "}
    SQL
  end

  def down
    execute(<<-SQL)
      DROP INDEX cor1440_gen_actividad_respuestafor_respuesta_ind;
      DROP INDEX cor1440_gen_actividad_respuestafor_actividad_ind ;
      DROP INDEX cor1440_gen_actividad_actividadpf_actividadpf_ind ;
      DROP INDEX cor1440_gen_actividad_actividadpf_actividad_ind ;
      DROP INDEX cor1440_gen_actividad_fecha_ind ;
      DROP INDEX cor1440_gen_actividadpf_titulo_ind ;
      DROP INDEX usuario_fechadeshabilitacion_ind ;
    SQL
  end
end
