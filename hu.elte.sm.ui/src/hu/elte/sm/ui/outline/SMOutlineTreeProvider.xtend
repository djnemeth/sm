package hu.elte.sm.ui.outline

import hu.elte.sm.sM.SMField
import hu.elte.sm.sM.SMFile
import hu.elte.sm.sM.SMMethod
import org.eclipse.xtext.ui.editor.outline.impl.DefaultOutlineTreeProvider
import org.eclipse.xtext.ui.editor.outline.impl.DocumentRootNode

/**
 * The outline tree provider defines how the Eclipse Outline should be constructed
 * for files written in our language (press Ctrl+O right now for a Java [technically
 * Xtend] equivalent]).
 * 
 * See: https://www.eclipse.org/Xtext/documentation/310_eclipse_support.html#outline
 */
class SMOutlineTreeProvider extends DefaultOutlineTreeProvider {

	def dispatch createChildren(DocumentRootNode rootNode, SMFile file) {
		// a node for the package declaration
		createNode(rootNode, file)

		// a node for the import section, if exists
		if (file.importSection !== null) {
			createNode(rootNode, file.importSection)
		}

		// a separate node for each machine
		file.machines.forEach [
			createNode(rootNode, it)
		]
	}

	def dispatch isLeaf(SMFile it) {
		true
	}

	def dispatch isLeaf(SMField it) {
		true
	}

	def dispatch isLeaf(SMMethod it) {
		true
	}

}
