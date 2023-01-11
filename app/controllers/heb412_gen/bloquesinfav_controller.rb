module Heb412Gen
  class BloquesinfavController < Msip::ModelosController
    helper ::ApplicationHelper

    before_action :set_bloqueinfav, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource  class: Heb412Gen::Bloqueinfav

    def clase 
      "Heb412Gen::Bloqueinfav"
    end

    def atributos_index
      [
        :id,
        :informeavanzado_id, 
        :bloque,
        :parametros,
        :posicion
      ]
    end

    def atributos_form
      [
        :informeavanzado_id, 
        :bloque,
        :parametros,
        :posición
      ]
    end

    def atributos_show
      atributos_index
    end


    def index_reordenar(registros)
      return registros.reorder('posicion')
    end

    def new_modelo_path(o)
      return new_bloqueinfav_path()
    end

    def genclase
      return 'M'
    end

    def new
      @bloqueinfav = Heb412Gen::Bloqueinfav.new(
        informeavanzado_id: params[:informeavanzado_id].to_i
      )
    end

    private

    def set_bloqueinfav
      @registro = @bloqueinfav = Heb412Gen::Bloqueinfav.find(
        params[:id].to_i)
    end

    # No confiar parametros a Internet, sólo permitir lista blanca
    def bloqueinfav_params
      params.require(:bloqueinfav).permit(*atributos_form)
    end

  end
end
