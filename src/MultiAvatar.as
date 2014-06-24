package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Vector3D;
	
	import nut.core.Nut;
	import nut.ext.model.Model;
	import nut.util.Monitor;
	import nut.util.NutMath;
	
	[SWF(backgroundColor="#000000", frameRate="60", quality="LOW", width="800", height="480")]
	
	public class MultiAvatar extends Sprite
	{
		private var _world:World3D;
		private var _time:Number = 0.0;
		private var _models:Vector.<Model> = new Vector.<Model>();
		
		public function MultiAvatar()
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
			_models.push(model);
			Nut.scene.addChild(model);
			
			model.addLight(_world.ambientLight);
			model.addLight(_world.sunLight);
			
			for (var i:int = 0; i != 120; ++i)
			{
				var m:Model = model.clone();
				
				m.addLight(_world.ambientLight);
				m.addLight(_world.sunLight);
				
				_models.push(m);
				Nut.scene.addChild(m);
			}
			
			for (var x:int = -5; x != 6; ++x)
			{
				for (var z:int = -5; z != 6; ++z)
				{
					var idx:int = (z+5)*11 + x+5;
					m = _models[idx];
					
					m.position = new Vector3D(x*3, 0, z*3);
					m.setRotation(new Vector3D(0, NutMath.random(idx)*NutMath.TWO_PI, 0)); 
				}
			}
		}
		
		private function onFrame(dt:Number):void
		{
			_time += dt;
			
			for (var i:int = 0; i != _models.length; ++i)
			{
				var m:Model = _models[i];
				m.updateAt("test", _time + i*0.04);
			}
		}
	}
}