package hu.elte.sm.jvmmodel

import com.google.inject.Inject
import hu.elte.sm.sM.SMEvent
import hu.elte.sm.sM.SMField
import hu.elte.sm.sM.SMMachine
import hu.elte.sm.sM.SMMethod
import hu.elte.sm.sM.SMState
import hu.elte.sm.sM.SMTransition
import org.eclipse.xtext.common.types.JvmEnumerationType
import org.eclipse.xtext.common.types.JvmGenericType
import org.eclipse.xtext.naming.IQualifiedNameProvider
import org.eclipse.xtext.xbase.jvmmodel.AbstractModelInferrer
import org.eclipse.xtext.xbase.jvmmodel.IJvmDeclaredTypeAcceptor
import org.eclipse.xtext.xbase.jvmmodel.JvmTypesBuilder

class SMJvmModelInferrer extends AbstractModelInferrer {

	@Inject extension JvmTypesBuilder
	@Inject extension IQualifiedNameProvider

	def dispatch void infer(SMMachine machine, IJvmDeclaredTypeAcceptor acceptor, boolean isPreIndexingPhase) {
		acceptor.accept(machine.toClass(machine.fullyQualifiedName)) [ jvmClass |
			inferStates(machine, jvmClass)
			val eventEnum = inferEvents(machine, jvmClass)
			inferTransitions(machine, jvmClass, eventEnum)
			inferOthers(machine, jvmClass)
		]
	}

	def private inferStates(SMMachine machine, JvmGenericType jvmClass) {
		val stateEnum = machine.toEnumerationType("State") [ stateEnum |
			machine.members.filter(SMState).forEach [ state |
				stateEnum.members += state.toEnumerationLiteral(state.name)
			]
		]

		jvmClass.members += stateEnum
		jvmClass.members += machine.toField("currentState", stateEnum.typeRef) [
			val initState = machine.members.filter(SMState).findFirst[init]
			initializer = '''State.«initState.name»'''
		]

		jvmClass.members += machine.toMethod("inState", Boolean.TYPE.typeRef) [
			parameters += machine.toParameter("state", stateEnum.typeRef)
			body = '''
				return currentState == state;
			'''
		]
	}

	def private inferEvents(SMMachine machine, JvmGenericType jvmClass) {
		val eventEnum = machine.toEnumerationType("Event") [ eventEnum |
			machine.members.filter(SMEvent).forEach [ event |
				eventEnum.members += event.toEnumerationLiteral(event.name)
			]
		]

		jvmClass.members += eventEnum
		return eventEnum
	}

	def private inferTransitions(SMMachine machine, JvmGenericType jvmClass, JvmEnumerationType eventEnum) {
		jvmClass.members += machine.toMethod("handleEvent", Void.TYPE.typeRef) [
			parameters += machine.toParameter("event", eventEnum.typeRef)

			body = '''
				«FOR transition : machine.members.filter(SMTransition)»
					if (inState(State.«transition.source.name») && event == Event.«transition.trigger.name») {
						currentState = State.«transition.target.name»;
					}
				«ENDFOR»
			'''
		]
	}

	def private inferOthers(SMMachine machine, JvmGenericType jvmClass) {
		machine.members.forEach [ member |
			if (member instanceof SMField) {
				jvmClass.members += member.toField(member.name, member.type)
			} else if (member instanceof SMMethod) {
				jvmClass.members += member.toMethod(member.name, member.type) [
					body = member.body
				]
			}
		]
	}

}
