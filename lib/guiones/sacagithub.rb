

url = 'https://api.github.com/repos/pasosdeJesus/sivel2_sjrcol/issues?state=closed&sort=updated'
uri = URI.parse(url)
h = Net::HTTP.get(uri)
j=JSON.parse(h)
u = Usuario.where(nusuario: 'vtamara').take || Usuario.take
j.each do |i|
  if Cor1440Gen::Actividad.where(urlcaso: i['html_url']).count == 0
    puts i['title']
    t = i['title'][/\[[0-9.,]+\]/].to_s[1..-2].to_s.sub(',','.')
    r = {
      fecha: Date.today,
      nombre: i['title'][0..499],
      oficina_id: 1,
      usuario_id: u.id,
      urlcaso: i['html_url'],
      tiempo: t.to_f
    }
    if ENV['fecharep'] then
      r[:fecharep] = ENV['fecharep']
    end
    Cor1440Gen::Actividad.create!(r)
  end
end


