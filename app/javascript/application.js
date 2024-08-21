/* eslint no-console:0 */

console.log('Hola Mundo desde ESM')


import Rails from "@rails/ujs";
if (typeof window.Rails == 'undefined') { 
  Rails.start();
  window.Rails = Rails;
}

import "@hotwired/turbo-rails";

import './jquery'
import '../../vendor/assets/javascripts/jquery-ui'

import 'popper.js'              // Dialogos emergentes usados por bootstrap
import * as bootstrap from 'bootstrap'              // Maquetacion y elementos de diseño
import 'chosen-js/chosen.jquery';       // Cuadros de seleccion potenciados
import 'bootstrap-datepicker'
import 'bootstrap-datepicker/dist/locales/bootstrap-datepicker.es.min.js'

import ApexCharts from 'apexcharts'
window.ApexCharts = ApexCharts
import apexes from 'apexcharts/dist/locales/es.json'
Apex.chart = {
  locales: [apexes],
  defaultLocale: 'es',
}

import 'gridstack'

import {AutocompletaAjaxExpreg} from '@pasosdejesus/autocompleta_ajax'
window.AutocompletaAjaxExpreg = AutocompletaAjaxExpreg

import inicializaProsidebar from '../../vendor/javascript/prosidebar/index.js'
window.inicializaProsidebar = inicializaProsidebar

let esperarRecursosSprocketsYDocumento = function (resolver) {
  if (typeof window.puntomontaje == 'undefined') {
    setTimeout(esperarRecursosSprocketsYDocumento, 100, resolver)
    return false
  }
  if (document.readyState !== 'complete') {
    setTimeout(esperarRecursosSprocketsYDocumento, 100, resolver)
    return false
  }
  resolver("otros recursos manejados con sprockets cargados y documento presentado en navegador")
    return true
  }

let promesaRecursosSprocketsYDocumento = new Promise((resolver, rechazar) => {
  esperarRecursosSprocketsYDocumento(resolver)
})

promesaRecursosSprocketsYDocumento.then((mensaje) => {
  console.log('Cargando recursos sprockets')
  var root = window;
  msip_prepara_eventos_comunes(root, '/cor1440pdJ');
  mr519_gen_prepara_eventos_comunes(root);
  heb412_gen_prepara_eventos_comunes(root);
  cor1440_gen_prepara_eventos_comunes(root);

  formato_fecha = 'dd/M/yyyy'
  if ($('meta[name=formato_fecha]').length != 0) {
    formato_fecha = $('meta[name=formato_fecha]').attr('content')
  }
})


document.addEventListener('turbo:load', (e) => {
 /* Lo que debe ejecutarse cada vez que turbo cargue una página,
 * tener cuidado porque puede dispararse el evento turbo varias
 * veces consecutivas al cargarse  la misma página.
 */

  console.log('Escuchador turbo:load')

  msip_ejecutarAlCargarPagina(window) // Establece root.puntomontaje 
  Msip__Motor.ejecutarAlCargarPagina()
  window.inicializaProsidebar()
})


import "./controllers"
