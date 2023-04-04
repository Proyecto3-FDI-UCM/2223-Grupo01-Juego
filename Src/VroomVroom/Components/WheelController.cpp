#include "WheelController.h"
#include "VehicleController.h"
#include "Input/InputManager.h"
#include "EntityComponent/Entity.h"
#include "EntityComponent/Components/Transform.h"


me::WheelController::WheelController()
{
	mXRotation = 0;
	mYRotation = 0;
	mSpeed = 0.05;
}

me::WheelController::~WheelController()
{
}


void me::WheelController::update()
{
	bool left = me::inputManager().getButton("LEFT");
	bool right = me::inputManager().getButton("RIGHT");

	float deltaX = me::inputManager().getAxis("HORIZONTAL");

	//Rotaci�n en Y para el giro
	if (mYRotation < me::Y_ROTATION_THRESHOLD && mYRotation >= 0) {
		if (left || deltaX > 0) { //Es posible que haya que intercambiar los < > de los deltaX al rev�s.
			mEntity->getComponent<me::Transform>("transform")->rotate(+Y_STEP_ROTATION, { 0, 1, 0 });
			mYRotation += Y_STEP_ROTATION;
		}
		else if (right || deltaX < 0) {
			mEntity->getComponent<me::Transform>("transform")->rotate(-Y_STEP_ROTATION, { 0, 1, 0 });
			mYRotation += Y_STEP_ROTATION;
		}
		else {
			mYRotation -= Y_STEP_ROTATION;
		}
	}

	bool acelerate = me::inputManager().getButton("ACELERATE");
	bool decelerate = me::inputManager().getButton("DECELERATE");

	//Rotaci�n en Z para la aceleracion

	mSpeed = mEntity->getComponent<me::VehicleController>("vehiclecontroller")->getSpeed();
	if (acelerate) {
		mEntity->getComponent<me::Transform>("transform")->rotate(mSpeed * Z_ROTATION_FACTOR, { 0, 0, 1 });
	}
	else if (decelerate) {
		mEntity->getComponent<me::Transform>("transform")->rotate(-mSpeed * Z_ROTATION_FACTOR, { 0, 0, 1 });
	}

}