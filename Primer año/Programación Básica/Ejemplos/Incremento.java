public class Incremento{
	public static void main(String args[]) {
		//Incrementar una variable utilizando preincremento y posincremento
		int x=0;
		int y=0;
		int preincremento=5;
		int posincremento=5;
		
		System.out.println("Variable x sin incrementar " +x);
		System.out.println("Variable y sin incrementar " +y);
		
		//equivalente a ++x (preincremento)
		preincremento++;
		x= 8 + preincremento;
		
		//equivalente a x++ (posincremento) INCREMENTA LA VARIABLE "POSINCREMENTO" LUEGO DE REALIZAR LA SUMA
		y= 8 + posincremento;
		posincremento++;
		
		System.out.println("Usando preincremento " +x);
		System.out.println("Usando posincremento: " +y);
		
		//metodo simple
		x=0;
		y=0;
		System.out.println("METODO SIMPLE");
		System.out.println("Usando preincremento: " + ++x);
		System.out.println("Usando posincremento: " + y++);
	}
}
