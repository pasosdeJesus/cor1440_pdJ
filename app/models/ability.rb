# encoding: UTF-8
class Ability  < Cor1440Gen::Ability


    ROLES = [
      ["Administrador", ROLADMIN], 
      ["", 0], 
      ["Directivo", ROLDIR], 
      ["", 0], 
      ["", 0 ],
      ["", 0],
      ["Sistematizador de Actividades", ROLSISTACT]
    ]

  # Ver documentacion de este metodo en app/models/ability de sip
  def initialize(usuario = nil)
    if !usuario || usuario.fechadeshabilitacion
      return
    end
    initialize_cor1440_gen(usuario)
  end

end

