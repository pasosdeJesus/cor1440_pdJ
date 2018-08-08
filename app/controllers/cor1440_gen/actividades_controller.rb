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
          :duracion,
          :medduracion,
          :responsable,
          :nombre, 
          :proyectosfinancieros,
          :actividadpf,
          :valorcampoact,
          :observaciones,
          :valor
        ]
      end

      def atributos_show
        atributos_index
      end

      def atributos_form
        atributos_index - [:id, :valor]
      end


      def index_reordenar(c)
        @horas = c.inject(0) { |memo,r| memo + r.horas } 
        @valor = c.inject(0) { |memo,r| memo + r.valor } 
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
        p = atributos_form - 
          [:actividadpf, :proyectosfinancieros, :valorcampoact] + [
            :actividadpf_ids => [],
            :proyectofinanciero_ids => [],
            :valorcampoact_attributes => [
              :valor, :campoact_id, :id
            ]
        ]
        params.require(:actividad).permit(p)
#          :nombre, 
#          :objetivo, :proyecto, :resultado,
#          
#          :fecha_localizada, :actividad, :observaciones, 
#          :usuario_id,
#          :lugar,
#          :actividadtipo_ids => [],
#          :proyecto_ids => [],
#          :usuario_ids => [],
#          :actividad_rangoedadac_attributes => [
#            :id, :rangoedadac_id, :fl, :fr, :ml, :mr, :_destroy
#          ],
#          :actividad_sip_anexo_attributes => [
#            :id,
#            :id_actividad, 
#            :_destroy,
#            :sip_anexo_attributes => [
#              :id, :descripcion, :adjunto, :_destroy
#            ]
#          ],
        #)
      end

  end
end
