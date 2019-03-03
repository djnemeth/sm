package hu.elte.sm.scoping

import org.eclipse.xtext.naming.QualifiedName
import org.eclipse.xtext.xbase.scoping.NestedTypeAwareImportNormalizerWithDotSeparator

/**
 * This custom import normalizer makes it possible to refer to entities defined in
 * our language with partially qualified names as well. Otherwise we wouldn't be
 * able to refer to, say, machine 'foo.M' just by 'M' inside package 'foo'.
 */
class SMImportNormalizer extends NestedTypeAwareImportNormalizerWithDotSeparator {

	new(QualifiedName importedNamespace, boolean wildcard, boolean ignoreCase) {
		super(importedNamespace, wildcard, ignoreCase);
	}

	override protected resolveWildcard(QualifiedName relativeName) {
		getImportedNamespacePrefix().append(relativeName)
	}

}
