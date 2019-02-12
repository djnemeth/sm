package hu.elte.sm.scoping

import org.eclipse.xtext.naming.QualifiedName
import org.eclipse.xtext.xbase.scoping.NestedTypeAwareImportNormalizerWithDotSeparator

class SMImportNormalizer extends NestedTypeAwareImportNormalizerWithDotSeparator {

	new(QualifiedName importedNamespace, boolean wildcard, boolean ignoreCase) {
		super(importedNamespace, wildcard, ignoreCase);
	}

	override protected resolveWildcard(QualifiedName relativeName) {
		getImportedNamespacePrefix().append(relativeName)
	}

}
