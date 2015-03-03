wings = {}

--This grants and revokes the fast priv along with fly when it is set to true.
--If you grant the fast priv on your server, do *not* enable it.
--As when the effect wears off, the fast priv of the player will go as well.
wings.fast = false

--Times for each of the wing types.
--I advise increasing them if fast is not a default priv and wings.fast = false.
--They are at the curent times because any longer allows large distances to be covered with fast.
--Even with this, the gold wings allow players with fast to cover almost 300 nodes.
wings.time = 7
wings.time_bronze = 15
wings.time_gold = 30

--This is how much the time is divided by when mana is used.
--As the wings can be used an unlimited number of times, flight needs to last for a shorter period of time.
wings.mana_divisor = 2

--If you want wings to be avalible only through /giveme or at admin shops, set this to false.
wings.crafts = true

--How much mana is needed for each type of wings.
--By default, the mana mod has a limit of 200 mana.
wings.mana = 100
wings.mana_bronze = 150
wings.mana_gold = 200
