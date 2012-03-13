module elementModule

class Element
	
	var parents: List[Element]
	var children: List[Element]
	var name: String

	init(name: String) do 
		self.name = name
		self.parents = new List[Element]
		self.children = new List[Element]
	end

	fun addParent(element: Element) do
		parents.push(element)
	end

	fun addChild(element: Element) do
		children.push(element)
	end

	fun rename(newName: String) do
		name = newName
	end

	fun hasParent(element: Element): Bool do
		for parent in parents do
			if parent.name == element.name then return true
		end
		return false
	end
	
	fun hasChild(element: Element): Bool do
		for child in children do
			if child.name == element.name then return true
		end
		return false
	end

	redef fun ==(o) do
		if not o isa Element or o is null then return false
		if name != o.name then return false
		if parents.length != o.parents.length then return false

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
