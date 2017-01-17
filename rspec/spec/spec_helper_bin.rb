# I need to avoid the script to run at exit, so I redefine at_exit before it
# is used by the module. I could write this snippet in the spec itself, but I
# don't like to write code between `require` statements. Looks much neater.
def at_exit(*, &_block)
  nil
end
