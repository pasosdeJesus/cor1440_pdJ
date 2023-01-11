ENV['RAILS_ENV'] ||= 'test'
require 'zeitwerk'
require 'simplecov'
Zeitwerk::Loader.eager_load_all
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  protected
  def load_seeds
    load "#{Rails.root}/db/seeds.rb"
  end
end


PRUEBA_ACTIVIDAD = {
  nombre: "n",
  fecha: "2017-03-02",
  oficina_id: 1,
  usuario_id: 1,
}

PRUEBA_ACTIVIDADPF = {
  id: 1,
  proyectofinanciero_id: 1,
  nombrecorto: "a",
  titulo: "aa",
  descripcion: "aaa",
  resultadopf_id: 1,
}


PRUEBA_OBJETIVOPF = {
  id: 1,
  proyectofinanciero_id: 1,
  numero: "o",
  objetivo: "o",
}


PRUEBA_PROYECTOFINANCIERO = {
  id: 1,
  nombre: "n",
  observaciones: "o",
  fechainicio: "2023-01-01",
  fechacierre: "2063-01-01",
  responsable_id: 1,
  fechacreacion: "2023-01-01",
  compromisos: "c",
  monto: 100,
  titulo: "t",
  poromision: "f",
  fechaformulacion: "2022-12-31",
  fechaaprobacion: "2022-12-31",
  fechaliquidacion: "2022-12-31",
  estado: "E",
  dificultad: "B",
  tipomoneda_id: 1,
  saldoaejecutarp: 100,
  centrocosto: "c",
  tasaej: 1,
  montoej: 0,
  aportepropioej: 0,
  presupuestototalej: 100,
}


PRUEBA_RESULTADOPF = {
  id: 1,
  proyectofinanciero_id: 1,
  objetivopf_id: 1,
  numero: "r",
  resultado: "r",
}

# Usuario para ingresar y hacer pruebas
PRUEBA_USUARIO = {
  nusuario: "admin",
  password: "sjrven123",
  nombre: "admin",
  descripcion: "admin",
  rol: 1,
  idioma: "es_CO",
  email: "usuario1@localhost",
  encrypted_password: '$2a$10$uMAciEcJuUXDnpelfSH6He7BxW0yBeq6VMemlWc5xEl6NZRDYVA3G',
  sign_in_count: 0,
  fechacreacion: "2014-08-05",
  fechadeshabilitacion: nil,
  oficina_id: nil
}


