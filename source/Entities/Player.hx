package;

class Player extends Entity
{
    public function new(X : Float, Y : Float, World : World)
    {
        super(X, Y, World);

        makeGraphic(8, 8, 0xFF00FF4D);
    }

    override public function update(elapsed : Float)
    {
        super.update(elapsed);
    }
}
