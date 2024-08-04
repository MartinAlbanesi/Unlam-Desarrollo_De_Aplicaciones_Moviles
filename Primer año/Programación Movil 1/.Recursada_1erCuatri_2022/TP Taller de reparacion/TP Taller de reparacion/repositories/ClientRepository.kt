import entities.Client

object ClientRepository {

    private var clients : MutableList<Client> = mutableListOf()

    init {
        // Client(code, name, surname)
        clients.add(Client(1, "Juan", "Dominguez"))
        clients.add(Client(2, "Maria", "None"))
        clients.add(Client(3, "Ramon", "Perez"))
        clients.add(Client(4, "Lucia", "Juarez"))
    }

    fun get(code: Int) : Client? {
        for (client in clients){
            if(client.code == code)
                return client
        }
        return  null
    }

    fun get() : MutableList<Client> {
        return clients
    }
}