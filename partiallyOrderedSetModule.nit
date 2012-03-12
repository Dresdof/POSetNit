module partiallyOrderedSetModule

import elementModule

class PartiallyOrderedSet

    var elements: List[Element]

    init do 
		elements = new List[Element]
    end

	fun addElement(element: Element) do 
		elements.push(element)
	end

	fun removeElement(element: Element): Bool do
		return false
	end

	fun renameElement(element: Element, newName: String): Bool do
		return false
	end

	fun getElementByName(elementName: String): nullable Element do
		return null
	end

	

	private fun fetchForElement(current: Element, searched: Element, response: List[Bool]) do 

		if current.parents.has(searched) then 
			response.push(true)
		else if current.parents.is_empty then
			response.push(false) 
		else
			for parent in current.parents do
				fetchForElement(parent, searched, response)
			end
		end
	end

	fun isComparable(element1: Element, element2: Element): Bool do
		return false
	end

	fun isLower(lowElement: Element, highElement: Element): Bool do
		return false
	end

	fun merge(poSet: PartiallyOrderedSet) do
		
	end

	fun isIncluding(poSet: PartiallyOrderedSet): Bool do
		return false
	end

	redef fun to_s: String do
		return "Not yet implemented"
	end

	redef fun ==(o) do
		return false
	end
end
