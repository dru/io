Path := Object clone do(
	//metadoc Path category FileSystem

	//doc Path hasDriveLetters returns true if the platform requires DOS C: style drive letters.
	hasDriveLetters := System platform containsAnyCaseSeq("Windows") or System platform containsAnyCaseSeq("Cygwin")

	//doc Path with(aSequence) Returns a new Path object for the given Sequence.
	with := method(
		s := Sequence clone
		call message arguments foreach(arg,
			v := call sender doMessage(arg)
			//writeln("appendPathSeq(", v type, ")")
			if(v == nil, v = "")
			s appendPathSeq(v)
		)
		s asSymbol
	)

	//doc Path isPathAbsolute Returns true if path is absolute, false if it is relative.
	isPathAbsolute := method(p,
		absolute := false
		try (
			if (hasDriveLetters,
				absolute = p at(0) isLetter and p at(1) asCharacter == ":" or p at(0) asCharacter == "/" or p at(0) asCharacter == "\\"
			,
				absolute = p at(0) asCharacter == "/"
			)
		)
		absolute
	)

	//doc Path absolute Returns an absolute version of the path.
	absolute := method(path,
		if(isPathAbsolute(path),
			path
		,
			with(Directory currentWorkingDirectory, path)
		)
	)
	
	//doc Path thisSourceFilePath Uses call message label to return an absolute path to the file that contains the sender.
	thisSourceFilePath := method(
		Path absolute(call message label)
	)
)

