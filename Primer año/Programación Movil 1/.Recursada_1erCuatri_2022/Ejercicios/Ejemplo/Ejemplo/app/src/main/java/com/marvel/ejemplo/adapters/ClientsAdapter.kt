package com.marvel.ejemplo.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.marvel.ejemplo.databinding.ItemClientBinding
import com.marvel.ejemplo.entities.Client

class ClientsAdapter(private val clients: List<Client>, private val selectClientClickLister: (Client) -> Unit) :
    RecyclerView.Adapter<ClientsAdapter.ClientsViewHolder>() {

    class ClientsViewHolder (val binding: ItemClientBinding) : RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ClientsViewHolder {
        val clientBinding = ItemClientBinding.inflate(LayoutInflater.from(parent.context), parent, false)

        return ClientsViewHolder(clientBinding)
    }

    override fun onBindViewHolder(holder: ClientsViewHolder, position: Int) {
        val client = clients[position]

        holder.binding.txtName.text = client.name
        holder.binding.txtSurname.text = client.surname

        holder.binding.clientsCard.setOnClickListener {
            selectClientClickLister(client)
        }
    }

    override fun getItemCount(): Int {
        return clients.size
    }
}