package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Vector3D;
	import flash.utils.ByteArray;
	
	import nut.core.Nut;
	import nut.enum.ResType;
	import nut.ext.model.Model;
	import nut.util.BytesLoader;
	import nut.util.Monitor;
	import nut.util.NutMath;

	[SWF(backgroundColor="#000000", frameRate="60", quality="LOW", width="800", height="480")]
	public class ModelLoading extends Sprite
	{
		private var _world:World3D;
		private var _model:Model;
		private var _time:Number = 0.0;
		
		public function ModelLoading()
		{
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_world = new World3D(stage);
			_world.onFrame = onFrame;
			_world.sunLight.castShadow = true;
			
			stage.addChildAt(Monitor.instance, 0);
			Monitor.instance.x = 0;
			Monitor.instance.y = 0;
			
			var model:Model = Nut.resMgr.loadModel("plane/plane.mdl", onLoaded);
		}
		
		private function onLoaded(model:Model):void
		{
			_model = model;
			
			model.castShadow = true;
			model.receiveShadow = true;
			model.addLight(_world.ambientLight);
			model.addLight(_world.sunLight);
			
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