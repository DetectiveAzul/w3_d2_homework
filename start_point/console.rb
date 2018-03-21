require_relative('./models/bounty')
require('pry')

bounty01_hash = {
  'name' => 'Han Solo',
  'species' => 'Human',
  'bounty_value' => '30000',
  'danger_level' =>'medium',
  'last_known_location' =>'Tatooine',
  'homeworld' =>'Coruscant',
  'favorite_weapon' =>'Hand Blaster',
  'cashed_in' => 'yes',
  'collected_by' => 'Bobba Fett'
}
bounty02_hash = {
  'name' => 'Chewbacca',
  'species' => 'Wookie',
  'bounty_value' => '50000',
  'danger_level' => 'high',
  'last_known_location' => 'Tatooine',
  'homeworld' => 'Kashyyk',
  'favorite_weapon' => 'Wookie Crossbow',
  'cashed_in' => 'no'
}
bounty03_hash = {
  'name' =>'Bulduga',
  'bounty_value' => 25000,
  'danger_level' => 'low',
  'favorite_weapon' => 'Vibroknife',
  'cashed_in' => 'no'
}
bounty04_hash = {
  'name' =>'Greedo',
  'species' =>'Rodian',
  'bounty_value' =>20000,
  'danger_level' =>'high',
  'homeworld' =>'Rodian-2',
  'cashed_in' =>'yes',
  'collected_by' =>'Han Solo'
}

bounty01 = Bounty.new(bounty01_hash)
bounty02 = Bounty.new(bounty02_hash)
bounty03 = Bounty.new(bounty03_hash)
bounty04 = Bounty.new(bounty04_hash)

Bounty.delete_table()
Bounty.create_table()

bounty01.save()
bounty02.save()
bounty03.save()
bounty04.save()

all_bounties_object = Bounty.all()
my_bounty = all_bounties_object.last
my_bounty.cashed_in = 'yes'
my_bounty.collected_by = 'Pawel'
my_bounty.update()

# deleting_bounty = all_bounties_object.first
# deleting_bounty.delete()

# Bounty.delete_all()

bounty_found_by_name = Bounty.find_by_name("Jaime")
# bounty_found_by_name.delete()
# bounty_found_by_id = Bounty.find_by_id(3)
# bounty_found_by_id.delete()
