class UTTeamGameAdapter extends UnrealEngine3Adapter;

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

var UTTeamGameFacade  gameInfoFacade;

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function setPawnClass(class<Pawn> pawnClass) {
  gameInfoFacade.defaultPawnClass = pawnClass;
}

simulated function setPlayerControllerClass(class<PlayerController> playerControllerClass) {
  gameInfoFacade.playerControllerClass = playerControllerClass;
}

simulated function setHUDClass(class<HUD> HUDClass) {
  gameInfoFacade.HUDType = HUDClass;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function Actor getGameInfoFacade() {
  return gameInfoFacade;
}

simulated function setGameInfoFacade(UTTeamGameFacade other) {
  gameInfoFacade = other;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function PlayerController facadeLogin(string portal, string options, out string error) {
  return gameInfoFacade.superLogin(portal, options, error);
}

simulated event facadePostLogin(PlayerController newPlayer) {
  gameInfoFacade.superPostLogin(newPlayer);
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function cleanup() {
  super.cleanup();

  if (gameInfoFacade != none) {
    gameInfoFacade.cleanup();
    gameInfoFacade = none;
  }
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function WorldInfo getLevel() {
  return gameInfoFacade.getLevel();
}

simulated function GameInfo getGameInfo() {
  return gameInfoFacade;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

defaultproperties
{
  defaultHUDClass=class'UTTeamHUDFacade'
  defaultHUDAdapterClass=class'UTTeamHUDAdapter'
}