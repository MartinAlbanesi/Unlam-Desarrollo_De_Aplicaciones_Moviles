package com.example.reclyclerviewpractica

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import java.util.ArrayList

class MainActivity : AppCompatActivity() {
    val linearLayoutManager = LinearLayoutManager(this)
    val recycler = findViewById<RecyclerView>(R.id.recycler)
    var listaElementos : MutableList<Int> = ArrayList()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        llenarLista()


        recycler.layoutManager = linearLayoutManager

    }

    private fun llenarLista(){
        var contador = 1
        repeat(100){
            listaElementos.add(contador)
            contador++
        }
    }

}