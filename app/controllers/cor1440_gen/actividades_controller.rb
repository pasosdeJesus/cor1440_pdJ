# encoding: UTF-8

require_dependency 'cor1440_gen/concerns/controllers/actividades_controller'

module Cor1440Gen
    class ActividadesController < Heb412Gen::ModelosController

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
          :proyectofinanciero,
          :actividadpf,
          :respuestafor,
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
            :actividadpf_ids => [],
            :proyectofinanciero_ids => [],
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
