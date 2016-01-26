package com
{
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2016-1-20 下午2:51:24
	 * 
	 */
	public class GirdPool
	{
		
		private static var _girdList:Vector.<Gird>;
		
		public function GirdPool()
		{
		}
		
		public static function get gird():Gird
		{
			var g:Gird;
			if(!_girdList)
			{
				_girdList = new Vector.<Gird>();
			}
			if(_girdList.length > 0)
			{
				g = _girdList.pop();
			}
			else
			{
				g = new Gird();
			}
			return g;
		}
		
		public function push(g:Gird):void
		{
			if(!_girdList)
			{
				_girdList = new Vector.<Gird>();
			}
			_girdList.push(g);
		}
	}
}