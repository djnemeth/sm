package hu.elte.sm.ui.outline

import hu.elte.sm.sM.SMField
import hu.elte.sm.sM.SMFile
import hu.elte.sm.sM.SMMethod
import org.eclipse.xtext.ui.editor.outline.impl.DefaultOutlineTreeProvider
import org.eclipse.xtext.ui.editor.outline.impl.DocumentRootNode

class SMOutlineTreeProvider extends DefaultOutlineTreeProvider {

	def dispatch createChildren(DocumentRootNode rootNode, SMFile file) {
		createNode(rootNode, file)
		if (file.importSection !== null) {
			createNode(rootNode, file.importSection)
		}

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
