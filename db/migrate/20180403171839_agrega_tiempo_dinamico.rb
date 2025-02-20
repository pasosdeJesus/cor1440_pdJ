# frozen_string_literal: true

class AgregaTiempoDinamico < ActiveRecord::Migration[5.1]
  def up
    execute(<<-SQL)
      INSERT INTO cor1440_gen_proyectofinanciero (id, nombre, observaciones, fechainicio, fechacierre, responsable_id, fechacreacion, fechadeshabilitacion, created_at, updated_at, compromisos, monto, valorhora) VALUES (1, 'MARCO PASOS DE JESÚS', '', '2004-12-04', NULL, NULL, NULL, NULL, '2018-04-03 15:05:35.02528', '2018-04-03 15:10:33.722221', NULL, 0, NULL);


      INSERT INTO cor1440_gen_objetivopf (id, proyectofinanciero_id, numero, objetivo) VALUES (1, 104, 'O1', 'Dar gloria y honra a nuestro Señor Jesucristo');
      INSERT INTO cor1440_gen_objetivopf (id, proyectofinanciero_id, numero, objetivo) VALUES (2, 104, 'O2', 'Desarrollar productos de calidad y de fuentes abiertas');

      INSERT INTO cor1440_gen_resultadopf (id, proyectofinanciero_id, objetivopf_id, numero, resultado) VALUES (1, 104, 2, 'R1', 'Software de calidad, sin fallas');
      INSERT INTO cor1440_gen_resultadopf (id, proyectofinanciero_id, objetivopf_id, numero, resultado) VALUES (2, 104, 1, 'R2', 'Ser justos en lo que pedimos a clientes y lo que pagamos a quienes trabajan');

      INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at, porcentaje) VALUES (20, 'TRABAJO POR HORAS', 'Requiere compromiso del trabajador', '2018-04-03', NULL, '2018-04-03 15:29:47.270546', '2018-04-03 15:30:40.588128', NULL);

      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, nombrecorto, titulo, descripcion, resultadopf_id, actividadtipo_id) VALUES (1, 104, 'A1', 'TRABAJO POR HORAS', '', 2, 20);
    SQL
  end

  def down
  end
end
