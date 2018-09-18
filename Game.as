package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	/**
	 * This is the controller class for the entire Game.
	 */
	public class Game extends MovieClip {

		/** This array should only hold Snow objects. */
		var snowflakes: Array = new Array();
		/** The number frames to wait before spawning the next Snow object. */
		var delaySpawn: int = 0;

		var startButton: StartButton = new StartButton();
		var start: Start = new Start();
		
		var snow: Snow = new Snow();
		
		var soap: Soap = new Soap();
		var water: Water = new Water();
		var dishSoap: DishSoap = new DishSoap();

		public var isGameWon: Boolean = false;
		public var isGameLost: Boolean = false;

		public var score: int = 0;
		private var music: BackMusic = new BackMusic();
		private var myChannel: SoundChannel = new SoundChannel();

		private var isGamePlaying: Boolean = false;

		var hasSoap: Boolean = false;
		var missedSoap: Boolean = false;
		var hasWater:Boolean = false;
		var missedWater:Boolean = false;
		var hasDishSoap:Boolean = false;
		var missedDishSoap:Boolean = false;

		/**
		 * This is where we setup the game.
		 */
		public function Game() {

			addChild(start);

			startButton.x = 275;
			startButton.y = 300;
			startButton.addEventListener(MouseEvent.CLICK, handleClick);
			addChild(startButton);

		}


		public function handleClick(e: MouseEvent): void {

			startButton.removeEventListener(MouseEvent.CLICK, handleClick);
			removeChild(start);
			removeChild(startButton);
			


			myChannel = music.play();
			addEventListener(Event.ENTER_FRAME, gameLoop);

			var blip: SoundBlip = new SoundBlip();
			blip.play();
		}


		/**
		 * This event-handler is called every time a new frame is drawn.
		 * It's our game loop!
		 * @param e The Event that triggered this event-handler.
		 */
		private function gameLoop(e: Event): void {


			if (isGameWon == false || isGameLost == false) { // tell program if it should update snow whether or not game is won/lost
				spawnSnow();
			    updateSnow();
			}

			if (hasSoap == false && missedSoap == false) { // updates soap and continuously updates it until it is spawned
				updateSoap();
			}
			
			if (hasWater == false && missedWater == false) { // updates soap and continuously updates it until it is spawned
				updateWater();
			}
			
			if (hasDishSoap == false && missedDishSoap == false) { // updates soap and continuously updates it until it is spawned
				updateDishSoap();
			}

			scoreboard.text = "Score: " + score;

			// TODO: put in if player gets all three items and hits score limit, game is won
			// TODO: put in if player misses any main items they lose
			// TODO: put in a reset button

			if (missedSoap == true || missedWater == true || missedDishSoap == true) {
				isGameLost = true;
			}
			
			if (hasSoap && hasWater && hasDishSoap && score == 5000){
				isGameWon = true;
			}


			// when the game is won or lost, this screen is shown
			
			GameWon();

			GameLost();
			
			


		} // function gameLoop

		/**
		 * Decrements the countdown timer, when it hits 0, it spawns a snowflake.
		 */
		public function spawnSnow() {

			// spawn snow:
			delaySpawn--;
			if (delaySpawn <= 0) {
				var s: Snow = new Snow();

				// gives the object more of a bubble look... totally aesthetic
				s.alpha = .5;

				addChild(s);
				snowflakes.push(s);
				delaySpawn = (int)(Math.random() * 10 + 10);


				// changes the spawn rate so that objects spawn sooner
				if (hasSoap == true) {
					delaySpawn = (int)(Math.random() * 9 + 9);

				}
				if (hasWater == true) {
					delaySpawn = (int)(Math.random() * 7 + 7);

				}
				if (hasDishSoap == true) {
					delaySpawn = (int)(Math.random() * 5 + 5);

				}
			}
		}

		private function updateSnow(): void {
			// update everything:


			for (var i = snowflakes.length - 1; i >= 0; i--) {

					snowflakes[i].update();



					if (snowflakes[i].isClickDead) {
						// remove it!!

						// 1. remove any event-listeners on the object
						snowflakes[i].dispose();

						// 2. remove the object from the scene-graph
						removeChild(snowflakes[i]);

						// 3. nullify any variables pointing to it
						// if the variable is an array,
						// remove the object from the array
						snowflakes.splice(i, 1);

						score += 100;

					}

					if (snowflakes[i].isDead) {
						// remove it!!

						// 1. remove any event-listeners on the object
						snowflakes[i].dispose();

						// 2. remove the object from the scene-graph
						removeChild(snowflakes[i]);

						// 3. nullify any variables pointing to it
						// if the variable is an array,
						// remove the object from the array
						snowflakes.splice(i, 1);

					}
					// checks score to see how far the player is in the game, and to see if it should amp the difficulty
					if (score >= 500) {
						snowflakes[i].y += 2;
						snowflakes[i].x += 1;
					}
					if (score >= 1000) {
						snowflakes[i].y -= 2;
						snowflakes[i].x -= 2;
					}
					if (score >= 2000) {
						snowflakes[i].y += 2;
						snowflakes[i].x += 2;
					}
					if (score >= 3000) {
						snowflakes[i].y += 1;
						snowflakes[i].x -= 2;
					}
					if (score >= 4000) {
						snowflakes[i].y += 2;
						snowflakes[i].x -= 3;
					}

			} // for loop updating snow
		}

		public function updateSoap(): void {
			
			if (score >= 1500) { // spawns soap at this point in the game
					addChild(soap);
					soap.update();
				}

			if (soap.isClickDead) {
				// remove it!!

				// 1. remove any event-listeners on the object
				soap.dispose();

				// 2. remove the object from the scene-graph
				removeChild(soap);
				hasSoap = true;
			}
			if (soap.isDead) {
				// 1. remove any event-listeners on the object
				soap.dispose();

				// 2. remove the object from the scene-graph
				removeChild(soap);
				missedSoap = true;
			}


		}
		
		public function updateWater(): void {
			
			if (score >= 2500) { // spawns soap at this point in the game
					addChild(water);
					water.update();
				}

			if (water.isClickDead) {
				// remove it!!

				// 1. remove any event-listeners on the object
				water.dispose();

				// 2. remove the object from the scene-graph
				removeChild(water);
				hasWater = true;
			}
			if (water.isDead) {
				// 1. remove any event-listeners on the object
				water.dispose();

				// 2. remove the object from the scene-graph
				removeChild(water);
				missedWater = true;
			}


		}
		
		public function updateDishSoap(): void {
			
			if (score >= 3500) { // spawns soap at this point in the game
					addChild(dishSoap);
					dishSoap.update();
				}

			if (dishSoap.isClickDead) {
				// remove it!!

				// 1. remove any event-listeners on the object
				dishSoap.dispose();

				// 2. remove the object from the scene-graph
				removeChild(dishSoap);
				hasDishSoap = true;
			}
			if (dishSoap.isDead) {
				// 1. remove any event-listeners on the object
				dishSoap.dispose();

				// 2. remove the object from the scene-graph
				removeChild(dishSoap);
				missedDishSoap = true;
			}


		}

		/*
		 *	checks to see if game is won. If game is won, it spawns the game won text.
		 *
		 */
		public function GameWon(): void {
			if (isGameWon == true) {
				var gameOverText: GameOverText = new GameOverText();
				gameOverText.x = 275;
				gameOverText.y = 200;
				addChild(gameOverText);
				myChannel.stop();
			}
		}

		// if player loses; music is stopped, You Lose is posted, and final score is posted

		public function GameLost(): void {
			if (isGameLost == true) {
				var lostText: LostText = new LostText();
				lostText.x = 275;
				lostText.y = 200;
				addChild(lostText);
				addChild(scoreboard);
				scoreboard.x = 105;
				scoreboard.y = 220;
				scoreboard.text = "Your Score Was: " + score;
				myChannel.stop();
			}
		}


	} // class Game
} // package