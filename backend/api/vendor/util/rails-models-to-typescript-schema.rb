# USAGE:
# rails runner rails-models-to-typescript-schema.rb > app/javascript/types/schema.d.ts

Rails.application.eager_load!
models = ActiveRecord::Base.descendants.reject { |i| i.abstract_class? }

belongs_to = true
has_many = true

conversions = {
  "string" => "string",
  "inet" => "string",
  "text" => "string",
  "json" => "Record<string, any>",
  "jsonb" => "Record<string, any>",
  "binary" => "string",
  "integer" => "number",
  "bigint" => "number",
  "float" => "number",
  "decimal" => "number",
  "boolean" => "boolean",
  "date" => "string",
  "datetime" => "string",
  "timestamp" => "string",
  "datetime_with_timezone" => "string"
}
type_template = ""

models.each do |model|
  name = model.model_name.singular.camelcase

  columns = model.columns.map do |i|
    type = conversions[i.type.to_s]
    if (enum = model.defined_enums[i.name])
      type = enum.keys.map { |k| "'#{k}'" }.join(" | ")
    end

    {
      name: i.name,
      ts_type: i.null ? "#{type} | null" : type
    }
  end

  if has_many
    model.reflect_on_all_associations.select(&:collection?).each do |collection|
      target = collection.compute_class(collection.class_name).model_name.singular.camelcase

      columns << {
        name: "#{collection.name}?",
        ts_type: "#{target}[]"
      }
    end
  end
  if has_many
    model.reflect_on_all_associations.select(&:has_one?).each do |collection|
      target = collection.compute_class(collection.class_name).model_name.singular.camelcase

      columns << {
        name: "#{collection.name}?",
        ts_type: target
      }
    end
  end

  if belongs_to
    model.reflect_on_all_associations.select(&:belongs_to?).reject(&:polymorphic?).each do |collection|
      target = collection.compute_class(collection.class_name).model_name.singular.camelcase

      columns << {
        name: "#{collection.name}?",
        ts_type: target
      }
    end
  end

  type_template += <<~TYPESCRIPT

    interface #{name} {
    #{columns.map { |column| "  #{column[:name]}: #{column[:ts_type]}; " }.join("\n")}
    }
  TYPESCRIPT
rescue ActiveRecord::StatementInvalid => e
  # warn "Skipping model #{model.name} due to missing table: #{e.message}"
end

template = <<~TPL
  declare namespace schema {
  #{type_template.indent(2)}
  }
TPL

puts template
