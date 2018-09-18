package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class Soap extends MovieClip {
		
		private var speed: Number;
		public var isDead: Boolean = false;
		public var isClickDead: Boolean = false;
		
		/** The y-component of the velocity in pixels/tick. */
		var velocityY:Number = 0;
		/** The y-component of the acceleration pixels/tick/tick. */
		var accelerationY:Number = 0.3;
		
		public function Soap() {
			// constructor code
			
			x = -20;
			y = Math.random() * 250 + 0;
			
			speed = 7; // 2 to 5?
			addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
			
		}
		
		
		public function update(): void {
			// fall
			velocityY += accelerationY;
			x += speed;
			y += velocityY;
			if (y > 400) {
		     isDead = true;

			}
		}
		
		public function handleClick(e: MouseEvent): void {

			isClickDead = true;

            
			var blip: SoundBlip = new SoundBlip();
			blip.play();

		}
		
		/**
		 * This function's job is to prepare the object for removal.
		 * In this case, we need to remove any event-listeners on this object.
		 */
		public function dispose(): void {
			removeEventListener(MouseEvent.MOUSE_DOWN, handleClick);
			
		}
		
	}
	
}
