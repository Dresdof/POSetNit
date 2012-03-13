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
	
	redef fun ==(o) do
		if not o isa Element or o is null then return false
		if name != o.name then return false
		if parents.length != o.parents.length then return false
		for i in [0..parents.length] do
			if parents[i] != o.parents[i] then return false
			if children[i] != o.children[i] then return false
		end
		return true
	end

	redef fun to_s: String do
		var str = name + " - "

		if parents.is_empty then str+= "[vide" else str += "["
		for parent in parents do
			str += parent.name
		end
		str += "]"

		if children.is_empty then str += "[vide" else str += "["
		for child in children do
			str += child.name
		end
		str += "]\n"

		return str
	end

end
