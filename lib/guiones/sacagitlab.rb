#require 'byebug'

#url = 'https://api.github.com/repos/pasosdeJesus/sivel2_sjrcol/issues?state=closed&sort=updated'
url = 'https://gitlab.com/api/v4/projects/25947661/issues?state=closed&order_by=updated_at'
uri = URI.parse(url)
h = Net::HTTP.get(uri)
j=JSON.parse(h)
u = Usuario.where(nusuario: 'vtamara').take || Usuario.take
j.each do |i|
  if i["type"] = "ISSUE" && Cor1440Gen::Actividad.where(urlcaso: i['web_url']).count == 0
    puts "Titulo: #{i['title']}"
    puts "Saltar (s)?"
    ps = gets.chomp
    puts "ps=#{ps}"
    if ps.to_s.strip.length == 0 || ps.to_s.strip.downcase[0] != 's'
      t = i['title'][/\[[0-9.,]+\]/].to_s[1..-2].to_s.sub(',','.')
      r = {
        fecha: Date.today,
        nombre: i['title'][0..499],
        oficina_id: 1,
        usuario_id: u.id,
        urlcaso: i['web_url'],
        duracion: t.to_f,
        medduracion: 'H'
      }
      if ENV['fecharep'] then
        r[:fecharep] = ENV['fecharep']
      end
      Cor1440Gen::Actividad.create!(r)
      puts "Registro creado"
    end
  end
end


