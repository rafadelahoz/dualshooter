package;

import flixel.addons.transition.FlxTransitionableState;

class World extends FlxTransitionableState
{
    override public function create()
    {
        bgColor = 0xFF0F0F0F;

        add(new Player(100, 100, this));

        super.create();
    }
}
