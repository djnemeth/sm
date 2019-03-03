package hu.elte.sm.typesystem

import hu.elte.sm.sM.SMCheckStateExpression
import hu.elte.sm.sM.SMRaiseEventExpression
import org.eclipse.xtext.xbase.annotations.typesystem.XbaseWithAnnotationsTypeComputer
import org.eclipse.xtext.xbase.typesystem.computation.ITypeComputationState

/**
 * The type computer defines how our custom statements and expressions are typed
 * (remember that in Xbase, even statements can be used as expressions). Note
 * that 'computeTypes' should be called explicitly for subexpressions.
 */
class SMTypeComputer extends XbaseWithAnnotationsTypeComputer {

	def dispatch computeTypes(SMCheckStateExpression checkStateExpr, ITypeComputationState state) {
		state.acceptActualType(getTypeForName(Boolean.TYPE, state))
		state.withoutRootExpectation.computeTypes(checkStateExpr.target)
	}

	def dispatch computeTypes(SMRaiseEventExpression raiseEventExpr, ITypeComputationState state) {
		state.acceptActualType(state.primitiveVoid)
		state.withoutRootExpectation.computeTypes(raiseEventExpr.target)
	}

}
