import partiallyOrderedSetModule

print "-- Début du programme --"

# Créer un ordre partiel vide.
var poSet = new PartiallyOrderedSet()

# Ajouter des éléments.
var eltA = new Element ("A")
var eltB = new Element ("B")
var eltC = new Element ("C")
var eltD = new Element ("D")
var eltE = new Element ("E")
var eltF = new Element ("F")
var eltG = new Element ("G")
var eltH = new Element ("H")
var eltI = new Element ("I")
var eltJ = new Element ("J")

poSet.addElement(eltA)
poSet.addElement(eltB)
poSet.addElement(eltC)
poSet.addElement(eltD)
poSet.addElement(eltE)
poSet.addElement(eltF)
poSet.addElement(eltG)
poSet.addElement(eltH)
poSet.addElement(eltI)
poSet.addElement(eltJ)

# Ajouter des relations.
poSet.addRelation(eltB, eltA)
poSet.addRelation(eltC, eltA)
poSet.addRelation(eltD, eltB)
poSet.addRelation(eltE, eltB)
poSet.addRelation(eltJ, eltD)
poSet.addRelation(eltJ, eltE)
poSet.addRelation(eltF, eltC)
poSet.addRelation(eltG, eltF)
poSet.addRelation(eltH, eltG)
poSet.addRelation(eltI, eltH)


# Lister les éléments.
#print poSet

# Afficher une relation.
#print poSet.isLower(eltA,eltD)

# Afficher les éléments maximaux.
#print poSet.getMaximumElements

# Afficher les éléments minimaux.

# Afficher les éléments plus grands qu'un élément.

# Afficher les éléments plus petits qu'un élément.

# Afficher les éléments directements plus grands qu'un élément.

# Afficher les éléments directements plus petits qu'un élément.

# Afficher les éléments maximaux d'un sous-ensemble donné.

# Afficher les éléments minimaux d'un sous-ensemble donné.

# Tester l'égalité entre deux ordres.

# Tester l'inclusion d'un ordre dans un autre.

# Fusion de deux ordres.

print "-- Fin du programme --"
