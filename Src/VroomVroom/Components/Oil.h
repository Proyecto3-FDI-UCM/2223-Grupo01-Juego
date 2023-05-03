 #pragma once
#ifndef __VROOMVROOM_OIL
#define __VROOMVROOM_OIL

#include "PowerUp.h"

namespace me {
	class Entity;
	class Rigidbody;
	class MeshRenderer;
	class AudioSource;
}

namespace VroomVroom {
	/**
Throws an oil barrel that makes an oil puddle behind the player and
makes the first car that drives on it lose control, and then disappears.
*/
	class Oil : public PowerUp
	{
	private:
		int mPlayerFriction; // The friction of the player's vehicle before colliding with the Oil
		int mFriction; // The friction value that the Oil sets when a vehicle collides with it
		float mOffset; // The distance behind the car
		float mPosYOil; // The pos 'y' of the oil

		me::AudioSource* mOilSound;

	public:
		Oil();
		~Oil();

		void start() override;

		/**
		Sets the friction value that the Oil will apply to vehicles that collide with it
		*/
		void setFriction(float friction);
		/*
		Sets the distance behind the car
		*/
		void setOffset(float offset);
		/*
		Sets the posY  of the oil that will have in the circuit
		*/
		void setPosYOil(float posYOil);

		// Overrides the PowerUp class functions
		void onCollisionEnter(me::Entity* other) override;
		void onCollisionStay(me::Entity* other) override;
		void onCollisionExit(me::Entity* other) override;

		void use(me::Entity* other) override;
	};
}
#endif

