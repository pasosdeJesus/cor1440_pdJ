require 'msip/version'

Msip.setup do |config|
  config.ruta_anexos = (ENV['MSIP_RUTA_ANEXOS'] || 
                        "#{Rails.root}/archivos/anexos/")
  config.ruta_volcados = (ENV['MSIP_RUTA_VOLCADOS'] || 
                          "#{Rails.root}/archivos/bd/")
  # En heroku los anexos son super-temporales
  if ENV["HEROKU_POSTGRESQL_MAUVE_URL"]
    config.ruta_anexos = "#{Rails.root}/tmp/"
  end
  config.titulo = "Cor1440 pdJ " + Cor1440Gen::VERSION
end
