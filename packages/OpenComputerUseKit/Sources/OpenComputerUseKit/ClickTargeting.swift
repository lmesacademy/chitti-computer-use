import ApplicationServices
import CoreGraphics

/// The window's own title-bar controls: close, minimize, zoom, full screen.
///
/// A click fallback must never choose one of these as a stand-in for the
/// click. When an app draws its content without an accessibility node under
/// the point (a GPU-rendered UI such as GPUI or a game), the best AX element
/// containing the point is the window itself, and the smallest pressable
/// descendant of a window is its close button.
let windowChromeSubroles: Set<String> = [
    kAXCloseButtonSubrole as String,
    kAXMinimizeButtonSubrole as String,
    kAXZoomButtonSubrole as String,
    kAXFullScreenButtonSubrole as String,
]

func isWindowChromeControl(subrole: String?) -> Bool {
    guard let subrole else {
        return false
    }
    return windowChromeSubroles.contains(subrole)
}

/// Whether a descendant may stand in for a click at `point`.
///
/// With no point (an `element_index` click) every descendant qualifies, which
/// is the long-standing behaviour. With a point (an x/y click) only one whose
/// frame contains it does: pressing some other child elsewhere in the window
/// is a click on something the caller never pointed at. Both are in the same
/// window-local space the snapshot's `localFrame`s use.
func descendantCandidateIsUnderPoint(frame: CGRect?, point: CGPoint?) -> Bool {
    guard let point else {
        return true
    }
    guard let frame else {
        return false
    }
    return frame.contains(point)
}
