package;

import flixel.addons.transition.FlxTransitionableState;

class World extends FlxTransitionableState
{
    override public function create()
    {
        bgColor = 0xFF0F0F0F;

        var target : Entity = new Entity(116, 116, this);
        target.makeGraphic(1, 1, 0xFFFFFFFF);
        add(target);
        add(new Player(100, 100, this, target));

        super.create();
    }
}
