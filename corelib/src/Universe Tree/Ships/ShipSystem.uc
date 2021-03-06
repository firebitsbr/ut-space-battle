class ShipSystem extends BaseObject;

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

var ship ship;
var bool bEnabled;

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function addedToShip(Ship other) {
  ship = other;
}

simulated function removedFromShip(Ship other) {
  ship = none;
}

// enabled/disabled probably isn't going to be constant among systems - some may be passive  
simulated function disableSystem() {
  bEnabled = false;
}

simulated function enableSystem() {
  bEnabled = true;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function cleanup()
{
  ship = none;
  bEnabled = false;

  super.cleanup();
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function updateShipSystem();

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function ShipSystem cloneSystem()
{
  local ShipSystem clone;

  clone = ShipSystem(allocateObject(self.class));

  initializeClonedSystem(clone);

  return clone;
}

simulated function initializeClonedSystem(ShipSystem clone)
{
  clone.bEnabled = bEnabled;

  // cloned system does not have the same ship
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

defaultproperties {
  bEnabled=true
}