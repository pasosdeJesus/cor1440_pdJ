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
      if Cor1440Gen::Proyectofinanciero.where(
          id: params[:proyectofinanciero_id].to_i).count != 1
        render inline: 'No existe proyectofinanciero con el proyectofinanciero_id dado'
        return
      end
      p = Cor1440Gen::Proyectofinanciero.find(
        params[:proyectofinanciero_id].to_i)
      authorize! :create, Cor1440Gen::Proyectofinanciero
      @registro = p.dup
      @registro.nombre += ' ' + Time.now.to_i.to_s
      if !@registro.save  # Elegir otra id
        render inline: 'No pudo salvar copia sin campos'
        return
      end
      # no se copian actividades, ni beneficiarios, ni anexos, ni medición de
      # indicadores, ni plantillas de exportación/importación

      # copia caracterizaciones
      [['Cor1440Gen::Caracterizacionpf', 'caracterización'],
       ['Cor1440Gen::FinanciadorProyectofinanciero', 'financiador'],
       ['Cor1440Gen::ProyectoProyectofinanciero', 'proyecto'],
       ['Cor1440Gen::ProyectofinancieroUsuario', 'usuario']
      ].each do |par|
        par[0].constantize.where(proyectofinanciero_id: p.id).
          each do |tr|
          ntr= tr.dup
          ntr.proyectofinanciero_id = @registro.id
          if !ntr.save
            render inline: "No pudo salvar copia de #{par[1]}"
            return
          end
        end #tr
      end #par

      Cor1440Gen::Objetivopf.where(proyectofinanciero_id: p.id).each do |ob|
        nob = ob.dup
        nob.proyectofinanciero_id = @registro.id
        if !nob.save
          render inline: "No pudo salvar copia de objetivo"
          return
        end
        Cor1440Gen::Indicadorpf.where(
          proyectofinanciero_id: p.id, objetivopf_id: ob.id).
          each do |ind|
          nind = ind.dup
          nind.proyectofinanciero_id = @registro.id
          nind.objetivopf_id = ob.id
          if !nind.save
            render inline: "No pudo salvar copia de indicador de efecto"
            return
          end
        end # Indicadorpf
        Cor1440Gen::Resultadopf.where(
          proyectofinanciero_id: p.id, objetivopf_id: ob.id).
          each do |res|
          nres = res.dup
          nres.proyectofinanciero_id = @registro.id
          nres.objetivopf_id = nob.id
          if !nres.save
            render inline: "No pudo salvar copia de resultado"
            return
          end
          Cor1440Gen::Indicadorpf.where(
            proyectofinanciero_id: p.id, resultadopf_id: res.id).
            each do |ind|
            nind = ind.dup
            nind.proyectofinanciero_id = @registro.id
            nind.resultadopf_id = res.id
            if !nind.save
              render inline: "No pudo salvar copia de indicador de resultado"
              return
            end
          end # Indicadorpf
          Cor1440Gen::Actividadpf.where(
            proyectofinanciero_id: p.id, resultadopf_id: res.id).
            each do |act|
            nact = act.dup
            nact.proyectofinanciero_id = @registro.id
            nact.resultadopf_id = nres.id
            if !nact.save
              render inline: "No pudo salvar copia de actividad"
              return
            end
          end # Actividadpf
        end  # Resultadopf
      end # Objetivopf

      if !@registro.save  # Elegir otra id
        render inline: 'No pudo salvar copia con campos'
        return
      end
      redirect_to cor1440_gen.proyectofinanciero_path(@registro)
    end

  end
end
