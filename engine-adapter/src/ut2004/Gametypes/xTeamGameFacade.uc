class xTeamGameFacade extends xTeamGame abstract;

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

  var xTeamGameAdapter gameEngineAdapter;
  var class<BaseObject> gameSimulationClass;
  
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated event initGame(string options, out string error)
{
  initAdapter();

  super.initGame(options, error);
}

simulated function initAdapter()
{
  gameEngineAdapter = new class'xTeamGameAdapter';
  gameEngineAdapter.setGameInfoFacade(self);
  gameEngineAdapter.setGameSimulation(new gameSimulationClass);
  gameEngineAdapter.initializeEngineAdapter();
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function tick(float delta) {
  super.tick(delta);
  
  if (gameEngineAdapter != none)
    gameEngineAdapter.tick(delta);
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function LevelInfo getLevel() {
  return level;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated event PlayerController login(string portal, string options, out string error) {
  return gameEngineAdapter.login(portal, options, error);
}

simulated event PlayerController superLogin(string portal, string options, out string error) {
  return super.login(portal, options, error);
}

simulated event postLogin(PlayerController newPlayer) {
  gameEngineAdapter.postLogin(newPlayer);
}

simulated event superPostLogin(PlayerController newPlayer) {
  super.postLogin(newPlayer);
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function restartPlayer(Controller other) {
  if( bRestartLevel && GetLevel().NetMode != NM_DedicatedServer && GetLevel().NetMode != NM_ListenServer )
      return;

  gameEngineAdapter.restartPlayer(other);
}

simulated function superRestartPlayer(Controller other) {
  super.restartPlayer(other);
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated exec simulated function bool gl(string command) {
  return gameEngineAdapter.receivedConsoleCommand(command);
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

// Just to satisfy existing superclass code.
simulated function NavigationPoint findPlayerStart(Controller player, optional byte inTeam, optional string incomingName) {
  return Spawn(class'TemporaryNavigationPoint');
}
  
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function cleanup() {
  gameEngineAdapter = none;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

defaultproperties
{
  MapPrefix="SP"

  MapListType="ClientScripts.MapListDefault"
}