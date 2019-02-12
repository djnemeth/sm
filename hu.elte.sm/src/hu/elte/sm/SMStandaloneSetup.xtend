package hu.elte.sm

class SMStandaloneSetup extends SMStandaloneSetupGenerated {

	def static void doSetup() {
		new SMStandaloneSetup().createInjectorAndDoEMFRegistration()
	}

}
