package hu.elte.sm

import com.google.inject.Binder
import com.google.inject.name.Names
import hu.elte.sm.compiler.SMCompiler
import hu.elte.sm.scoping.SMImportScopeProvider
import hu.elte.sm.typesystem.SMTypeComputer
import org.eclipse.xtext.scoping.IScopeProvider
import org.eclipse.xtext.scoping.impl.AbstractDeclarativeScopeProvider
import org.eclipse.xtext.xbase.compiler.XbaseCompiler
import org.eclipse.xtext.xbase.typesystem.computation.ITypeComputer

/**
 * The runtime module defines interface-implementation bindings for dependency
 * injection (which is used, for example, to populate fields annotated with
 * '@Inject' across the language infrastructure).
 * 
 * See: https://www.eclipse.org/Xtext/documentation/302_configuration.html#dependency-injection
 */
class SMRuntimeModule extends AbstractSMRuntimeModule {

	def Class<? extends ITypeComputer> bindITypeComputer() {
		SMTypeComputer
	}

	def Class<? extends XbaseCompiler> bindXbaseCompiler() {
		SMCompiler
	}

	override configureIScopeProviderDelegate(Binder binder) {
		binder.bind(IScopeProvider)
			.annotatedWith(Names.named(AbstractDeclarativeScopeProvider.NAMED_DELEGATE))
			.to(SMImportScopeProvider)
	}

}
