package ar.edu.unlam.homero;

import java.util.TreeSet;

public class Bar {

	private TreeSet<Cliente> clientes;

//	private List<Cliente> clientes;
//	private Set<Cliente> clientes;

	public Bar() {
		this.clientes = new TreeSet<Cliente>();

//		this.clientes = new ArrayList<Cliente>();
//		this.clientes = new HashSet<Cliente>();
	}

	public Boolean agregarCliente(Cliente cliente) {
		return clientes.add(cliente);
	}

	public Integer obtenerCantidadDeClientes() {
		return clientes.size();
	}

	public Integer obtenerCantidadDeClientesMayoresDeEdad() {
		Integer mayores = 0;

		for (Cliente actual : this.clientes) {
			if (actual.getEdad() >= 18) {
				mayores++;
			}
		}
		return mayores;
	}

	public TreeSet<Cliente> getClientes() {
		return clientes;
	}

}
