function ll --wraps='ls -l' --wraps='eza -l' --description 'alias ll=eza -l'
  eza -l $argv
        
end
