// Intended to be used /w Kerbal X Stock rocket
// Made for KSP Camp 2016

set terminal:width to 60.
clearscreen.

print "Set throttle to full".
lock throttle to 1.0.
stage. wait 1.0. // kaynnistetaan 1. vaiheen moottorit, odotetaan hetki
print "Detach launch clamps". stage.

// automaattinen ohjaus
local targetApoapsis is 90000.
local suunta is 87.
lock steering to heading(90, suunta). // 90 = ita, kallistuskulma suunta

function adjustPitch {
  parameter height, pitch.

  if altitude > height {
    lock steering to heading(90, pitch).
  }
}

function autoStage {
  local engineList is "".

  list engines in engineList. // tallentaa kaikki moottorit engineList:iin
  for eng in engineList { // käydään läpi kaikki moottorit
    if eng:flameout { // moottorista polttoaine loppu?
      stage. wait 0.1.
      break.
    }
  }
}

when altitude > 50000 then { // aktivoi toiminnot 1 ja 2
  AG1 on.
  AG2 on.
}

until ship:apoapsis >= targetApoapsis {
  autoStage().

  adjustPitch(5000,  80).
  adjustPitch(15000, 60).
  adjustPitch(25000, 40).
  adjustPitch(35000, 20).
  adjustPitch(45000,  0).

  wait 0.1.
}

print "Coasting to apoapsis".
lock throttle to 0.
lock steering to heading(90, 0). // lukitse suunta kohti horisonttia
wait until eta:apoapsis < 20. // sekunteja

print "Raise periapsis to sufficent altitude".
lock throttle to 1.0.
wait until periapsis > 75000.

lock throttle to 0.
set ship:control:pilotmainthrottle to 0. // manuaalinen kaasu pois
