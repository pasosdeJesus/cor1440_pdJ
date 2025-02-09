require 'msip/version'

Msip.setup do |config|
  config.ruta_anexos = (ENV['MSIP_RUTA_ANEXOS'] ||
                        "#{Rails.root}/archivos/anexos/")
  config.ruta_volcados = (ENV['MSIP_RUTA_VOLCADOS'] ||
                          "#{Rails.root}/archivos/bd/")
  config.titulo = "Cor1440 pdJ " + Cor1440Gen::VERSION

  config.descripcion = "Motor para seguimiento de actividades de Pasos de Jesús"
  config.codigofuente = "https://gitlab.com/pasosdeJesus/cor1440_pdJ"
  config.urlcontribuyentes = "https://gitlab.com/pasosdeJesus/cor1440_pdJ/-/graphs/main"
  config.urlcreditos = "https://gitlab.com/pasosdeJesus/cor1440_pdJ/blob/main/CREDITOS.md"
  config.urllicencia = "https://gitlab.com/pasosdeJesus/cor1440_pdJ/blob/main/LICENCIA.md"
  config.agradecimientoDios = "<p>
Agradecemos a Dios porque amandolo podemos descansar en Él:
</p>
<blockquote>
<p>
Por demás es que os levantéis de madrugada, y vayáis tarde a reposar,
<br/>
Y que comáis pan de dolores;
<br/>
Pues que a su amado dará Dios el sueño.
</p>
<p>Salmo 127:2</p>
</blockquote>".html_safe
end
