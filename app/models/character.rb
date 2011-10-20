class Character
  include MongoMapper::Document

  key :name, String
  key :slug, String
  key :level, Integer
  one :abilities
  one :defenses
  many :powers
  one :hp, :class => Gauge
  one :surges
  key :action_points, Integer, :default => 1

  many(:skillset, :class => Skill) do
    def [](index)
      case index
      when String then detect { |skill| skill.name.downcase == index.downcase }
      when Symbol then send :[], index.to_s
      else super
      end
    end
  end

  def skills
    if skillset.empty?
      Skill::ALL.each_pair do |k, v|
        skillset << Skill.new(:name => k, :ability => v)
      end
    end
    skillset
  end
end