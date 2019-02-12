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

class SMReferenceProposalCreator extends XbaseReferenceProposalCreator {

	@Inject extension IBatchTypeResolver
	@Inject extension IJvmModelAssociations

	override queryScope(IScope scope, EObject model, EReference ref, Predicate<IEObjectDescription> filter) {
		switch model {
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
