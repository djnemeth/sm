package hu.elte.sm.compiler

import hu.elte.sm.sM.SMCheckStateExpression
import hu.elte.sm.sM.SMRaiseEventExpression
import org.eclipse.xtext.xbase.XExpression
import org.eclipse.xtext.xbase.compiler.XbaseCompiler
import org.eclipse.xtext.xbase.compiler.output.ITreeAppendable

/**
 * The compiler defines how our custom statements and expressions are translated to
 * textual Java code. As we have added our new action code elements to Xbase, we
 * start from 'XbaseCompiler'. In Xbase, an action code element can appear both as
 * a statement and as an expression, therefore we have to define both interpretations
 * of the elements introduced by us.
 */
class SMCompiler extends XbaseCompiler {

	override protected doInternalToJavaStatement(XExpression expression, ITreeAppendable builder, boolean isReferenced) {
		switch expression {
			SMCheckStateExpression,
			SMRaiseEventExpression:
				expression.toJavaStatement(builder)
			default:
				super.doInternalToJavaStatement(expression, builder, isReferenced)
		}
	}

	def dispatch void toJavaStatement(SMCheckStateExpression checkStateExpr, ITreeAppendable it) {
		// do nothing, 'CheckState' is strictly an expression
	}

	/**
	 * Maps a 'RaiseEvent' statement to a 'handleEvent' method call on the target.
	 */
	def dispatch void toJavaStatement(SMRaiseEventExpression raiseEventExpr, ITreeAppendable it) {
		newLine
		toJavaExpression(raiseEventExpr.target, it)
		append(".handleEvent(")
		append(raiseEventExpr.target.lightweightType)
		append('''.Event.«raiseEventExpr.event.name»);''')
	}

	override protected internalToConvertedExpression(XExpression expression, ITreeAppendable builder) {
		switch expression {
			SMCheckStateExpression,
			SMRaiseEventExpression:
				expression.toJavaExpression(builder)
			default:
				super.internalToConvertedExpression(expression, builder)
		}
	}

	/**
	 * Maps a 'CheckState' expression to an 'inState' method call on the target.
	 */
	def dispatch void toJavaExpression(SMCheckStateExpression checkStateExpr, ITreeAppendable it) {
		toJavaExpression(checkStateExpr.target, it)
		append(".inState(")
		append(checkStateExpr.target.lightweightType)
		append('''.State.«checkStateExpr.state.name»)''')
	}

	def dispatch void toJavaExpression(SMRaiseEventExpression raiseEventExpr, ITreeAppendable it) {
		// do nothing, 'RaiseEvent' is strictly a statement
	}

}
