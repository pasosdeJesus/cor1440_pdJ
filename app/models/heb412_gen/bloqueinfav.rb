module Heb412Gen
  class Bloqueinfav < ActiveRecord::Base
    include Msip::Modelo
    include Msip::Localizacion

    belongs_to :informeavanzado, 
      class_name: 'Heb412Gen::Informeavanzado',
      foreign_key: 'informeavanzado_id', validate: true, optional: false

    validates :bloque, presence: true, length: {maximum: 128}
    validates :parametros, length: {maximum: 512}


  end
end
