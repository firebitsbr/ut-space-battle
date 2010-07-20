class ManualShipControlMapper extends ShipControlMapper;

// Desired rotation torque is reduced each tick. This factor controls how rapidly old inputs decay.
var float turnDecayTime;
// Amount of rotation torque to apply for a given amount of mouse movement.
var float turnSensitivity;
var vector shipSteering;

var float steeringFireDirectionModifier;

simulated function updateControls(float deltaTime, rotator currentRotation, float yawChange, float pitchChange, float rollChange) {
  if (deltaTime >= turnDecayTime)
    shipSteering = vect(0,0,0);
  else
    shipSteering *= (turnDecayTime-deltaTime) / turnDecayTime;

  shipSteering.x = fclamp(shipSteering.x + (yawChange * turnSensitivity), -1, 1);
  shipSteering.y = fclamp(shipSteering.y + (pitchChange * turnSensitivity), -1, 1);
  shipSteering.z = fclamp(shipSteering.z + (rollChange * turnSensitivity), -1, 1);
}

simulated function vector getShipSteering(float deltaTime, PhysicsStateInterface physicsState, float maximumRotationalAcceleration) {
  return shipSteering;
}

function rotator getWeaponFireRotation(rotator currentRotation) {
  return rotator(vector(copyVectToRot(shipSteering * steeringFireDirectionModifier)) >> currentRotation);
}

defaultProperties
{
  turnDecayTime=1

  turnSensitivity=0.0001

  steeringFireDirectionModifier=3500
}