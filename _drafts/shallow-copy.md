object = { :a => 1, :b => "xyz" }

# Now object contains a "reference" to the hash object. We can see that with:

irb(main):009:0> puts object.object_id
10898380
=> nil

# Variables are just 'names' for objects. Two objects are the same if they have
# the same object_id (same space in memory). So, we can create two names to the
# same object:

irb(main):011:0> another_ref = object
=> {:a=>1, :b=>"xyz"}
irb(main):012:0> puts another_ref.object_id
10898380
=> nil

# Now, 'another_ref' and 'object' are two names that actually point to the same
# object.

# To create a copy of a hash (different object, same values, different object_id),
# you use 'clone':

irb(main):011:0> another_ref = object
=> {:a=>1, :b=>"xyz"}
irb(main):012:0> puts another_ref.object_id
10898380
=> nil

# As you can see, even if the objects have the same values, they have different
# object_id's, which means that they are two separate entities in memory. This
# is all good.

# But there is one problem...

irb(main):018:0> puts object[:a].object_id, another_ref[:a].object_id, one_clone[:a].object_id
3
3
3
=> nil

irb(main):019:0> puts object[:b].object_id, another_ref[:b].object_id, one_clone[:b].object_id
10898400
10898400
10898400
=> nil

# Even if 'object' and 'one_clone' are different objects, living as separate
# entities in memory, its elements point to the same values.

# Let's play with that a bit:

irb(main):022:0> object[:a] = 10
=> 10
irb(main):023:0> puts object[:a].object_id, another_ref[:a].object_id, one_clone[:a].object_id
21
21
3
=> nil

# So, by assigning a different value, now object[:a] points to a different
# object (and another_ref also, because it's just another name for the same
# 'object'). But 'one_clone' stayed the same. This is because we "rewrote" :a
# to point to a different object. What happens if instead making it point to a
# different object, we modify the object it points to?

irb(main):024:0> object[:b][0] = "Z" # let's modify the string pointed by :b, to have the first character be Z instead
=> "Z"
irb(main):025:0> puts object[:b].object_id, another_ref[:b].object_id, one_clone[:b].object_id
10898400
10898400
10898400
=> nil
irb(main):026:0> puts object, another_ref, one_clone
{:a=>10, :b=>"Zyz"}
{:a=>10, :b=>"Zyz"}
{:a=>1, :b=>"Zyz"}
=> nil

# Wow! one_clone was modified, even if I was changing 'object'. Why? because
# for both, :b pointed to the same string, and we modified the string, not
# where :b pointed to, so the change affected the original and the copies.

# With Marshal, the objects are completely copied recursively, so no references
# end up being the same, and this will not happen.


