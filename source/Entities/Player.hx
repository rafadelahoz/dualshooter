package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.util.FlxSpriteUtil;

class Player extends Entity
{
    var id : Int;

    var rotationTarget : Player;
    var rotationCenter : FlxPoint;

    var distance : Float;
    var radAngle : Float;
    var radDelta : Float;

    var canvas : FlxSprite;
    var lineStyle : Dynamic;

    public function new(X : Float, Y : Float, World : World, Id : Int)
    {
        super(X, Y, World);

        id = Id;

        makeGraphic(8, 8, (id == 0 ? 0xFF00FF4D : 0xFFFF004D));

        distance = 32;

        radDelta = 0.1;
        radAngle = 0;

        canvas = world.canvas;
        if (id == 0)
            lineStyle = {thickness: 2, color: 0xFF00FF4D};
        else
            lineStyle = {thickness: 1, color: 0xFFFF004D};
    }

    public function setRotationTarget(target : Player)
    {
        rotationTarget = target;
        updateRotationCenter();
        // Recompute angle from new target
        radAngle = FlxAngle.angleBetween(this, rotationTarget);

        computePosition();
    }

    override public function update(elapsed : Float)
    {
        updateRotationCenter();

        var oldAngle : Float = radAngle;

        if ((id == 0 && FlxG.keys.pressed.LEFT) || (id == 1 && FlxG.keys.pressed.A))
        {
            radAngle -= radDelta;
            if (radAngle < 0)
                radAngle += Math.PI*2;
            else if (radAngle > Math.PI*2)
                radAngle -= Math.PI*2;

            rotationTarget.radAngle = radAngle + Math.PI;
        }
        else if ((id == 0 && FlxG.keys.pressed.RIGHT) || (id == 1 && FlxG.keys.pressed.S))
        {
            radAngle += radDelta;
            if (radAngle < 0)
                radAngle += Math.PI*2;
            else if (radAngle > Math.PI*2)
                radAngle -= Math.PI*2;

            rotationTarget.radAngle = radAngle + Math.PI;
        }

        if (radAngle != oldAngle)
            computePosition();

        super.update(elapsed);
    }

    function computePosition() : Void
    {
        /*x = rotationCenter.x + Math.cos(radAngle) * distance - origin.x;
        y = rotationCenter.y + Math.sin(radAngle) * distance - origin.y;
        last.x = x;
        last.y = y;*/
        var pos : FlxPoint = FlxAngle.getCartesianCoords(distance, radAngle * FlxAngle.TO_DEG);
        x = rotationCenter.x + pos.x - origin.x;
        y = rotationCenter.y + pos.y - origin.y;
    }

    function updateRotationCenter() : Void
    {
        if (rotationTarget != null)
        {
            rotationCenter = rotationTarget.getMidpoint();
        }
    }

    override public function draw()
    {
        super.draw();

        var midpoint : FlxPoint = getMidpoint();
        FlxSpriteUtil.drawLine(canvas, midpoint.x, midpoint.y,
                                midpoint.x + Math.cos(radAngle + Math.PI) * distance,
                                midpoint.y + Math.sin(radAngle + Math.PI) * distance,
                                lineStyle);
    }
}
