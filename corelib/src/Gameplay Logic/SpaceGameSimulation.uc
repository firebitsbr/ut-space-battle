class SpaceGameSimulation extends BaseObject;

var protected array<Sector> sectors;
var array<User> users;
var protected Sector globalSector;

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function Sector createNewSector() {
  return Sector(allocateObject(class'Sector'));
}

simulated function Sector getGlobalSector() {
  if (globalSector == none)
    globalSector = createNewSector();
    
  return globalSector;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function User addUser(User newUser) {
  users[users.Length] = newUser;

  return newUser;
}

simulated function removeUser(User other) {
  local int i;

  for (i=0;i<users.Length;i++)
    if (users[i] == other)
    {
      users.Remove(i,0);
      break;
    }
}
  
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function userGainedContact(User user, Contact contact) {
  user.gainedContact(contact);
}

simulated function userLostContact(User user, Contact contact) {
  user.lostContact(contact);
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

// A ship was actually destroyed, eg removed from play. Nothing is left of it.
simulated function notifyShipDestroyed(Ship other);

// The ship was "killed." eg for scoring purposes. Something may still be left of it, eg a smoking hulk. If nothing is left, the ship should be "destroyed" after being "killed".
simulated function notifyShipKilled(Ship other, object destroyedBy);

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function class<SensorSimulationStrategy> getSensorSimulationStrategyClass() {
  return class'DefaultSensorSimulationStrategy';
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function Ship createShip_Docked(User newOwner, Ship dockedIn, ShipFactory factory)
{
  local Ship result;

  result = createShip(newOwner, factory);
  if (dockedIn != none)
  {
    result.attemptDock(dockedIn);
    result.attemptUndock();
  }

  return result;
}

simulated function Ship createShip_OpenSpace(User newOwner, Sector newSector, vector newLocation, ShipFactory factory)
{
  local Ship result;

  result = createShip(newOwner, factory);
  result.setShipLocation(newLocation);
  result.setShipRotation(rotRand());
  result.changeShipSector(newSector);

  return result;
}

simulated function Ship createShip(User newOwner, ShipFactory factory)
{
  local Ship newShip;

  newShip = factory.createShip();
  if (newOwner != none)
    newShip.setShipOwner(newOwner);
  newShip.initializeShip();

  return newShip;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function bool setGameParameter(string parameterName, string parameterValue) {
  errorMessage("Game parameter '" $ parameterName $ "' not recognized.");
  return false;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function cleanup()
{
  while (users.length > 0) {
    if (users[users.length-1] != none)
      users[users.length-1].cleanup();
    users.remove(users.length-1, 1);
  }

  if (globalSector != none) {
    // cleanup any ships that remain in the global sector.
    // ships belonging to a user will have already been cleaned up when we cleaned up the user.
    // however, ships that have no user owning them will not have been cleaned up yet.
    while (globalSector.ships.length > 0) {
      globalSector.ships[globalSector.ships.length-1].cleanupShipNOW();
    }
    
    globalSector.cleanup();
    globalSector = none;
  }
  
  if (sectors.length > 0)       sectors.remove(0,sectors.length);
  
  super.cleanup();
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

defaultproperties
{
}