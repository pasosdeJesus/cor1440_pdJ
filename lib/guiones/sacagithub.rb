# frozen_string_literal: true

url = "https://api.github.com/repos/pasosdeJesus/sivel2_sjrcol/issues?state=closed&sort=updated"
uri = URI.parse(url)
h = Net::HTTP.get(uri)
j = JSON.parse(h)
u = Usuario.find_by(nusuario: "vtamara") || Usuario.take
j.each do |i|
  next unless Cor1440Gen::Actividad.where(urlcaso: i["html_url"]).count == 0 &&
    i["html_url"].include?("/issues/")

  puts i["title"]
  puts i
  puts "Saltar (s)?"
  ps = gets.chomp
  puts "ps=#{ps}"
  next unless ps.to_s.strip.length == 0 || ps.to_s.strip.downcase[0] != "s"

  t = i["title"][/\[[0-9.,]+\]/].to_s[1..-2].to_s.sub(",", ".")
  r = {
    fecha: Date.today,
    nombre: i["title"][0..499],
    oficina_id: 1,
    usuario_id: u.id,
    urlcaso: i["html_url"],
    duracion: t.to_f,
    medduracion: "H",
  }
  if ENV["fecharep"]
    r[:fecharep] = ENV["fecharep"]
  end
  Cor1440Gen::Actividad.create!(r)
  puts "Registro creado"
end
