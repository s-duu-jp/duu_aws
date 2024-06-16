# generate_combined_typescript_types.rb

require 'rails'
require 'active_model'
require 'fileutils'

# Railsアプリケーションの環境をロード
Rails.application.eager_load!

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

# ActiveRecordモデルを処理
active_record_models = ActiveRecord::Base.descendants.reject { |i| i.abstract_class? }

active_record_models.each do |model|
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

  if model.reflect_on_all_associations.any?
    model.reflect_on_all_associations.select(&:collection?).each do |collection|
      target = collection.compute_class(collection.class_name).model_name.singular.camelcase

      columns << {
        name: "#{collection.name}?",
        ts_type: "#{target}[]"
      }
    end

    model.reflect_on_all_associations.select(&:has_one?).each do |collection|
      target = collection.compute_class(collection.class_name).model_name.singular.camelcase

      columns << {
        name: "#{collection.name}?",
        ts_type: target
      }
    end

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
    #{columns.map { |column| "  #{column[:name]}: #{column[:ts_type]};" }.join("\n")}
    }
  TYPESCRIPT
rescue ActiveRecord::StatementInvalid => e
  # warn "Skipping model #{model.name} due to missing table: #{e.message}"
end

# プレーンなActiveModelモデルを処理
plain_models = ObjectSpace.each_object(Class).select do |klass|
  klass.included_modules.include?(ActiveModel::Model) && !begin
    klass < ActiveRecord::Base
  rescue StandardError
    false
  end
end

plain_models.each do |klass|
  name = klass.name

  attributes = klass.attribute_types.map do |attr_name, attr_type|
    type = conversions[attr_type.type.to_s] || "any"
    {
      name: attr_name,
      ts_type: type
    }
  end

  type_template += <<~TYPESCRIPT

    interface #{name} {
    #{attributes.map { |attr| "  #{attr[:name]}: #{attr[:ts_type]};" }.join("\n")}
    }
  TYPESCRIPT
end

template = <<~TPL
  declare namespace schema {
  #{type_template.indent(2)}
  }
TPL

puts template
