#include "UIButtonScene.h"
#include "Input/InputManager.h"
#include "Render/RenderManager.h"
#include "EntityComponent/SceneManager.h"
#include "GameManager.h"
#include "EntityComponent/Components/UITransform.h"
#include "EntityComponent/Entity.h"
#include "Render/Window.h"

using namespace me;
using namespace VroomVroom;

UIButtonScene::UIButtonScene()
{
}

UIButtonScene::~UIButtonScene()
{
	renderManager().destroyUISprite(mName);
}

void UIButtonScene::init(std::string name, std::string materialName) 
{
	mName = name;
	mSpriteName = materialName;

	if (mSpriteName.size() > 0)
	{
		renderManager().createSprite(mName, mSpriteName);
	}

}

void UIButtonScene::start()
{
	mUITransform = getEntity()->getComponent<UITransform>("uitransform");
	renderManager().setUISpriteTransform(mName, mUITransform->getPosition(), mUITransform->getScale(), mUITransform->getRotation());
}


void UIButtonScene::setNewScene(std::string newScene) {
	mNewScene = newScene;
}

void UIButtonScene::update()
{
	

	if (inputManager().getButton("LEFTCLICK" + std::to_string(0))) {

		

		Vector2 mousePosition = me::inputManager().getMousePositon();
		std::cout << mousePosition.x << " + " << mousePosition.y << "\n";


		int w, h;
		w = window().getWindowWidth();
		h = window().getWindowHeight();
		std::cout << mUITransform->getPosition().x * w << " + " << mUITransform->getPosition().y * h  << "\n";



		if (mousePosition.x >= mUITransform->getPosition().x * w && mousePosition.x <= mUITransform->getPosition().y * w + mUITransform->getScale().x * w  &&
			mousePosition.y >= mUITransform->getPosition().y * h && mousePosition.y <= mUITransform->getPosition().y * h + mUITransform->getScale().y * h) {
			execute();
		}
	}
}

void UIButtonScene::execute()
{
	gameManager()->changeScene(mNewScene);
}

std::string UIButtonScene::getName()
{
	return mName;
}

void UIButtonScene::setSpriteMaterial(std::string materialName)
{
	renderManager().setUISpriteMaterial(mName, materialName);
}


