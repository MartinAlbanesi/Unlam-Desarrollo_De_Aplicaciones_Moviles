import entities.SparePart

object SparePartRepository {

    private var spareParts : MutableList<SparePart> = mutableListOf()

    init {
        // SparePart(code, name, price, unitsInStock)
        spareParts.add(SparePart(1, "Batería", 8000.0, 10))
        spareParts.add(SparePart(2, "Bujia", 200.0, 2))
        spareParts.add(SparePart(3, "Motor", 40000.0, 3))
        spareParts.add(SparePart(4, "Kit de distribución", 20000.0, 5))
    }

    fun get(code: Int) : SparePart? {
        for (sparePart in spareParts){
            if(sparePart.code == code)
                return sparePart
        }
        return  null
    }

    fun get() : MutableList<SparePart> {
        return spareParts
    }
}