package hu.elte.sm.ide

import com.google.inject.Guice
import hu.elte.sm.SMRuntimeModule
import hu.elte.sm.SMStandaloneSetup
import org.eclipse.xtext.util.Modules2

/**
 * Related to standalone (i.e. non-Eclipse) usage of the
 * container-independent parts of the implementation.
 */
class SMIdeSetup extends SMStandaloneSetup {

	override createInjector() {
		Guice.createInjector(Modules2.mixin(new SMRuntimeModule, new SMIdeModule))
	}

}
