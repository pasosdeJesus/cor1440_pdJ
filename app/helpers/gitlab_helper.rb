# frozen_string_literal: true

module GitlabHelper
  def actualizar_de_gitlab(proyecto_id)
    if proyecto_id && Cor1440Gen::Proyectofinanciero.where(id: proyecto_id).count != 1
      STDERR.puts "No existe proyecto #{proyecto_id}"
      exit(1)
    end

    pf = Cor1440Gen::Proyectofinanciero.find(proyecto_id)
    if pf.idrep_gitlab.to_i == 0
      STDERR.puts "Proyecto #{pf.nombre} no tiene ID de repositorio en gitlab"
      exit(1)
    end

    # url = 'https://api.github.com/repos/pasosdeJesus/sivel2_sjrcol/issues?state=closed&sort=updated'
    url = "https://gitlab.com/api/v4/projects/#{pf.idrep_gitlab}/issues?state=closed&order_by=updated_at"
    uri = URI.parse(url)
    h = Net::HTTP.get(uri)
    j = JSON.parse(h)
    u = Usuario.find_by(nusuario: "vtamara") || Usuario.take
    j.each do |i|
      next unless i["type"] = "ISSUE" && Cor1440Gen::Actividad.where(urlcaso: i["web_url"]).count == 0

      puts "Titulo: #{i["title"]}"
      puts "Saltar (s)?"
      ps = "n" # gets.chomp
      puts "ps=#{ps}"
      next unless ps.to_s.strip.length == 0 || ps.to_s.strip.downcase[0] != "s"

      t = i["title"][/\[[0-9.,]+\]/].to_s[1..-2].to_s.sub(",", ".")
      r = {
        fecha: Date.today,
        fecharep: Date.today,
        nombre: i["title"][0..499],
        oficina_id: 1,
        usuario_id: u.id,
        urlcaso: i["web_url"],
        duracion: t.to_f,
        medduracion: "H",
      }
      if ENV["fecharep"]
        r[:fecharep] = ENV["fecharep"]
      end
      a = Cor1440Gen::Actividad.create!(r)
      if proyecto_id > 0
        Cor1440Gen::ActividadProyectofinanciero.create!(
          actividad_id: a.id,
          proyectofinanciero_id: proyecto_id,
        )
      end
      puts "Registro creado"
    end
  end
  module_function :actualizar_de_gitlab
end
