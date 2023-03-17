#pragma once
#ifndef __VROOMVROOM_VROOMVROOM
#define __VROOMVROOM_VROOMVROOM

#define __VROOMVROOM_EXPORT
#ifdef __VROOMVROOM_EXPORT
#define __VROOMVROOM_API __declspec(dllexport)
#else
#define __VROOMVROOM_API __declspec(dllimport)
#endif

#include "ComponentsRegister.h"
#include "MotorEngine/MotorEngine.h"

extern "C" {
	__VROOMVROOM_API const char* name();

	__VROOMVROOM_API bool init();

	/*__VROOMVROOM_API void componentsResgister() {
		me::addAllFactory();
	}*/
}

#endif