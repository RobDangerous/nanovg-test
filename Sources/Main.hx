package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import nanovg.KhaContext;
import nanovg.NVG;

class Main {
	static function update(): Void {}

	static function render(frames: Array<Framebuffer>): Void {
		final g = frames[0].g4;
		g.begin();
		g.clear(Color.Cyan);

		var vg: NVGcontext = NVG.nvgCreateKha(NVGcreateFlags.NVG_ANTIALIAS | NVGcreateFlags.NVG_STENCIL_STROKES);
		var context: KhaContext = vg.params.userPtr;
		context.g = g;
		NVG.nvgBeginFrame(vg, frames[0].width, frames[0].height, 1.0);
		NVG.nvgBeginPath(vg);
		NVG.nvgRect(vg, 100, 100, 120, 30);
		NVG.nvgFillColor(vg, NVG.nvgRGBA(255, 192, 0, 255));
		NVG.nvgFill(vg);
		NVG.nvgEndFrame(vg);

		g.end();
	}

	public static function main() {
		System.start({title: "nanovg", width: 1024, height: 768}, function(_) {
			Assets.loadEverything(() -> {
				Scheduler.addTimeTask(update, 0, 1 / 60);
				System.notifyOnFrames(render);
			});
		});
	}
}
