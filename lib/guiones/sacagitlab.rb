# frozen_string_literal: true

# require 'byebug'

require "net/http"

proyecto_id = ARGV[0].to_i

GitlabHelper.actualizar_de_gitlab(proyecto_id)
