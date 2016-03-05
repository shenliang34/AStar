package com
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * 格子数据
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2016-1-20 下午2:43:07
	 * 
	 */
	public class Gird extends Sprite
	{
		private var pos:Point;
		public function Gird()
		{
			super();
			
			pos = new Point();
		}
		
		public function setPos(px:Number,py:Number):void
		{
			setX(px * PublicData.GIRD_WIDTH);
			setY(py * PublicData.GIRD_HEIGHT);
		}
		
		public function setX(px:Number):void
		{
			pos.x = px;
			this.x = pos.x;
		}
		
		public function setY(py:Number):void
		{
			pos.y = py;
			this.y = pos.y;
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function setStatus(value:int):void
		{
			switch(value)
			{
				case GirdType.TYPE_EMPTY:
				{
					drawRect(GirdType.EMPTY_COLOR);
					break;
				}
				case GirdType.TYPE_ROAD:
				{
					drawRect(GirdType.ROAD_COLOR);
					break;
				}
				case GirdType.TYPE_WALL:
				{
					drawRect(GirdType.WALL_COLOR);
					break;
				}
				case GirdType.TYPE_TARGET:
				{
					drawRect(GirdType.TARGET_COLOR);
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
		
		private function drawRect(color:uint):void
		{
			graphics.clear();
			graphics.lineStyle(1,0);
			graphics.beginFill(color);
			graphics.drawRect(0,0,PublicData.GIRD_WIDTH,PublicData.GIRD_HEIGHT);
			graphics.endFill();
		}
	}
}