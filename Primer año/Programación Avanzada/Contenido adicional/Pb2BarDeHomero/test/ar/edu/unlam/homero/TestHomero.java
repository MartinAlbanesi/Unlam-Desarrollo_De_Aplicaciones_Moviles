package ar.edu.unlam.homero;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class TestHomero {

	@Test
	public void verificarQueEstenPresentesLosClientes() {

		Cliente pepe = new Cliente("Pepito", 54);
		Cliente marta = new Cliente("Martus", 47);
		Cliente benjamin = new Cliente("Benja", 17);
		Integer valorEsperado = 3;

		Bar homero = new Bar();

		homero.agregarCliente(pepe);
		homero.agregarCliente(marta);
		homero.agregarCliente(benjamin);
		Integer valoObtenido = homero.obtenerCantidadDeClientes();

		assertEquals(valorEsperado, valoObtenido);
	}

	@Test
	public void queSeCuentenLosMayoresDeEdad() {

		Cliente pepe = new Cliente("Pepito", 54);
		Cliente marta = new Cliente("Martus", 47);
		Cliente benjamin = new Cliente("Benja", 17);
		Integer valorEsperado = 2;

		Bar homero = new Bar();

		homero.agregarCliente(pepe);
		homero.agregarCliente(marta);
		homero.agregarCliente(benjamin);

		Integer valoObtenido = homero.obtenerCantidadDeClientesMayoresDeEdad();

		assertEquals(valorEsperado, valoObtenido);
	}

	@Test
	public void verificarQueNoHayaClientesRepetidos() {

		Cliente pepe = new Cliente("Pepito", 54);
		Cliente marta = new Cliente("Martus", 47);
		Cliente benjamin = new Cliente("Benja", 17);
		Cliente benjamin1 = new Cliente("Benja", 17);
		Cliente pepe1 = new Cliente("Pepito", 54);
		Integer valorEsperado = 3;

		Bar homero = new Bar();

		homero.agregarCliente(pepe);
		homero.agregarCliente(marta);
		homero.agregarCliente(benjamin);
		homero.agregarCliente(benjamin1);
		homero.agregarCliente(pepe1);

//			System.out.println(homero.getClientes());

		Integer valoObtenido = homero.obtenerCantidadDeClientes();

		assertEquals(valorEsperado, valoObtenido);
	}

//	@Test
//	public void verificarQueLosClientesEstenOrdenadosPorNombre() {
//
//		Cliente pepe = new Cliente("Pepito", 54);
//		Cliente marta = new Cliente("Martus", 47);
//		Cliente sergio = new Cliente("Sergio", 17);
//		Cliente andres = new Cliente("Andres", 17);
//		Cliente jose = new Cliente("Jose", 54);
//		Cliente jocesito = new Cliente("Jose", 22);
//
//		Integer valorEsperado = 5;
//		Cliente valorEsperado1 = andres;
//		Cliente valorEsperado2 = sergio;
//		Bar homero = new Bar();
//
//		homero.agregarCliente(pepe);
//		homero.agregarCliente(marta);
//		homero.agregarCliente(sergio);
//		homero.agregarCliente(jose);
//		homero.agregarCliente(jocesito);
//		homero.agregarCliente(andres);
//		Integer valoObtenido = homero.obtenerCantidadDeClientes();
//		Cliente valoObtenido1 = homero.getClientes().first();
//		Cliente valoObtenido2 = homero.getClientes().last();
//
//		assertEquals(valorEsperado, valoObtenido);
//		assertEquals(valorEsperado1, valoObtenido1);
//		assertEquals(valorEsperado2, valoObtenido2);
//	}
}