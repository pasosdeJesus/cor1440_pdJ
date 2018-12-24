# encoding: UTF-8

require 'cor1440_gen/concerns/controllers/proyectosfinancieros_controller'

module Cor1440Gen
  class ProyectosfinancierosController < Sip::ModelosController
    helper ::ApplicationHelper
    include ::ApplicationHelper
    include Cor1440Gen::Concerns::Controllers::ProyectosfinancierosController
    include ::Sip::ModeloHelper

    before_action :set_proyectofinanciero, 
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: Cor1440Gen::Proyectofinanciero

    #include Sip::ConsultasHelper

    def atributos_index
      [ "id", 
        "nombre",
      ] +
      [ :financiador_ids =>  [] ] +
      [ "fechainicio_localizada",
        "fechacierre_localizada"
      ] +
      [ 
        "monto_localizado",
        "valorhora_localizado",
      ] 
    end

    def atributos_form
      [ :id, 
        :nombre ] +
      [ :financiador_ids =>  [] ] +
      [ :fechainicio_localizada,
        :fechacierre_localizada,
      ] +
      [ :monto_localizado,
        :valorhora_localizado,
        :observaciones,
        :marcologico,
        :anexo_proyectofinanciero
      ] 
    end

    def atributos_show
      atributos_form
    end

    def index_reordenar(c)
      c.reorder('fechacierre desc')
    end

    def new
      @registro = clase.constantize.new
      @registro.monto = 1
      @registro.nombre = 'N'
      @registro.save!
      redirect_to cor1440_gen.edit_proyectofinanciero_path(@registro)
    end

    private

    def set_proyectofinanciero
      @registro = @basica = @proyectofinanciero = Proyectofinanciero.find(
        Proyectofinanciero.connection.quote_string(params[:id]).to_i
      )
      #@proyectofinanciero.current_usuario = current_usuario
    end

    # No confiar parametros a Internet, sólo permitir lista blanca
    def proyectofinanciero_params
      params.require(:proyectofinanciero).permit(
        *atributos_form - [:objetivopf, :resultadopf, 
                           :indicadorpf, :actividadpf] +
                           [ :objetivopf_attributes =>  [
                             :id, :numero, :objetivo, :_destroy ] 
                           ] +
                           [ :resultadopf_attributes =>  [
                             :id, :objetivopf_id,
                             :numero, :resultado, :_destroy ] 
                           ] +
                           [ :indicadorpf_attributes =>  [
                             :id, :resultadopf_id,
                             :numero, :indicador, :tipoindicador_id,
                             :_destroy ] 
                           ] +
                           [ :actividadpf_attributes =>  [
                             :id, :resultadopf_id,
                             :actividadtipo_id,
                             :nombrecorto, :titulo, 
                             :descripcion, :_destroy ] 
                           ] 

      )
    end

  end
end
