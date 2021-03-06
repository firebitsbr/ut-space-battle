class UnrealEngineCanvasObjectBase extends CanvasObject;

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

var Canvas unrealCanvas;

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function setUnrealCanvas(Canvas newUnrealCanvas) {
  unrealCanvas = newUnrealCanvas;
}

simulated function clearUnrealCanvas() {
  unrealCanvas = none;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function cleanup() {
  clearUnrealCanvas();
  
  super.cleanup();
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated function setPos(float x, float y) {
  unrealCanvas.setPos(x, y);
}

simulated function int getSizeX() {
  return unrealCanvas.sizeX;
}

simulated function int getSizeY() {
  return unrealCanvas.sizeY;
}

simulated function resetCanvas() {
  unrealCanvas.reset();
}

simulated function setFont(Font newFont) {
  unrealCanvas.font = newFont;
}

simulated function setDrawColor(Color newDrawColor) {
  unrealCanvas.drawColor = newDrawColor;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

simulated static function float getGlobalDrawscaleFactor() {
  return 1;
}

simulated static function float getGlobalPositionScaleFactor() {
  return 1;
}

simulated function float convertWorldWidthToCanvasWidth(float distance, float worldWidth) {
  local float FOVAngle;
  local float horizonWidth;
  local float result;

  worldWidth *= getGlobalDrawscaleFactor();

  // I believe that the view is like an equilateral triangle. A line to a target in the center of the screen bisects that triangle forming a right triangle.
  // The width of area visible at a given distance would then be twice the opposite side of the triangle. Using that and the known actual width of the target
  // I can calculate the proportion of the screen a contact covers and then use the screen resolution to determine the actual width.
  FOVAngle = 90;
  horizonWidth = distance * abs(tan(FOVAngle));
  result = 2 * (worldWidth / horizonWidth) * getSizeX();

  return result;
}

// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************
// ********************************************************************************************************************************************

defaultproperties
{
}