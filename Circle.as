package{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class Circle extends MovieClip{
		public var state:Boolean;		
		public var revealed:Boolean;
		public var xcor:uint;
		public var ycor:uint;
		
		public function Circle(corx:uint, cory:uint):void
		{
			this.xcor = corx;
			this.ycor = cory;
			this.state = false;
			this.revealed = false;
			//this.addEventListener(MouseEvent.CLICK, zoneClicked);
			
		}
	}
}