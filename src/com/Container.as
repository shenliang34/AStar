package com
{
	import flash.display.Sprite;
	import flash.events.AccelerometerEvent;
	import flash.events.MouseEvent;
	import flash.sensors.Accelerometer;
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2016-1-19 下午3:48:33
	 * 
	 */
	public class Container extends Sprite
	{
		private var _container:Sprite;
		private var _drawSprite:Sprite;
		
		private var _randomList:Array;
		
		private var _player:Gird;
		
		private var targetX:int;
		private var targetY:int;
		
		private var mainX:int;
		private var mainY:int;
		
		private var _unLockList:Array = [];
		private var _lockList:Dictionary = new Dictionary();
		private var _girdList:Array = new Array();
		public function Container()
		{
			init();
		}
		
		private function init():void
		{
			// TODO Auto Generated method stub
			_container = new Sprite();
			addChild(_container);
			
			_drawSprite = new Sprite();
			addChild(_drawSprite);
			
			_container.addEventListener(MouseEvent.CLICK,onClick);
			getRandom();
			
			initView();
		}
		
		protected function onClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			_container.mouseEnabled = false;
			_container.mouseChildren = false;
			targetX = Math.floor(event.stageX / PublicData.GIRD_WIDTH);
			targetY = Math.floor(event.stageY / PublicData.GIRD_HEIGHT);
			trace(targetX,targetY);
			var start:Number = getTimer();
			var path:Array = findRoad();
			var end:Number = getTimer();
			trace("消耗时间："+ (end - start) +"毫秒");
			walk(path);
			trace(path);
		}
		
		private function walk(path:Array):void
		{
			// TODO Auto Generated method stub
			var posX:Number = 0;
			var posY:Number = 0;
			_drawSprite.graphics.clear();
			if(path && path.length > 0)
			{
				var sign:Sign;
				var isStart:Boolean = true;
				
				var intval:int = setInterval(function w():void
				{
					sign = path.shift();
					posX = sign.vx * PublicData.GIRD_WIDTH +PublicData.GIRD_WIDTH/2;
					posY = sign.vy * PublicData.GIRD_HEIGHT +PublicData.GIRD_HEIGHT/2;
					_player.setPos(sign.vx,sign.vy);
					
					if(isStart)
					{
						isStart = false;
						_drawSprite.graphics.lineStyle(1,0xffff00);
						_drawSprite.graphics.moveTo(posX,posY);
					}
					else
					{
						_drawSprite.graphics.lineTo(posX,posY);
					}
					
					if(path.length<=0)
					{
						clear();
						clearInterval(intval);
					}
				},50);
			}
			else
			{
				targetX = mainX;
				targetY = mainY;
				clear()
				trace("死路");
			}
		}
		
		private function initView():void
		{
			// TODO Auto Generated method stub
			var vx:int;
			var vy:int
			
			for (var i:int = 0; i < PublicData.COL; i++) 
			{
				for (var j:int = 0; j < PublicData.ROW; j++) 
				{
					var g:Gird = new Gird();
					_container.addChild(g);
					
					var status:int = _randomList[i][j];
					g.setStatus(status);
					g.setPos(i ,j);
				}
			}
			_player = new Gird();
			_container.addChild(_player);
			_player.setStatus(GirdType.TYPE_TARGET);
			_player.setPos(mainX,mainY);
		}
		
		private function getRandom():void
		{
			// TODO Auto Generated method stub
			
			_randomList = new Array();
			for (var i:int = 0; i < PublicData.COL; i++) 
			{
				_randomList.push(new Array(PublicData.ROW));
			}
			
			var total:int = PublicData.ROW * PublicData.COL;
			var surplus:int = total - PublicData.WALL_TOTAL;
			var count:int = 0;
			
			var vx:int;
			var vy:int;
			
			//障碍数据
			while( count < PublicData.WALL_TOTAL)
			{
				vx = Math.floor(Math.random() * PublicData.COL);
				vy = Math.floor(Math.random() * PublicData.ROW);
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
					if(_randomList[j][k] == null)
					{
						_randomList[j][k] = GirdType.TYPE_ROAD;
					}
				}
			}
			
			//
			for (var i2:int = 0; i2 < PublicData.COL; i2++) 
			{
				trace(_randomList[i2]);
			}
			
			//主角
			while(true)
			{
				vx = Math.floor(Math.random() * PublicData.COL);
				vy = Math.floor(Math.random() * PublicData.ROW);
				mainX = vx;
				mainY = vy;
				trace(mainX,mainY);
				break;
			}
		}
		
		private function findRoad():Array
		{
			var path:Array = [];
			if(_randomList[targetX][targetY] == GirdType.TYPE_WALL)
			{
				return path;
			}
			else
			{
				/****/
				var startX:int = mainX;
				/****/
				var startY:int = mainY;
				
				var sign:Sign = new Sign(mainX,mainY,0,0,null);
				_lockList[mainX+"_"+mainY] = sign;
				
				while(true)
				{
					addUnLockList(createSign(startX - 1,startY    ,false,sign));
					addUnLockList(createSign(startX    ,startY - 1,false,sign));
					addUnLockList(createSign(startX + 1,startY    ,false,sign));
					addUnLockList(createSign(startX    ,startY + 1,false,sign));
					
					addUnLockList(createSign(startX - 1,startY - 1,true,sign));
					addUnLockList(createSign(startX + 1,startY - 1,true,sign));
					
					addUnLockList(createSign(startX - 1,startY + 1,true,sign));
					addUnLockList(createSign(startX + 1,startY + 1,true,sign));
					
					if(_unLockList.length == 0)
					{
						break;
					}
					
					_unLockList.sortOn(["f","h","g"],[Array.NUMERIC,Array.NUMERIC,Array.NUMERIC]);
					sign = _unLockList.shift();
					_lockList[sign.vx + "_" + sign.vy] = sign;
					startX = sign.vx;
					startY = sign.vy;
					
					//找到
					if(startX == targetX && startY == targetY)
					{
						while(sign != null)
						{
							path.push(sign);
							sign = sign.parent;
						}
						break;
					}
				}
				sign = null;
				return path.reverse();
			}
		}
		/**
		 *清除 
		 * 
		 */		
		private function clear():void
		{
			mainX = targetX;
			mainY = targetY;
			_player.setPos(mainX,mainY);
			
			_container.mouseEnabled = true;
			_unLockList = new Array();
			_lockList = new Dictionary();
			_lockList = new Dictionary();
		}
		
		private function addUnLockList(sign:Sign):void
		{
			if(sign)
			{
				_unLockList.push(sign);
				_unLockList[sign.vx + "_" + sign.vy] = sign;
			}
		}
		/**
		 * 
		 * @param vx
		 * @param vy
		 * @param isBias
		 * @param p
		 * @return 
		 * 
		 */		
		private function createSign(vx:int,vy:int,isBias:Boolean,p:Sign):Sign
		{
			var sign:Sign = null;
			if(vx < 0 || vy < 0 || vx >= PublicData.COL || vy >= PublicData.ROW)
			{
				return null;
			}
			if(_randomList[vx][vy] == GirdType.TYPE_WALL)
			{
				return null;
			}
			
			if(_lockList[vx + "_" + vy])
			{
				return null;	
			}
			if(_unLockList[vx +"_"+vy])
			{
				return null;
			}
			//
			if(isBias)
			{
				if(_randomList[p.vx][vy] == GirdType.TYPE_WALL || _randomList[vx][p.vy] == GirdType.TYPE_WALL)
				{
				 	return null;	
				}
			}
			sign = new Sign(vx,vy,isBias?PublicData.BIAS_VALUE:PublicData.LINE_VALUE,Math.abs(targetX - vx) + Math.abs(targetY - vy) * 10,p);
			return sign;
		}
	}
}