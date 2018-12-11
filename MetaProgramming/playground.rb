require_relative './composite_base'

class Tiger < CompositeBase
  member_of :population
  member_of :classification
end

class Jungle < CompositeBase
  composite_of :population
end

class Species < CompositeBase
  composite_of :classification
end

tiger = Tiger.new('Tony')
jungle = Jungle.new('Northeastern Jungle')

jungle.add_sub_population(tiger)

species = Species.new('Panthera tigris')
species.add_sub_classification(tiger)

p tiger.parent_population
p tiger.parent_classification
