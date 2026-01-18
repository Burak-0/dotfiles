function shredf --wraps='shred -uvz --iterations=5' --description 'alias shredf=shred -uvz --iterations=5'
  shred -uvz --iterations=5 $argv
        
end
