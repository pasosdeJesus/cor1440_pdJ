# frozen_string_literal: true

require_dependency "cor1440_gen/concerns/controllers/actividades_controller"

module Cor1440Gen
  class ActividadesController < Heb412Gen::ModelosController
    include Cor1440Gen::Concerns::Controllers::ActividadesController

    before_action :set_actividad,
      only: [:show, :edit, :update, :destroy],
      exclude: [:contar, :contar_beneficiarios]
    load_and_authorize_resource class: Cor1440Gen::Actividad

    def atributos_index
      [
        :id,
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
        :valor,
      ]
    end

    def atributos_show
      a = atributos_index
      a + [
        :orgsocial,
        :listadoasistencia,
        # :poblacion,
        #          :anexos
      ]
    end

    def atributos_form
      a = atributos_show
      a[a.index(:nombreurlcaso)] = "nombre"
      a - [
        :id, :valor, :actividadpf,
      ]
    end

    def prefiltrar
      if params[:filtro].nil?
        params[:filtro] = {}
        params[:filtro][:busfechaini] = "#{Date.today.year}-01-01"
      end
    end

    def index_reordenar(c)
      @horas = c.inject(0) do |memo, r|
        r.horas ? memo + r.horas : memo
      end
      @horasvol = c.inject(0) do |acum, r|
        r.horasvol ? acum + r.horasvol : acum
      end
      @valor = c.inject(0) do |memo, r|
        r.valor ? memo + r.valor : memo
      end
      c.reorder("fecha desc")
    end

    private

    def set_actividad
      @registro = @actividad = Cor1440Gen::Actividad.find(
        Cor1440Gen::Actividad.connection.quote_string(params[:id]).to_i,
      )
    end

    def lista_params
      atributos_form -
        [:actividadpf, :proyectosfinancieros, :respuestafor] + [
          :usuario_id,
          actividad_proyectofinanciero_attributes: [
            :id,
            :proyectofinanciero_id,
            :_destroy,
            actividadpf_ids: [],
          ],
          actividad_msip_anexo_attributes: [
            :id,
            :id_actividad,
            :_destroy,
            msip_anexo_attributes: [
              :id, :descripcion, :adjunto, :_destroy,
            ],
          ],
          orgsocial_ids: [],
          respuestafor_attributes: [
            :id, "valorcampo_attributes" => [
              :valor, :campo_id, :id,
            ] +
              [valor_ids: []],
          ],
        ]
    end

    # No confiar parametros a Internet, sólo permitir lista blanca
    def actividad_params
      params.require(:actividad).permit(lista_params)
    end
  end
end
