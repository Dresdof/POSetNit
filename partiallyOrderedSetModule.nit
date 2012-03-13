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

	fun removeElementByName(elementName: String): Bool do
		var element = getElementByName(elementName)
		if element != null then	elements.remove(element) else return false
		return true
	end

	fun renameElementByName(elementName: String, newName: String): Bool do
		var element = getElementByName(elementName)
		if element != null then element.rename(newName) else return false
		return true
	end

	fun getElementByName(elementName: String): nullable Element do
		for element in elements do
			if element.name == elementName then return element
		end
		return null
	end

	fun addRelation(lower: Element, higher: Element): Bool do
		if not setHasBoth(lower, higher) then return false
		
		var parentAdded = false
		var childAdded = false
	
		for element in elements do
			if parentAdded and childAdded then return true
			if element == lower then 
				element.addParent(higher)
				parentAdded = true
			end
			if element == higher then 
				element.addChild(lower)
				childAdded = true
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

	fun getMaximumElements: List[Element] do
		var list = new List[Element]
		for element in elements do
			if element.parents.is_empty then list.push(element)
		end
		return list
	end

	fun getMinimumElements: List[Element] do
		var list = new List[Element]
		for element in elements do
			if element.children.is_empty then list.push(element)
		end
		return list
	end

	fun merge(poSet: PartiallyOrderedSet) do
		
	end

	fun isIncluding(poSet: PartiallyOrderedSet): Bool do
		return false
	end

	redef fun to_s: String do
		var str = ""
		for element in elements do
			str += element.to_s
		end
		return str
	end

	redef fun ==(o) do
		return false
	end
end
