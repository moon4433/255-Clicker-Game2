package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;


	public class Snow extends MovieClip {

		private var speed: Number;
		/** If this is true, the object is queued up to be destroyed!! */
		public var isDead: Boolean = false;
		public var unscoredPoints: int = 0;
		public var isClickDead: Boolean = false;
		
		

		public function Snow() {
			x = Math.random() * 550;
			y = -50; 
			speed = Math.random() * 3 + 2; // 2 to 5?
			scaleX = Math.random() * .2 + .2; // .2 to .4
			scaleY = scaleX;
			addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
			
			




		}
		public function update(): void {
			// fall
			y += speed;
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