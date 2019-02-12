package hu.elte.sm.scoping

import com.google.inject.Inject
import hu.elte.sm.sM.SMCheckStateExpression
import hu.elte.sm.sM.SMMachine
import hu.elte.sm.sM.SMPackage
import hu.elte.sm.sM.SMState
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EReference
import org.eclipse.xtext.scoping.IScope
import org.eclipse.xtext.scoping.Scopes
import org.eclipse.xtext.xbase.jvmmodel.IJvmModelAssociations
import org.eclipse.xtext.xbase.typesystem.IBatchTypeResolver

class SMScopeProvider extends AbstractSMScopeProvider {

	@Inject extension IJvmModelAssociations
	@Inject extension IBatchTypeResolver

	override getScope(EObject context, EReference reference) {
		switch context {
			SMCheckStateExpression case reference == SMPackage.Literals.SM_CHECK_STATE_EXPRESSION__STATE: {
				val jvmClass = context.target.resolveTypes.getActualType(context.target).type
				val sourceMachine = jvmClass.primarySourceElement as SMMachine

				if (sourceMachine !== null) {
					Scopes.scopeFor(sourceMachine.members.filter(SMState))
				} else {
					IScope.NULLSCOPE
				}
			}

			default: super.getScope(context, reference)
		}
	}

}
