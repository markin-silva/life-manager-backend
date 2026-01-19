# frozen_string_literal: true

class CategoryBlueprint < Blueprinter::Base
  identifier :id

  fields :key, :name, :color, :icon, :system
end
