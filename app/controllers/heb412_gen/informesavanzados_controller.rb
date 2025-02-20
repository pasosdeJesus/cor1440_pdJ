# frozen_string_literal: true

module Heb412Gen
  class InformesavanzadosController < Msip::ModelosController
    helper ::ApplicationHelper

    before_action :set_informeavanzado,
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: Heb412Gen::Informeavanzado

    def clase
      "Heb412Gen::Informeavanzado"
    end

    def atributos_index
      [
        :id,
        :titulo,
        :proyectofinanciero_id,
        :fechaini_localizada,
        :fechafin_localizada,
      ]
    end

    def atributos_form
      [
        :titulo,
        :proyectofinanciero_id,
        :fechaini_localizada,
        :fechafin_localizada,
        :bloquesinfav,
      ]
    end

    def atributos_show
      atributos_index
    end

    def index_reordenar(registros)
      registros.reorder("fechaini DESC")
    end

    def new_modelo_path(o)
      new_informeavanzado_path
    end

    def genclase
      "M"
    end

    private

    def set_informeavanzado
      @registro = @informeavanzado = Heb412Gen::Informeavanzado.find(
        params[:id].to_i,
      )
    end

    # No confiar parametros a Internet, sólo permitir lista blanca
    def informeavanzado_params
      params.require(:informeavanzado).permit(*atributos_form)
    end
  end
end
