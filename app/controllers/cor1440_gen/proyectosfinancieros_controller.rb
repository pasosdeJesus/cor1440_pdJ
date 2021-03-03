require_dependency "cor1440_gen/concerns/controllers/proyectosfinancieros_controller"

module Cor1440Gen
  class ProyectosfinancierosController < Heb412Gen::ModelosController
    include Cor1440Gen::Concerns::Controllers::ProyectosfinancierosController

    before_action :set_proyectofinanciero,
      only: [:show, :edit, :update, :destroy]
    skip_before_action :set_proyectofinanciero, only: [:validar] 

    load_and_authorize_resource  class: Cor1440Gen::Proyectofinanciero,
      only: [:new, :create, :destroy, :edit, :update, :index, :show,
             :objetivospf]


    def proyectofinanciero_params
      params.require(:proyectofinanciero).permit(
        proyectofinanciero_params_cor1440_gen.map {|e|
          e.class == Hash && e[:actividadpf_attributes] ?
            {:actividadpf_attributes =>  [
              :id,
              :resultadopf_id,
              :actividadtipo_id,
              :nombrecorto,
              :titulo,
              :descripcion,
              :valorfijohora_localizado,
              :implicaactividadpf_id,
              :_destroy ]} : e
        }
      )
    end

  end
end
