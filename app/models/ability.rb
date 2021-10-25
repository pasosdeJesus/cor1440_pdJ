class Ability  < Cor1440Gen::Ability

  ROLES = [
    ["Administrador", ROLADMIN], 
    ["", 0], 
    ["Directivo", ROLDIR], 
    ["", 0], 
    ["Operador", ROLOPERADOR ],
    ["", 0],
    ["", 0]
  ]

  CAMPOS_PLANTILLAS_PROPIAS = { 
      'Actividad' => {
        campos: [
          Cor1440Gen::Actividad.human_attribute_name(
            :actividadareas).downcase.gsub(' ', '_'),
          Cor1440Gen::Actividad.human_attribute_name(
            :actividadpf).downcase.gsub(' ', '_'),
          'actualizacion',
          'anexo_1_desc',
          'anexo_2_desc',
          'anexo_3_desc',
          'anexo_4_desc',
          'anexo_5_desc',
          'anexos_ids',
          'campos_dinamicos',
          'corresponsables',
          'creacion',
          'duracionvol',
          'fecha',
          'fecharep',
          'fecha_localizada',
          'duracion',
          'id',
          'lugar',
          'nombre',
          'numero_anexos',
          'objetivo',
          'observaciones',
          Cor1440Gen::Actividad.human_attribute_name(
            :objetivopf).downcase.gsub(' ', '_'),
          'oficina',
          'organizaciones_sociales',
          'organizaciones_sociales_ids',
          'poblacion',
          'poblacion_mujeres_l',
          'poblacion_mujeres_r',
          'poblacion_hombres_l',
          'poblacion_hombres_r',
          'poblacion_sinsexo',
          'poblacion_mujeres_l_g1',
          'poblacion_mujeres_r_g1',
          'poblacion_hombres_l_g1',
          'poblacion_hombres_r_g1',
          'poblacion_sinsexo_g1',
          'poblacion_mujeres_l_g2',
          'poblacion_mujeres_r_g2',
          'poblacion_hombres_l_g2',
          'poblacion_hombres_r_g2',
          'poblacion_sinsexo_g2',
          'poblacion_mujeres_l_g3',
          'poblacion_mujeres_r_g3',
          'poblacion_hombres_l_g3',
          'poblacion_hombres_r_g3',
          'poblacion_sinsexo_g3',
          'poblacion_mujeres_l_g4',
          'poblacion_mujeres_r_g4',
          'poblacion_hombres_l_g4',
          'poblacion_hombres_r_g4',
          'poblacion_sinsexo_g4',
          'poblacion_mujeres_l_g5',
          'poblacion_mujeres_r_g5',
          'poblacion_hombres_l_g5',
          'poblacion_hombres_r_g5',
          'poblacion_sinsexo_g5',
          'poblacion_mujeres_l_g6',
          'poblacion_mujeres_r_g6',
          'poblacion_hombres_l_g6',
          'poblacion_hombres_r_g6',
          'poblacion_sinsexo_g6',
          Cor1440Gen::Actividad.human_attribute_name(
            :proyectofinanciero).downcase.gsub(' ', '_'),
          Cor1440Gen::Actividad.human_attribute_name(
            :proyectofinanciero).downcase.gsub(' ', '_') + '_id',
          Cor1440Gen::Actividad.human_attribute_name(
            :proyectos).downcase.gsub(' ', '_'),
          'responsable',
          'responsable_nombre',
          'resultado',
          'urlcaso'
        ],
        controlador: 'Cor1440Gen::ActividadesController',
        ruta: '/actividades'
      },
  }

  def campos_plantillas
    Heb412Gen::Ability::CAMPOS_PLANTILLAS_PROPIAS.clone.
      merge(Cor1440Gen::Ability::CAMPOS_PLANTILLAS_PROPIAS.clone).
      merge(CAMPOS_PLANTILLAS_PROPIAS.clone)
  end

  # Ver documentacion de este metodo en app/models/ability de sip
  def initialize(usuario = nil)
    if !usuario || usuario.fechadeshabilitacion
      return
    end
    initialize_cor1440_gen(usuario)
  end

end

