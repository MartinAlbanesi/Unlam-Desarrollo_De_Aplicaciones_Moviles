package com.practice.practica_layouts1

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import java.lang.RuntimeException

class MainActivity : AppCompatActivity() {

    private lateinit var user: TextView
    private lateinit var password: TextView
    private lateinit var login: TextView
    private lateinit var errorText: TextView
    private lateinit var welcomeText: TextView
    private lateinit var welcomeImage: ImageView


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        user = findViewById(R.id.textoUsuario)
        password = findViewById(R.id.textoContraseña)
        login = findViewById(R.id.botonLogin)
        errorText = findViewById(R.id.textoError)
        welcomeText = findViewById(R.id.textoBienvenido)
        welcomeImage = findViewById(R.id.imagenBienvenido)

        welcomeText.visibility = View.GONE
        welcomeImage.visibility = View.GONE
        errorText.visibility = View.GONE

        login.setOnClickListener { login() }
    }

    private fun login(){
        val usuario = user.text.toString()
        val contraseña = password.text.toString()
            if(usuario.equals("test") && contraseña.equals("test")){
                errorText.visibility = View.GONE
                welcomeImage.visibility = View.VISIBLE
                welcomeText.visibility = View.VISIBLE
            }else{
                welcomeImage.visibility = View.GONE
                welcomeText.visibility = View.GONE
                errorText.visibility = View.VISIBLE
            }
    }



}