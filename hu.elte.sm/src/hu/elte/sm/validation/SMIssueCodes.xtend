package hu.elte.sm.validation

class SMIssueCodes {
	protected static val ISSUE_CODE_PREFIX = "hu.elte.sm.issue."

	public static val MISSING_INITIAL_STATE = ISSUE_CODE_PREFIX + "missing_initial_state"
	public static val MISSING_EVENT_IN_RAISE = ISSUE_CODE_PREFIX + "missing_event_in_raise"
	public static val NOT_OWNED_EVENT_IN_RAISE = ISSUE_CODE_PREFIX + "not_owned_event_in_raise"
}
