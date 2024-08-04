package com.marvel.ejemplo

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import androidx.recyclerview.widget.LinearLayoutManager
import com.marvel.ejemplo.adapters.ClientsAdapter
import com.marvel.ejemplo.databinding.ActivityMainBinding
import com.marvel.ejemplo.entities.Client
import com.marvel.ejemplo.repositories.ClientRepository

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        setUpRecyclerView()
    }

    private fun setUpRecyclerView() {
        val selectClientClickLister = { client: Client ->
            Toast.makeText(this, "Tocaste el cliente ${client.name} ${client.surname}", Toast.LENGTH_LONG).show()
        }
        binding.recyclerViewClients.adapter = ClientsAdapter(ClientRepository.get(), selectClientClickLister)
        binding.recyclerViewClients.layoutManager = LinearLayoutManager(this)
    }
}