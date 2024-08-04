package com.example.reclyclerviewpractica

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class AdaptadorDeNumeros: RecyclerView.Adapter<AdaptadorDeNumeros.ViewHolder>() {


    class ViewHolder(view: View) : RecyclerView.ViewHolder(view){
        var numero:TextView= view.findViewById(R.id.titulo)
    }

    var numeros = ArrayList<Int>()

    override fun getItemCount(): Int {
        return numeros.size
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater
            .from(parent.context)
            .inflate(R.layout.list_item_number, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val numero = numeros[position]
        holder.itemView.numero.text = numeros.numero
        holder.itemView.paridad.text = numeros.paridad

        holder.itemView.setOnClickListener {

        }
    }



}