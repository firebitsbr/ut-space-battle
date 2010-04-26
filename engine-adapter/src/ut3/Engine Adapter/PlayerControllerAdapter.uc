class PlayerControllerAdapter extends UTPlayerController;

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

  var InputView         InputView;

  var vector						CameraLocation;
  var rotator						CameraRotation;

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated event Destroyed()
{
  // Cleanup.
  Cleanup();
  
  // Call Superclass.
  Super.Destroyed();
}

simulated function Cleanup()
{
  // Clear InputView.
  InputView = None;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function SetCameraLocation(vector NewCameraLocation)
{
	CameraLocation = NewCameraLocation;
	
	SetLocation(CameraLocation);  
	if (Pawn != None)
		Pawn.SetLocation(CameraLocation);  
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function SetCameraRotation(rotator NewCameraRotation)
{
	CameraRotation = NewCameraRotation;
	
	SetRotation(CameraRotation);  
	if (Pawn != None)
		Pawn.SetRotation(CameraRotation);  
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated event GetPlayerViewPoint(out vector out_Location, out Rotator out_Rotation)
{
	out_Location = cameraLocation;
	out_Rotation = cameraRotation;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function playerKilled(PlayerController killer)
{
	if (PawnAdapter(pawn) != none)
		PawnAdapter(pawn).playerKilled(killer);
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

defaultproperties
{
  bCollideWorld=false
}