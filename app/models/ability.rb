# encoding: UTF-8
class Ability  < Cor1440Gen::Ability

  # Ver documentacion de este metodo en app/models/ability de sip
  def initialize(usuario = nil)
    # Sin autenticación puede consultarse información geográfica 
    can :read, [Sip::Pais, Sip::Departamento, Sip::Municipio, Sip::Clase]
    if !usuario || usuario.fechadeshabilitacion
      return
    end
    can :contar, Sip::Ubicacion
    can :buscar, Sip::Ubicacion
    can :lista, Sip::Ubicacion
    can :descarga_anexo, Sip::Anexo
    can :nuevo, Cor1440Gen::Actividad
    can :nuevo, Sip::Ubicacion
    if !usuario.nil? && !usuario.rol.nil? then
      case usuario.rol 
      when Ability::ROLSISTACT
        can [:read, :new], Cor1440Gen::Actividad
        can [:update, :create, :destroy], Cor1440Gen::Actividad, 
          oficina: { id: usuario.oficina_id}
        can :read, Cor1440Gen::Actividadpf
        can :read, Cor1440Gen::ActividadProyectofinanciero
        can :read, Cor1440Gen::Efecto
        can :manage, Cor1440Gen::Informe
        can :read, Cor1440Gen::Proyectofinanciero

        can [:read, :create], Heb412Gen::Doc
        can :read, Heb412Gen::Plantilladoc
        can :read, Heb412Gen::Plantillahcm
        can :read, Heb412Gen::Plantillahcr

      when Ability::ROLADMIN, Ability::ROLDIR
        can :manage, Cor1440Gen::Actividad
        can :manage, Cor1440Gen::Actividadpf
        can :manage, Cor1440Gen::Efecto
        can :manage, Cor1440Gen::Informe
        can :manage, Cor1440Gen::Proyectofinanciero

        can :manage, Heb412Gen::Doc 
        can :manage, Heb412Gen::Plantilladoc
        can :manage, Heb412Gen::Plantillahcm
        can :manage, Heb412Gen::Plantillahcr
       
        can :manage, Mr519Gen::Formulario
        
        can :manage, Sip::Actorsocial
        can :manage, Sip::Persona

        can :manage, Usuario
        can :manage, :tablasbasicas
        tablasbasicas.each do |t|
          c = Ability.tb_clase(t)
          can :manage, c
        end
      end
    end
  end

end

