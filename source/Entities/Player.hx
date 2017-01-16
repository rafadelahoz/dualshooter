package;

import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;

class Player extends Entity
{
    var rotationTarget : Entity;
    var rotationCenter : FlxPoint;

    var distance : Float;
    var radAngle : Float;
    var radDelta : Float;

    public function new(X : Float, Y : Float, World : World, RotationTarget : Entity)
    {
        super(X, Y, World);

        makeGraphic(8, 8, 0xFF00FF4D);
        centerOffsets(true);

        rotationTarget = RotationTarget;
        distance = 16;

        radDelta = 0.1;
        radAngle = 0;
    }

    override public function update(elapsed : Float)
    {
        updateRotationCenter();

        x = rotationCenter.x + FlxMath.fastCos(radAngle) * distance;
        y = rotationCenter.y + FlxMath.fastSin(radAngle) * distance;

        if (FlxG.keys.pressed.LEFT)
            radAngle -= radDelta;
        else if (FlxG.keys.pressed.RIGHT)
            radAngle += radDelta;

        super.update(elapsed);
    }

    function updateRotationCenter() : Void
    {
        if (rotationTarget != null)
        {
            rotationCenter = rotationTarget.getMidpoint();
        }
    }
}
