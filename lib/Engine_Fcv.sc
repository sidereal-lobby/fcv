Engine_Fcv : CroneEngine {
	*new { arg context, doneCallback;
		^super.new(context, doneCallback);
	}

	alloc {
    // Global ape (arbitraria perplexus enigmus)
    ~ape = 1;
    Ndef(\ape, {|ape, lag=0| ape.lag(0); });

    this.addCommand("ape", "f", {|msg|
      ~ape = msg[1];
      Ndef(\ape).set(\ape, msg[1]);
    });

    // Global bps (beats-per-second) tempo
    ~bps = 2;
    Ndef(\bps, {|bps, lag=0| bps.lag(0); });

    this.addCommand("bps", "f", {|msg|
      ~bps = msg[1];
	  //("bps set to " ++ msg[1]).postln;
      Ndef(\bps).set(\bps, msg[1]);
    });

    this.addCommand("bpm", "f", {|msg|
      ~bps = msg[1] / 60;
      Ndef(\bps).set(\bps, msg[1] /60);
    });

	// Echo
	context.server.sync;
	~delayBus = Bus.audio(context.server, 2);
	context.server.sync;

    [\gye, \ixb, \lor, \mek, \vrs, \qpo].do({|x|
      Ndef(x, {|t_trig=0, note=48, volume=1, mod=0, lag=0|
        var env = t_trig.lagud(0, 0.2) * volume;
        note = note.lag(lag);
        mod = mod.lag(lag);
        SinOscFB.ar((note).midicps, mod, env) ! 2;
	  });
	  Ndef(x).(fadeTime: 2);

	  Ndef((x ++ \Strip).asSymbol, {
		|volume=1, pan=0, delaySend=0, lag=1|
		var delayOut;
        var out = \in.ar(0 ! 2);
		out = LeakDC.ar(out, mul: volume.lag(lag));
		out = Balance2.ar(out[0], out[1], pan.lag(lag)).tanh;
		Out.ar(~delayBus.index, out * delaySend);
		out;
      }).play;

	  Ndef((x ++ \Strip).asSymbol) <<>.in Ndef(x);
    });

	Ndef(\delay, {|beats=0.1, lag=0.1, decay=3.7|
		var tr = 1/10000;
		var delayTime = (beats / Ndef(\bps).max(0.1)).max(tr).lag(lag);
		var out = In.ar(~delayBus.index, 2);
		delayTime = SinOsc.kr(0.01, [0, pi/12], tr, delayTime + tr);
		LeakDC.ar(CombC.ar(out, 2, delayTime, decay)).tanh;
	}).play;

	("setup commands").postln;
	this.addCommand("level", "sf", {|msg|
		Ndef((msg[1] ++ "Strip").asSymbol).set(\volume, msg[2]);
    });

	this.addCommand("pan", "sf", {|msg|
			("lag for"+msg[1]+"set to"+msg[2]).postln;
		Ndef((msg[1] ++ "Strip").asSymbol).set(\pan, msg[2]);
    });

	this.addCommand("lag", "sf", {|msg|
		Ndef((msg[1] ++ "Strip").asSymbol).set(\lag, msg[2]);
    });

	this.addCommand("send_delay", "sf", {|msg|
		Ndef((msg[1] ++ "Strip").asSymbol).set(\delaySend, msg[2]);
    });

	this.addCommand("delay_beats", "f", {|msg|
		Ndef(\delay).set(\beats, msg[1]);
    });

	this.addCommand("delay_lag", "f", {|msg|
		Ndef(\delay).set(\lag, msg[1]);
    });

	this.addCommand("delay_decay", "f", {|msg|
		Ndef(\delay).set(\decay, msg[1]);
    });

    this.addCommand("trig", "sf", {|msg|
      if(msg[2] != 0, {
        Ndef(msg[1].asSymbol).set(\volume, msg[2]);
      }, {
        "volume not specified".postln;
      });

      Ndef(msg[1].asSymbol).set(\t_trig, 1);
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
		Ndef.clear(0);
  }
}
