function decrease_periapsis {
  parameter desiredAlt.

  print "Turning to retrograde".
  lock steering to retrograde.
  wait 10.

  print "Setting full throttle".
  lock throttle to 1.0.

  until maxthrust > 1 {
    print "Staging".
    stage. wait 0.5.
  }

  wait until periapsis < desiredAlt.
  lock throttle to 0.
}





function final_descent {
  parameter parachuteAlt.
  wait until altitude < parachuteAlt.

  print "laukaistaan varjo".
  // bug: ei toimi nykyisellä kos-versiolla. ks.
  // http://bit.ly/29sHrPh
  ag5 on. // olettaa, että laskuvarjo on action groupissa 5
}

print "Lasketaan periapsis 40:een kilometriin".
decrease_periapsis(40000).

print "odotetaan että korkeus on alle 5km".
final_descent(3000).
