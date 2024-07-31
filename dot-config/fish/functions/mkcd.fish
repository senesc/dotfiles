function mkcd -d "Create (-p) directory and cd into it"
	command mkdir $argv
	if test $status = 0
		cd $argv[(count $argv)]
		return 0
	end
end
