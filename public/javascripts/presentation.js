var kp = {
  namespace: function(name) {
    var ns = name.split('.'), i, len, o = window;
    for (i = 0, len = ns.length; i < len; i++) {
      o = o[ns[i]] = o[ns[i]] || {};
    }
    return o;
  }
}
