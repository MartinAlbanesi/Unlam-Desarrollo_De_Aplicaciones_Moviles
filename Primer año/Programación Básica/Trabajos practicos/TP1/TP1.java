public class TP1{  													//declara la clase
	public static void main(String args[]) { 						//abro main
	//Punto 1
		System.out.println("Primera ejecucion exitosa");  			//muestro en pantalla el texto
		
	System.out.println("\t");										//tabulacion de una linea para el proximo punto
	
	//Punto 2
		int nro= 2147483647;										//declaro la variable con int y le asigno un valor
		System.out.println("Prueba con entero sin sumar 1: "+nro);
		nro= nro + 1;
		System.out.println("Prueba con entero mas 1: "+nro);
		
	System.out.println("\t");	
	
	//Punto 3
		//con byte
		byte b= 126 + 1;
		System.out.println("Prueba con byte: "+b);
		//con char
		char c= (char)65534 + 1;
		System.out.println("Prueba con char: "+c);
		//con short
		short s= 32766 + 1;
		System.out.println("Prueba con short: "+s);
		//con long
		long l= 999999999 +1;
		System.out.println("Prueba con long: "+l);
		
		System.out.println("\t");
		
	//Punto 4
		String str= "Buenos dias";
		String nombre= "Martin";
		System.out.println(str +" "+ nombre);
		
		System.out.println("\t");
		
	//Punto 6
		//Los dos tipos que no son primitivos del lenguaje son:  String y Float
		
	//Punto 8
		int preIncremento= 5;
		int posIncremento= 5;
		System.out.println("Preincremento: "+ ++preIncremento);
		System.out.println("Posincremento: "+ posIncremento++);
		// Preincremento aplica el incremento al valor de la variable y luego muestra en pantalla
		// Posincremento muestra el valor en pantalla y luego incrementa el valor de la variable
		
		System.out.println("\t");
		
	//Punto 9
		int capacidadHdd= 1; // Expresada en TERA
		double capacidadDvd= 8.5d; //Expresada en GIGA
		double capacidadBlueRay= 25.0d; //Expresada en GIGA
		int cantidadDeDvdsParaBackupearHdd;
		int cantidadBlueRaysParaBackupearHdd;
		
		int conversionDeUnidad= 1024;
		
		cantidadDeDvdsParaBackupearHdd= ((capacidadHdd*conversionDeUnidad)/(int)capacidadDvd);
		cantidadBlueRaysParaBackupearHdd= ((capacidadHdd*conversionDeUnidad)/(int)capacidadBlueRay);
		
		System.out.println("Cantidad de DVD que se necesitan para backupear el disco rigido: " + cantidadDeDvdsParaBackupearHdd);
		System.out.println("Cantidad de Blue Ray que se necesitan para backupear el disco rigido: " + cantidadBlueRaysParaBackupearHdd);
		
		//para corregir los errores añadi un casteo int a las variables capacidadDvd y capacidadBlueRay aplicando conversion explicita.
		//esto lo hice debido a que una variable de tipo double es mas grande que una variable de tipo int y por lo tanto la conversion no se hace de forma automatica.
		//otra solucion posible es cambiar el tipo de variable de cantidadDeDvdsParaBackupearHdd y cantidadBlueRaysParaBackupearHdd a int.
	}
}




















