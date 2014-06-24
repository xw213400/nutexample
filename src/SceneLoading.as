package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.ByteArray;
	
	import nut.core.Nut;
	import nut.enum.ResType;
	import nut.ext.model.Model;
	import nut.ext.scene.GameScene;
	import nut.util.BytesLoader;
	import nut.util.Monitor;
	
	[SWF(backgroundColor="#000000", frameRate="60", quality="LOW", width="800", height="480")]
	public class SceneLoading extends Sprite
	{
		private var _world:World3D;
		
		public function SceneLoading()
		{
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_world = new World3D(stage);
			
			stage.addChildAt(Monitor.instance, 0);
			Monitor.instance.x = 0;
			Monitor.instance.y = 0;
			
			var scene:GameScene = Nut.resMgr.loadScene("test5.scn", onLoaded);
			
			scene.name = "test5.scn";
			scene.ambientLight = _world.ambientLight;
			scene.sunLight = _world.sunLight;
		}
		
		private function onLoaded(scene:GameScene):void
		{
		}
	}
}