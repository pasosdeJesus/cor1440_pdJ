require_dependency 'cor1440_gen/concerns/controllers/actividades_controller'

module Cor1440Gen
    class ActividadesController < Heb412Gen::ModelosController

      include Cor1440Gen::Concerns::Controllers::ActividadesController

      before_action :set_actividad,
        only: [:show, :edit, :update, :destroy],
        exclude: [:contar, :contar_beneficiarios]
      load_and_authorize_resource class: Cor1440Gen::Actividad

      def atributos_index
        [ :id,
          :fecha_localizada,
          :duracion,
          :duracionvol,
          :medduracion,
          :responsable,
          :nombreurlcaso,
          :proyectofinanciero,
          :actividadpf,
          :respuestafor,
          :observaciones,
          :urlcaso,
          :fecharep_localizada,
          :valor
        ]
      end

      def atributos_show
        a = atributos_index
        a + [
          :actorsocial,
          :listadoasistencia,
          :poblacion,
          :anexos
        ]
      end

      def atributos_form
        a = atributos_show
        a[a.index(:nombreurlcaso)] = 'nombre'
        atributos_show - [
          :id, :valor, :actividadpf
        ]
      end


      def index_reordenar(c)
        @horas = c.inject(0) { |memo,r|
          r.horas ? memo + r.horas : memo
        }
        @valor = c.inject(0) { |memo,r|
          r.valor ? memo + r.valor : memo
        }
        c.reorder('fecha desc')
      end


      def new
        new_cor1440_gen
        redirect_to cor1440_gen.edit_actividad_path(@registro)
      end

      private

      def set_actividad
        @registro = @actividad = Cor1440Gen::Actividad.find(
          Cor1440Gen::Actividad.connection.quote_string(params[:id]).to_i
        )
      end

      def lista_params
        atributos_form -
          [:actividadpf, :proyectosfinancieros, :respuestafor] + [
            :usuario_id,
            :actividad_proyectofinanciero_attributes => [
              :id, :proyectofinanciero_id, :_destroy,
              :actividadpf_ids => []
            ],
            :respuestafor_attributes => [
              :id, "valorcampo_attributes" => [
                :valor, :campo_id, :id] +
                [:valor_ids => []]
            ]
        ]
      end

      # No confiar parametros a Internet, sólo permitir lista blanca
      def actividad_params
        params.require(:actividad).permit(lista_params)
      end

  end
end
