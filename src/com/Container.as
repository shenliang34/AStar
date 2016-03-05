package com
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2016-1-19 下午3:48:33
	 * 
	 */
	public class Container extends Sprite
	{
		private var _container:Sprite;
		
		private var _randomList:Array;
		
		private var _player:Gird;
		
		private var targetX:int;
		private var targetY:int;
		
		private var mainX:int;
		private var mainY:int;
		public function Container()
		{
			init();
		}
		
		private function init():void
		{
			// TODO Auto Generated method stub
			_container = new Sprite();
			addChild(_container);
			
			_container.addEventListener(MouseEvent.CLICK,onClick);
			getRandom();
			
			initView();
		}
		
		protected function onClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			targetX = Math.floor(event.stageX / PublicData.GIRD_WIDTH);
			targetY = Math.floor(event.stageY / PublicData.GIRD_HEIGHT);
			trace(targetX,targetY);
			findRoad();
		}
		
		private function initView():void
		{
			// TODO Auto Generated method stub
			var vx:int;
			var vy:int
			
			for (var i:int = 0; i < PublicData.ROW; i++) 
			{
				for (var j:int = 0; j < PublicData.COL; j++) 
				{
					var g:Gird = new Gird();
					_container.addChild(g);
					
					var status:int = _randomList[i][j];
					g.setStatus(status);
					g.setPos(j ,i);
				}
			}
		}
		
		private function getRandom():void
		{
			// TODO Auto Generated method stub
			
			_randomList = new Array();
			for (var i:int = 0; i < PublicData.ROW; i++) 
			{
				_randomList.push(new Array(PublicData.COL));
			}
			
			var total:int = PublicData.ROW * PublicData.COL;
			var surplus:int = total - PublicData.WALL_TOTAL;
			var count:int = 0;
			
			var vx:int;
			var vy:int;
			
			//障碍数据
			while( count < PublicData.WALL_TOTAL)
			{
				vx = Math.floor(Math.random() * PublicData.ROW);
				vy = Math.floor(Math.random() * PublicData.COL);
				if(_randomList[vx][vy] == null)
				{
					count ++;
					_randomList[vx][vy] = GirdType.TYPE_WALL;
				}
			}
			
			
			for (var j:int = 0; j < PublicData.COL; j++) 
			{
				for (var k:int = 0; k < PublicData.ROW; k++) 
				{
					if(_randomList[k][j] == null)
					{
						_randomList[k][j] = GirdType.TYPE_ROAD;
					}
				}
			}
			
			//
			for (var i2:int = 0; i2 < PublicData.ROW; i2++) 
			{
				trace(_randomList[i2]);
			}
			
			//主角
			while(true)
			{
				vx = Math.floor(Math.random() * PublicData.ROW);
				vy = Math.floor(Math.random() * PublicData.COL);
				_randomList[vx][vy] = GirdType.TYPE_TARGET;
				break;
			}
		}
		
		private function findRoad():Array
		{
			var path:Array = [];
			if(_randomList[targetY][targetX] == GirdType.TYPE_WALL)
			{
				return path;
			}
			else
			{
				
			}
			return null;
		}
	}
}