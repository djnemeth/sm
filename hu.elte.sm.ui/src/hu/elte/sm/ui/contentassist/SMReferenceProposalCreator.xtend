package hu.elte.sm.ui.contentassist

import com.google.common.base.Predicate
import com.google.inject.Inject
import hu.elte.sm.sM.SMMachine
import hu.elte.sm.sM.SMPackage
import hu.elte.sm.sM.SMRaiseEventExpression
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EReference
import org.eclipse.xtext.resource.IEObjectDescription
import org.eclipse.xtext.scoping.IScope
import org.eclipse.xtext.xbase.jvmmodel.IJvmModelAssociations
import org.eclipse.xtext.xbase.typesystem.IBatchTypeResolver
import org.eclipse.xtext.xbase.ui.contentassist.XbaseReferenceProposalCreator

/**
 * In the reference proposal creator we can filter content assist proposals issued
 * in the context of a cross-reference. This is how we provide entity candidates
 * which are truly relevant for the given cross-reference context.
 */
class SMReferenceProposalCreator extends XbaseReferenceProposalCreator {

	@Inject extension IBatchTypeResolver
	@Inject extension IJvmModelAssociations

	override queryScope(IScope scope, EObject model, EReference ref, Predicate<IEObjectDescription> filter) {
		switch model {
			// In a 'RaiseEvent' expression, only the events of the target machine should be proposed.
			SMRaiseEventExpression case ref == SMPackage.Literals.SM_RAISE_EVENT_EXPRESSION__EVENT: {
				val jvmClass = model.target.resolveTypes.getActualType(model.target).type
				val sourceMachine = jvmClass.primarySourceElement as SMMachine

				if (sourceMachine !== null) {
					scope.allElements.filter[EObjectOrProxy.eContainer == sourceMachine]
				} else {
					IScope.NULLSCOPE.allElements
				}
			}

			default:
				super.queryScope(scope, model, ref, filter)
		}
	}

}
