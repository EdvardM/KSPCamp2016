clearscreen.

print "Set throttle to full".
lock throttle to 1.0.
stage. wait 1.0. // kaynnistetaan 1. vaiheen moottorit, odotetaan hetki
print "Detach launch clamps". stage.

// automaattinen ohjaus
local targetApoapsis is 90000.
local suunta is 87.
lock steering to heading(90, suunta). // 90 = ita, kallistuskulma suunta

until ship:apoapsis >= targetApoapsis {
  local hasFuel is true. // oleta, että moottorilla on polttoainetta
  local engineList is "".

  list engines in engineList.
  for eng in engineList {
    if eng:flameout {
      set hasFuel to false. break.
    }
  }
  if not hasFuel { stage. } // polttoaine loppu -> seuraava vaihe

  if altitude >  5000 { set suunta to 80. }
  if altitude > 15000 { set suunta to 60. }
  if altitude > 25000 { set suunta to 40. }
  if altitude > 35000 { set suunta to 20. }
  if altitude > 45000 { set suunta to  0. }

  wait 0.1.
}

print "Raise periapsis to sufficent altitude".
lock steering to prograde.
lock throttle to 0.
wait until eta:apoapsis < 15. // sekunteja
lock throttle to 1.0.
wait until periapsis > 75000.
lock throttle to 0.
print "Finished".

wait 300. // jotta kOS:n kontrolli pysyy
