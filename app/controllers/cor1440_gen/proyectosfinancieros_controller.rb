# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/proyectosfinancieros_controller"

module Cor1440Gen
  class ProyectosfinancierosController < Heb412Gen::ModelosController
    include Cor1440Gen::Concerns::Controllers::ProyectosfinancierosController

    load_and_authorize_resource  class: Cor1440Gen::Proyectofinanciero,
      only: [:new, :create, :destroy, :edit, :update, :index, :show,
             :objetivospf]

    def copia
      if !params || !params[:proyectofinanciero_id] 
        render inline: 'Falta parámetro proyectofinanciero_id'
        return
      end
      if Mr519Gen::Formulario.where(
          id: params[:proyectofinanciero_id].to_i).count != 1
        render inline: 'No existe formulario con el proyectofinanciero_id dado'
        return
      end
      f = Cor1440Gen::Proyectofinanciero.find(
        params[:proyectofinanciero_id].to_i)
      authorize! :create, Cor1440Gen::Proyectofinanciero
      @registro = f.dup
      @registro.nombre += ' ' + Time.now.to_i.to_s
      if !@registro.save  # Elegir otra id
        render inline: 'No pudo salvar copia sin campos'
        return
      end
      byebug
      f.campo.each do |c|
        nc = c.dup
        nc.formulario_id = @registro.id
        if !nc.save
          render inline: 'No pudo salvar copia de campo'
          return
        end
      end
      if !@registro.save  # Elegir otra id
        render inline: 'No pudo salvar copia con campos'
        return
      end
      redirect_to formulario_path(@registro)
    end

  end
end
