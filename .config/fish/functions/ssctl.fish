function ssctl --wraps='sudo systemctl' --description 'alias ssctl sudo systemctl'
  sudo systemctl $argv
        
end
