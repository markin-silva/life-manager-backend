# frozen_string_literal: true

module CategorySerialization
  private

  def serialize_category(category)
    return if category.nil?

    {
      id: category.id,
      key: category.key,
      name: category.name,
      color: category.color,
      icon: category.icon,
      system: category.system
    }
  end
end
