package hu.elte.sm.examples.hospital;

public class Hospital {
	public static void main(String[] args) {
		Doctor doctor = new Doctor();
		doctor.register(new Patient(), "Alice");
		doctor.register(new Patient(), "Bob");
		doctor.work();
	}
}
