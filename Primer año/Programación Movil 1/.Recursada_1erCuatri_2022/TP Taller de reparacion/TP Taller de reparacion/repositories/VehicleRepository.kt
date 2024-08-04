import entities.Vehicle

object VehicleRepository {

    private var vehicles : MutableList<Vehicle> = mutableListOf()

    init {
        // Vehicle(numberPlate, clientCode, insuranceCap, insuranceCoverageFrom)
        vehicles.add(Vehicle("FGH 698", 1, 10000.0, 10000.0))
        vehicles.add(Vehicle("EGN 234", 2, 5000.0, 400.0))
        vehicles.add(Vehicle("QAW 531", 3, 30000.0, 4000.0))
        vehicles.add(Vehicle("OIH 874", 4, null, null))
    }

    fun get(numberPlate: String) : Vehicle? {
        for (vehicle in vehicles){
            if(vehicle.numberPlate == numberPlate)
                return vehicle
        }
        return  null
    }

    fun get() : MutableList<Client> {
        return clients
    }
}