# encoding: UTF-8

require_dependency 'cor1440_gen/concerns/controllers/actividades_controller'

module Cor1440Gen
    class ActividadesController < Sip::ModelosController

      include Cor1440Gen::Concerns::Controllers::ActividadesController

      before_action :set_actividad, 
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Cor1440Gen::Actividad

      def atributos_index
        [ :id, 
          :fecha_localizada, 
          :responsable,
          :nombre, 
          :proyectosfinancieros,
          :actividadpf,
          :valorcampoact,
          :observaciones
        ]
      end

      def atributos_show
        atributos_index
      end

      def atributos_form
        [ :id, 
          :fecha_localizada, 
          :responsable,
          :nombre, 
          :proyectosfinancieros,
          :actividadpf,
          :valorcampoact,
          :observaciones
        ]
      end


      def index_reordenar(c)
        c.reorder('fecha desc')
      end

      private


      def set_actividad
        @registro = @actividad = Cor1440Gen::Actividad.find(
          Cor1440Gen::Actividad.connection.quote_string(params[:id]).to_i
        )
      end

      # No confiar parametros a Internet, sólo permitir lista blanca
      def actividad_params
        params.require(:actividad).permit(
          :oficina_id, :nombre, 
          :objetivo, :proyecto, :resultado,
          :fecha_localizada, :actividad, :observaciones, 
          :usuario_id,
          :lugar,
          :actividadarea_ids => [],
          :actividadpf_ids => [],
          :actividadtipo_ids => [],
          :proyecto_ids => [],
          :proyectofinanciero_ids => [],
          :usuario_ids => [],
          :actividad_rangoedadac_attributes => [
            :id, :rangoedadac_id, :fl, :fr, :ml, :mr, :_destroy
          ],
          :actividad_sip_anexo_attributes => [
            :id,
            :id_actividad, 
            :_destroy,
            :sip_anexo_attributes => [
              :id, :descripcion, :adjunto, :_destroy
            ]
          ],
          :valorcampoact_attributes => [
            :valor, :campoact_id, :id
          ]
 
        )
      end

  end
end
