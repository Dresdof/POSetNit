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

	fun addRelation(lower: Element, higher: Element): Bool do
		if not setHasBoth(lower, higher) then return false
		for element in elements do
			if element == lower then 
				element.addParent(higher)
				return true
			end
		end
		return false
	end

	private fun recursiveFetchForParent(current: Element, parent: Element, response: List[Bool]) do 
		if current.parents.has(parent) then 
			response.push(true)
		else if current.parents.is_empty then
			response.push(false) 
		else
			for currentDirectParent in current.parents do
				recursiveFetchForParent(currentDirectParent, parent, response)
			end
		end
	end

	private fun boolFromBoolList(boolList: List[Bool]): Bool do
		if boolList.has(true) then return true else return false
	end

	fun isLower(element: Element, parent: Element): Bool do
		var list = new List[Bool]
		recursiveFetchForParent(element, parent, list)
		return boolFromBoolList(list)
	end

	private fun setHasBoth(element1: Element, element2: Element): Bool do
		return elements.has(element1) and elements.has(element2) 
	end

	fun isComparable(element1: Element, element2: Element): Bool do
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
