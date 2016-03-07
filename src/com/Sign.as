package com
{
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2016-3-7 上午11:18:18
	 * 
	 */
	public class Sign
	{
		private var _vx:Number;
		private var _vy:Number;
		private var _parent:Sign;
		private var _f:int = 0;
		private var _h:int = 0;
		private var _g:int = 0;
		/**
		 * 
		 * @param _vx 点位置
		 * @param _vy 点位置
		 * @param pg 父节点到当前消耗
		 * @param ph 估计
		 * @param _p 父节点
		 * 
		 */		
		public function Sign(_vx:Number,_vy:Number,pg:int,ph:int,_p:Sign)
		{
			this._vx = _vx;
			this._vy = _vy;
			
			this._parent = _p;
			if(_p)
			{
				_g = pg + _p.g;
				_h = ph;
				_f = _g + _h;
			}
		}

		/**当前消耗*/
		public function get g():int
		{
			return _g;
		}

		/**估计消耗*/
		public function get h():int
		{
			return _h;
		}

		/**路径评分*/
		public function get f():int
		{
			return _f;
		}

		public function get parent():Sign
		{
			return _parent;
		}

		public function get vx():Number
		{
			return _vx;
		}

		public function get vy():Number
		{
			return _vy;
		}


	}
}