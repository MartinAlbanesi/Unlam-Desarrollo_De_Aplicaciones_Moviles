package com.marvel.ejemplo.repositories

import com.marvel.ejemplo.entities.Client

object ClientRepository {

    private var clients : MutableList<Client> = mutableListOf()

    init {
        clients.add(Client(1, "Brian", "Bayarri", "2020-01-01"))
        clients.add(Client(2, "John", "Jackson", "2021-04-15"))
        clients.add(Client(3, "Elizabeth", "Larrson", "2021-01-01"))
        clients.add(Client(4, "Stefany", "Kroscen", "2020-12-22"))
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

    fun add(client: Client) : Boolean{
        return clients.add(client)
    }

    fun remove(client: Client) : Boolean {
        return clients.remove(client)
    }

}