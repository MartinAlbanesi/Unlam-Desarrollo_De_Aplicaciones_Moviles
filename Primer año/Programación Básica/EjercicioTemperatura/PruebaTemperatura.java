package ar.edu.unlam.pb1.trabajoPractico04;

public class PruebaTemperatura {
	
	public static void main(String[] args) {
		double temperturaArgentina = 11.0; // Utiliza la unidad de medida Celsius
		double temperturaEEUU = 56.0; // Utiliza la unidad de medida Farenheit
		
		Temperatura termometro = new Temperatura();

		// Argentina
		System.out.println("Argentina");
		//unidadDeseada = Temperatura.CELSIUS;
		termometro.setValor(temperturaArgentina);
		System.out.println("La temperatura argentina es de " + termometro.getValor() + " grados centígrados");
		System.out.println("La temperatura argentina es de " + termometro.convertir(Temperatura.FARENHEIT) + " grados farenheit");
		System.out.println("La temperatura absoluta en argentina es de " + termometro.convertir(Temperatura.KELVIN) + " grados kelvin");		

		// EEUU
		System.out.println("\nEEUU");
		termometro.setValor(temperturaEEUU, Temperatura.FARENHEIT);
		System.out.println("La temperatura EEUU es de " + termometro.convertir(Temperatura.FARENHEIT) + " grados farenheit");
		System.out.println("La temperatura absoluta en EEUU es de " + termometro.convertir(Temperatura.KELVIN) + " grados kelvin");		

		// Temperaturas inválidas
		System.out.println("Intentamos guarda -300° C");
		temperturaArgentina = -300.0;
		termometro.setValor(temperturaArgentina);
		System.out.println("La temperatura argentina es de " + termometro.getValor() + " grados centígrados");
		termometro.setValor(-5, Temperatura.KELVIN);
		System.out.println("La temperatura argentina es de " + termometro.getValor() + " grados centígrados");
	}

}
