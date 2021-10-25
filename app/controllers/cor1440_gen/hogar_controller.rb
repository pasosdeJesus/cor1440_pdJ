module Cor1440Gen
  class HogarController < Sip::HogarController

    # Sin definición de autorización por ser para no autenticados
    def index
      if current_usuario
        authorize! :nuevo, Cor1440Gen::Actividad
      end
      render layout: 'application'
    end

  end
end
