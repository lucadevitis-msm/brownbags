require 'base_spec_helper'

# I need to avoid the script to run at exit, so I redefine at_exit before it
# is used by the module.
def at_exit(*, &_block)
  nil
end
