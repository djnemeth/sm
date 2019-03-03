package hu.elte.sm

/**
 * Related to standalone (i.e. non-Eclipse) usage of the core language infrastructure.
 */
class SMStandaloneSetup extends SMStandaloneSetupGenerated {

	def static void doSetup() {
		new SMStandaloneSetup().createInjectorAndDoEMFRegistration()
	}

}
