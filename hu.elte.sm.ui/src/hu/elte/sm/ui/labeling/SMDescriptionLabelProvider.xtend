package hu.elte.sm.ui.labeling

import org.eclipse.xtext.xbase.ui.labeling.XbaseDescriptionLabelProvider

/**
 * In the description label provider we can define how (unresolved) proxies representing
 * entities of our language should be displayed across the Eclipse UI. This mainly refers
 * to search-related GUIs, but we won't consider proxies for now.
 * 
 * See: https://www.eclipse.org/Xtext/documentation/310_eclipse_support.html#description-label-provider
 */
class SMDescriptionLabelProvider extends XbaseDescriptionLabelProvider {
}
