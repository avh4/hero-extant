Elm.Native.Now = {};

Elm.Native.Now.make = function(localRuntime) {

  localRuntime.Native = localRuntime.Native || {};


  localRuntime.Native.Now = localRuntime.Native.Now || {};

  if (localRuntime.Native.Now.values) {
    return localRuntime.Native.Now.values;
  }

  var Result = Elm.Result.make(localRuntime);

  return localRuntime.Native.Now.values = {
    loadTime: (new Date()).getTime()
  };

};