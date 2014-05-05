require 'json'

module Jekyll
  class RenderCategoryTagsTag < Liquid::Tag
    safe = true

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      categories = context.registers[:site].categories.keys
      arr = Array.new
      hash = Hash.new
      clean_hash = Hash.new

      categories.each do |category|
        hash[category] = []
        context.registers[:site].categories[category].each do |post|
          post.tags.each do |tag|
            hash[category].push(tag)
          end
        end
        clean_hash[category] = hash[category].uniq
      end

      clean_hash.to_json
    end
  end
end

Liquid::Template.register_tag('render_category_tags_json', Jekyll::RenderCategoryTagsTag)
