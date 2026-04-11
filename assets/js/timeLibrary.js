///
/// Description: TARDIS (Time And Relative Dimensions In Space) functions
/// Requires: <none>
///

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function getDaysDiff(from, to) {
    // Calculate difference in milliseconds
    const msPerDay = 24 * 60 * 60 * 1000;
    return Math.floor((to - from) / msPerDay);
    }

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function getTimeSpan(from, to) {
    return(to - from);
    }

/// <summary>
/// </summary>
/// <param name=""></param>
/// <returns></returns>
function isBetween(val, from, to) {
    return ((from <= val) && (val <= to) ? true : false);
    }

