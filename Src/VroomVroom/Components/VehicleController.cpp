#include "VehicleController.h"

#include "Input/InputManager.h"
#include "EntityComponent/SceneManager.h"
#include "GameManager.h"

#include "EntityComponent/Entity.h"
#include "EntityComponent/Scene.h"
#include "EntityComponent/Components/Transform.h"
#include "EntityComponent/Components/RigidBody.h"

#include "Checkpoint.h"
#include "CircuitInfo.h"
#include "PowerUpUIWheel.h"
#include "PowerUpObject.h"
#include "Oil.h"
#include "Nerf.h"

#include "Utils/Vector3.h"
#include "Utils/Vector4.h"
#include <math.h>


using namespace me;
using namespace VroomVroom;

VehicleController::VehicleController()
{
}

VehicleController::~VehicleController()
{
    delete mSpeedBoostTimer;
    delete mSpeedSlowTimer;
}

bool VehicleController::getPlayerButton(std::string buttonName)
{
    return inputManager().getButton(buttonName + std::to_string(mPlayerNumber));
}

float VehicleController::getPlayerAxis(std::string axisName)
{
    return inputManager().getAxis(axisName + std::to_string(mPlayerNumber));
}

void VehicleController::start()
{
    mTransform = mEntity->getComponent<Transform>("transform");
    mRigidBody = mEntity->getComponent<RigidBody>("rigidbody");
    mPowerUpUIWheel = mEntity->getComponent<PowerUpUIWheel>("powerupuiwheel");
    mPowerUpUIWheel->addSpriteNameToPool("nerf");
    mPowerUpUIWheel->addSpriteNameToPool("oil");
    mPowerUpUIWheel->addSpriteNameToPool("lightningBolt");
    mCircuitInfo = mEntity->getScene()->findEntity("circuit").get()->getComponent<CircuitInfo>("circuitinfo");
    mEntity->getScene()->findEntity("finish" + std::to_string(mPlayerNumber)).get()->getComponent<UIText>("uitext")->setActive(false);
    mCircuitInfo->addVehicle(this);
    mLapsText = mEntity->getScene()->findEntity("laps" + std::to_string(mPlayerNumber)).get()
        ->getComponent<UIText>("uitext");

    // Lock in axis (X-Z)
    mRigidBody->setLinearFactor(Vector3(1, 0, 1));
    mRigidBody->setAngularFactor(Vector3(0, 1, 0));

    mChrono = getEntity()->getScene()->findEntity("chrono" + std::to_string(mPlayerNumber)).get()
        ->getComponent<UIText>("uitext");

    mCheckpointIndex = -1;
    mLap = 0;
    mPlace = 0;

    mLapsText->setText("Lap " + std::to_string(mLap + 1) + "/" + std::to_string(mCircuitInfo->getLaps()));

    mControllable = false;

    mSpeedBoostTimer = new Timer(false);
    mSpeedSlowTimer = new Timer(false);

    mOriginalMaxSpeed = mActualMaxSpeed;
}

void VehicleController::update(const double& dt)
{
    //Respawn if out of bounds
    /*if (mTransform->getPosition().y <= mCircuitInfo->getDeathHeight())
        mTransform->setPosition(mLastCheckpointPosition);*/

    if (!mControllable) {
        applyPush(dt, false, false);
        return;
    }

    mChrono->setText(mCircuitInfo->getElapsedTime());

    // Get the input
    bool accelerate = getPlayerButton("ACCELERATE");
    bool decelerate = getPlayerButton("DECELERATE");
    bool useObject = getPlayerButton("USEOBJECT");
    float deltaX = getPlayerAxis("HORIZONTAL");

    Vector3 vForward = mTransform->forward().normalize();

    applyPush(dt, accelerate, decelerate);

    // Rotate the vehicle
    applyRotation(dt, deltaX);

    mSpeedBoostTimer->update(dt);
    mSpeedSlowTimer->update(dt);

    if (mSpeedBoostTimer->getRawSeconds() >= 1.0f) {
        setMaxSpeedAndRotationSpeed(mOriginalMaxSpeed, mMaxAngularSpeed);
        mSpeedBoostTimer->reset();
        mSpeedBoostTimer->pause();
    }

    if (mSpeedSlowTimer->getRawSeconds() >= 3.0f) {
        setMaxSpeedAndRotationSpeed(mOriginalMaxSpeed, mMaxAngularSpeed);
        mSpeedSlowTimer->reset();
        mSpeedSlowTimer->pause();
    }

    // make use of the power up active if it has anyone
    if (mPowerUpUIWheel->isAnimEnd() && useObject) {
        switch (mPowerUpType)
        {
        case NERF:
            // Create nerf entity  with nerf Component
            mPowerUpEntity->getComponent<Nerf>("nerf")->use(mEntity);
            break;
        case OIL:
            //Create oil entity with Oil Component
            mPowerUpEntity->getComponent<Oil>("oil")->use(mEntity);
            break;
        case THUNDER:
            // Create thunder entity with thunder Component
            setMaxSpeedAndRotationSpeed(mOriginalMaxSpeed * 2, mMaxAngularSpeed);
            mEntity->getComponent<RigidBody>("rigidbody")->addImpulse(vForward * mAcceleration * 5);
            mSpeedBoostTimer->resume();
            break;
        default:
            break;
        }

        mPowerUpUIWheel->resetLinkSprite();
        mPowerUpPicked = false;
    }
}

void VehicleController::clamp(float& value, float min, float max)
{
    if (value > max) 
        value = max;
    else if (value < min) 
        value = min;
}

bool VehicleController::isMovingBackwards() {
    // Normaliza los vectores para obtener la direcci�n del movimiento
    Vector3 vForward = mTransform->forward().normalize();
    Vector3 normalizedVel = mRigidBody->getVelocity().normalize();

    // Calcula el producto punto de los vectores normalizados
    float dotProduct = normalizedVel.dot(vForward);

    // Si el producto punto es negativo, significa que los vectores tienen direcciones opuestas
    return dotProduct < 0;
}

void VehicleController::applyPush(const double& dt, bool accelerate, bool decelerate)
{
    Vector3 vForward = mTransform->forward().normalize();
    Vector3 lastVelocity;

    bool movingBackwards = isMovingBackwards();

    if (movingBackwards)
        lastVelocity =  vForward * -(mRigidBody->getVelocity().magnitude() * mLinearDamping);
    else
        lastVelocity =  vForward * (mRigidBody->getVelocity().magnitude() * mLinearDamping);

    Vector3 newVelocity = lastVelocity;
    float velocity;

    if (accelerate) {
        if (movingBackwards)
            velocity = -mRigidBody->getVelocity().magnitude() + (mAcceleration * mAccelerationBoost * dt);
        else
            velocity = mRigidBody->getVelocity().magnitude() + (mAcceleration * dt);


        clamp(velocity, -mActualMaxSpeed, mActualMaxSpeed);
        newVelocity = vForward * velocity;
    }
    else if (decelerate) {
        if (movingBackwards)
            velocity = -mRigidBody->getVelocity().magnitude() - (mAcceleration * dt);
        else
            velocity = mRigidBody->getVelocity().magnitude() - (mAcceleration * mAccelerationBoost * dt);


        clamp(velocity, -mActualMaxSpeed, mActualMaxSpeed);
        newVelocity = vForward * velocity;
    }

    mRigidBody->setVelocity(newVelocity);
}

void VehicleController::applyRotation(const double& dt, float deltaX)
{
    // Limit movement
    float rotationMultiplier = mRigidBody->getVelocity().magnitude() / mActualMaxSpeed * mSpeedBasedRotationMultiplier;
    clamp(rotationMultiplier, 0, 1);

    Vector3 angVel = mRigidBody->getAngularVelocity();
    float lastAngularVelocity = 0;

    if (angVel.y < 0)
        lastAngularVelocity = -mRigidBody->getAngularVelocity().magnitude();
    else if (angVel.y > 0)
        lastAngularVelocity = mRigidBody->getAngularVelocity().magnitude();

    Vector3 newAngularVelocity = Vector3::up() * (lastAngularVelocity * mAngularDamping);
    float rotationVelocity;

    if (isMovingBackwards())
        deltaX = -deltaX;

    if (deltaX > 0) { // Derecha
        if (angVel.y < 0)
            rotationVelocity = lastAngularVelocity - (mDriftFactor * mRotationSpeed * deltaX * dt);
        else
            rotationVelocity = lastAngularVelocity - (mDriftFactor * mRotationSpeed * mSteeringBoost * deltaX * dt);

        // Limit angular velocity
        clamp(rotationVelocity, -mMaxAngularSpeed, mMaxAngularSpeed);

        newAngularVelocity = Vector3::up() * rotationVelocity * rotationMultiplier;
    }
    else if (deltaX < 0) { // Izquierda
        if (angVel.y < 0)
            rotationVelocity = lastAngularVelocity - (mDriftFactor * mRotationSpeed * mSteeringBoost * deltaX * dt);
        else 
            rotationVelocity = lastAngularVelocity - (mDriftFactor * mRotationSpeed * deltaX * dt);

        // Limit angular velocity
        clamp(rotationVelocity, -mMaxAngularSpeed, mMaxAngularSpeed);

        newAngularVelocity = Vector3::up() * rotationVelocity * rotationMultiplier;
    }

    mRigidBody->setAngularVelocity(newAngularVelocity);
}

void VehicleController::setAccelerationAndRotation(float acceleration, float rotationSpeed, float driftFactor)
{
    mAcceleration = acceleration;
    mRotationSpeed = rotationSpeed;
    mDriftFactor = driftFactor;
}

void VehicleController::setMaxSpeedAndRotationSpeed(float maxSpeed, float maxRotationSpeed)
{
    mActualMaxSpeed = maxSpeed;
    mMaxAngularSpeed = maxRotationSpeed;
}

void VehicleController::setAccelerationAndSteeringBoost(float accelerationBoost, float steeringBoost) {
    mAccelerationBoost = accelerationBoost;
    mSteeringBoost = steeringBoost;
}

void VehicleController::setSpeedBasedRotationMultiplier(float speedBaseFactor) {
    mSpeedBasedRotationMultiplier = speedBaseFactor;
}

bool VroomVroom::VehicleController::isPowerUpPicked()
{
    return mPowerUpPicked;
}

void VehicleController::setLinearAndAngularDamping(float linearDamping, float angularDamping)
{
    mLinearDamping = linearDamping;
    mAngularDamping = angularDamping;
}

void VehicleController::setPlayerNumber(PlayerNumber playerNumber) {
    mPlayerNumber = playerNumber;
}

void VehicleController::setControllable(bool controllable) {
    mControllable = controllable;
}

void VehicleController::setPowerUp(PowerUpType powerUpType, me::Entity* powerUpEntity)
{
    mPowerUpType = powerUpType;
    mPowerUpEntity = powerUpEntity;
    mPowerUpPicked = true;
}

PlayerNumber VehicleController::getPlayerNumber() {
    return mPlayerNumber;
}

void VehicleController::setPowerUpUI()
{
    std::string name;

    switch (mPowerUpType)
    {
    case NERF:
        name = "nerf";
        break;
    case OIL:
        name = "oil";
        break;
    case THUNDER:
        name = "lightningBolt";
        break;
    }

    mPowerUpUIWheel->spinForSecondsAndLandOnSprite(3, name);
}

void VehicleController::setPlace(int newPlace)
{
    mPlace = newPlace;
}

int VehicleController::getPlace()
{
    return mPlace;
}

int VehicleController::getLap()
{
    return mLap;
}

int VehicleController::getChekpointIndex()
{
    return mCheckpointIndex;
}

float VehicleController::getOrigMaxSpeed()
{
    return mOriginalMaxSpeed;
}

float VehicleController::getMaxAngularSpeed()
{
    return mMaxAngularSpeed;
}

void VehicleController::startOilTimer()
{
    mSpeedSlowTimer->resume();
}

void VehicleController::onCollisionEnter(me::Entity* other)
{
    if (other->hasComponent("checkpoint")) {
        Checkpoint* checkpoint = other->getComponent<Checkpoint>("checkpoint");
        mLastCheckpointPosition = checkpoint->getEntity()->getComponent<Transform>("transform")->getPosition();

#ifdef _DEBUG
        std::cout << "Car " << mPlayerNumber << " has reached checkpoint " << checkpoint->getIndex() << "\n";
#endif

        if (checkpoint->getIndex() == (mCheckpointIndex + 1) % checkpoint->GetNumCheckpoints()) {
            //Next checkpoint
            mCheckpointIndex++;

            if (mCheckpointIndex == checkpoint->GetNumCheckpoints()) {
                //Add lap
                mCheckpointIndex = 0;
                mLap++;

                if(mLap != mCircuitInfo->getLaps())
                    mLapsText->setText("Lap " + std::to_string(mLap + 1) + "/" + std::to_string(mCircuitInfo->getLaps()));

#ifdef _DEBUG
                std::cout << "Car " << mPlayerNumber << " started lap " << mLap << "\n";
#endif

                if (mLap == mCircuitInfo->getLaps()) {
                    //Finish race
                    mFinishTime = mCircuitInfo->getFinishTime();
                    mChrono->setText(mFinishTime);
                    mControllable = false;
                    int x = mCircuitInfo->getCarFinished();
                    if (x == 1)
                        gameManager()->setWinnerTime(mFinishTime, mPlayerNumber);
                    else gameManager()->setLoserTime(mFinishTime);

                    mEntity->getScene()->findEntity("finish" + std::to_string(mPlayerNumber)).get()->getComponent<UIText>("uitext")->setActive(true);
#ifdef _DEBUG
                    std::cout << "Car " << mPlayerNumber << " finished the race in " << mFinishTime << "\n";
#endif
                }
            }
        }
        else if (checkpoint->getIndex() == (mCheckpointIndex + 1) % checkpoint->GetNumCheckpoints())
        {
            //Previous checkpoint (you are in the wrong direction)
            mCheckpointIndex--;

            if (mCheckpointIndex == -1) {
                //Remove lap
                mCheckpointIndex += checkpoint->GetNumCheckpoints();
                mLap--;
            }
        }
    }
}