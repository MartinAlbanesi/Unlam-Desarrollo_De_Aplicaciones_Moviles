public class TiposConversion {
	public static void main(String[] args) {
		
		//Conversión implícita -> para variables chicas almacenadas dentro de variables más grandes
		int variable;
		long nuevaVariable;
		double otraNuevaVariable;
		
		variable= 123;
		nuevaVariable= variable;
		otraNuevaVariable= variable;
		
		System.out.println("Conversion implicita");
		System.out.println("int: "+variable);
		System.out.println("long: "+nuevaVariable);
		System.out.println("double: "+otraNuevaVariable);
		
		//Conversión explícita -> para variables grandes almacenadas dentro de variables más chicas. Hay pérdida de datos
		double numero;
		float nuevoNumero;
		int otroNuevoNumero;
		
		numero= 130.94564231348897345642;
		nuevoNumero= (float)numero;
		otroNuevoNumero= (int)numero;
		
		System.out.println("\t");
		System.out.println("Conversion explicita:");
		System.out.println("double: "+numero);
		System.out.println("float: "+nuevoNumero);
		System.out.println("int: "+otroNuevoNumero);
	}
}