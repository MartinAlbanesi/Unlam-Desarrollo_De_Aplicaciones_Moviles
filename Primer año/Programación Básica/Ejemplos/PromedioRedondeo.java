public class PromedioRedondeo{
	public static void main(String args[]) {
		/* Redondear un número decimal al entero próximo
Si supera 0,5 muestra el superior, de lo contrario muestra el inferior. Use conversiones implicitas*/

		int a;
		double d= 9.50d;
		double b= d + 0.5;
		a=(int)b;
		System.out.println("El numero es:" + d);
		System.out.println("El numero redondeado es" + a);
	}
}
