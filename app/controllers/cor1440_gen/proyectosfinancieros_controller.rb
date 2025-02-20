# frozen_string_literal: true

require_dependency "cor1440_gen/concerns/controllers/proyectosfinancieros_controller"

module Cor1440Gen
  class ProyectosfinancierosController < Heb412Gen::ModelosController
    include Cor1440Gen::Concerns::Controllers::ProyectosfinancierosController

    before_action :set_proyectofinanciero,
      only: [:show, :edit, :update, :destroy]
    skip_before_action :set_proyectofinanciero, only: [:validar]

    load_and_authorize_resource class: Cor1440Gen::Proyectofinanciero,
      only: [
        :new,
        :create,
        :destroy,
        :edit,
        :update,
        :index,
        :show,
        :objetivospf,
      ]

    def actualizar_de_gitlab
      set_proyectofinanciero
      if @registro
        GitlabHelper.actualizar_de_gitlab(@registro.id)
      end
      redirect_to(cor1440_gen.actividades_path)
    end

    def proyectofinanciero_params
      l = proyectofinanciero_params_cor1440_gen + [:idrep_gitlab]
      params.require(:proyectofinanciero).permit(
        l.map do |e|
          if e.class == Hash && e[:actividadpf_attributes]
            {
              actividadpf_attributes: [
                :actividadtipo_id,
                :descripcion,
                :formulario_id,
                :heredade_id,
                :id,
                :nombrecorto,
                :resultadopf_id,
                :titulo,
                :valorfijohora_localizado,
                :_destroy,
              ],
            }
          else
            e
          end
        end,
      )
    end
  end
end
