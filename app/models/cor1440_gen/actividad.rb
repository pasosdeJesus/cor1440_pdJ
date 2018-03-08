# encoding: UTF-8

require 'cor1440_gen/concerns/models/actividad'

module Cor1440Gen
  class Actividad < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Actividad
    include Sip::Localizacion

    attr_accessor :valor

    def valor
      if actividadtipo.count == 1 && proyectofinanciero.count == 1 &&
        actividadtipo[0].porcentaje && proyectofinanciero[0].valorhora
        # Más bien suma de conbinaciones porcentaje por tipo*proyecto de 
        # las validas proyecto,tipo --cuando se implemente en actividad de 
        # convenio --que deberí poderse configurar fácil y rápido tal vez
        # con plantilla de actividad de convenio (?) o con lo de indicadores?
        actividadtipo[0].porcentaje*proyectofinanciero[0].valorhora
      else
        0
      end
    end

    validates :tiempo, numericality: { 
      greater_than: 0,
      allow_nil: true 
    }

    scope :filtro_fecha_localizadaini, lambda { |f|
      where('fecha >= ?', Sip::FormatoFechaHelper.fecha_local_estandar(f))
    }

    scope :filtro_fecha_localizadafin, lambda { |f|
      where('fecha <= ?', Sip::FormatoFechaHelper.fecha_local_estandar(f))
    }

    scope :responsable, lambda { |uid|
      where('usuario_id = ?', uid)
    }

    scope :filtro_nombre, lambda { |n|
      where("unaccent(nombre) ILIKE '%' || unaccent(?) || '%'", n)
    }

    scope :filtro_observaciones, lambda {|o|
      where("unaccent(observaciones) ILIKE '%' || unaccent(?) || '%'", o)
    } 
  end
end
