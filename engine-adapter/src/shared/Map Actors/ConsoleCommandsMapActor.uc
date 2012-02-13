class ConsoleCommandsMapActor extends BaseMapActor;

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

var() array<string> commands;

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function trigger(Actor other, Pawn eventInstigator) {
  executeConsoleCommands(getCommands());
}

simulated function array<string> getCommands() {
  return commands;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

defaultproperties
{
}
