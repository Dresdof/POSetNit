module elementModule

class Element
	
	var parents: List[Element]
	var name: String

	init(name: String) do 
		self.name = name
		self.parents = new List[Element]
	end

	fun addParent(element: Element) do
		parents.push(element)
	end

	redef fun ==(o) do
		if not o isa Element or o is null then return false
		return name == o.name 
	end

end
