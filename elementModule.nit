module elementModule

class Element
	
	# Element's direct parents
	var parents: List[Element]
	
	# Element's direct children
	var children: List[Element]
	
	# Element's name (You don't say ?)
	var name: String

	# Constructor with name's argument
	init(name: String) do 
		self.name = name
		self.parents = new List[Element]
		self.children = new List[Element]
	end

	# Adds a direct parent for the element
	fun addParent(element: Element) do
		parents.push(element)
	end

	# Adds a direct child for the element
	fun addChild(element: Element) do
		children.push(element)
	end

	# Setter for the name
	fun rename(newName: String) do
		name = newName
	end

	# Looks for the parent by name
	fun hasParent(element: Element): Bool do
		for parent in parents do
			if parent.name == element.name then return true
		end
		return false
	end
	
	# Looks for the child by name
	fun hasChild(element: Element): Bool do
		for child in children do
			if child.name == element.name then return true
		end
		return false
	end
	
	# Compares names, names of the children and names of the parents
	redef fun ==(o) do
		if not o isa Element or o is null then return false
		if name != o.name then return false
		if parents.length != o.parents.length then return false
		if children.length != o.parents.length then return false

		for myParent in parents do
			var found = false
			for hisParent in o.parents do
				if hisParent.name == myParent.name then found = true
			end
			if not found then return false
		end

		for myChild in children do
			var found = false
			for hisChild in o.children do
				if hisChild.name == myChild.name then found = true
			end
			if not found then return false
		end
		return true
	end

	# Returns a string with element's name and its children and parents
	redef fun to_s: String do
		var str = name + " - "

		if children.is_empty then str += "[vide" else str += "["
		for child in children do
			str += child.name
		end
		str += "]"

		if parents.is_empty then str+= "[vide" else str += "["
		for parent in parents do
			str += parent.name
		end
		str += "]"

		return str
	end

end
