/// @func wrap(_a, _min, _max)
/// @desc Wraps a value inside the range
/// @param {Real} _a
/// @param {Real} _min
/// @param {Real} _max
function wrap(_a, _min, _max) {
  return (_a >= 0 ? _min : _max) + (_a mod (_max - _min));
}

/// @func in_range(_val, _low, _high)
/// @desc Returns whether the value is contained inclusively within the given interval
/// @arg {Real} _val
/// @arg {Real} _low
/// @arg {Real} _high
/// @returns {Bool}
function in_range(_val, _low, _high) {
  gml_pragma("forceinline");
  return (_val >= _low) && (_val <= _high);
}
