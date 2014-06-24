package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import nut.core.Nut;
	import nut.ext.model.Model;
	import nut.util.Monitor;
	
	[SWF(backgroundColor="#000000", frameRate="60", quality="LOW", width="800", height="480")]
	public class Avatar extends Sprite
	{
		private var _world:World3D;
		private var _model:Model;
		private var _time:Number = 0.0;
		
		public function Avatar()
		{
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_world = new World3D(stage);
			_world.onFrame = onFrame;
			
			stage.addChildAt(Monitor.instance, 0);
			Monitor.instance.x = 0;
			Monitor.instance.y = 0;
			
			Nut.resMgr.loadModel("batman/batman.mdl", onLoaded);
		}
		
		private function onLoaded(model:Model):void
		{
			_model = model;
			_model.addLight(_world.ambientLight);
			_model.addLight(_world.sunLight);
			Nut.scene.addChild(model);
		}
		
		private function onFrame(dt:Number):void
		{
			_time += dt;
			if (_model != null)
				_model.updateAt("test", _time);
		}
	}
}