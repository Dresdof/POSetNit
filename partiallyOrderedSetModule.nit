module partiallyOrderedSetModule

import elementModule

class PartiallyOrderedSet

	# List of the elements from the set.
    var elements: List[Element]
	
	# Default constructor
    init do 
		elements = new List[Element]
    end

	# Adds an element to the set
	# Relations will be preserved
	fun addElement(element: Element) do 
		elements.push(element)
	end
	
	# Returns true if the element has been removed or false if the element has not been found
	fun removeElementByName(elementName: String): Bool do
		var element = getElementByName(elementName)
		if element != null then	elements.remove(element) else return false
		return true
	end
	
	# Returns true if the element has been renamed or false if the element has not been found
	fun renameElementByName(elementName: String, newName: String): Bool do
		var element = getElementByName(elementName)
		if element != null then element.rename(newName) else return false
		return true
	end

	# Returns the first occurence of the name argument or null if no element found
	fun getElementByName(elementName: String): nullable Element do
		for element in elements do
			if element.name == elementName then return element
		end
		return null
	end

	# Adds a relation between two elements
	# The first argument is the child, the second is the parent
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

	# Checks if the first element is a transitive child of the second element
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
	
	# Returns true if the list contains at least one "true"
	# Intern use for the recursiveFetchForParent function
	private fun boolFromBoolList(boolList: List[Bool]): Bool do
		if boolList.has(true) then return true else return false
	end

	# Checks if the first element is a direct or transitive child of the second element in arguments
	fun isLower(element: Element, parent: Element): Bool do
		var list = new List[Bool]
		recursiveFetchForParent(element, parent, list)
		return boolFromBoolList(list)
	end

	private fun setHasBoth(element1: Element, element2: Element): Bool do
		return elements.has(element1) and elements.has(element2) 
	end

	# Returns elements wihout direct parent
	fun getMaximumElements: List[Element] do
		var list = new List[Element]
		for element in elements do
			if element.parents.is_empty then list.push(element)
		end
		return list
	end

	
	# Returns elements without direct child
	fun getMinimumElements: List[Element] do
		var list = new List[Element]
		for element in elements do
			if element.children.is_empty then list.push(element)
		end
		return list
	end
	
	# Returns elements without direct parent into the argument elements list
	fun getMaximumElementsFromSubset(list: List[Element]) : List[Element] do
		var returnList = new List[Element]
		for element in list do
			if element.parents.is_empty then returnList.push(element) else
				var hasParent = false
				for parent in element.parents do
					if list.has(parent) then hasParent = true
				end
				if not hasParent then returnList.push(element)
			end
		end
		return returnList
	end
	
	# Returns elements without direct child into the argument elements list
	fun getMinimumElementsFromSubset(list: List[Element]) : List[Element] do
		var returnList = new List[Element]
		for element in list do
			if element.children.is_empty then returnList.push(element) else
				var hasChild = false
				for child in element.children do
					if list.has(child) then hasChild = true
				end
				if not hasChild then returnList.push(element)
			end
		end
		return returnList
	end

	
	# Fetch of the entire set, looking for transitive parents of an element
	# Function used for intern class use
	private fun recursiveFetchForParents(current: Element, response: List[Element]) do
		if not current.parents.is_empty then
			for element in current.parents do
				if not response.has(element) then response.push(element)
				recursiveFetchForParents(element, response)
			end
		end
	end
	
	# Fetch of the entire set, looking for transitive children of an element
	# Function used for intern class use
	private fun recursiveFetchForChildren(current: Element, response: List[Element]) do
		if not current.children.is_empty then
			for element in current.children do
				if not response.has(element) then response.push(element)
				recursiveFetchForChildren(element, response)
			end
		end
	end

	# Returns a list of every direct and transitive parent of an element
	fun getParents(element: Element): List[Element] do
		var list = new List[Element]
		recursiveFetchForParents(element, list)
		return list
	end
	
	# Returns a list of every direct and transitive child of an element
	fun getChildren(element: Element): List[Element] do
		var list = new List[Element]
		recursiveFetchForChildren(element, list)
		return list
	end

	# Merge of two sets
	# In case of collision, the relation from the current set is prefered
	fun merge(poSet: PartiallyOrderedSet) do
		for	hisElement in poSet.elements do

			var myElement = getElementByName(hisElement.name)

			if myElement != null then
				for currentParent in hisElement.parents do
					if not myElement.hasChild(currentParent) and not myElement.hasParent(currentParent) then
						myElement.parents.push(currentParent)
					end
				end
				for currentChild in hisElement.children do
					if not myElement.hasParent(currentChild) and not myElement.hasChild(currentChild) then 
						myElement.children.push(currentChild)
					end
				end
			else 
				elements.push(hisElement)
			end
		end
	end

	# True if every element and relation in the argument are in the current set.
	fun includes(poSet: PartiallyOrderedSet): Bool do
		for element in poSet.elements do
			var tmp = getElementByName(element.name)
			if tmp != null then
				if tmp != element then return false
			else return false
		end
		return true
	end
	
	# Prints the name, the children and the parents of every element in the set
	redef fun to_s: String do
		var str = ""
		for element in elements do
			str += element.to_s + "\n"
		end
		return str
	end
	
	# Comparison between two sets for their elements and relations
	redef fun ==(o) do
		if not o isa PartiallyOrderedSet then return false
		if o.elements.length != elements.length then return false
		for element in elements do
			var testElement = o.getElementByName(element.name)
			if testElement != null then
				if testElement != element then return false
			end
		end
		return true
	end
end
