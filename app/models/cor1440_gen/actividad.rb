require 'cor1440_gen/concerns/models/actividad'

module Cor1440Gen
  class Actividad < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Actividad
    include Msip::Localizacion

    attr_accessor :valor
    attr_accessor :horas

    campofecha_localizado :fecharep

    validates :urlcaso, length: {maximum: 2000}

    def horas
        case medduracion
        when 'I'
          duracion/60.0
        when 'H'
          duracion
        when 'D'
          duracion*8
        when 'M'
          duracion*8*25
        else
          0
        end
    end

    def valor
      if duracion && duracion > 0 && medduracion &&
        proyectofinanciero.count == 1 && 
        actividadpf.count == 1
        a = actividadpf[0]
        while a && (!a.valorfijohora || a.valorfijohora <= 0)
          a = a.heredade
        end
        if a 
          horas * a.valorfijohora
        elsif proyectofinanciero[0].valorhora &&
            actividadpf[0].actividadtipo &&
            actividadpf[0].actividadtipo.porcentaje &&
            actividadpf[0].actividadtipo.porcentaje > 0 

          horas * (actividadpf[0].actividadtipo.porcentaje/100.0) * 
            proyectofinanciero[0].valorhora
        else
          0
        end
      else
        0
      end
    end

    #validates :tiempo, numericality: { 
    #  greater_than: 0,
    #  allow_nil: true 
    #}

    def presenta(atr)
      case atr.to_s
      when 'medduracion'
        Msip::ModeloHelper.etiqueta_coleccion(
          ::ApplicationHelper::DURACION, medduracion)
      when 'nombreurlcaso' 
        u = ''
        if  self.urlcaso && (self.urlcaso != '')
          begin
            u = URI.parse(self.urlcaso)
            return "<a href='#{u.to_s}'>"\
              "#{CGI::escapeHTML(self.nombre)}</a>".html_safe
          rescue
            return self.nombre
          end
        else
          return self.nombre
        end
      when 'responsable'
        responsable ? responsable.presenta_nombre  : '-'
      else
        presenta_cor1440_gen(atr)
      end
    end

    scope :filtro_fecha_localizadaini, lambda { |f|
      where('fecha >= ?', 
            Msip::FormatoFechaHelper.fecha_local_estandar(f))
    }

    scope :filtro_fecha_localizadafin, lambda { |f|
      where('fecha <= ?', 
            Msip::FormatoFechaHelper.fecha_local_estandar(f))
    }

    scope :filtro_fecharepini, lambda { |f|
      where('fecharep >= ?', Msip::FormatoFechaHelper.fecha_local_estandar(f))
    }

    scope :filtro_fecharepfin, lambda { |f|
      where('fecharep <= ?', 
            Msip::FormatoFechaHelper.fecha_local_estandar(f))
    }

    scope :filtro_nombreurlcaso, lambda { |n|
      where("unaccent(nombre) ILIKE '%' || unaccent(?) || '%'", n)
    }

    scope :filtro_observaciones, lambda {|o|
      where("unaccent(observaciones) ILIKE '%' || unaccent(?) || '%'", o)
    } 

    scope :responsable, lambda { |uid|
      where('usuario_id = ?', uid)
    }

    scope :filtro_urlcaso, lambda {|u|
      where("unaccent(urlcaso) ILIKE '%' || unaccent(?) || '%'", u)
    } 

  end
end
