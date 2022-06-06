package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import nanovg.KhaContext;
import nanovg.NVG;

class Main {
	static var vg: NVGcontext;
	static var image: Int;

	static function update(): Void {}

	static function render(frames: Array<Framebuffer>): Void {
		final g = frames[0].g4;
		g.begin();
		g.clear(Color.Cyan);

		var context: KhaContext = vg.params.userPtr;
		context.g = g;
		NVG.nvgBeginFrame(vg, frames[0].width, frames[0].height, 1.0);
		//test1(vg);
		//test2(vg);
		//test3(vg);
		test4(vg);
		NVG.nvgEndFrame(vg);

		g.end();
	}

	static function test1(vg: NVGcontext): Void {
		NVG.nvgBeginPath(vg);
		NVG.nvgRect(vg, 100, 100, 120, 30);
		NVG.nvgFillColor(vg, NVG.nvgRGBA(255, 192, 0, 255));
		NVG.nvgFill(vg);
	}

	static function test2(vg: NVGcontext): Void {
		NVG.nvgBeginPath(vg);
		NVG.nvgRect(vg, 100, 100, 120, 30);
		//NVG.nvgRect(vg, 200, 200, 120, 30);
		NVG.nvgCircle(vg, 120, 120, 5);
		NVG.nvgPathWinding(vg, NVGsolidity.NVG_HOLE); // Mark circle as a hole.
		NVG.nvgFillColor(vg, NVG.nvgRGBA(255, 192, 0, 255));
		NVG.nvgFill(vg);
	}

	static function test3(vg: NVGcontext): Void {
		var nCaretX = 100;
		var rect_y = 200;
		var rect_w = 150;
		NVG.nvgLineCap(vg, NVGlineCap.NVG_ROUND);
		NVG.nvgLineJoin(vg, NVGlineCap.NVG_ROUND);
		NVG.nvgStrokeWidth(vg, 1);
		NVG.nvgStrokeColor(vg, NVG.nvgRGBA(255, 192, 0, 255));
		NVG.nvgBeginPath(vg);
		NVG.nvgMoveTo(vg, nCaretX, rect_y);
		NVG.nvgLineTo(vg, nCaretX, rect_y + rect_w);
		NVG.nvgStroke(vg);
	}

	static function test4(vg: NVGcontext): Void {
		var imgPaint = NVG.nvgImagePattern(vg, 0, 0, 100, 100, 0.0, image, 0.5);
		NVG.nvgBeginPath(vg);
		NVG.nvgRect(vg, 100, 100, 120, 30);
		NVG.nvgFillPaint(vg, imgPaint);
		NVG.nvgFill(vg);
	}

	public static function main() {
		System.start({title: "nanovg", width: 1024, height: 768}, function(_) {
			Assets.loadEverything(() -> {
				vg = NVG.nvgCreateKha(NVGcreateFlags.NVG_ANTIALIAS | NVGcreateFlags.NVG_STENCIL_STROKES);
				image = NVG.nvgCreateImage(vg, kha.Assets.images.parrot, 0);

				Scheduler.addTimeTask(update, 0, 1 / 60);
				System.notifyOnFrames(render);
			});
		});
	}
}
