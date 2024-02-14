function sctlu --wraps='systemctl --user' --description 'alias sctlu systemctl --user'
  systemctl --user $argv
        
end
