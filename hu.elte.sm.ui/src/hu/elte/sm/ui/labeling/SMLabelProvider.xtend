package hu.elte.sm.ui.labeling

import com.google.inject.Inject
import hu.elte.sm.sM.SMEvent
import hu.elte.sm.sM.SMField
import hu.elte.sm.sM.SMFile
import hu.elte.sm.sM.SMMachine
import hu.elte.sm.sM.SMMethod
import hu.elte.sm.sM.SMState
import hu.elte.sm.sM.SMTransition
import org.eclipse.emf.edit.ui.provider.AdapterFactoryLabelProvider
import org.eclipse.jface.viewers.StyledString
import org.eclipse.xtext.xbase.ui.labeling.XbaseLabelProvider

/**
 * In the label provider we can define how entities of our language should be
 * displayed across the Eclipse UI. One examples is the outline view (press
 * Ctrl+O right now to show the Java [technically Xtend] equivalent).
 * 
 * See: https://www.eclipse.org/Xtext/documentation/310_eclipse_support.html#label-provider
 */
class SMLabelProvider extends XbaseLabelProvider {

	@Inject
	new(AdapterFactoryLabelProvider delegate) {
		super(delegate)
	}

	def image(SMFile it) {
		"file.gif"
	}

	def image(SMTransition it) {
		"transition.gif"
	}

	def image(SMMachine it) {
		"machine.gif"
	}

	def image(SMEvent it) {
		"event.gif"
	}

	def image(SMMethod it) {
		"method.gif"
	}

	def image(SMField it) {
		"field.gif"
	}

	def image(SMState it) {
		if (init) "initial.gif" else "state.gif"
	}

	def text(SMField it) {
		styledText(name, type.simpleName)
	}

	def text(SMMethod it) {
		val params = if (parameters.empty) "()"
			else parameters.join("(", ", ", ")", [parameterType.simpleName])
		styledText(name + params, type.simpleName)
	}

	def text(SMTransition it) {
		new StyledString(
			'''«source.name» to «target.name» on «trigger.name»''',
			StyledString::DECORATIONS_STYLER
		)
	}

	/**
	 * For the common 'name : details' text, where the part starting from the colon
	 * is styled differently.
	 */
	def private styledText(String name, String details) {
		new StyledString(name)
			.append(
		new StyledString(" : " + details, StyledString::DECORATIONS_STYLER))
	}

}
