package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import nut.core.Nut;
	import nut.ext.effect.EffectNode;
	import nut.util.Monitor;
	
	[SWF(backgroundColor="#000000", frameRate="60", quality="LOW", width="800", height="480")]
	public class EffectLoading extends Sprite
	{
		private var _world:World3D;
		private var _effect:EffectNode;
		
		public function EffectLoading()
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
			
			Nut.resMgr.loadEffect("test5.eff", onLoaded);
		}
		
		private function onLoaded(eff:EffectNode):void
		{
			_effect = eff;
			Nut.scene.addChild(eff);
		}
		
		private function onFrame(dt:Number):void
		{
			if (_effect != null)
				_effect.update(dt);
		}
	}
}