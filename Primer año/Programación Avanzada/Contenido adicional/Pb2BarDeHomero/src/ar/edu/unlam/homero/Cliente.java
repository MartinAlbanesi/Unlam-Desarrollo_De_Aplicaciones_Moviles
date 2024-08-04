package ar.edu.unlam.homero;

public class Cliente implements Comparable<Cliente> {

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public int getEdad() {
		return edad;
	}

	public void setEdad(int edad) {
		this.edad = edad;
	}

	private String nombre;
	private Integer edad;

	public Cliente(String nombre, int edad) {
		this.nombre = nombre;
		this.edad = edad;
	}

	// toString
	@Override
	public String toString() {
		return "Cliente [nombre=" + nombre + ", edad=" + edad + "]";
	}

	// sobre escribir hashCode y equals
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((nombre == null) ? 0 : nombre.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Cliente other = (Cliente) obj;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		return true;
	}

	@Override
	public int compareTo(Cliente otro) {
		return this.nombre.compareTo(otro.nombre);
//		return this.edad.compareTo(otro.edad);
	}

}
