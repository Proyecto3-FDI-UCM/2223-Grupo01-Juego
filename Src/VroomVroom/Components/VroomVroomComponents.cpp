#include "VroomVroomComponents.h"
#include "CameraFollow.h"
#include "VehicleController.h"
#include "CircuitInfo.h"
#include "WheelController.h"
#include "GameManager.h"
#include "Checkpoint.h"
#include "Oil.h"
#include "UIButtonScene.h"

using namespace me;
using namespace VroomVroom;

Component* FactoryCameraFollow::create(Parameters& params)
{
    CameraFollow* camerafollow = new CameraFollow();
    camerafollow->setTargetName(Value(params, "target", std::string()));

    camerafollow->setOffset(Vector3(Value(params, "offset_x", 0.0f),
        Value(params, "offset_y", 3.0f), Value(params, "offset_z", 5.0f)));

    //Añadir suavizado
    return camerafollow;
}

void FactoryCameraFollow::destroy(me::Component* component)
{
    delete component;
}

Component* FactoryVehicleController::create(Parameters& params)
{
    VehicleController* vehicleController = new VehicleController();
    vehicleController->setSpeedAndDrift(Value(params, "speed", 0.0f),
        Value(params, "rotationspeed", 0.0f), Value(params, "driftfactor", 0.0f));
    vehicleController->setPlayerNumber(PlayerNumber(Value(params, "playerNumber", 0)));
    
    return vehicleController;
}

void FactoryVehicleController::destroy(me::Component* component)
{
    delete component;
}

Component* FactoryWheelController::create(Parameters& params)
{
    WheelController* wheelController = new WheelController();

    return wheelController;
}

void FactoryWheelController::destroy(me::Component* component)
{
    delete component;
}

Component* FactoryCheckpoint::create(Parameters& params)
{
    Checkpoint* checkpoint = new Checkpoint();
    return checkpoint;
}

void FactoryCheckpoint::destroy(Component* component)
{
    delete component;
}

Component* FactoryCirtuitoInfo::create(Parameters& params)
{
    CircuitInfo* circuitInfo = new CircuitInfo();
    circuitInfo->setPosition(Vector3(Value(params, "position_x", 0.0f),
        Value(params, "position_y", 0.0f), Value(params, "position_z", 0.0f)));
    return circuitInfo;
}

void FactoryCirtuitoInfo::destroy(Component* component)
{
    delete component;
}

Component* FactoryGameManager::create(Parameters& params)
{
    return gameManager();
}

void FactoryGameManager::destroy(Component* component)
{
    delete component;
}

Component* FactoryOil::create(Parameters& params)
{
    Oil* oil = new Oil();
    oil->setFriction(Value(params, "friction", 5.0f));
    return oil;

}

void FactoryOil::destroy(Component* component)
{
    delete component;
}

me::Component* FactoryUIButtonScene::create(me::Parameters& params)
{
    if (params.empty())
    {
        return new UIButtonScene();
    }
    std::string sprite = Value(params, "sprite", std::string());
    std::string materialName = Value(params, "materialname", std::string());
    std::string newScene = Value(params, "scene", std::string());

    UIButtonScene* button = new UIButtonScene();
    button->init(sprite, materialName);
    button->setNewScene(newScene);

    return button;
}

void FactoryUIButtonScene::destroy(me::Component* component)
{
    delete component;
}
