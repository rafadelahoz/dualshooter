package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.addons.transition.FlxTransitionableState;

class World extends FlxTransitionableState
{
    public var canvas : FlxSprite;
    override public function create()
    {
        bgColor = 0xFF0F0F0F;

        canvas = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width), Std.int(FlxG.height), 0x00000000);
        add(canvas);

        var player1 : Player = new Player(100, 100, this, 0);
        var player2 : Player = new Player(100, 100, this, 1);

        add(player1);
        add(player2);

        player1.setRotationTarget(player2);
        player2.setRotationTarget(player1);

        super.create();
    }

    override public function draw()
    {
        FlxSpriteUtil.fill(canvas, 0x00000000);
        super.draw();
        canvas.draw();
    }
}
