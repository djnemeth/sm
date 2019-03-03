package hu.elte.sm.ui.quickfix

import com.google.inject.Inject
import hu.elte.sm.sM.SMMachine
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.nodemodel.util.NodeModelUtils
import org.eclipse.xtext.resource.XtextResource
import org.eclipse.xtext.ui.editor.model.edit.IModificationContext
import org.eclipse.xtext.ui.editor.model.edit.ISemanticModification
import org.eclipse.xtext.ui.editor.quickfix.Fix
import org.eclipse.xtext.ui.editor.quickfix.IssueResolutionAcceptor
import org.eclipse.xtext.validation.Issue
import org.eclipse.xtext.xbase.ui.contentassist.ReplacingAppendable
import org.eclipse.xtext.xbase.ui.quickfix.XbaseQuickfixProvider

import static hu.elte.sm.validation.SMIssueCodes.*

/**
 * In the quickfix provider we can define automatically applicable solutions to the
 * possible problems we implicitly listed in our static validation rules (for a Java
 * [technically Xtend] example, hover the word 'Xtend' in the source of this comment
 * and see how it could be added to the dictionary etc.).
 * 
 * See: https://www.eclipse.org/Xtext/documentation/310_eclipse_support.html#quick-fixes
 */
class SMQuickfixProvider extends XbaseQuickfixProvider {

	@Inject extension ReplacingAppendable.Factory

	@Fix(MISSING_INITIAL_STATE)
	def addInitialState(Issue issue, IssueResolutionAcceptor acceptor) {
		acceptor.accept(issue, "Add initial state", "Add initial state 'initial' to the selected machine", null,
			new ISemanticModification() {
				override apply(EObject element, IModificationContext context) {
					val machine = element as SMMachine
					val isEmpty = machine.members.empty

					// find where the code of the new state should be appended
					val offset = if (isEmpty)
							NodeModelUtils.findActualNodeFor(machine).leafNodes.findFirst[text == "{"].offset + 1
						else
							NodeModelUtils.findActualNodeFor(machine.members.head).offset
					val appendable = context.xtextDocument.create(machine.eResource as XtextResource, offset, 0)

					// append the code of the new state
					if (isEmpty) appendable.increaseIndentation.newLine
					appendable.append("init initial")
					if (isEmpty) appendable.decreaseIndentation
					appendable.newLine

					appendable.commitChanges()
				}
			})
	}

}
