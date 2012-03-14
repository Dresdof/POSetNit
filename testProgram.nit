import partiallyOrderedSetModule

var characters = "ABCDEFGHIJ"
# Créer un ordre partiel vide.
var poSet = new PartiallyOrderedSet

# Ajouter des éléments
for character in characters do
	poSet.addElement(new Element(character.to_s))
end

poSet.addRelation(poSet.elements[1], poSet.elements[0]) # B < C
poSet.addRelation(poSet.elements[2], poSet.elements[0]) # C < A
poSet.addRelation(poSet.elements[3], poSet.elements[1]) # D < B
poSet.addRelation(poSet.elements[4], poSet.elements[1]) # E < B
poSet.addRelation(poSet.elements[9], poSet.elements[3]) # J < D
poSet.addRelation(poSet.elements[9], poSet.elements[4]) # J < E
poSet.addRelation(poSet.elements[5], poSet.elements[2]) # F < C
poSet.addRelation(poSet.elements[6], poSet.elements[5]) # G < F
poSet.addRelation(poSet.elements[7], poSet.elements[6]) # H < G
poSet.addRelation(poSet.elements[8], poSet.elements[7]) # I < H

# Lister les éléments.
print "Liste des éléments de l'ordre : Element - [enfants][parents]"
print poSet

# Indiquer qu'un élément est inférieur à un autre
# Savoir si un élément est inférieur à un autre
print "A est il inférieur à D ? " + poSet.isLower(poSet.elements[0],poSet.elements[3]).to_s
print "H est il inférieur à C ? " + poSet.isLower(poSet.elements[7],poSet.elements[2]).to_s + "\n"

# Afficher les éléments maximaux.
print "Éléments maximaux de l'ensemble :"
for element in poSet.getMaximumElements do
	print element
end
print ""

# Afficher les éléments minimaux.
print "Éléments minimaux de l'ensemble :"
for element in poSet.getMinimumElements do
	print element
end
print ""

# Afficher les éléments plus grands qu'un élément.
print "Éléments plus grands que J :"
for element in poSet.getParents(poSet.elements[9]) do
	print element
end
print ""

# Afficher les éléments plus petits qu'un élément.
print "Éléments plus petits que F :"
for element in poSet.getChildren(poSet.elements[5]) do
	print element
end
print ""

# Afficher les éléments directements plus grands qu'un élément.
print "Parents directs de J :"
for element in poSet.elements[9].parents do
	print element
end
print ""

# Afficher les éléments directements plus petits qu'un élément.
print "Enfants directs de A :"
for element in poSet.elements[0].children do
	print element
end
print ""

print "Sous-ensemble : F G B C D"
var subset = new List[Element]

subset.push(poSet.elements[5]) # F
subset.push(poSet.elements[6]) # G
subset.push(poSet.elements[1]) # B
subset.push(poSet.elements[2]) # C
subset.push(poSet.elements[3]) # D

# Afficher les éléments maximaux d'un sous-ensemble donné.
print "Elements maximaux du sous-ensemble :"
for element in poSet.getMaximumElementsFromSubset(subset) do
	print element.to_s
end
print ""

# Afficher les éléments minimaux d'un sous-ensemble donné.
print "Elements minimaux du sous-ensemble :"
for element in poSet.getMinimumElementsFromSubset(subset) do
	print element.to_s
end
print ""

# Tester l'égalité entre deux ordres.


# Créer un ordre partiel vide.
var poSet2 = new PartiallyOrderedSet

# Ajouter des éléments
for character in characters do
	poSet2.addElement(new Element(character.to_s))
end

print "Tester l'inclusion d'un ordre dans un autre :"
print "poSet2 : mêmes éléments et relations que poSet."
poSet2.addRelation(poSet2.elements[1], poSet2.elements[0]) # B < C
poSet2.addRelation(poSet2.elements[2], poSet2.elements[0]) # C < A
poSet2.addRelation(poSet2.elements[3], poSet2.elements[1]) # D < B
poSet2.addRelation(poSet2.elements[4], poSet2.elements[1]) # E < B
poSet2.addRelation(poSet2.elements[9], poSet2.elements[3]) # J < D
poSet2.addRelation(poSet2.elements[9], poSet2.elements[4]) # J < E
poSet2.addRelation(poSet2.elements[5], poSet2.elements[2]) # F < C
poSet2.addRelation(poSet2.elements[6], poSet2.elements[5]) # G < F
poSet2.addRelation(poSet2.elements[7], poSet2.elements[6]) # H < G
poSet2.addRelation(poSet2.elements[8], poSet2.elements[7]) # I < H


var equality = poSet == poSet2
print "poSet == poSet2 ? " + equality.to_s

var poSet3 = new PartiallyOrderedSet

print "Nouvel ensemble poSet3 : B D E J"
poSet3.addElement(poSet.elements[1]) # B
poSet3.addElement(poSet.elements[3]) # D
poSet3.addElement(poSet.elements[4]) # E
poSet3.addElement(poSet.elements[9]) # J

equality = poSet == poSet3
print "poSet == poSet 3 ? " + equality.to_s

print ""
print "poSet3 est-il inclus dans poSet ? : " + poSet.includes(poSet3).to_s 
print "poSet est-il inclus dans poSet3 ? : " + poSet3.includes(poSet).to_s + "\n"

# Fusion de deux ordres.
var poSet4 = new PartiallyOrderedSet

print "Nouvel ensemble poSet4 : A C F L K"
var eltA2 = new Element("A")
var eltC2 = new Element("C")
var eltF2 = new Element("F")
var eltL = new Element("L")
var eltK = new Element("K")

poSet4.addElement(eltA2)
poSet4.addElement(eltC2)
poSet4.addElement(eltF2)
poSet4.addElement(eltL)
poSet4.addElement(eltK)

poSet4.addRelation(eltA2, eltC2)
poSet4.addRelation(eltK, eltC2)
poSet4.addRelation(eltF2, eltC2)
poSet4.addRelation(eltL, eltF2)

poSet.merge(poSet4)

print "Éléments de poSet, après fusion :"
print poSet
