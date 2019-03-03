package hu.elte.sm.scoping

import org.eclipse.xtext.naming.QualifiedName
import org.eclipse.xtext.xbase.scoping.XImportSectionNamespaceScopeProvider

/**
 * This import scope provider was defined for the sole purpose of providing our
 * custom import normalizer in place of the default one.
 */
class SMImportScopeProvider extends XImportSectionNamespaceScopeProvider {

	override protected doCreateImportNormalizer(QualifiedName importedNamespace, boolean wildcard, boolean ignoreCase) {
		new SMImportNormalizer(importedNamespace, wildcard, ignoreCase)
	}

}
