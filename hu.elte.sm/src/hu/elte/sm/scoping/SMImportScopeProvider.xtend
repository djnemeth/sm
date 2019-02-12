package hu.elte.sm.scoping

import org.eclipse.xtext.naming.QualifiedName
import org.eclipse.xtext.xbase.scoping.XImportSectionNamespaceScopeProvider

class SMImportScopeProvider extends XImportSectionNamespaceScopeProvider {

	override protected doCreateImportNormalizer(QualifiedName importedNamespace, boolean wildcard, boolean ignoreCase) {
		new SMImportNormalizer(importedNamespace, wildcard, ignoreCase)
	}

}
