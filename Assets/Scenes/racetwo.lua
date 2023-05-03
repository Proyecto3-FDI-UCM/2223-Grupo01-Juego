Entities = {
	Circuit = {
	    Transform = {
            position = { x = -65, y = 5, z = 0 },
			rotation = { x = 0, y = 0, z = 0 },
            scale = { x = 1, y = 1, z = 1} --80 30 40
	    },
	    RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 2,
            mask = 6,
            colliderscale = {x = 200, y = 0.01, z = 200},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {
            
        },
        meshrenderer = {
            mesh = "circuit",
            meshName = "Circuito.mesh",
            -- materialName = "Material/roja"
        },
        CircuitInfo = {
            laps = 1
        },
        audiosource = {
            name = "bgRaceMusic",
            path = "musicaCircuito.mp3",
            onstart = true,
            loop = false,
            threed = false,
            groupchannel = "music"
        }
	},
    
    camera = {
        transform = {
            position = { x = 0, y = 200, z = 0 } -- -104 70 0 / 20 10 -10
        },
        camera = {
            lookat = { x = 0, y = 1, z = 0 }, -- -104 10 0 / -20 10 -10
            name = "main",
            neardistance = 0.5,
            fardistance = 1,
            autoratio = true,
            zorder = 3,
            overlayenable = true,
            backgroundcolor = { r = .72, g = .92, b = 1, a = 1  },
            viewport = { left = 0.0, right = 0.0, width = 1.0, height =1.0 }
        }
    },

    -------------------------------------------------------------
    ---------           primer jugador                  ---------
    -------------------------------------------------------------

	Car1 = {
        Transform = {
            position = { x=-50, y = 5.5, z = -10 },
            scale = { x = 0.7, y = 0.7, z = 0.7 },
            rotation = {x = 0, y = 0, z = 0}
        },
		RigidBody = {
            colShape = 2,
            mvType = 0,
            mass = 1,
            group = 2,
            mask = 7,
            colliderscale = {x = 1, y = .4, z = 1},
            restitution = .5,
            friction = 0,
            isTrigger = false
        },
        vehicleController = {
            acceleration = 4,
            rotationspeed = 5,
			maxspeed = 12,
			maxrotationspeed = 3,
            driftFactor = 1,
            playerNumber = 0
        },
        collider = {
            
        },
        powerupuiwheel = {
            spinspeed = 0.1;
            linkedsprite = "insidecontainer"
        },
        meshrenderer = {
            mesh = "kartone",
            meshName = "RedCar.mesh",
            --materialName = "Material/roja"
        },
        audiosource = {
            name = "thunderCarOne",
            path = "posibleAumentoDeVel.mp3",
            onstart = false,
            loop = false,
            threed = true,
            groupchannel = "effects"
        }
	},

    camera1 = {
        transform = {
            position = { x=-60, y = 8.5, z = -10 } -- -104 70 0 / 20 10 -10
        },
        camera = {
            lookat = { x=-50, y = 7.5, z = -10 }, -- -104 10 0 / -20 10 -10
            name = "playerOne",
            neardistance = 0.5,
            fardistance = 100000,
            autoratio = true,
            zorder = 0,
            overlayenable = false,
            backgroundcolor = { r = .72, g = .92, b = 1, a = 1  },
            viewport = { left = 0.0, top = 0.0, width = 0.5, height =1.0 }
        },
		camerafollow = {
			target = "car1",
			positionoffset = { x= 0, y = 3, z = -10 },
            lookoffset = { x= 0, y = 2, z = 0 },
            smoothing = .3
		}
    },

    container1 = {
        UITransform = {
            position = { x = 0.05, y = 0.07 },
            scale = { x = 0.1, y = 0.177 },
            rotation = 0
        },
        UISpriteRenderer = {
            sprite = "container1",     -- Nombre Interno
            materialName = "container",  -- Nombre en MaterialsResource
            zorder = 0
        }
    },

    insidecontainer = {
        UITransform = {
            position = { x = 0.066, y = 0.096 },
            scale = { x = 0.06, y = 0.1 },
            rotation = 0
        },
        UISpriteRenderer = {
            sprite = "insidecontainer",     -- Nombre Interno
            materialName = "insidecontainer",  -- Nombre en MaterialsResource
            zorder = 1
        }
    },

    
    place1 = {
        UITransform = {
            position = { x = 0.05, y = 0.8 },
            scale = { x = 0.1, y = 0.177 },
            rotation = 0
        },
        UISpriteRenderer ={
            sprite = "place1",     -- Nombre Interno
            materialName = "first"  -- Nombre en MaterialsResource
        }
    },

    laps0 = {
        UITransform = {
            position = { x = 350, y = 540.1 },
            scale = { x = 0.1, y = 0.177 },
            rotation = 0
        },
        UIText ={
            name = "laps0",
            text = "LAP 1/3",
            position = { x = 0.4, y = 0.9 },
            dimension = { x = 0.3, y = 0.3 },
            charheight = 0.07,
            fontname = "Mario"
        }
    },

    FinishAudio1 ={
        transform={
            parentname = "car1";
        },
        audiosource={
            name = "finishCarOne",
            path = "endRace.mp3",
            onstart = false,
            loop = false,
            threed = false,
            groupchannel = "effects"
        }
    },

    -------------------------------------------------------------
    ---------           segundo jugador                  --------
    -------------------------------------------------------------

    Car2 = {
        Transform = {
            position = { x=-50, y = 5.5, z = -5 },
            scale = { x = 0.7, y = 0.7, z = 0.7 },
            rotation = {x = 0, y = 0, z = 0}
        },
        RigidBody = {
            colShape = 2,
            mvType = 0,
            mass = 1,
            group = 2,
            mask = 7,
            colliderscale = {x = 1, y = .4, z = 1},
            restitution = .5,
            friction = 0,
            isTrigger = false
        },
        vehicleController = {
            acceleration = 4,
            rotationspeed = 5,
			maxspeed = 12,
			maxrotationspeed = 3,
            driftFactor = 1,
            playernumber = 1
        },
        collider = {
            
        },
        powerupuiwheel = {
            spinspeed = 0.1;
            linkedsprite = "insidecontainer2"
        },
        meshrenderer = {
            mesh = "karttwo",
            meshName = "BlueCar.mesh"
        },
        audiosource = {
            name = "thunderCarOne",
            path = "posibleAumentoDeVel.mp3",
            onstart = false,
            loop = false,
            threed = true,
            groupchannel = "effects"
        }
	},
    
    camera2 = {
        transform = {
            position = { x=-60, y = 8.5, z = -5 } -- -104 70 0 / 20 10 -10
        },
        camera = {
            lookat = { x=-50, y = 7.5, z = -5 }, -- -104 10 0 / -20 10 -10
            name = "playerTwo",
            neardistance = 0.5,
            fardistance = 100000,
            autoratio = true,
            zorder = 1,
            overlayenable = false,
            backgroundcolor = { r = .72, g = .92, b = 1, a = 1  },
            viewport = { left = 0.5, top = 0.0, width = 0.5, height =1.0 }
        },
		camerafollow = {
			target = "car2",
			positionoffset = { x= 0, y = 3, z = -10 },
            lookoffset = { x= 0, y = 2, z = 0 },
            smoothing = .3
		}
    },

    container2 = {
        UITransform = {
            position = { x = 0.55, y = 0.07 },
            scale = { x = 0.1, y = 0.177 },
            rotation = 0
        },
        UISpriteRenderer = {
            sprite = "container2",     -- Nombre Interno
            materialName = "container",  -- Nombre en MaterialsResource
            zorder = 0
        }
    },

    insidecontainer2 = {
        UITransform = {
            position = { x = 0.57, y = 0.096 },
            scale = { x = 0.06, y = 0.1 },
            rotation = 0
        },
        UISpriteRenderer = {
            sprite = "insidecontainer2",     -- Nombre Interno
            materialName = "insidecontainer",  -- Nombre en MaterialsResource
            zorder = 1
        }
    },


    place2 = {
        UITransform = {
            position = { x = 0.55, y = 0.8 },
            scale = { x = 0.1, y = 0.177 },
            rotation = 0
        },
        UISpriteRenderer ={
            sprite = "place2",     -- Nombre Interno
            materialName = "second"  -- Nombre en MaterialsResource
        }
    },

    laps1 = {
        UITransform = {
            position = { x = 900, y = 540 },
            scale = { x = 0.1, y = 0.177 },
            rotation = 0
        },
        UIText ={
            name = "laps1",
            text = "LAP 1/3",
            position = { x = 0.9, y = 0.9 },
            dimension = { x = 0.3, y = 0.3 },
            charheight = 0.07,
            fontname = "Mario"
        }
    },

    FinishAudio2 ={
        transform={
            parentname = "car2";
        },
        audiosource={
            name = "finishCarOne",
            path = "endRace.mp3",
            onstart = false,
            loop = false,
            threed = false,
            groupchannel = "effects"
        }
    },

    finish0 = {
        UITransform = {
            position = { x = 150, y = 250 },
            scale = { x = 0.5, y = 0.6 },
            rotation = 0
        },
        UIText ={
            name = "finish0",
            position = { x = 0.250, y = 0.4 },
            dimension = { x = 0.3, y = 0.3 },
            text = "FINISH!",
            charheight = 0.2,
            fontname = "Mario"
        }
    },
    finish1 = {
        UITransform = {
            position = { x = 670, y = 250 },
            scale = { x = 0.5, y = 0.6 },
            rotation = 0
        },
        UIText ={
            name = "finish1",
            position = { x = 0.750, y = 0.4 },
            dimension = { x = 0.3, y = 0.3 },
            text = "FINISH!",
            charheight = 0.2,
            fontname = "Mario"
        }
    },

    chrono0 = {
        UITransform = {
            position = { x = 300, y = 20 },
            scale = { x = 0.1, y = 0.177 },
            rotation = 0
        },
        UIText ={
            name = "chono",
            text = "00:00.000",
            position = { x = 0.4, y = 0.05 },
            dimension = { x = 0.3, y = 0.3 },
            charheight = 0.07,
            fontname = "Mario"
        }
    },
    chrono1 = {
        UITransform = {
            position = { x = 850, y = 20 },
            scale = { x = 0.1, y = 0.177 },
            rotation = 0
        },
        UIText ={
            name = "chono1",
            text = "00:00.000",
            position = { x = 0.9, y = 0.05 },
            dimension = { x = 0.3, y = 0.3 },
            charheight = 0.07,
            fontname = "Mario"
        }
    },
    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------

    countdownUI = {
        UITransform = {
            position = { x = 0.4, y = 0.33 },
            scale = { x = 0.2, y = 0.355 },
            rotation = 0
        },
        UISpriteRenderer ={
            sprite = "countdown",     -- Nombre Interno
            materialName = "countdown3"  -- Nombre en MaterialsResource
        },
        transform = {

        },
        audiosource = {
            name = "countDownSound",
            path = "comienzoCarrera.mp3",
            onstart = true,
            loop = false,
            threed = false,
            groupchannel = "music"
        }
    },

    
    PowerUp1 = {
        Transform = {
            position = { x= 0, y = 5.8, z = 0 },
            scale = { x = 1, y = 1, z = 1},
            rotation = {x = 0, y = 180, z = 0}
        },
        RigidBody = {
            colShape = 1,
            mvType = 2,
            mass = 0,
            group = 2,
            mask = 7,
            colliderscale = {x = 0.5, y = 0.5, z = 0.5},
            restitution = .5,
            friction = 0.5,
            isTrigger = true
        },
        meshrenderer = {
            mesh = "powerUp1",
            meshName = "Power_Up_Box.mesh"
        },
        collider = {
        },
        PowerUpObject = {
            type = 0
        },
        audiosource = {
            name = "powerUp1Sound",
            path = "pickPowerUpBox.mp3",
            onstart = false,
            loop = false,
            threed = false,
            groupchannel = "effects"
        }
    },

    PowerUp2 = {
        Transform = {
            position = { x= -3, y = 5.8, z = 0 },
            scale = { x = 1, y = 1, z = 1 },
            rotation = {x = 0, y = 180, z = 0}
        },
        RigidBody = {
            colShape = 1,
            mvType = 2,
            mass = 0,
            group = 2,
            mask = 7,
            colliderscale = {x = 0.5, y = 0.5, z = 0.5},
            restitution = .5,
            friction = 0.5,
            isTrigger = true
        },
        meshrenderer = {
            mesh = "powerUp2",
            meshName = "Power_Up_Box.mesh"
        },
        collider = {
        },
        PowerUpObject = {
            type = 0
        },
        audiosource = {
            name = "powerUp2Sound",
            path = "pickPowerUpBox.mp3",
            onstart = false,
            loop = false,
            threed = false,
            groupchannel = "effects"
        }
    },

    PowerUp3 = {
        Transform = {
            position = { x= -6, y = 5.8, z = 0 },
            scale = { x = 1, y= 1, z = 1 },
            rotation = {x = 0, y = 180, z = 0}
        },
        RigidBody = {
            colShape = 1,
            mvType = 2,
            mass = 0,
            group = 2,
            mask = 7,
            colliderscale = {x = 0.5, y = 0.5, z = 0.5},
            restitution = .5,
            friction = 0.5,
            isTrigger = true
        },
        meshrenderer = {
            mesh = "powerUp3",
            meshName = "Power_Up_Box.mesh"
        },
        collider = {
        },
        PowerUpObject = {
            type = 0
        },
        audiosource = {
            name = "powerUp3Sound",
            path = "pickPowerUpBox.mp3",
            onstart = false,
            loop = false,
            threed = false,
            groupchannel = "effects"
        }
    },

    PowerUp4 = {
        Transform = {
            position = { x= -121, y = 5.8, z = 0 },
            scale = { x = 1, y = 1, z = 1 },
            rotation = {x = 0, y = 180, z = 0}
        },
        RigidBody = {
            colShape = 1,
            mvType = 2,
            mass = 1,
            group = 2,
            mask = 7,
            colliderscale = {x = 0.5, y = 0.5, z = 0.5},
            restitution = .5,
            friction = 0.5,
            isTrigger = true
        },
        meshrenderer = {
            mesh = "powerUp4",
            meshName = "Power_Up_Box.mesh"
        },
        collider = {
            
        },
        PowerUpObject = {
            type = 0
        },
        audiosource = {
            name = "powerUp4Sound",
            path = "pickPowerUpBox.mp3",
            onstart = false,
            loop = false,
            threed = false,
            groupchannel = "effects"
        }
    },

    PowerUp5 = {
        Transform = {
            position = { x= -124, y = 5.8, z = 0 },
            scale = { x = 1, y = 1, z = 1},
            rotation = {x = 0, y = 180, z = 0}
        },
        RigidBody = {
            colShape = 1,
            mvType = 2,
            mass = 1,
            group = 2,
            mask = 7,
            colliderscale = {x = 0.5, y = 0.5, z = 0.5},
            restitution = .5,
            friction = 0.5,
            isTrigger = true
        },
        meshrenderer = {
            mesh = "powerUp5",
            meshName = "Power_Up_Box.mesh"
        },
        collider = {
            
        },
        PowerUpObject = {
            type = 0
        },
        audiosource = {
            name = "powerUp5Sound",
            path = "pickPowerUpBox.mp3",
            onstart = false,
            loop = false,
            threed = false,
            groupchannel = "effects"
        }
    },

    PowerUp6 = {
        Transform = {
            position = { x= -127, y = 5.8, z = 0 },
            scale = { x = 1, y =1, z = 1},
            rotation = {x = 0, y = 180, z = 0}
        },
        RigidBody = {
            colShape = 1,
            mvType = 2,
            mass = 1,
            group = 2,
            mask = 7,
            colliderscale = {x = 0.5, y = 0.5, z = 0.5},
            restitution = .5,
            friction = 0.5,
            isTrigger = true
        },
        meshrenderer = {
            mesh = "powerUp6",
            meshName = "Power_Up_Box.mesh"
        },
        collider = {
            
        },
        PowerUpObject = {
            type = 0
        },
        audiosource = {
            name = "powerUp6Sound",
            path = "pickPowerUpBox.mp3",
            onstart = false,
            loop = false,
            threed = false,
            groupchannel = "effects"
        }
    },

    checkpoint3 = {
        Transform = {
            position = { x= -120, y = 0, z = 0 },
            scale = { x = 1, y = 1, z = 1 },
            rotation = {x = 0, y = 180, z = 0}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 10, y = 10, z = 1},
            restitution = .5,
            friction = 0.5,
            isTrigger = true
        },
        collider = {

        },
        Checkpoint={
            index = 3;
        }
    },
    checkpoint2 = {
        Transform = {
            position = { x= -80, y = 0, z = 10 },
            scale = { x = 1, y = 1, z = 1 },
            rotation = {x = 0, y = 180, z = 0}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 1, y = 10, z = 10},
            restitution = .5,
            friction = 0.5,
            isTrigger = true
        },
        collider = {

        },
        Checkpoint={
            index = 2;
        }
    },
    checkpoint1 = {
        Transform = {
            position = { x= -0, y = 0, z = 0 },
            scale = { x = 1, y = 1, z = 1 },
            rotation = {x = 0, y = 180, z = 0}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 10, y = 10, z = 1},
            restitution = .5,
            friction = 0.5,
            isTrigger = true
        },
        collider = {

        },
        Checkpoint={
            index = 1;
        }
    },
    checkpoint0 = {
        Transform = {
            position = { x=-42, y = 0, z = -10 },
            scale = { x = 1, y = 1, z = 1 },
            rotation = {x = 0, y = 180, z = 0}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 1, y = 10, z = 10},
            restitution = .5,
            friction = 0.5,
            isTrigger = true
        },
        collider = {

        },
        Checkpoint={
            index = 0;
        }
    },

    -- -- DirectionalLight2 = {
    -- --     Transform = {
    -- --         position = { x = 0, y = 500, z = 500 }
    -- --     },
    -- --     Light = {
    -- --         name = "DirectionalLight2",
    -- --         direction = { x = -1, y = -1, z = -1 },
    -- --         type = 0
    -- --     }
    -- -- }, 

    DirectionalLight = {
        Transform = {
            position = { x = 0, y = 500, z = 500 }
        },
        Light = {
            name = "DirectionalLight",
            direction = { x = 1, y = -1, z = -1 },
            type = 0,
            color = { r = .5, g = .5, b = .5 },
            ambientColor = { r = .5, g = .5, b = .5 }
        }
    },

    -- -- Paredes del centro del circuito

    ParedCentroDerecha = {
        Transform = {
            position = { x = -63, y = 5, z = 2.8},
			rotation = { x = 0, y = 0, z = 0 },
            scale = { x = 1, y = 1, z = 1}
	    },
        RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 54, y = 10, z = 0.01},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {}
    },

    ParedCentroIzquierda = {
        Transform = {
            position = { x = -63, y = 5, z = -2.8},
			rotation = { x = 0, y = 0, z = 0 },
            scale = { x = 1, y = 1, z = 1}
	    },
        RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 54, y = 10, z = 0.01},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {}
    },

    -- -- Paredes del centro del circuito

    ParedCentroDerecha = {
        Transform = {
            position = { x = -63, y = 5, z = 2.8},
			rotation = { x = 0, y = 0, z = 0 },
            scale = { x = 1, y = 1, z = 1}
	    },
        RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 54, y = 10, z = 0.01},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {}
    },

    ParedCentroIzquierda = {
        Transform = {
            position = { x = -63, y = 5, z = -2.8},
			rotation = { x = 0, y = 0, z = 0 },
            scale = { x = 1, y = 1, z = 1}
	    },
        RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 54, y = 10, z = 0.01},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {}
    },

    ParedCentro1 = {
        Transform = {
            position = { x = -7.2, y = 5, z = 0},
			rotation = { x = 0, y = 90, z = 0 },
            scale = { x = 1, y = 1, z = 1}
	    },
        RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.8, y = 10, z = 0.01},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {}
    },

    ParedCentro2 = {
        Transform = {
            position = { x = -7.4, y = 5, z = -0.8},
			rotation = { x = 0, y = -70, z = 0 },
            scale = { x = 1, y = 1, z = 1}
	    },
        RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.8, y = 10, z = 0.01},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {}
    },

    ParedCentro3 = {
        Transform = {
            position = { x = -8.2, y = 5, z = -2},
			rotation = { x = 0, y = -50, z = 0 },
            scale = { x = 1, y = 1, z = 1}
	    },
        RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.8, y = 10, z = 0.01},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {}
    },

    ParedCentro4 = {
        Transform = {
            position = { x = -7.4, y = 5, z = 0.8},
			rotation = { x = 0, y = 70, z = 0 },
            scale = { x = 1, y = 1, z = 1}
	    },
        RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.8, y = 10, z = 0.01},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {}
    },

    ParedCentro5 = {
        Transform = {
            position = { x = -8.2, y = 5, z = 2},
			rotation = { x = 0, y = 50, z = 0 },
            scale = { x = 1, y = 1, z = 1}
	    },
        RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.8, y = 10, z = 0.01},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {}
    },

    ParedCentro6 = {
        Transform = {
            position = { x = -119, y = 5, z = 0},
			rotation = { x = 0, y = 90, z = 0 },
            scale = { x = 1, y = 1, z = 1}
	    },
        RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.8, y = 10, z = 0.01},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {}
    },

    ParedCentro7 = {
        Transform = {
            position = { x = -119, y = 5, z = 0.8},
			rotation = { x = 0, y = -70, z = 0 },
            scale = { x = 1, y = 1, z = 1}
	    },
        RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.8, y = 10, z = 0.01},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {}
    },

    ParedCentro8 = {
        Transform = {
            position = { x = -118, y = 5, z = 2},
			rotation = { x = 0, y = -40, z = 0 },
            scale = { x = 1, y = 1, z = 1}
	    },
        RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.8, y = 10, z = 0.01},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {}
    },

    ParedCentro9 = {
        Transform = {
            position = { x = -119, y = 5, z = -0.8},
			rotation = { x = 0, y = 70, z = 0 },
            scale = { x = 1, y = 1, z = 1}
	    },
        RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.8, y = 10, z = 0.01},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {}
    },

    ParedCentro10 = {
        Transform = {
            position = { x = -118, y = 5, z = -2},
			rotation = { x = 0, y = 40, z = 0 },
            scale = { x = 1, y = 1, z = 1}
	    },
        RigidBody = {
		    colShape = 1,
		    mvType = static,
		    mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.8, y = 10, z = 0.01},
		    restitution = .5,
		    friction = .3,
		    isTrigger = false
	    },
        collider = {}
    },

 --Paredes del exterior del circuito

    ParedDerecha = {
        Transform = {
            position = { x = -50, y = 5, z = 13},
            rotation = { x = 0, y = 0, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 100, y = 10, z = 0.01},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedIzquierda = {
        Transform = {
            position = { x = -50, y = 5, z = -13},
            rotation = { x = 0, y = 0, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 100, y = 10, z = 0.01},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedFondo1 = {
        Transform = {
            position = { x = 2.5, y = 5, z = 0},
            rotation = { x = 0, y = 0, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.01, y = 10, z = 10},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedFondo2 = {
        Transform = {
            position = { x = 1, y = 5, z = -6},
            rotation = { x = 0, y = 27, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.01, y = 10, z = 20},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedFondo3 = {
        Transform = {
            position = { x = 0, y = 5, z = -8},
            rotation = { x = 0, y = 42, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.01, y = 10, z = 10},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedFondo4 = {
        Transform = {
            position = { x = -2, y = 5, z = -11},
            rotation = { x = 0, y = 65, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.01, y = 10, z = 10},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedFondo5 = {
        Transform = {
            position = { x = 1.5, y = 5, z = 6},
            rotation = { x = 0, y = -27, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.01, y = 10, z = 20},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedFondo6 = {
        Transform = {
            position = { x = 0, y = 5, z = 8},
            rotation = { x = 0, y = -42, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.01, y = 10, z = 10},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedFondo7 = {
        Transform = {
            position = { x = -2, y = 5, z = 11},
            rotation = { x = 0, y = -65, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.01, y = 10, z = 10},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedFrente1 = {
        Transform = {
            position = { x = -129, y = 5, z = 0},
            rotation = { x = 0, y = 0, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.01, y = 10, z = 10},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedFrente2 = {
        Transform = {
            position = { x = -127.2, y = 5.5, z = 6},
            rotation = { x = 0, y = 27, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.01, y = 10, z = 10},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedFrente3 = {
        Transform = {
            position = { x = -126.5, y = 5, z = 8},
            rotation = { x = 0, y = 42, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.01, y = 10, z = 10},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedFrente4 = {
        Transform = {
            position = { x = -124.5, y = 5, z = 11},
            rotation = { x = 0, y = 65, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.01, y = 10, z = 10},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedFrente5 = {
        Transform = {
            position = { x = -127.2, y = 5.5, z = -6},
            rotation = { x = 0, y = -27, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.01, y = 10, z = 20},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedFrente6 = {
        Transform = {
            position = { x = -126.5, y = 5, z = -8},
            rotation = { x = 0, y = -42, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.01, y = 10, z = 10},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },

    ParedFrente7 = {
        Transform = {
            position = {x = -124.5, y = 5, z = -11},
            rotation = { x = 0, y = -65, z = 0 },
            scale = { x = 1, y = 1, z = 1}
        },
        RigidBody = {
            colShape = 1,
            mvType = static,
            mass = 5,
            group = 1,
            mask = 2,
            colliderscale = {x = 0.01, y = 10, z = 10},
            restitution = .5,
            friction = .3,
            isTrigger = false
        },
        collider = {}
    },
    -------------------------------------------------------------
    ---------           decoracion circuito              --------
    -------------------------------------------------------------

    Trees = {
	    Transform = {
            position = { x = -70, y = 4, z = -37},
			rotation = { x = 0, y = 0, z = 0 },
            scale = { x = 1, y = 1, z = 1} --80 30 40
	    },
        meshrenderer = {
            mesh = "arboles",
            meshName = "Arboles.mesh",
            -- materialName = "Material/roja"
        }
	},
    Houses = {
	    Transform = {
            position = { x = -80, y = 4, z = -35},
			rotation = { x = 0, y = 0, z = 0 },
            scale = { x = 1, y = 1, z = 1} --80 30 40
	    },
        meshrenderer = {
            mesh = "houses",
            meshName = "Casas.mesh",
            -- materialName = "Material/roja"
        }
	}
}


