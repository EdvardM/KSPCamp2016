// Intended to be used /w Kerbal X Stock rocket
// Made for KSP Camp 2016

// functions
function decreasePeriapsis {
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

function finalDescent {
  parameter parachuteAlt.
  wait until altitude < parachuteAlt.

  print "Deploy parachutes".
  // bug: ei toimi nykyisellä kos-versiolla. ks. http://bit.ly/29sHrPh
  ag5 on. // olettaa, että laskuvarjo on action groupissa 5
}

// Main
local targetPeriapsis is 40000.
local chuteDeployAltitude is 3000.

print "Decrease periapsis to " targetPeriapsis.
decreasePeriapsis(targetPeriapsis).

print "Waiting until altitude is below " + chuteDeployAltitude.
finalDescent(chuteDeployAltitude).
