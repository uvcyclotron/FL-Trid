package 
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flashx.textLayout.elements.InlineGraphicElement;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;


	public class Main extends Sprite
	{
		public var board:Sprite;
		public var zones:Array ;
		public var flag:Boolean;
		public var chk:String;
		public var hzones:Array;
		public var tris:Array;
		public function Main()
		{//cons
			zones = new Array();
			board = new Sprite();
			addChildAt(board,0);
			game_incomplete.visible=false;
			hint_text.visible=false;
			game_won.visible=false;
			continue_btn.visible=false;
			drawB();
			tris = new Array();
			bttn.addEventListener(MouseEvent.CLICK,checkB);
			hint.addEventListener(MouseEvent.CLICK,hints);
			clearA.addEventListener(MouseEvent.CLICK,clearAll);
			continue_btn.addEventListener(MouseEvent.CLICK, continues);
			}//end of Con
		
		public function drawB():void
		{
			var k:Number = 300;
			for (var i:Number=0; i<5; i++)
			{ var hzones:Array = new Array();
				zones[i]=hzones;
				for (var j:Number=0; j<=i; j++)
				{
					var circle:Circle = new Circle(j, i);
					zones[i][j] = circle;
					board.addChild(zones[i][j]);
					zones[i][j].x = j * 80 + k;
					zones[i][j].y = i * 80+ 20;
					}
				k -=  40;
			}
		}//end of drawB
		
		public function checkAll():Boolean{ //check if all nos in range
					var c:Number=0,sum:Number=0;
			 		var cir;
					for(var i:int=0;i<15;i++){ 
						flag=true;
						comp(0);//renew
						cir=board.getChildAt(i);
						c=int(cir.modtext.text);
						if (!comp(c))
						{
							flag=false;
							break;
						}
					}
					return flag;
		}
	
		var k:int;
		var fls:Boolean;
		
		public function comp(k:int):Boolean{ //compares the no if in range
			if (k==0)
			chk="12345"; //renews/sets str if 0 is passed
			var m:int = 0;
			for (var i:int = 0; i<chk.length;i++){
				if (k==int(chk.charAt(i))){
					m=1; //flag for char found!
					chk=chk.substring(0,i)+chk.substring(i+1,chk.length);
					break;
				}
			}
			if (m==1)
			return true;
			else 
			return false;
			}
			
			public function chkLineH():Boolean{ //checks condn for a horiz line
				var c:Number=0;
				var d:Number;
				var cir;
				flag=true;
				for (var i:int=0; i<5; i++){
					c+=i;
					if (flag){
					comp(0); //reset the chk string for a new horiz line
					for (var j:int=0;j<=i;j++){
						cir=board.getChildAt(j+c);
						d=int(cir.modtext.text);
						if (!comp(d)){
							flag = false;
							break;
						}}
					}//close if (flag)
				}
				return flag;
			}//end of cheklineH
			
			public function checkDiagF():Boolean{
				var d:Number;
				var cir;
				flag=true;
				for (var j:int=0;j<5 ;j++){
					comp(0);
					if (flag){
			for (var i:int=j; i<5; i++){
					cir=board.getChildAt(((i*(i+1))/2)+j);
						d=int(cir.modtext.text);
						if (!comp(d)){
							flag = false;
							break;
						}}				
				}//close if (flag)
				}
				return flag;
			} //end of checkDiagF
			
			public function checkDiagB():Boolean{
				var d:Number;
				var cir;
				flag=true;
				for (var j:int=1;j<=5 ;j++){
					comp(0);
					if (flag){
			for (var i:int=j; i<=5; i++){
					cir=board.getChildAt(((i*(i+1))/2)-j);
						d=int(cir.modtext.text);
						if (!comp(d)){
							flag = false;
							break;
						}}				
				}//close if (flag)
				}
				return flag;
			} //end of checkDiagB
			
			public function checkTri():Boolean{
				var d:Number;
				var cir;
				flag=true;
				for (var i:int=0;i<6;i++){
					var hzones:Array = new Array();
					tris[i]=hzones;
				}
				//now putting data in array [x][0-2] has circle positions, and [x][3] has the reqd sum
				tris[0][0]=1;
				tris[0][1]=3;
				tris[0][2]=4;
				tris[0][3]=12;
				tris[1][0]=3;
				tris[1][1]=6;
				tris[1][2]=7;
				tris[1][3]=9;	
				tris[2][0]=5;
				tris[2][1]=8;
				tris[2][2]=9;
				tris[2][3]=6;
				tris[3][0]=6;
				tris[3][1]=10;
				tris[3][2]=11;
				tris[3][3]=6;
				tris[4][0]=7;
				tris[4][1]=11;
				tris[4][2]=12;
				tris[4][3]=12;
				tris[5][0]=8;
				tris[5][1]=12;
				tris[5][2]=13;
				tris[5][3]=8;			
				for (var i:int=0;i<6;i++){
					var sum:int=0;
					for (var j:int=0;j<3;j++){
						cir=board.getChildAt(tris[i][j]);
						d=int(cir.modtext.text);
						sum+=d;
					}
					
						if (sum!=tris[i][3]){
							flag=false;
							break;
						}}
				return flag;
			}//end of checktri
				
				public function checkB(event:MouseEvent):void{
					if ((checkAll() && checkTri() && chkLineH() && checkDiagF() && checkDiagB())){
				
					parent.parent.score += 35;
			this.dispatchEvent( new Event("won", true));
					
					}
					
					else{
						game_incomplete.visible=true;
							continue_btn.visible=true;
					}
					
					}
					
					private function continues(event:MouseEvent):void{
			game_incomplete.visible=false;
			continue_btn.visible=false;
			hint_text.visible=false;
		}
		private function hints(event:MouseEvent):void{
			hint_text.visible=true;
			continue_btn.visible=true;}
			
			private function clearAll(event:MouseEvent):void{
			
			 		var cir;
			for (var i:Number=0; i<15; i++)
			{ 
				
					cir=board.getChildAt(i);
					cir.modtext.text="";
					
			}}
	}//end of main
	
}