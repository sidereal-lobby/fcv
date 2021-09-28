Engine_Fcv : CroneEngine {
	*new { arg context, doneCallback;
		^super.new(context, doneCallback);
	}

	alloc {
    [\gye, \ixb, \mek, \urn, \vrs, \yyr].do({|x|
      Ndef(x).fadeTime = 2;
      Ndef(x, {|t_trig=0, note=48, mod=0, lag=0| 
        var env = t_trig.lagud(0, 0.2);
        note = note.lag(lag);
        mod = mod.lag(lag);
        SinOscFB.ar((note).midicps, mod, env) ! 2;
      }).play;
    });

    this.addCommand("trig", "s", {|msg| 
      Ndef(msg[1].asSymbol).set(\t_trig, 1) 
    });

    this.addCommand("eval", "s", {|msg| 
      try {
        msg[1].asString.compile.value;
      } { |error|
        ("error evaluating:\n```"++msg[1]++
          "```\n----\n"++error++"\n----").postln;
      }
    });

    ["note", "mod", "lag"].do({|cmd|
      this.addCommand(cmd, "sf", {|msg| 
        Ndef(msg[1].asSymbol).set(cmd.asSymbol, msg[2]) 
      })
    });
  }

  free {
    Ndef.clear;
  }
}
