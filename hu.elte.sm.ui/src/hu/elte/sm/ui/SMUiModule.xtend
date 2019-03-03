package hu.elte.sm.ui

import hu.elte.sm.ui.contentassist.SMReferenceProposalCreator
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor
import org.eclipse.xtext.ui.editor.contentassist.AbstractJavaBasedContentProposalProvider.ReferenceProposalCreator

/**
 * Interface-implementation bindings for dependency injection inside
 * the Eclipse UI specific parts of the language infrastructure.
 */
@FinalFieldsConstructor
class SMUiModule extends AbstractSMUiModule {

	override Class<? extends ReferenceProposalCreator> bindAbstractJavaBasedContentProposalProvider$ReferenceProposalCreator() {
		SMReferenceProposalCreator
	}

}
