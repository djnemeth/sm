package hu.elte.sm.ui

import hu.elte.sm.ui.contentassist.SMReferenceProposalCreator
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor
import org.eclipse.xtext.ui.editor.contentassist.AbstractJavaBasedContentProposalProvider.ReferenceProposalCreator

@FinalFieldsConstructor
class SMUiModule extends AbstractSMUiModule {

	override Class<? extends ReferenceProposalCreator> bindAbstractJavaBasedContentProposalProvider$ReferenceProposalCreator() {
		SMReferenceProposalCreator
	}

}
