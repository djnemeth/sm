package hu.elte.sm.examples.count;

public class Count {
	public static void main(String[] args) {
		Counter counter = new Counter();
		counter.start();

		for (int i = 0; i < 14; ++i) {
			counter.tick();
			if (i % 3 == 0) {
				counter.handleEvent(Counter.Event.ToggleMode);
			}
		}

		int result = counter.result();
		System.out.print("Result: " + result);
	}
}
