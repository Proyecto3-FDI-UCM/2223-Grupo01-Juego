#include "PowerUpUIWheel.h"
#include "Utils/Timer.h"
#include "Render/UIComponents/UISpriteRenderer.h"
#include "EntityComponent/Entity.h"
#include "MotorEngine/Scene.h"
#include "MotorEngine/SceneManager.h"
#include "MotorEngine/MotorEngineError.h"

using namespace me;
using namespace VroomVroom;



me::Component* FactoryPowerUpUIWheel::create(me::Parameters& params)
{
	if (params.empty())
	{
		return new PowerUpUIWheel();
	}
	float spinSpeed = Value(params, "spinspeed", 0.2f);
	std::string linkedSpriteEntityName = Value(params, "linkedsprite", std::string());

	PowerUpUIWheel* powerUpWheel = new PowerUpUIWheel();
	powerUpWheel->setSpinSpeed(spinSpeed);
	powerUpWheel->setLinked(linkedSpriteEntityName);

	return powerUpWheel;
}

void FactoryPowerUpUIWheel::destroy(me::Component* component)
{
	delete component;
}



PowerUpUIWheel::PowerUpUIWheel()
{
}

PowerUpUIWheel::~PowerUpUIWheel()
{
	delete mSpriteIntervalTimer;
	delete mSpinTimer;
}

void PowerUpUIWheel::start() {
	mSpinning = false;
	mAnimEnd = false;
	mSpriteIntervalTimer = new Timer(false);
	mSpinTimer = new Timer(false);
	mTotalSpinTime = 1;
	mSpriteToLandOn = "NameNotSet";

	if (!mEntity->getScene()->findEntity(mLinkedUISpriteName)) {
		errorManager().throwMotorEngineError("PowerUpUIWheel error", "Linked sprite entity was not found");
		sceneManager().quit();
        return;
	}

	Entity* linkedUISpriteEntity = mEntity->getScene()->findEntity(mLinkedUISpriteName).get();
	if (!linkedUISpriteEntity) {
		errorManager().throwMotorEngineError("PowerUpUIWheel error",
			mLinkedUISpriteName + " entity was not found.");
		sceneManager().quit();
		return;
	}
	mLinkedUISprite = linkedUISpriteEntity->getComponent<UISpriteRenderer>("uispriterenderer");
	if (!mLinkedUISprite) {
		errorManager().throwMotorEngineError("PowerUpUIWheel error", 
			"Linked sprite entity doesn't have UISpriteRenderer component");
		sceneManager().quit();
        return;
	}
}

void PowerUpUIWheel::update(const double& dt) {
	if (!mSpinning)
		return;

	mSpriteIntervalTimer->update(dt);
	mSpinTimer->update(dt);

	if (mSpriteIntervalTimer->getRawSeconds() > mSpinSpeed) {
		mSpriteIntervalTimer->reset();

		std::string lastName = mAvailableSpriteNames.front();
		mAvailableSpriteNames.pop_front();

		mLinkedUISprite->setSpriteMaterial(lastName);

		mAvailableSpriteNames.push_back(lastName);
	}

	if (mSpinTimer->getRawSeconds() > mTotalSpinTime) {
		mSpinTimer->reset();
		stopSpinOnSprite(mSpriteToLandOn);
	}
}

void PowerUpUIWheel::startSpinEffect() {
	mSpinning = true;
	mSpriteIntervalTimer->reset();
	mSpriteIntervalTimer->resume();
}


void PowerUpUIWheel::spinForSecondsAndLandOnSprite(float secs, std::string materialName) {
	startSpinEffect();
	mSpinTimer->reset();
	mSpinTimer->resume();
	mSpriteToLandOn = materialName;
	mTotalSpinTime = secs;
}

void PowerUpUIWheel::addSpriteNameToPool(std::string materialName) {
	mAvailableSpriteNames.push_back(materialName);
}

void VroomVroom::PowerUpUIWheel::setSpinSpeed(float spinSpeed)
{
	mSpinSpeed = spinSpeed;
}

void VroomVroom::PowerUpUIWheel::setLinked(std::string linkedUISpriteName)
{
	if (linkedUISpriteName != "")
		mLinkedUISpriteName = linkedUISpriteName;
}

void VroomVroom::PowerUpUIWheel::resetLinkSprite()
{
	mLinkedUISprite->resetSpriteMaterial();
	mAnimEnd = false;
}

bool VroomVroom::PowerUpUIWheel::isAnimEnd()
{
	return mAnimEnd;
}

void PowerUpUIWheel::stopSpinOnSprite(std::string materialName) {
	mSpinning = false;
	mAnimEnd = true;
	mSpriteIntervalTimer->pause();
	mLinkedUISprite->setSpriteMaterial(materialName);
	mAvailableSpriteNames.remove(materialName);
	mAvailableSpriteNames.push_front(materialName);
}
